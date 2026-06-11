// This is a generated file - do not edit.
//
// Generated from bluetooth.proto.

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

@$core.Deprecated('Use responseStatusDescriptor instead')
const ResponseStatus$json = {
  '1': 'ResponseStatus',
  '2': [
    {'1': 'OK', '2': 0},
    {'1': 'ERROR', '2': 1},
    {'1': 'TIMEOUT', '2': 2},
    {'1': 'UNSUPPORTED', '2': 3},
  ],
};

/// Descriptor for `ResponseStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List responseStatusDescriptor = $convert.base64Decode(
    'Cg5SZXNwb25zZVN0YXR1cxIGCgJPSxAAEgkKBUVSUk9SEAESCwoHVElNRU9VVBACEg8KC1VOU1'
    'VQUE9SVEVEEAM=');

@$core.Deprecated('Use wifiStateDescriptor instead')
const WifiState$json = {
  '1': 'WifiState',
  '2': [
    {'1': 'WIFI_UNKNOWN', '2': 0},
    {'1': 'WIFI_DISABLED', '2': 1},
    {'1': 'WIFI_DISCONNECTED', '2': 2},
    {'1': 'WIFI_CONNECTED', '2': 3},
  ],
};

/// Descriptor for `WifiState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List wifiStateDescriptor = $convert.base64Decode(
    'CglXaWZpU3RhdGUSEAoMV0lGSV9VTktOT1dOEAASEQoNV0lGSV9ESVNBQkxFRBABEhUKEVdJRk'
    'lfRElTQ09OTkVDVEVEEAISEgoOV0lGSV9DT05ORUNURUQQAw==');

@$core.Deprecated('Use sportDescriptor instead')
const Sport$json = {
  '1': 'Sport',
  '2': [
    {'1': 'SPORT_UNKNOWN', '2': 0},
    {'1': 'SPORT_SOCCER', '2': 1},
    {'1': 'SPORT_BASKETBALL', '2': 2},
    {'1': 'SPORT_AMERICAN_FOOTBALL', '2': 3},
    {'1': 'SPORT_VOLLEYBALL', '2': 4},
    {'1': 'SPORT_HOCKEY', '2': 5},
    {'1': 'SPORT_BASEBALL', '2': 6},
    {'1': 'SPORT_RUGBY', '2': 7},
    {'1': 'SPORT_OTHER', '2': 99},
  ],
};

/// Descriptor for `Sport`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sportDescriptor = $convert.base64Decode(
    'CgVTcG9ydBIRCg1TUE9SVF9VTktOT1dOEAASEAoMU1BPUlRfU09DQ0VSEAESFAoQU1BPUlRfQk'
    'FTS0VUQkFMTBACEhsKF1NQT1JUX0FNRVJJQ0FOX0ZPT1RCQUxMEAMSFAoQU1BPUlRfVk9MTEVZ'
    'QkFMTBAEEhAKDFNQT1JUX0hPQ0tFWRAFEhIKDlNQT1JUX0JBU0VCQUxMEAYSDwoLU1BPUlRfUl'
    'VHQlkQBxIPCgtTUE9SVF9PVEhFUhBj');

@$core.Deprecated('Use playerPositionDescriptor instead')
const PlayerPosition$json = {
  '1': 'PlayerPosition',
  '2': [
    {'1': 'POSITION_UNKNOWN', '2': 0},
    {'1': 'POSITION_KEEPER', '2': 1},
    {'1': 'POSITION_DEFENDER', '2': 2},
    {'1': 'POSITION_MID', '2': 3},
    {'1': 'POSITION_FORWARD', '2': 4},
    {'1': 'POSITION_OTHER', '2': 99},
  ],
};

/// Descriptor for `PlayerPosition`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerPositionDescriptor = $convert.base64Decode(
    'Cg5QbGF5ZXJQb3NpdGlvbhIUChBQT1NJVElPTl9VTktOT1dOEAASEwoPUE9TSVRJT05fS0VFUE'
    'VSEAESFQoRUE9TSVRJT05fREVGRU5ERVIQAhIQCgxQT1NJVElPTl9NSUQQAxIUChBQT1NJVElP'
    'Tl9GT1JXQVJEEAQSEgoOUE9TSVRJT05fT1RIRVIQYw==');

@$core.Deprecated('Use matchControlActionDescriptor instead')
const MatchControlAction$json = {
  '1': 'MatchControlAction',
  '2': [
    {'1': 'MATCH_ACTION_UNKNOWN', '2': 0},
    {'1': 'MATCH_KICKOFF', '2': 1},
    {'1': 'MATCH_PERIOD_END', '2': 2},
    {'1': 'MATCH_PERIOD_START', '2': 3},
    {'1': 'MATCH_FINAL_WHISTLE', '2': 4},
    {'1': 'MATCH_CLOCK_PAUSE', '2': 5},
    {'1': 'MATCH_CLOCK_RESUME', '2': 6},
  ],
};

/// Descriptor for `MatchControlAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List matchControlActionDescriptor = $convert.base64Decode(
    'ChJNYXRjaENvbnRyb2xBY3Rpb24SGAoUTUFUQ0hfQUNUSU9OX1VOS05PV04QABIRCg1NQVRDSF'
    '9LSUNLT0ZGEAESFAoQTUFUQ0hfUEVSSU9EX0VORBACEhYKEk1BVENIX1BFUklPRF9TVEFSVBAD'
    'EhcKE01BVENIX0ZJTkFMX1dISVNUTEUQBBIVChFNQVRDSF9DTE9DS19QQVVTRRAFEhYKEk1BVE'
    'NIX0NMT0NLX1JFU1VNRRAG');

@$core.Deprecated('Use matchStatusDescriptor instead')
const MatchStatus$json = {
  '1': 'MatchStatus',
  '2': [
    {'1': 'MATCH_STATUS_UNKNOWN', '2': 0},
    {'1': 'MATCH_NOT_STARTED', '2': 1},
    {'1': 'MATCH_ACTIVE', '2': 2},
    {'1': 'MATCH_PAUSED', '2': 3},
    {'1': 'MATCH_HALF_TIME', '2': 4},
    {'1': 'MATCH_FINISHED', '2': 5},
  ],
};

/// Descriptor for `MatchStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List matchStatusDescriptor = $convert.base64Decode(
    'CgtNYXRjaFN0YXR1cxIYChRNQVRDSF9TVEFUVVNfVU5LTk9XThAAEhUKEU1BVENIX05PVF9TVE'
    'FSVEVEEAESEAoMTUFUQ0hfQUNUSVZFEAISEAoMTUFUQ0hfUEFVU0VEEAMSEwoPTUFUQ0hfSEFM'
    'Rl9USU1FEAQSEgoOTUFUQ0hfRklOSVNIRUQQBQ==');

@$core.Deprecated('Use recordingActionDescriptor instead')
const RecordingAction$json = {
  '1': 'RecordingAction',
  '2': [
    {'1': 'RECORDING_ACTION_UNKNOWN', '2': 0},
    {'1': 'RECORDING_START', '2': 1},
    {'1': 'RECORDING_STOP', '2': 2},
    {'1': 'RECORDING_PAUSE', '2': 3},
    {'1': 'RECORDING_RESUME', '2': 4},
  ],
};

/// Descriptor for `RecordingAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recordingActionDescriptor = $convert.base64Decode(
    'Cg9SZWNvcmRpbmdBY3Rpb24SHAoYUkVDT1JESU5HX0FDVElPTl9VTktOT1dOEAASEwoPUkVDT1'
    'JESU5HX1NUQVJUEAESEgoOUkVDT1JESU5HX1NUT1AQAhITCg9SRUNPUkRJTkdfUEFVU0UQAxIU'
    'ChBSRUNPUkRJTkdfUkVTVU1FEAQ=');

@$core.Deprecated('Use streamingActionDescriptor instead')
const StreamingAction$json = {
  '1': 'StreamingAction',
  '2': [
    {'1': 'STREAMING_ACTION_UNKNOWN', '2': 0},
    {'1': 'STREAMING_START', '2': 1},
    {'1': 'STREAMING_STOP', '2': 2},
  ],
};

/// Descriptor for `StreamingAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List streamingActionDescriptor = $convert.base64Decode(
    'Cg9TdHJlYW1pbmdBY3Rpb24SHAoYU1RSRUFNSU5HX0FDVElPTl9VTktOT1dOEAASEwoPU1RSRU'
    'FNSU5HX1NUQVJUEAESEgoOU1RSRUFNSU5HX1NUT1AQAg==');

