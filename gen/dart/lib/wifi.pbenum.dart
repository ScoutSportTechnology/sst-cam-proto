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

import 'package:protobuf/protobuf.dart' as $pb;

class PreviewCodec extends $pb.ProtobufEnum {
  static const PreviewCodec PREVIEW_CODEC_UNKNOWN =
      PreviewCodec._(0, _omitEnumNames ? '' : 'PREVIEW_CODEC_UNKNOWN');
  static const PreviewCodec PREVIEW_CODEC_RTSP_H264 =
      PreviewCodec._(1, _omitEnumNames ? '' : 'PREVIEW_CODEC_RTSP_H264');

  static const $core.List<PreviewCodec> values = <PreviewCodec>[
    PREVIEW_CODEC_UNKNOWN,
    PREVIEW_CODEC_RTSP_H264,
  ];

  static final $core.List<PreviewCodec?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static PreviewCodec? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PreviewCodec._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
