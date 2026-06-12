// This is a generated file - do not edit.
//
// Generated from wifi.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'wifi.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'wifi.pbenum.dart';

/// Descriptor for the live preview stream. Returned alongside
/// WifiDirectGroupResponse or updated mid-session (e.g., bitrate drop).
class PreviewStreamDescriptor extends $pb.GeneratedMessage {
  factory PreviewStreamDescriptor({
    $core.String? url,
    PreviewCodec? codec,
    $core.int? width,
    $core.int? height,
    $core.int? fps,
    $core.int? bitrateKbps,
  }) {
    final result = create();
    if (url != null) result.url = url;
    if (codec != null) result.codec = codec;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (fps != null) result.fps = fps;
    if (bitrateKbps != null) result.bitrateKbps = bitrateKbps;
    return result;
  }

  PreviewStreamDescriptor._();

  factory PreviewStreamDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PreviewStreamDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreviewStreamDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aE<PreviewCodec>(2, _omitFieldNames ? '' : 'codec',
        enumValues: PreviewCodec.values)
    ..aI(3, _omitFieldNames ? '' : 'width', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'height', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'fps', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'bitrateKbps',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreviewStreamDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreviewStreamDescriptor copyWith(
          void Function(PreviewStreamDescriptor) updates) =>
      super.copyWith((message) => updates(message as PreviewStreamDescriptor))
          as PreviewStreamDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreviewStreamDescriptor create() => PreviewStreamDescriptor._();
  @$core.override
  PreviewStreamDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PreviewStreamDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreviewStreamDescriptor>(create);
  static PreviewStreamDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  PreviewCodec get codec => $_getN(1);
  @$pb.TagNumber(2)
  set codec(PreviewCodec value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCodec() => $_has(1);
  @$pb.TagNumber(2)
  void clearCodec() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get height => $_getIZ(3);
  @$pb.TagNumber(4)
  set height($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get fps => $_getIZ(4);
  @$pb.TagNumber(5)
  set fps($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFps() => $_has(4);
  @$pb.TagNumber(5)
  void clearFps() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get bitrateKbps => $_getIZ(5);
  @$pb.TagNumber(6)
  set bitrateKbps($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBitrateKbps() => $_has(5);
  @$pb.TagNumber(6)
  void clearBitrateKbps() => $_clearField(6);
}

/// App-side heartbeat: fired at the codec's nominal frame rate so other UI
/// surfaces can detect "frames flowing" without subscribing to the RTSP byte
/// stream. Carries no pixel data.
class PreviewFrame extends $pb.GeneratedMessage {
  factory PreviewFrame({
    $fixnum.Int64? sequence,
    $fixnum.Int64? captureUnixMs,
  }) {
    final result = create();
    if (sequence != null) result.sequence = sequence;
    if (captureUnixMs != null) result.captureUnixMs = captureUnixMs;
    return result;
  }

  PreviewFrame._();

  factory PreviewFrame.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PreviewFrame.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreviewFrame',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'captureUnixMs', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreviewFrame clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreviewFrame copyWith(void Function(PreviewFrame) updates) =>
      super.copyWith((message) => updates(message as PreviewFrame))
          as PreviewFrame;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreviewFrame create() => PreviewFrame._();
  @$core.override
  PreviewFrame createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PreviewFrame getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreviewFrame>(create);
  static PreviewFrame? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sequence => $_getI64(0);
  @$pb.TagNumber(1)
  set sequence($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get captureUnixMs => $_getI64(1);
  @$pb.TagNumber(2)
  set captureUnixMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCaptureUnixMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaptureUnixMs() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