@$core.Deprecated('Use overlayShapeDescriptor instead')
const OverlayShape$json = {
  '1': 'OverlayShape',
  '2': [
    {'1': 'SHAPE_UNKNOWN', '2': 0},
    {'1': 'SHAPE_RECT', '2': 1},
    {'1': 'SHAPE_TEXT', '2': 2},
    {'1': 'SHAPE_CIRCLE', '2': 3},
  ],
};

/// Descriptor for `OverlayShape`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List overlayShapeDescriptor = $convert.base64Decode(
    'CgxPdmVybGF5U2hhcGUSEQoNU0hBUEVfVU5LTk9XThAAEg4KClNIQVBFX1JFQ1QQARIOCgpTSE'
    'FQRV9URVhUEAISEAoMU0hBUEVfQ0lSQ0xFEAM=');

@$core.Deprecated('Use overlayBindingDescriptor instead')
const OverlayBinding$json = {
  '1': 'OverlayBinding',
  '2': [
    {'1': 'BINDING_STATIC', '2': 0},
    {'1': 'BINDING_SCORE_A', '2': 1},
    {'1': 'BINDING_SCORE_B', '2': 2},
    {'1': 'BINDING_SCORE_VS', '2': 3},
    {'1': 'BINDING_TEAM_A_NAME', '2': 4},
    {'1': 'BINDING_TEAM_B_NAME', '2': 5},
    {'1': 'BINDING_MATCH_CLOCK', '2': 6},
    {'1': 'BINDING_PERIOD_LABEL', '2': 7},
  ],
};

/// Descriptor for `OverlayBinding`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List overlayBindingDescriptor = $convert.base64Decode(
    'Cg5PdmVybGF5QmluZGluZxISCg5CSU5ESU5HX1NUQVRJQxAAEhMKD0JJTkRJTkdfU0NPUkVfQR'
    'ABEhMKD0JJTkRJTkdfU0NPUkVfQhACEhQKEEJJTkRJTkdfU0NPUkVfVlMQAxIXChNCSU5ESU5H'
    'X1RFQU1fQV9OQU1FEAQSFwoTQklORElOR19URUFNX0JfTkFNRRAFEhcKE0JJTkRJTkdfTUFUQ0'
    'hfQ0xPQ0sQBhIYChRCSU5ESU5HX1BFUklPRF9MQUJFTBAH');

@$core.Deprecated('Use textAlignDescriptor instead')
const TextAlign$json = {
  '1': 'TextAlign',
  '2': [
    {'1': 'TEXT_ALIGN_LEFT', '2': 0},
    {'1': 'TEXT_ALIGN_CENTER', '2': 1},
    {'1': 'TEXT_ALIGN_RIGHT', '2': 2},
  ],
};

/// Descriptor for `TextAlign`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List textAlignDescriptor = $convert.base64Decode(
    'CglUZXh0QWxpZ24SEwoPVEVYVF9BTElHTl9MRUZUEAASFQoRVEVYVF9BTElHTl9DRU5URVIQAR'
    'IUChBURVhUX0FMSUdOX1JJR0hUEAI=');

@$core.Deprecated('Use fontWeightDescriptor instead')
const FontWeight$json = {
  '1': 'FontWeight',
  '2': [
    {'1': 'FONT_WEIGHT_NORMAL', '2': 0},
    {'1': 'FONT_WEIGHT_BOLD', '2': 1},
  ],
};

/// Descriptor for `FontWeight`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fontWeightDescriptor = $convert.base64Decode(
    'CgpGb250V2VpZ2h0EhYKEkZPTlRfV0VJR0hUX05PUk1BTBAAEhQKEEZPTlRfV0VJR0hUX0JPTE'
    'QQAQ==');

