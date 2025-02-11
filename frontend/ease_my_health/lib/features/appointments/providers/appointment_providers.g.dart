// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentRepositoryHash() =>
    r'e5371ae1d5f58062e7e0ac19c00ae37cfea25149';

/// See also [appointmentRepository].
@ProviderFor(appointmentRepository)
final appointmentRepositoryProvider =
    AutoDisposeProvider<AppointmentRepository>.internal(
  appointmentRepository,
  name: r'appointmentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appointmentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppointmentRepositoryRef
    = AutoDisposeProviderRef<AppointmentRepository>;
String _$appointmentNotifierHash() =>
    r'4f41211b597974f21ac6fd31d0aa93a34e3d451d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AppointmentNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<String>> {
  late final String doctorId;
  late final DateTime date;

  FutureOr<List<String>> build(
    String doctorId,
    DateTime date,
  );
}

/// See also [AppointmentNotifier].
@ProviderFor(AppointmentNotifier)
const appointmentNotifierProvider = AppointmentNotifierFamily();

/// See also [AppointmentNotifier].
class AppointmentNotifierFamily extends Family<AsyncValue<List<String>>> {
  /// See also [AppointmentNotifier].
  const AppointmentNotifierFamily();

  /// See also [AppointmentNotifier].
  AppointmentNotifierProvider call(
    String doctorId,
    DateTime date,
  ) {
    return AppointmentNotifierProvider(
      doctorId,
      date,
    );
  }

  @override
  AppointmentNotifierProvider getProviderOverride(
    covariant AppointmentNotifierProvider provider,
  ) {
    return call(
      provider.doctorId,
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'appointmentNotifierProvider';
}

/// See also [AppointmentNotifier].
class AppointmentNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AppointmentNotifier, List<String>> {
  /// See also [AppointmentNotifier].
  AppointmentNotifierProvider(
    String doctorId,
    DateTime date,
  ) : this._internal(
          () => AppointmentNotifier()
            ..doctorId = doctorId
            ..date = date,
          from: appointmentNotifierProvider,
          name: r'appointmentNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentNotifierHash,
          dependencies: AppointmentNotifierFamily._dependencies,
          allTransitiveDependencies:
              AppointmentNotifierFamily._allTransitiveDependencies,
          doctorId: doctorId,
          date: date,
        );

  AppointmentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.doctorId,
    required this.date,
  }) : super.internal();

  final String doctorId;
  final DateTime date;

  @override
  FutureOr<List<String>> runNotifierBuild(
    covariant AppointmentNotifier notifier,
  ) {
    return notifier.build(
      doctorId,
      date,
    );
  }

  @override
  Override overrideWith(AppointmentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppointmentNotifierProvider._internal(
        () => create()
          ..doctorId = doctorId
          ..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        doctorId: doctorId,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AppointmentNotifier, List<String>>
      createElement() {
    return _AppointmentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentNotifierProvider &&
        other.doctorId == doctorId &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, doctorId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AppointmentNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<String>> {
  /// The parameter `doctorId` of this provider.
  String get doctorId;

  /// The parameter `date` of this provider.
  DateTime get date;
}

class _AppointmentNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AppointmentNotifier,
        List<String>> with AppointmentNotifierRef {
  _AppointmentNotifierProviderElement(super.provider);

  @override
  String get doctorId => (origin as AppointmentNotifierProvider).doctorId;
  @override
  DateTime get date => (origin as AppointmentNotifierProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
