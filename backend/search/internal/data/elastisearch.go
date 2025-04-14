// internal/data/elasticsearch.go

package data

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/elastic/go-elasticsearch/v8"
	"github.com/elastic/go-elasticsearch/v8/esapi"
)

// this is for Elasticsearch client wrapper
type ElasticsearchClient struct {
	Client *elasticsearch.Client
	Index  string
}

// creating
func NewElasticsearchClient(addresses []string, username, password, index string) (*ElasticsearchClient, error) {
	cfg := elasticsearch.Config{
		Addresses: addresses,
	}

	client, err := elasticsearch.NewClient(cfg)
	if err != nil {
		return nil, fmt.Errorf("error creating the client: %s", err)
	}

	// checking cnn.
	res, err := client.Info()
	if err != nil {
		return nil, fmt.Errorf("error getting response: %s", err)
	}
	defer res.Body.Close()

	if res.IsError() {
		return nil, fmt.Errorf("error: %s", res.String())
	}

	return &ElasticsearchClient{
		Client: client,
		Index:  index,
	}, nil
}

// defining index
func (es *ElasticsearchClient) CreateIndex() error {
	//checking if index exists.
	req := esapi.IndicesExistsRequest{
		Index: []string{es.Index},
	}
	res, err := req.Do(context.Background(), es.Client)
	if err != nil {
		return fmt.Errorf("error checking if index exists: %s", err)
	}
	defer res.Body.Close()
	mapping := `{
		"settings": {
			"number_of_shards": 1,
			"number_of_replicas": 1,
			"analysis": {
				"analyzer": {
					"medication_analyzer": {
						"type": "custom",
						"tokenizer": "standard",
						"filter": ["lowercase", "asciifolding"]
					}
				}
			}
		},
		"mappings": {
			"properties": {
				"id": { "type": "keyword" },
				"sub_category": { "type": "text", "analyzer": "medication_analyzer", "fields": { "keyword": { "type": "keyword" } } },
				"product_name": { "type": "text", "analyzer": "medication_analyzer", "fields": { "keyword": { "type": "keyword" } } },
				"salt_composition": { "type": "text", "analyzer": "medication_analyzer" },
				"product_price": { "type": "float" },
				"product_manufactured": { "type": "text", "fields": { "keyword": { "type": "keyword" } } },
				"medicine_desc": { "type": "text" },
				"side_effects": { "type": "text" },
				"drug_interactions": { "type": "nested" },
				"created_at": { "type": "date" }
			}
		}
	}`

	//creating it
	if res.StatusCode == 404 {
		createReq := esapi.IndicesCreateRequest{
			Index: es.Index,
			Body:  strings.NewReader(mapping),
		}
		res, err := createReq.Do(context.Background(), es.Client)
		if err != nil {
			return fmt.Errorf("error creating index: %s", err)
		}
		defer res.Body.Close()

		if res.IsError() {
			return fmt.Errorf("error creating index: %s", res.String())
		}
	}

	return nil
}

// indexing the doc.
func (es *ElasticsearchClient) IndexMedication(medication Medication) error {
	data, err := json.Marshal(medication)
	if err != nil {
		return fmt.Errorf("error marshaling document: %s", err)
	}

	req := esapi.IndexRequest{
		Index:      es.Index,
		DocumentID: medication.ID,
		Body:       bytes.NewReader(data),
		Refresh:    "true",
	}

	res, err := req.Do(context.Background(), es.Client)
	if err != nil {
		return fmt.Errorf("error indexing document: %s", err)
	}
	defer res.Body.Close()

	if res.IsError() {
		return fmt.Errorf("error indexing document: %s", res.String())
	}

	return nil
}