@$core.Deprecated('Use chunkedPayloadDescriptor instead')
const ChunkedPayload$json = {
  '1': 'ChunkedPayload',
  '2': [
    {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    {'1': 'chunk_index', '3': 2, '4': 1, '5': 13, '10': 'chunkIndex'},
    {'1': 'total_chunks', '3': 3, '4': 1, '5': 13, '10': 'totalChunks'},
    {'1': 'data', '3': 4, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ChunkedPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chunkedPayloadDescriptor = $convert.base64Decode(
    'Cg5DaHVua2VkUGF5bG9hZBIlCg5jb3JyZWxhdGlvbl9pZBgBIAEoCVINY29ycmVsYXRpb25JZB'
    'IfCgtjaHVua19pbmRleBgCIAEoDVIKY2h1bmtJbmRleBIhCgx0b3RhbF9jaHVua3MYAyABKA1S'
    'C3RvdGFsQ2h1bmtzEhIKBGRhdGEYBCABKAxSBGRhdGE=');

@$core.Deprecated('Use chunkAckDescriptor instead')
const ChunkAck$json = {
  '1': 'ChunkAck',
  '2': [
    {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    {'1': 'chunk_index', '3': 2, '4': 1, '5': 13, '10': 'chunkIndex'},
  ],
  '9': [
    {'1': 3, '2': 4},
  ],
};

/// Descriptor for `ChunkAck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chunkAckDescriptor = $convert.base64Decode(
    'CghDaHVua0FjaxIlCg5jb3JyZWxhdGlvbl9pZBgBIAEoCVINY29ycmVsYXRpb25JZBIfCgtjaH'
    'Vua19pbmRleBgCIAEoDVIKY2h1bmtJbmRleEoECAMQBA==');

@$core.Deprecated('Use commandDescriptor instead')
const Command$json = {
  '1': 'Command',
  '2': [
    {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    {
      '1': 'get_device_info',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.GetDeviceInfoCommand',
      '9': 0,
      '10': 'getDeviceInfo'
    },
    {
      '1': 'thumbnail',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.ThumbnailRequest',
      '9': 0,
      '10': 'thumbnail'
    },
    {
      '1': 'get_telemetry',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.GetTelemetryCommand',
      '9': 0,
      '10': 'getTelemetry'
    },
    {
      '1': 'get_match_state',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.GetMatchStateCommand',
      '9': 0,
      '10': 'getMatchState'
    },
    {
      '1': 'match_control',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.MatchControlCommand',
      '9': 0,
      '10': 'matchControl'
    },
    {
      '1': 'score_update',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.ScoreUpdateCommand',
      '9': 0,
      '10': 'scoreUpdate'
    },
    {
      '1': 'banner_event',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.BannerEventCommand',
      '9': 0,
      '10': 'bannerEvent'
    },
    {
      '1': 'recording_control',
      '3': 30,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.RecordingControlCommand',
      '9': 0,
      '10': 'recordingControl'
    },
    {
      '1': 'streaming_control',
      '3': 31,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.StreamingControlCommand',
      '9': 0,
      '10': 'streamingControl'
    },
    {
      '1': 'list_recordings',
      '3': 32,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.ListRecordingsCommand',
      '9': 0,
      '10': 'listRecordings'
    },
    {
      '1': 'download_request',
      '3': 33,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.DownloadRequestCommand',
      '9': 0,
      '10': 'downloadRequest'
    },
    {
      '1': 'raw_capture',
      '3': 34,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.RawCaptureControlCommand',
      '9': 0,
      '10': 'rawCapture'
    },
    {
      '1': 'set_wifi_config',
      '3': 40,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.SetWifiConfigCommand',
      '9': 0,
      '10': 'setWifiConfig'
    },
    {
      '1': 'set_streaming_config',
      '3': 41,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.SetStreamingConfigCommand',
      '9': 0,
      '10': 'setStreamingConfig'
    },
    {
      '1': 'factory_reset',
      '3': 50,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.FactoryResetCommand',
      '9': 0,
      '10': 'factoryReset'
    },
    {
      '1': 'firmware_update',
      '3': 51,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.FirmwareUpdateCommand',
      '9': 0,
      '10': 'firmwareUpdate'
    },
    {
      '1': 'push_session_config',
      '3': 52,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.PushSessionConfigCommand',
      '9': 0,
      '10': 'pushSessionConfig'
    },
    {
      '1': 'start_wifi_direct',
      '3': 53,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.StartWifiDirectCommand',
      '9': 0,
      '10': 'startWifiDirect'
    },
    {
      '1': 'stop_wifi_direct',
      '3': 54,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.StopWifiDirectCommand',
      '9': 0,
      '10': 'stopWifiDirect'
    },
    {
      '1': 'push_overlay_layout',
      '3': 55,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.PushOverlayLayoutCommand',
      '9': 0,
      '10': 'pushOverlayLayout'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
  '9': [
    {'1': 20, '2': 21},
    {'1': 60, '2': 61},
    {'1': 61, '2': 62},
    {'1': 62, '2': 63},
    {'1': 63, '2': 64},
    {'1': 64, '2': 65},
    {'1': 65, '2': 66},
    {'1': 66, '2': 67},
    {'1': 67, '2': 68},
    {'1': 68, '2': 69},
    {'1': 69, '2': 70},
    {'1': 70, '2': 71},
    {'1': 80, '2': 81},
    {'1': 81, '2': 82},
    {'1': 82, '2': 83},
    {'1': 83, '2': 84},
  ],
  '10': [
    'match_config',
    'list_teams',
    'list_team_matches',
    'create_team',
    'update_team',
    'delete_team',
    'set_team_hidden',
    'add_player',
    'update_player',
    'remove_player',
    'add_team_match',
    'remove_team_match',
    'list_sport_presets',
    'create_sport_preset',
    'update_sport_preset',
    'delete_sport_preset'
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEiUKDmNvcnJlbGF0aW9uX2lkGAEgASgJUg1jb3JyZWxhdGlvbklkEkcKD2dldF'
    '9kZXZpY2VfaW5mbxgKIAEoCzIdLnNzdF9jYW0uR2V0RGV2aWNlSW5mb0NvbW1hbmRIAFINZ2V0'
    'RGV2aWNlSW5mbxI5Cgl0aHVtYm5haWwYCyABKAsyGS5zc3RfY2FtLlRodW1ibmFpbFJlcXVlc3'
    'RIAFIJdGh1bWJuYWlsEkMKDWdldF90ZWxlbWV0cnkYDCABKAsyHC5zc3RfY2FtLkdldFRlbGVt'
    'ZXRyeUNvbW1hbmRIAFIMZ2V0VGVsZW1ldHJ5EkcKD2dldF9tYXRjaF9zdGF0ZRgNIAEoCzIdLn'
    'NzdF9jYW0uR2V0TWF0Y2hTdGF0ZUNvbW1hbmRIAFINZ2V0TWF0Y2hTdGF0ZRJDCg1tYXRjaF9j'
    'b250cm9sGBUgASgLMhwuc3N0X2NhbS5NYXRjaENvbnRyb2xDb21tYW5kSABSDG1hdGNoQ29udH'
    'JvbBJACgxzY29yZV91cGRhdGUYFiABKAsyGy5zc3RfY2FtLlNjb3JlVXBkYXRlQ29tbWFuZEgA'
    'UgtzY29yZVVwZGF0ZRJACgxiYW5uZXJfZXZlbnQYFyABKAsyGy5zc3RfY2FtLkJhbm5lckV2ZW'
    '50Q29tbWFuZEgAUgtiYW5uZXJFdmVudBJPChFyZWNvcmRpbmdfY29udHJvbBgeIAEoCzIgLnNz'
    'dF9jYW0uUmVjb3JkaW5nQ29udHJvbENvbW1hbmRIAFIQcmVjb3JkaW5nQ29udHJvbBJPChFzdH'
    'JlYW1pbmdfY29udHJvbBgfIAEoCzIgLnNzdF9jYW0uU3RyZWFtaW5nQ29udHJvbENvbW1hbmRI'
    'AFIQc3RyZWFtaW5nQ29udHJvbBJJCg9saXN0X3JlY29yZGluZ3MYICABKAsyHi5zc3RfY2FtLk'
    'xpc3RSZWNvcmRpbmdzQ29tbWFuZEgAUg5saXN0UmVjb3JkaW5ncxJMChBkb3dubG9hZF9yZXF1'
    'ZXN0GCEgASgLMh8uc3N0X2NhbS5Eb3dubG9hZFJlcXVlc3RDb21tYW5kSABSD2Rvd25sb2FkUm'
    'VxdWVzdBJECgtyYXdfY2FwdHVyZRgiIAEoCzIhLnNzdF9jYW0uUmF3Q2FwdHVyZUNvbnRyb2xD'
    'b21tYW5kSABSCnJhd0NhcHR1cmUSRwoPc2V0X3dpZmlfY29uZmlnGCggASgLMh0uc3N0X2NhbS'
    '5TZXRXaWZpQ29uZmlnQ29tbWFuZEgAUg1zZXRXaWZpQ29uZmlnElYKFHNldF9zdHJlYW1pbmdf'
    'Y29uZmlnGCkgASgLMiIuc3N0X2NhbS5TZXRTdHJlYW1pbmdDb25maWdDb21tYW5kSABSEnNldF'
    'N0cmVhbWluZ0NvbmZpZxJDCg1mYWN0b3J5X3Jlc2V0GDIgASgLMhwuc3N0X2NhbS5GYWN0b3J5'
    'UmVzZXRDb21tYW5kSABSDGZhY3RvcnlSZXNldBJJCg9maXJtd2FyZV91cGRhdGUYMyABKAsyHi'
    '5zc3RfY2FtLkZpcm13YXJlVXBkYXRlQ29tbWFuZEgAUg5maXJtd2FyZVVwZGF0ZRJTChNwdXNo'
    'X3Nlc3Npb25fY29uZmlnGDQgASgLMiEuc3N0X2NhbS5QdXNoU2Vzc2lvbkNvbmZpZ0NvbW1hbm'
    'RIAFIRcHVzaFNlc3Npb25Db25maWcSTQoRc3RhcnRfd2lmaV9kaXJlY3QYNSABKAsyHy5zc3Rf'
    'Y2FtLlN0YXJ0V2lmaURpcmVjdENvbW1hbmRIAFIPc3RhcnRXaWZpRGlyZWN0EkoKEHN0b3Bfd2'
    'lmaV9kaXJlY3QYNiABKAsyHi5zc3RfY2FtLlN0b3BXaWZpRGlyZWN0Q29tbWFuZEgAUg5zdG9w'
    'V2lmaURpcmVjdBJTChNwdXNoX292ZXJsYXlfbGF5b3V0GDcgASgLMiEuc3N0X2NhbS5QdXNoT3'
    'ZlcmxheUxheW91dENvbW1hbmRIAFIRcHVzaE92ZXJsYXlMYXlvdXRCCQoHcGF5bG9hZEoECBQQ'
    'FUoECDwQPUoECD0QPkoECD4QP0oECD8QQEoECEAQQUoECEEQQkoECEIQQ0oECEMQREoECEQQRU'
    'oECEUQRkoECEYQR0oECFAQUUoECFEQUkoECFIQU0oECFMQVFIMbWF0Y2hfY29uZmlnUgpsaXN0'
    'X3RlYW1zUhFsaXN0X3RlYW1fbWF0Y2hlc1ILY3JlYXRlX3RlYW1SC3VwZGF0ZV90ZWFtUgtkZW'
    'xldGVfdGVhbVIPc2V0X3RlYW1faGlkZGVuUgphZGRfcGxheWVyUg11cGRhdGVfcGxheWVyUg1y'
    'ZW1vdmVfcGxheWVyUg5hZGRfdGVhbV9tYXRjaFIRcmVtb3ZlX3RlYW1fbWF0Y2hSEmxpc3Rfc3'
    'BvcnRfcHJlc2V0c1ITY3JlYXRlX3Nwb3J0X3ByZXNldFITdXBkYXRlX3Nwb3J0X3ByZXNldFIT'
    'ZGVsZXRlX3Nwb3J0X3ByZXNldA==');

@$core.Deprecated('Use commandResponseDescriptor instead')
const CommandResponse$json = {
  '1': 'CommandResponse',
  '2': [
    {'1': 'correlation_id', '3': 1, '4': 1, '5': 9, '10': 'correlationId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.ResponseStatus',
      '10': 'status'
    },
    {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    {
      '1': 'device_info',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.DeviceInfoResponse',
      '9': 0,
      '10': 'deviceInfo'
    },
    {
      '1': 'thumbnail',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.ThumbnailResponse',
      '9': 0,
      '10': 'thumbnail'
    },
    {
      '1': 'recording_list',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.RecordingListResponse',
      '9': 0,
      '10': 'recordingList'
    },
    {
      '1': 'download_token',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.DownloadTokenResponse',
      '9': 0,
      '10': 'downloadToken'
    },
    {
      '1': 'telemetry',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.DeviceTelemetry',
      '9': 0,
      '10': 'telemetry'
    },
    {
      '1': 'match_state',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.MatchState',
      '9': 0,
      '10': 'matchState'
    },
    {
      '1': 'wifi_direct_group',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.WifiDirectGroupResponse',
      '9': 0,
      '10': 'wifiDirectGroup'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
  '9': [
    {'1': 16, '2': 17},
    {'1': 17, '2': 18},
    {'1': 18, '2': 19},
    {'1': 19, '2': 20},
    {'1': 20, '2': 21},
    {'1': 21, '2': 22},
    {'1': 22, '2': 23},
  ],
  '10': [
    'team_list',
    'team_match_list',
    'team',
    'player',
    'team_match',
    'sport_preset_list',
    'sport_preset'
  ],
};

/// Descriptor for `CommandResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandResponseDescriptor = $convert.base64Decode(
    'Cg9Db21tYW5kUmVzcG9uc2USJQoOY29ycmVsYXRpb25faWQYASABKAlSDWNvcnJlbGF0aW9uSW'
    'QSLwoGc3RhdHVzGAIgASgOMhcuc3N0X2NhbS5SZXNwb25zZVN0YXR1c1IGc3RhdHVzEiMKDWVy'
    'cm9yX21lc3NhZ2UYAyABKAlSDGVycm9yTWVzc2FnZRI+CgtkZXZpY2VfaW5mbxgKIAEoCzIbLn'
    'NzdF9jYW0uRGV2aWNlSW5mb1Jlc3BvbnNlSABSCmRldmljZUluZm8SOgoJdGh1bWJuYWlsGAsg'
    'ASgLMhouc3N0X2NhbS5UaHVtYm5haWxSZXNwb25zZUgAUgl0aHVtYm5haWwSRwoOcmVjb3JkaW'
    '5nX2xpc3QYDCABKAsyHi5zc3RfY2FtLlJlY29yZGluZ0xpc3RSZXNwb25zZUgAUg1yZWNvcmRp'
    'bmdMaXN0EkcKDmRvd25sb2FkX3Rva2VuGA0gASgLMh4uc3N0X2NhbS5Eb3dubG9hZFRva2VuUm'
    'VzcG9uc2VIAFINZG93bmxvYWRUb2tlbhI4Cgl0ZWxlbWV0cnkYDiABKAsyGC5zc3RfY2FtLkRl'
    'dmljZVRlbGVtZXRyeUgAUgl0ZWxlbWV0cnkSNgoLbWF0Y2hfc3RhdGUYDyABKAsyEy5zc3RfY2'
    'FtLk1hdGNoU3RhdGVIAFIKbWF0Y2hTdGF0ZRJOChF3aWZpX2RpcmVjdF9ncm91cBgXIAEoCzIg'
    'LnNzdF9jYW0uV2lmaURpcmVjdEdyb3VwUmVzcG9uc2VIAFIPd2lmaURpcmVjdEdyb3VwQgkKB3'
    'BheWxvYWRKBAgQEBFKBAgREBJKBAgSEBNKBAgTEBRKBAgUEBVKBAgVEBZKBAgWEBdSCXRlYW1f'
    'bGlzdFIPdGVhbV9tYXRjaF9saXN0UgR0ZWFtUgZwbGF5ZXJSCnRlYW1fbWF0Y2hSEXNwb3J0X3'
    'ByZXNldF9saXN0UgxzcG9ydF9wcmVzZXQ=');

@$core.Deprecated('Use getDeviceInfoCommandDescriptor instead')
const GetDeviceInfoCommand$json = {
  '1': 'GetDeviceInfoCommand',
};

/// Descriptor for `GetDeviceInfoCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceInfoCommandDescriptor =
    $convert.base64Decode('ChRHZXREZXZpY2VJbmZvQ29tbWFuZA==');

@$core.Deprecated('Use getTelemetryCommandDescriptor instead')
const GetTelemetryCommand$json = {
  '1': 'GetTelemetryCommand',
};

/// Descriptor for `GetTelemetryCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTelemetryCommandDescriptor =
    $convert.base64Decode('ChNHZXRUZWxlbWV0cnlDb21tYW5k');

@$core.Deprecated('Use getMatchStateCommandDescriptor instead')
const GetMatchStateCommand$json = {
  '1': 'GetMatchStateCommand',
};

/// Descriptor for `GetMatchStateCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMatchStateCommandDescriptor =
    $convert.base64Decode('ChRHZXRNYXRjaFN0YXRlQ29tbWFuZA==');

@$core.Deprecated('Use listRecordingsCommandDescriptor instead')
const ListRecordingsCommand$json = {
  '1': 'ListRecordingsCommand',
};

/// Descriptor for `ListRecordingsCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRecordingsCommandDescriptor =
    $convert.base64Decode('ChVMaXN0UmVjb3JkaW5nc0NvbW1hbmQ=');

@$core.Deprecated('Use factoryResetCommandDescriptor instead')
const FactoryResetCommand$json = {
  '1': 'FactoryResetCommand',
};

/// Descriptor for `FactoryResetCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List factoryResetCommandDescriptor =
    $convert.base64Decode('ChNGYWN0b3J5UmVzZXRDb21tYW5k');

@$core.Deprecated('Use firmwareUpdateCommandDescriptor instead')
const FirmwareUpdateCommand$json = {
  '1': 'FirmwareUpdateCommand',
};

/// Descriptor for `FirmwareUpdateCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List firmwareUpdateCommandDescriptor =
    $convert.base64Decode('ChVGaXJtd2FyZVVwZGF0ZUNvbW1hbmQ=');

@$core.Deprecated('Use deviceInfoResponseDescriptor instead')
const DeviceInfoResponse$json = {
  '1': 'DeviceInfoResponse',
  '2': [
    {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'firmware_version', '3': 3, '4': 1, '5': 9, '10': 'firmwareVersion'},
    {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    {'1': 'protocol_version', '3': 5, '4': 1, '5': 13, '10': 'protocolVersion'},
  ],
};

/// Descriptor for `DeviceInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInfoResponseDescriptor = $convert.base64Decode(
    'ChJEZXZpY2VJbmZvUmVzcG9uc2USGwoJZGV2aWNlX2lkGAEgASgJUghkZXZpY2VJZBISCgRuYW'
    '1lGAIgASgJUgRuYW1lEikKEGZpcm13YXJlX3ZlcnNpb24YAyABKAlSD2Zpcm13YXJlVmVyc2lv'
    'bhIUCgVtb2RlbBgEIAEoCVIFbW9kZWwSKQoQcHJvdG9jb2xfdmVyc2lvbhgFIAEoDVIPcHJvdG'
    '9jb2xWZXJzaW9u');

@$core.Deprecated('Use deviceTelemetryDescriptor instead')
const DeviceTelemetry$json = {
  '1': 'DeviceTelemetry',
  '2': [
    {
      '1': 'storage_free_bytes',
      '3': 1,
      '4': 1,
      '5': 4,
      '10': 'storageFreeBytes'
    },
    {
      '1': 'storage_total_bytes',
      '3': 2,
      '4': 1,
      '5': 4,
      '10': 'storageTotalBytes'
    },
    {
      '1': 'wifi_state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.WifiState',
      '10': 'wifiState'
    },
    {'1': 'wifi_ssid', '3': 4, '4': 1, '5': 9, '10': 'wifiSsid'},
    {'1': 'wifi_signal_dbm', '3': 5, '4': 1, '5': 17, '10': 'wifiSignalDbm'},
    {
      '1': 'internet_reachable',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'internetReachable'
    },
    {'1': 'temp_celsius', '3': 7, '4': 1, '5': 2, '10': 'tempCelsius'},
    {'1': 'ram_used_pct', '3': 8, '4': 1, '5': 2, '10': 'ramUsedPct'},
    {'1': 'cpu_used_pct', '3': 9, '4': 1, '5': 2, '10': 'cpuUsedPct'},
    {'1': 'uptime_seconds', '3': 10, '4': 1, '5': 4, '10': 'uptimeSeconds'},
    {'1': 'is_recording', '3': 11, '4': 1, '5': 8, '10': 'isRecording'},
    {'1': 'is_streaming', '3': 12, '4': 1, '5': 8, '10': 'isStreaming'},
    {
      '1': 'battery_level_pct',
      '3': 13,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'batteryLevelPct',
      '17': true
    },
    {
      '1': 'is_raw_capturing',
      '3': 14,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'isRawCapturing',
      '17': true
    },
  ],
  '8': [
    {'1': '_battery_level_pct'},
    {'1': '_is_raw_capturing'},
  ],
};

/// Descriptor for `DeviceTelemetry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceTelemetryDescriptor = $convert.base64Decode(
    'Cg9EZXZpY2VUZWxlbWV0cnkSLAoSc3RvcmFnZV9mcmVlX2J5dGVzGAEgASgEUhBzdG9yYWdlRn'
    'JlZUJ5dGVzEi4KE3N0b3JhZ2VfdG90YWxfYnl0ZXMYAiABKARSEXN0b3JhZ2VUb3RhbEJ5dGVz'
    'EjEKCndpZmlfc3RhdGUYAyABKA4yEi5zc3RfY2FtLldpZmlTdGF0ZVIJd2lmaVN0YXRlEhsKCX'
    'dpZmlfc3NpZBgEIAEoCVIId2lmaVNzaWQSJgoPd2lmaV9zaWduYWxfZGJtGAUgASgRUg13aWZp'
    'U2lnbmFsRGJtEi0KEmludGVybmV0X3JlYWNoYWJsZRgGIAEoCFIRaW50ZXJuZXRSZWFjaGFibG'
    'USIQoMdGVtcF9jZWxzaXVzGAcgASgCUgt0ZW1wQ2Vsc2l1cxIgCgxyYW1fdXNlZF9wY3QYCCAB'
    'KAJSCnJhbVVzZWRQY3QSIAoMY3B1X3VzZWRfcGN0GAkgASgCUgpjcHVVc2VkUGN0EiUKDnVwdG'
    'ltZV9zZWNvbmRzGAogASgEUg11cHRpbWVTZWNvbmRzEiEKDGlzX3JlY29yZGluZxgLIAEoCFIL'
    'aXNSZWNvcmRpbmcSIQoMaXNfc3RyZWFtaW5nGAwgASgIUgtpc1N0cmVhbWluZxIvChFiYXR0ZX'
    'J5X2xldmVsX3BjdBgNIAEoDUgAUg9iYXR0ZXJ5TGV2ZWxQY3SIAQESLQoQaXNfcmF3X2NhcHR1'
    'cmluZxgOIAEoCEgBUg5pc1Jhd0NhcHR1cmluZ4gBAUIUChJfYmF0dGVyeV9sZXZlbF9wY3RCEw'
    'oRX2lzX3Jhd19jYXB0dXJpbmc=');

@$core.Deprecated('Use thumbnailRequestDescriptor instead')
const ThumbnailRequest$json = {
  '1': 'ThumbnailRequest',
  '2': [
    {'1': 'width', '3': 1, '4': 1, '5': 13, '10': 'width'},
    {'1': 'height', '3': 2, '4': 1, '5': 13, '10': 'height'},
    {'1': 'quality', '3': 3, '4': 1, '5': 13, '10': 'quality'},
  ],
};

/// Descriptor for `ThumbnailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thumbnailRequestDescriptor = $convert.base64Decode(
    'ChBUaHVtYm5haWxSZXF1ZXN0EhQKBXdpZHRoGAEgASgNUgV3aWR0aBIWCgZoZWlnaHQYAiABKA'
    '1SBmhlaWdodBIYCgdxdWFsaXR5GAMgASgNUgdxdWFsaXR5');

@$core.Deprecated('Use thumbnailResponseDescriptor instead')
const ThumbnailResponse$json = {
  '1': 'ThumbnailResponse',
  '2': [
    {'1': 'jpeg_bytes', '3': 1, '4': 1, '5': 12, '10': 'jpegBytes'},
    {
      '1': 'capture_timestamp',
      '3': 2,
      '4': 1,
      '5': 4,
      '10': 'captureTimestamp'
    },
  ],
};

/// Descriptor for `ThumbnailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thumbnailResponseDescriptor = $convert.base64Decode(
    'ChFUaHVtYm5haWxSZXNwb25zZRIdCgpqcGVnX2J5dGVzGAEgASgMUglqcGVnQnl0ZXMSKwoRY2'
    'FwdHVyZV90aW1lc3RhbXAYAiABKARSEGNhcHR1cmVUaW1lc3RhbXA=');

@$core.Deprecated('Use matchControlCommandDescriptor instead')
const MatchControlCommand$json = {
  '1': 'MatchControlCommand',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.MatchControlAction',
      '10': 'action'
    },
    {'1': 'period', '3': 2, '4': 1, '5': 13, '10': 'period'},
  ],
};

/// Descriptor for `MatchControlCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchControlCommandDescriptor = $convert.base64Decode(
    'ChNNYXRjaENvbnRyb2xDb21tYW5kEjMKBmFjdGlvbhgBIAEoDjIbLnNzdF9jYW0uTWF0Y2hDb2'
    '50cm9sQWN0aW9uUgZhY3Rpb24SFgoGcGVyaW9kGAIgASgNUgZwZXJpb2Q=');

@$core.Deprecated('Use scoreUpdateCommandDescriptor instead')
const ScoreUpdateCommand$json = {
  '1': 'ScoreUpdateCommand',
  '2': [
    {'1': 'team_id', '3': 1, '4': 1, '5': 9, '10': 'teamId'},
    {'1': 'delta', '3': 2, '4': 1, '5': 17, '10': 'delta'},
  ],
};

/// Descriptor for `ScoreUpdateCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scoreUpdateCommandDescriptor = $convert.base64Decode(
    'ChJTY29yZVVwZGF0ZUNvbW1hbmQSFwoHdGVhbV9pZBgBIAEoCVIGdGVhbUlkEhQKBWRlbHRhGA'
    'IgASgRUgVkZWx0YQ==');

@$core.Deprecated('Use bannerEventCommandDescriptor instead')
const BannerEventCommand$json = {
  '1': 'BannerEventCommand',
  '2': [
    {'1': 'template_id', '3': 1, '4': 1, '5': 9, '10': 'templateId'},
    {
      '1': 'params',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sst_cam.BannerEventCommand.ParamsEntry',
      '10': 'params'
    },
    {'1': 'duration_s', '3': 3, '4': 1, '5': 13, '10': 'durationS'},
    {'1': 'player_id', '3': 4, '4': 1, '5': 9, '10': 'playerId'},
  ],
  '3': [BannerEventCommand_ParamsEntry$json],
};

@$core.Deprecated('Use bannerEventCommandDescriptor instead')
const BannerEventCommand_ParamsEntry$json = {
  '1': 'ParamsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `BannerEventCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bannerEventCommandDescriptor = $convert.base64Decode(
    'ChJCYW5uZXJFdmVudENvbW1hbmQSHwoLdGVtcGxhdGVfaWQYASABKAlSCnRlbXBsYXRlSWQSPw'
    'oGcGFyYW1zGAIgAygLMicuc3N0X2NhbS5CYW5uZXJFdmVudENvbW1hbmQuUGFyYW1zRW50cnlS'
    'BnBhcmFtcxIdCgpkdXJhdGlvbl9zGAMgASgNUglkdXJhdGlvblMSGwoJcGxheWVyX2lkGAQgAS'
    'gJUghwbGF5ZXJJZBo5CgtQYXJhbXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgC'
    'IAEoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use matchStateDescriptor instead')
const MatchState$json = {
  '1': 'MatchState',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.MatchStatus',
      '10': 'status'
    },
    {'1': 'current_period', '3': 2, '4': 1, '5': 13, '10': 'currentPeriod'},
    {'1': 'time_remaining_s', '3': 3, '4': 1, '5': 13, '10': 'timeRemainingS'},
    {'1': 'score_a', '3': 4, '4': 1, '5': 13, '10': 'scoreA'},
    {'1': 'score_b', '3': 5, '4': 1, '5': 13, '10': 'scoreB'},
    {'1': 'team_a_id', '3': 6, '4': 1, '5': 9, '10': 'teamAId'},
    {'1': 'team_b_id', '3': 7, '4': 1, '5': 9, '10': 'teamBId'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 4, '10': 'updatedAt'},
  ],
};

/// Descriptor for `MatchState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchStateDescriptor = $convert.base64Decode(
    'CgpNYXRjaFN0YXRlEiwKBnN0YXR1cxgBIAEoDjIULnNzdF9jYW0uTWF0Y2hTdGF0dXNSBnN0YX'
    'R1cxIlCg5jdXJyZW50X3BlcmlvZBgCIAEoDVINY3VycmVudFBlcmlvZBIoChB0aW1lX3JlbWFp'
    'bmluZ19zGAMgASgNUg50aW1lUmVtYWluaW5nUxIXCgdzY29yZV9hGAQgASgNUgZzY29yZUESFw'
    'oHc2NvcmVfYhgFIAEoDVIGc2NvcmVCEhoKCXRlYW1fYV9pZBgGIAEoCVIHdGVhbUFJZBIaCgl0'
    'ZWFtX2JfaWQYByABKAlSB3RlYW1CSWQSHQoKdXBkYXRlZF9hdBgIIAEoBFIJdXBkYXRlZEF0');

