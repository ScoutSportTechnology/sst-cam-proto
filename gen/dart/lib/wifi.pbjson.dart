// This is a generated file - do not edit.
//
// Generated from wifi.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use previewCodecDescriptor instead')
const PreviewCodec$json = {
  '1': 'PreviewCodec',
  '2': [
    {'1': 'PREVIEW_CODEC_UNKNOWN', '2': 0},
    {'1': 'PREVIEW_CODEC_RTSP_H264', '2': 1},
  ],
  '4': [
    {'1': 2, '2': 2},
  ],
  '5': ['PREVIEW_MJPEG_HTTP', 'PREVIEW_WEBRTC_H264'],
};

/// Descriptor for `PreviewCodec`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List previewCodecDescriptor = $convert.base64Decode(
    'CgxQcmV2aWV3Q29kZWMSGQoVUFJFVklFV19DT0RFQ19VTktOT1dOEAASGwoXUFJFVklFV19DT0'
    'RFQ19SVFNQX0gyNjQQASIECAIQAioSUFJFVklFV19NSlBFR19IVFRQKhNQUkVWSUVXX1dFQlJU'
    'Q19IMjY0');

@$core.Deprecated('Use previewStreamDescriptorDescriptor instead')
const PreviewStreamDescriptor$json = {
  '1': 'PreviewStreamDescriptor',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {
      '1': 'codec',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.PreviewCodec',
      '10': 'codec'
    },
    {'1': 'width', '3': 3, '4': 1, '5': 13, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 13, '10': 'height'},
    {'1': 'fps', '3': 5, '4': 1, '5': 13, '10': 'fps'},
    {'1': 'bitrate_kbps', '3': 6, '4': 1, '5': 13, '10': 'bitrateKbps'},
  ],
};

/// Descriptor for `PreviewStreamDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List previewStreamDescriptorDescriptor = $convert.base64Decode(
    'ChdQcmV2aWV3U3RyZWFtRGVzY3JpcHRvchIQCgN1cmwYASABKAlSA3VybBIrCgVjb2RlYxgCIA'
    'EoDjIVLnNzdF9jYW0uUHJldmlld0NvZGVjUgVjb2RlYxIUCgV3aWR0aBgDIAEoDVIFd2lkdGgS'
    'FgoGaGVpZ2h0GAQgASgNUgZoZWlnaHQSEAoDZnBzGAUgASgNUgNmcHMSIQoMYml0cmF0ZV9rYn'
    'BzGAYgASgNUgtiaXRyYXRlS2Jwcw==');

@$core.Deprecated('Use previewFrameDescriptor instead')
const PreviewFrame$json = {
  '1': 'PreviewFrame',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 4, '10': 'sequence'},
    {'1': 'capture_unix_ms', '3': 2, '4': 1, '5': 4, '10': 'captureUnixMs'},
  ],
  '9': [
    {'1': 3, '2': 4},
  ],
  '10': ['jpeg_bytes'],
};

/// Descriptor for `PreviewFrame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List previewFrameDescriptor = $convert.base64Decode(
    'CgxQcmV2aWV3RnJhbWUSGgoIc2VxdWVuY2UYASABKARSCHNlcXVlbmNlEiYKD2NhcHR1cmVfdW'
    '5peF9tcxgCIAEoBFINY2FwdHVyZVVuaXhNc0oECAMQBFIKanBlZ19ieXRlcw==');