// searching in the doc
func (es *ElasticsearchClient) SearchMedications(query string, category string, minPrice, maxPrice float64, page, pageSize int) ([]Medication, int, error) {
	//query
	temp := (page - 1) * pageSize
	var buf bytes.Buffer
	searchQuery := map[string]interface{}{
		"_source": []string{
			"id",
			"product_name",
			"salt_composition",
			"sub_category",
			"product_price",
			"product_manufactured",
		},
		"query": map[string]interface{}{
			"bool": map[string]interface{}{
				"must": []map[string]interface{}{},
			},
		},
		"collapse": map[string]interface{}{
			"field": "product_name.keyword",
		},
		"aggs": map[string]interface{}{
			"unique_product_count": map[string]interface{}{
				"cardinality": map[string]interface{}{
					"field": "product_name.keyword",
				},
			},
		},
		"from": temp,
		"size": pageSize,
	}

	mustClauses := []map[string]interface{}{}
	if query != "" {
		mustClauses = append(mustClauses, map[string]interface{}{
			"multi_match": map[string]interface{}{
				"query":     query,
				"fields":    []string{"product_name^3", "salt_composition^2", "sub_category", "medicine_desc"},
				"fuzziness": "AUTO",
			},
		})
	}
	if category != "" {
		mustClauses = append(mustClauses, map[string]interface{}{
			"match": map[string]interface{}{
				"sub_category": category,
			},
		})
	}

	if minPrice > 0 || maxPrice > 0 {
		priceRange := map[string]interface{}{}
		if minPrice > 0 {
			priceRange["gte"] = minPrice
		}
		if maxPrice > 0 {
			priceRange["lte"] = maxPrice
		}

		//checking if exists
		existsClause := map[string]interface{}{
			"exists": map[string]interface{}{
				"field": "product_price",
			},
		}

		//range clause
		rangeClause := map[string]interface{}{
			"range": map[string]interface{}{
				"product_price": priceRange,
			},
		}

		//combining both
		mustClauses = append(mustClauses, map[string]interface{}{
			"bool": map[string]interface{}{
				"must": []interface{}{existsClause, rangeClause},
			},
		})
	}

	//searching
	if len(mustClauses) > 0 {
		searchQuery["query"].(map[string]interface{})["bool"].(map[string]interface{})["must"] = mustClauses
	} else {
		searchQuery["query"] = map[string]interface{}{
			"match_all": map[string]interface{}{},
		}
	}

	if err := json.NewEncoder(&buf).Encode(searchQuery); err != nil {
		return nil, 0, fmt.Errorf("error encoding search query: %s", err)
	}
	//running the req
	res, err := es.Client.Search(
		es.Client.Search.WithContext(context.Background()),
		es.Client.Search.WithIndex(es.Index),
		es.Client.Search.WithBody(&buf),
		es.Client.Search.WithTrackTotalHits(true),
		es.Client.Search.WithPretty(),
	)
	if err != nil {
		return nil, 0, fmt.Errorf("error performing search: %s", err)
	}
	defer res.Body.Close()

	if res.IsError() {
		return nil, 0, fmt.Errorf("error searching: %s", res.String())
	}

	var r map[string]interface{}
	if err := json.NewDecoder(res.Body).Decode(&r); err != nil {
		return nil, 0, fmt.Errorf("error parsing response: %s", err)
	}

	uniqueCount := int(r["aggregations"].(map[string]interface{})["unique_product_count"].(map[string]interface{})["value"].(float64))

	hits := r["hits"].(map[string]interface{})["hits"].([]interface{})
	medications := make([]Medication, len(hits))

	for i, hit := range hits {
		source := hit.(map[string]interface{})["_source"]
		sourceBytes, err := json.Marshal(source)
		if err != nil {
			return nil, 0, fmt.Errorf("error marshaling hit source: %s", err)
		}

		if err := json.Unmarshal(sourceBytes, &medications[i]); err != nil {
			return nil, 0, fmt.Errorf("error unmarshaling hit source: %s", err)
		}
	}

	return medications, uniqueCount, nil
}

// BulkIndexMedications performs a bulk indexing operation for multiple medications
// llm code
func (es *ElasticsearchClient) BulkIndexMedications(medications []Medication) error {
	var buf bytes.Buffer

	for _, med := range medications {
		// Action line
		meta := map[string]interface{}{
			"index": map[string]interface{}{
				"_index": es.Index,
				"_id":    med.ID,
			},
		}
		if err := json.NewEncoder(&buf).Encode(meta); err != nil {
			return fmt.Errorf("error encoding meta: %s", err)
		}

		// Document line
		if err := json.NewEncoder(&buf).Encode(med); err != nil {
			return fmt.Errorf("error encoding document: %s", err)
		}
	}

	// Perform the bulk indexing request
	res, err := es.Client.Bulk(
		bytes.NewReader(buf.Bytes()),
		es.Client.Bulk.WithIndex(es.Index),
		es.Client.Bulk.WithRefresh("true"),
	)
	if err != nil {
		return fmt.Errorf("error performing bulk index: %s", err)
	}
	defer res.Body.Close()

	if res.IsError() {
		return fmt.Errorf("error bulk indexing: %s", res.String())
	}

	return nil
}