@$core.Deprecated('Use recordingControlCommandDescriptor instead')
const RecordingControlCommand$json = {
  '1': 'RecordingControlCommand',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.RecordingAction',
      '10': 'action'
    },
  ],
};

/// Descriptor for `RecordingControlCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordingControlCommandDescriptor =
    $convert.base64Decode(
        'ChdSZWNvcmRpbmdDb250cm9sQ29tbWFuZBIwCgZhY3Rpb24YASABKA4yGC5zc3RfY2FtLlJlY2'
        '9yZGluZ0FjdGlvblIGYWN0aW9u');

@$core.Deprecated('Use rawCaptureControlCommandDescriptor instead')
const RawCaptureControlCommand$json = {
  '1': 'RawCaptureControlCommand',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.RecordingAction',
      '9': 0,
      '10': 'action',
      '17': true
    },
    {
      '1': 'capture_group_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'captureGroupId',
      '17': true
    },
  ],
  '8': [
    {'1': '_action'},
    {'1': '_capture_group_id'},
  ],
};

/// Descriptor for `RawCaptureControlCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rawCaptureControlCommandDescriptor = $convert.base64Decode(
    'ChhSYXdDYXB0dXJlQ29udHJvbENvbW1hbmQSNQoGYWN0aW9uGAEgASgOMhguc3N0X2NhbS5SZW'
    'NvcmRpbmdBY3Rpb25IAFIGYWN0aW9uiAEBEi0KEGNhcHR1cmVfZ3JvdXBfaWQYAiABKAlIAVIO'
    'Y2FwdHVyZUdyb3VwSWSIAQFCCQoHX2FjdGlvbkITChFfY2FwdHVyZV9ncm91cF9pZA==');

