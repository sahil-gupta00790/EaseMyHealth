CREATE TABLE Token_Blacklist (
    token_id UUID PRIMARY KEY,
    token_jti VARCHAR(255) UNIQUE NOT NULL,
    user_id UUID NOT NULL,
    expiration_time TIMESTAMP NOT NULL,
    blacklisted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);