@$core.Deprecated('Use streamingControlCommandDescriptor instead')
const StreamingControlCommand$json = {
  '1': 'StreamingControlCommand',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.StreamingAction',
      '10': 'action'
    },
    {'1': 'destination', '3': 2, '4': 1, '5': 9, '10': 'destination'},
  ],
};

/// Descriptor for `StreamingControlCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamingControlCommandDescriptor = $convert.base64Decode(
    'ChdTdHJlYW1pbmdDb250cm9sQ29tbWFuZBIwCgZhY3Rpb24YASABKA4yGC5zc3RfY2FtLlN0cm'
    'VhbWluZ0FjdGlvblIGYWN0aW9uEiAKC2Rlc3RpbmF0aW9uGAIgASgJUgtkZXN0aW5hdGlvbg==');

@$core.Deprecated('Use recordingMetadataDescriptor instead')
const RecordingMetadata$json = {
  '1': 'RecordingMetadata',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'duration_s', '3': 2, '4': 1, '5': 4, '10': 'durationS'},
    {'1': 'size_bytes', '3': 3, '4': 1, '5': 4, '10': 'sizeBytes'},
    {'1': 'started_at', '3': 4, '4': 1, '5': 4, '10': 'startedAt'},
    {'1': 'sport', '3': 5, '4': 1, '5': 9, '10': 'sport'},
    {'1': 'teams', '3': 6, '4': 1, '5': 9, '10': 'teams'},
    {'1': 'thumbnail_id', '3': 7, '4': 1, '5': 9, '10': 'thumbnailId'},
    {'1': 'is_raw', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'isRaw', '17': true},
    {
      '1': 'camera_index',
      '3': 9,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'cameraIndex',
      '17': true
    },
    {
      '1': 'capture_group_id',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'captureGroupId',
      '17': true
    },
  ],
  '8': [
    {'1': '_is_raw'},
    {'1': '_camera_index'},
    {'1': '_capture_group_id'},
  ],
};

/// Descriptor for `RecordingMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordingMetadataDescriptor = $convert.base64Decode(
    'ChFSZWNvcmRpbmdNZXRhZGF0YRIOCgJpZBgBIAEoCVICaWQSHQoKZHVyYXRpb25fcxgCIAEoBF'
    'IJZHVyYXRpb25TEh0KCnNpemVfYnl0ZXMYAyABKARSCXNpemVCeXRlcxIdCgpzdGFydGVkX2F0'
    'GAQgASgEUglzdGFydGVkQXQSFAoFc3BvcnQYBSABKAlSBXNwb3J0EhQKBXRlYW1zGAYgASgJUg'
    'V0ZWFtcxIhCgx0aHVtYm5haWxfaWQYByABKAlSC3RodW1ibmFpbElkEhoKBmlzX3JhdxgIIAEo'
    'CEgAUgVpc1Jhd4gBARImCgxjYW1lcmFfaW5kZXgYCSABKA1IAVILY2FtZXJhSW5kZXiIAQESLQ'
    'oQY2FwdHVyZV9ncm91cF9pZBgKIAEoCUgCUg5jYXB0dXJlR3JvdXBJZIgBAUIJCgdfaXNfcmF3'
    'Qg8KDV9jYW1lcmFfaW5kZXhCEwoRX2NhcHR1cmVfZ3JvdXBfaWQ=');

@$core.Deprecated('Use recordingListResponseDescriptor instead')
const RecordingListResponse$json = {
  '1': 'RecordingListResponse',
  '2': [
    {
      '1': 'recordings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sst_cam.RecordingMetadata',
      '10': 'recordings'
    },
  ],
};

/// Descriptor for `RecordingListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordingListResponseDescriptor = $convert.base64Decode(
    'ChVSZWNvcmRpbmdMaXN0UmVzcG9uc2USOgoKcmVjb3JkaW5ncxgBIAMoCzIaLnNzdF9jYW0uUm'
    'Vjb3JkaW5nTWV0YWRhdGFSCnJlY29yZGluZ3M=');

@$core.Deprecated('Use downloadRequestCommandDescriptor instead')
const DownloadRequestCommand$json = {
  '1': 'DownloadRequestCommand',
  '2': [
    {'1': 'recording_id', '3': 1, '4': 1, '5': 9, '10': 'recordingId'},
  ],
};

/// Descriptor for `DownloadRequestCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadRequestCommandDescriptor =
    $convert.base64Decode(
        'ChZEb3dubG9hZFJlcXVlc3RDb21tYW5kEiEKDHJlY29yZGluZ19pZBgBIAEoCVILcmVjb3JkaW'
        '5nSWQ=');

@$core.Deprecated('Use downloadTokenResponseDescriptor instead')
const DownloadTokenResponse$json = {
  '1': 'DownloadTokenResponse',
  '2': [
    {'1': 'recording_id', '3': 1, '4': 1, '5': 9, '10': 'recordingId'},
    {'1': 'http_url', '3': 2, '4': 1, '5': 9, '10': 'httpUrl'},
    {'1': 'auth_token', '3': 3, '4': 1, '5': 9, '10': 'authToken'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 4, '10': 'expiresAt'},
  ],
};

/// Descriptor for `DownloadTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTokenResponseDescriptor = $convert.base64Decode(
    'ChVEb3dubG9hZFRva2VuUmVzcG9uc2USIQoMcmVjb3JkaW5nX2lkGAEgASgJUgtyZWNvcmRpbm'
    'dJZBIZCghodHRwX3VybBgCIAEoCVIHaHR0cFVybBIdCgphdXRoX3Rva2VuGAMgASgJUglhdXRo'
    'VG9rZW4SHQoKZXhwaXJlc19hdBgEIAEoBFIJZXhwaXJlc0F0');

@$core.Deprecated('Use setWifiConfigCommandDescriptor instead')
const SetWifiConfigCommand$json = {
  '1': 'SetWifiConfigCommand',
  '2': [
    {'1': 'ssid', '3': 1, '4': 1, '5': 9, '10': 'ssid'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `SetWifiConfigCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setWifiConfigCommandDescriptor = $convert.base64Decode(
    'ChRTZXRXaWZpQ29uZmlnQ29tbWFuZBISCgRzc2lkGAEgASgJUgRzc2lkEhoKCHBhc3N3b3JkGA'
    'IgASgJUghwYXNzd29yZA==');

@$core.Deprecated('Use setStreamingConfigCommandDescriptor instead')
const SetStreamingConfigCommand$json = {
  '1': 'SetStreamingConfigCommand',
  '2': [
    {
      '1': 'config',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.StreamingConfig',
      '10': 'config'
    },
  ],
};

/// Descriptor for `SetStreamingConfigCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setStreamingConfigCommandDescriptor =
    $convert.base64Decode(
        'ChlTZXRTdHJlYW1pbmdDb25maWdDb21tYW5kEjAKBmNvbmZpZxgBIAEoCzIYLnNzdF9jYW0uU3'
        'RyZWFtaW5nQ29uZmlnUgZjb25maWc=');

@$core.Deprecated('Use streamingConfigDescriptor instead')
const StreamingConfig$json = {
  '1': 'StreamingConfig',
  '2': [
    {
      '1': 'youtube_stream_key',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'youtubeStreamKey'
    },
    {
      '1': 'instagram_stream_key',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'instagramStreamKey'
    },
    {'1': 'custom_rtmp_url', '3': 3, '4': 1, '5': 9, '10': 'customRtmpUrl'},
  ],
};

/// Descriptor for `StreamingConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamingConfigDescriptor = $convert.base64Decode(
    'Cg9TdHJlYW1pbmdDb25maWcSLAoSeW91dHViZV9zdHJlYW1fa2V5GAEgASgJUhB5b3V0dWJlU3'
    'RyZWFtS2V5EjAKFGluc3RhZ3JhbV9zdHJlYW1fa2V5GAIgASgJUhJpbnN0YWdyYW1TdHJlYW1L'
    'ZXkSJgoPY3VzdG9tX3J0bXBfdXJsGAMgASgJUg1jdXN0b21SdG1wVXJs');

@$core.Deprecated('Use pushSessionConfigCommandDescriptor instead')
const PushSessionConfigCommand$json = {
  '1': 'PushSessionConfigCommand',
  '2': [
    {'1': 'match_uuid', '3': 1, '4': 1, '5': 9, '10': 'matchUuid'},
    {'1': 'user_uuid', '3': 2, '4': 1, '5': 9, '10': 'userUuid'},
    {'1': 'sport', '3': 3, '4': 1, '5': 9, '10': 'sport'},
    {'1': 'num_periods', '3': 4, '4': 1, '5': 5, '10': 'numPeriods'},
    {
      '1': 'period_length_seconds',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'periodLengthSeconds'
    },
    {
      '1': 'rtmp_url',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'rtmpUrl',
      '17': true
    },
    {
      '1': 'stream_key',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'streamKey',
      '17': true
    },
    {'1': 'video_output_path', '3': 8, '4': 1, '5': 9, '10': 'videoOutputPath'},
    {
      '1': 'thumbnail_output_path',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'thumbnailOutputPath'
    },
    {'1': 'team_a_id', '3': 10, '4': 1, '5': 9, '10': 'teamAId'},
    {'1': 'team_b_id', '3': 11, '4': 1, '5': 9, '10': 'teamBId'},
    {'1': 'team_a_name', '3': 12, '4': 1, '5': 9, '10': 'teamAName'},
    {'1': 'team_b_name', '3': 13, '4': 1, '5': 9, '10': 'teamBName'},
    {'1': 'team_a_color_hex', '3': 14, '4': 1, '5': 9, '10': 'teamAColorHex'},
    {'1': 'team_b_color_hex', '3': 15, '4': 1, '5': 9, '10': 'teamBColorHex'},
  ],
  '8': [
    {'1': '_rtmp_url'},
    {'1': '_stream_key'},
  ],
};

/// Descriptor for `PushSessionConfigCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushSessionConfigCommandDescriptor = $convert.base64Decode(
    'ChhQdXNoU2Vzc2lvbkNvbmZpZ0NvbW1hbmQSHQoKbWF0Y2hfdXVpZBgBIAEoCVIJbWF0Y2hVdW'
    'lkEhsKCXVzZXJfdXVpZBgCIAEoCVIIdXNlclV1aWQSFAoFc3BvcnQYAyABKAlSBXNwb3J0Eh8K'
    'C251bV9wZXJpb2RzGAQgASgFUgpudW1QZXJpb2RzEjIKFXBlcmlvZF9sZW5ndGhfc2Vjb25kcx'
    'gFIAEoBVITcGVyaW9kTGVuZ3RoU2Vjb25kcxIeCghydG1wX3VybBgGIAEoCUgAUgdydG1wVXJs'
    'iAEBEiIKCnN0cmVhbV9rZXkYByABKAlIAVIJc3RyZWFtS2V5iAEBEioKEXZpZGVvX291dHB1dF'
    '9wYXRoGAggASgJUg92aWRlb091dHB1dFBhdGgSMgoVdGh1bWJuYWlsX291dHB1dF9wYXRoGAkg'
    'ASgJUhN0aHVtYm5haWxPdXRwdXRQYXRoEhoKCXRlYW1fYV9pZBgKIAEoCVIHdGVhbUFJZBIaCg'
    'l0ZWFtX2JfaWQYCyABKAlSB3RlYW1CSWQSHgoLdGVhbV9hX25hbWUYDCABKAlSCXRlYW1BTmFt'
    'ZRIeCgt0ZWFtX2JfbmFtZRgNIAEoCVIJdGVhbUJOYW1lEicKEHRlYW1fYV9jb2xvcl9oZXgYDi'
    'ABKAlSDXRlYW1BQ29sb3JIZXgSJwoQdGVhbV9iX2NvbG9yX2hleBgPIAEoCVINdGVhbUJDb2xv'
    'ckhleEILCglfcnRtcF91cmxCDQoLX3N0cmVhbV9rZXk=');

@$core.Deprecated('Use startWifiDirectCommandDescriptor instead')
const StartWifiDirectCommand$json = {
  '1': 'StartWifiDirectCommand',
};

/// Descriptor for `StartWifiDirectCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startWifiDirectCommandDescriptor =
    $convert.base64Decode('ChZTdGFydFdpZmlEaXJlY3RDb21tYW5k');

@$core.Deprecated('Use stopWifiDirectCommandDescriptor instead')
const StopWifiDirectCommand$json = {
  '1': 'StopWifiDirectCommand',
};

/// Descriptor for `StopWifiDirectCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopWifiDirectCommandDescriptor =
    $convert.base64Decode('ChVTdG9wV2lmaURpcmVjdENvbW1hbmQ=');

@$core.Deprecated('Use wifiDirectGroupResponseDescriptor instead')
const WifiDirectGroupResponse$json = {
  '1': 'WifiDirectGroupResponse',
  '2': [
    {'1': 'ssid', '3': 1, '4': 1, '5': 9, '10': 'ssid'},
    {'1': 'psk', '3': 2, '4': 1, '5': 9, '10': 'psk'},
    {'1': 'group_owner_ip', '3': 3, '4': 1, '5': 9, '10': 'groupOwnerIp'},
    {'1': 'preview_port', '3': 4, '4': 1, '5': 13, '10': 'previewPort'},
    {'1': 'download_port', '3': 5, '4': 1, '5': 13, '10': 'downloadPort'},
    {'1': 'role', '3': 6, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `WifiDirectGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wifiDirectGroupResponseDescriptor = $convert.base64Decode(
    'ChdXaWZpRGlyZWN0R3JvdXBSZXNwb25zZRISCgRzc2lkGAEgASgJUgRzc2lkEhAKA3BzaxgCIA'
    'EoCVIDcHNrEiQKDmdyb3VwX293bmVyX2lwGAMgASgJUgxncm91cE93bmVySXASIQoMcHJldmll'
    'd19wb3J0GAQgASgNUgtwcmV2aWV3UG9ydBIjCg1kb3dubG9hZF9wb3J0GAUgASgNUgxkb3dubG'
    '9hZFBvcnQSEgoEcm9sZRgGIAEoCVIEcm9sZQ==');

@$core.Deprecated('Use pushOverlayLayoutCommandDescriptor instead')
const PushOverlayLayoutCommand$json = {
  '1': 'PushOverlayLayoutCommand',
  '2': [
    {
      '1': 'layout',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.OverlayLayout',
      '10': 'layout'
    },
  ],
};

/// Descriptor for `PushOverlayLayoutCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pushOverlayLayoutCommandDescriptor =
    $convert.base64Decode(
        'ChhQdXNoT3ZlcmxheUxheW91dENvbW1hbmQSLgoGbGF5b3V0GAEgASgLMhYuc3N0X2NhbS5Pdm'
        'VybGF5TGF5b3V0UgZsYXlvdXQ=');

@$core.Deprecated('Use overlayLayoutDescriptor instead')
const OverlayLayout$json = {
  '1': 'OverlayLayout',
  '2': [
    {'1': 'canvas_width', '3': 1, '4': 1, '5': 13, '10': 'canvasWidth'},
    {'1': 'canvas_height', '3': 2, '4': 1, '5': 13, '10': 'canvasHeight'},
    {
      '1': 'elements',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sst_cam.OverlayElement',
      '10': 'elements'
    },
    {
      '1': 'templates',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sst_cam.OverlayTemplate',
      '10': 'templates'
    },
  ],
};

/// Descriptor for `OverlayLayout`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overlayLayoutDescriptor = $convert.base64Decode(
    'Cg1PdmVybGF5TGF5b3V0EiEKDGNhbnZhc193aWR0aBgBIAEoDVILY2FudmFzV2lkdGgSIwoNY2'
    'FudmFzX2hlaWdodBgCIAEoDVIMY2FudmFzSGVpZ2h0EjMKCGVsZW1lbnRzGAMgAygLMhcuc3N0'
    'X2NhbS5PdmVybGF5RWxlbWVudFIIZWxlbWVudHMSNgoJdGVtcGxhdGVzGAQgAygLMhguc3N0X2'
    'NhbS5PdmVybGF5VGVtcGxhdGVSCXRlbXBsYXRlcw==');

@$core.Deprecated('Use overlayElementDescriptor instead')
const OverlayElement$json = {
  '1': 'OverlayElement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'shape',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.OverlayShape',
      '10': 'shape'
    },
    {
      '1': 'bounds',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.OverlayRect',
      '10': 'bounds'
    },
    {
      '1': 'style',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sst_cam.OverlayStyle',
      '10': 'style'
    },
    {
      '1': 'binding',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.OverlayBinding',
      '10': 'binding'
    },
    {
      '1': 'visible',
      '3': 6,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'visible',
      '17': true
    },
  ],
  '8': [
    {'1': '_visible'},
  ],
};

/// Descriptor for `OverlayElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overlayElementDescriptor = $convert.base64Decode(
    'Cg5PdmVybGF5RWxlbWVudBIOCgJpZBgBIAEoCVICaWQSKwoFc2hhcGUYAiABKA4yFS5zc3RfY2'
    'FtLk92ZXJsYXlTaGFwZVIFc2hhcGUSLAoGYm91bmRzGAMgASgLMhQuc3N0X2NhbS5PdmVybGF5'
    'UmVjdFIGYm91bmRzEisKBXN0eWxlGAQgASgLMhUuc3N0X2NhbS5PdmVybGF5U3R5bGVSBXN0eW'
    'xlEjEKB2JpbmRpbmcYBSABKA4yFy5zc3RfY2FtLk92ZXJsYXlCaW5kaW5nUgdiaW5kaW5nEh0K'
    'B3Zpc2libGUYBiABKAhIAFIHdmlzaWJsZYgBAUIKCghfdmlzaWJsZQ==');

@$core.Deprecated('Use overlayRectDescriptor instead')
const OverlayRect$json = {
  '1': 'OverlayRect',
  '2': [
    {'1': 'x1', '3': 1, '4': 1, '5': 2, '10': 'x1'},
    {'1': 'y1', '3': 2, '4': 1, '5': 2, '10': 'y1'},
    {'1': 'z', '3': 3, '4': 1, '5': 13, '10': 'z'},
    {'1': 'x2', '3': 4, '4': 1, '5': 2, '10': 'x2'},
    {'1': 'y2', '3': 5, '4': 1, '5': 2, '10': 'y2'},
  ],
};

/// Descriptor for `OverlayRect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overlayRectDescriptor = $convert.base64Decode(
    'CgtPdmVybGF5UmVjdBIOCgJ4MRgBIAEoAlICeDESDgoCeTEYAiABKAJSAnkxEgwKAXoYAyABKA'
    '1SAXoSDgoCeDIYBCABKAJSAngyEg4KAnkyGAUgASgCUgJ5Mg==');

@$core.Deprecated('Use overlayStyleDescriptor instead')
const OverlayStyle$json = {
  '1': 'OverlayStyle',
  '2': [
    {'1': 'fill_color', '3': 1, '4': 1, '5': 9, '10': 'fillColor'},
    {'1': 'text_color', '3': 2, '4': 1, '5': 9, '10': 'textColor'},
    {
      '1': 'opacity',
      '3': 3,
      '4': 1,
      '5': 2,
      '9': 0,
      '10': 'opacity',
      '17': true
    },
    {'1': 'corner_radius', '3': 4, '4': 1, '5': 2, '10': 'cornerRadius'},
    {'1': 'font_family', '3': 5, '4': 1, '5': 9, '10': 'fontFamily'},
    {'1': 'font_size', '3': 6, '4': 1, '5': 2, '10': 'fontSize'},
    {
      '1': 'text_align',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.TextAlign',
      '10': 'textAlign'
    },
    {
      '1': 'font_weight',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.sst_cam.FontWeight',
      '10': 'fontWeight'
    },
    {'1': 'static_text', '3': 9, '4': 1, '5': 9, '10': 'staticText'},
  ],
  '8': [
    {'1': '_opacity'},
  ],
};

/// Descriptor for `OverlayStyle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overlayStyleDescriptor = $convert.base64Decode(
    'CgxPdmVybGF5U3R5bGUSHQoKZmlsbF9jb2xvchgBIAEoCVIJZmlsbENvbG9yEh0KCnRleHRfY2'
    '9sb3IYAiABKAlSCXRleHRDb2xvchIdCgdvcGFjaXR5GAMgASgCSABSB29wYWNpdHmIAQESIwoN'
    'Y29ybmVyX3JhZGl1cxgEIAEoAlIMY29ybmVyUmFkaXVzEh8KC2ZvbnRfZmFtaWx5GAUgASgJUg'
    'pmb250RmFtaWx5EhsKCWZvbnRfc2l6ZRgGIAEoAlIIZm9udFNpemUSMQoKdGV4dF9hbGlnbhgH'
    'IAEoDjISLnNzdF9jYW0uVGV4dEFsaWduUgl0ZXh0QWxpZ24SNAoLZm9udF93ZWlnaHQYCCABKA'
    '4yEy5zc3RfY2FtLkZvbnRXZWlnaHRSCmZvbnRXZWlnaHQSHwoLc3RhdGljX3RleHQYCSABKAlS'
    'CnN0YXRpY1RleHRCCgoIX29wYWNpdHk=');

@$core.Deprecated('Use overlayTemplateDescriptor instead')
const OverlayTemplate$json = {
  '1': 'OverlayTemplate',
  '2': [
    {'1': 'event_type', '3': 1, '4': 1, '5': 9, '10': 'eventType'},
    {'1': 'duration_ms', '3': 2, '4': 1, '5': 13, '10': 'durationMs'},
    {
      '1': 'elements',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sst_cam.OverlayElement',
      '10': 'elements'
    },
  ],
};

/// Descriptor for `OverlayTemplate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List overlayTemplateDescriptor = $convert.base64Decode(
    'Cg9PdmVybGF5VGVtcGxhdGUSHQoKZXZlbnRfdHlwZRgBIAEoCVIJZXZlbnRUeXBlEh8KC2R1cm'
    'F0aW9uX21zGAIgASgNUgpkdXJhdGlvbk1zEjMKCGVsZW1lbnRzGAMgAygLMhcuc3N0X2NhbS5P'
    'dmVybGF5RWxlbWVudFIIZWxlbWVudHM=');
