// This is a generated file - do not edit.
//
// Generated from bluetooth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ResponseStatus extends $pb.ProtobufEnum {
  static const ResponseStatus OK =
      ResponseStatus._(0, _omitEnumNames ? '' : 'OK');
  static const ResponseStatus ERROR =
      ResponseStatus._(1, _omitEnumNames ? '' : 'ERROR');
  static const ResponseStatus TIMEOUT =
      ResponseStatus._(2, _omitEnumNames ? '' : 'TIMEOUT');
  static const ResponseStatus UNSUPPORTED =
      ResponseStatus._(3, _omitEnumNames ? '' : 'UNSUPPORTED');

  static const $core.List<ResponseStatus> values = <ResponseStatus>[
    OK,
    ERROR,
    TIMEOUT,
    UNSUPPORTED,
  ];

  static final $core.List<ResponseStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ResponseStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ResponseStatus._(super.value, super.name);
}

class WifiState extends $pb.ProtobufEnum {
  static const WifiState WIFI_UNKNOWN =
      WifiState._(0, _omitEnumNames ? '' : 'WIFI_UNKNOWN');
  static const WifiState WIFI_DISABLED =
      WifiState._(1, _omitEnumNames ? '' : 'WIFI_DISABLED');
  static const WifiState WIFI_DISCONNECTED =
      WifiState._(2, _omitEnumNames ? '' : 'WIFI_DISCONNECTED');
  static const WifiState WIFI_CONNECTED =
      WifiState._(3, _omitEnumNames ? '' : 'WIFI_CONNECTED');

  static const $core.List<WifiState> values = <WifiState>[
    WIFI_UNKNOWN,
    WIFI_DISABLED,
    WIFI_DISCONNECTED,
    WIFI_CONNECTED,
  ];

  static final $core.List<WifiState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static WifiState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const WifiState._(super.value, super.name);
}

class Sport extends $pb.ProtobufEnum {
  static const Sport SPORT_UNKNOWN =
      Sport._(0, _omitEnumNames ? '' : 'SPORT_UNKNOWN');
  static const Sport SPORT_SOCCER =
      Sport._(1, _omitEnumNames ? '' : 'SPORT_SOCCER');
  static const Sport SPORT_BASKETBALL =
      Sport._(2, _omitEnumNames ? '' : 'SPORT_BASKETBALL');
  static const Sport SPORT_AMERICAN_FOOTBALL =
      Sport._(3, _omitEnumNames ? '' : 'SPORT_AMERICAN_FOOTBALL');
  static const Sport SPORT_VOLLEYBALL =
      Sport._(4, _omitEnumNames ? '' : 'SPORT_VOLLEYBALL');
  static const Sport SPORT_HOCKEY =
      Sport._(5, _omitEnumNames ? '' : 'SPORT_HOCKEY');
  static const Sport SPORT_BASEBALL =
      Sport._(6, _omitEnumNames ? '' : 'SPORT_BASEBALL');
  static const Sport SPORT_RUGBY =
      Sport._(7, _omitEnumNames ? '' : 'SPORT_RUGBY');
  static const Sport SPORT_OTHER =
      Sport._(99, _omitEnumNames ? '' : 'SPORT_OTHER');

  static const $core.List<Sport> values = <Sport>[
    SPORT_UNKNOWN,
    SPORT_SOCCER,
    SPORT_BASKETBALL,
    SPORT_AMERICAN_FOOTBALL,
    SPORT_VOLLEYBALL,
    SPORT_HOCKEY,
    SPORT_BASEBALL,
    SPORT_RUGBY,
    SPORT_OTHER,
  ];

  static final $core.Map<$core.int, Sport> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Sport? valueOf($core.int value) => _byValue[value];

  const Sport._(super.value, super.name);
}

class PlayerPosition extends $pb.ProtobufEnum {
  static const PlayerPosition POSITION_UNKNOWN =
      PlayerPosition._(0, _omitEnumNames ? '' : 'POSITION_UNKNOWN');
  static const PlayerPosition POSITION_KEEPER =
      PlayerPosition._(1, _omitEnumNames ? '' : 'POSITION_KEEPER');
  static const PlayerPosition POSITION_DEFENDER =
      PlayerPosition._(2, _omitEnumNames ? '' : 'POSITION_DEFENDER');
  static const PlayerPosition POSITION_MID =
      PlayerPosition._(3, _omitEnumNames ? '' : 'POSITION_MID');
  static const PlayerPosition POSITION_FORWARD =
      PlayerPosition._(4, _omitEnumNames ? '' : 'POSITION_FORWARD');
  static const PlayerPosition POSITION_OTHER =
      PlayerPosition._(99, _omitEnumNames ? '' : 'POSITION_OTHER');

  static const $core.List<PlayerPosition> values = <PlayerPosition>[
    POSITION_UNKNOWN,
    POSITION_KEEPER,
    POSITION_DEFENDER,
    POSITION_MID,
    POSITION_FORWARD,
    POSITION_OTHER,
  ];

  static final $core.Map<$core.int, PlayerPosition> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PlayerPosition? valueOf($core.int value) => _byValue[value];

  const PlayerPosition._(super.value, super.name);
}

class MatchControlAction extends $pb.ProtobufEnum {
  static const MatchControlAction MATCH_ACTION_UNKNOWN =
      MatchControlAction._(0, _omitEnumNames ? '' : 'MATCH_ACTION_UNKNOWN');
  static const MatchControlAction MATCH_KICKOFF =
      MatchControlAction._(1, _omitEnumNames ? '' : 'MATCH_KICKOFF');
  static const MatchControlAction MATCH_PERIOD_END =
      MatchControlAction._(2, _omitEnumNames ? '' : 'MATCH_PERIOD_END');
  static const MatchControlAction MATCH_PERIOD_START =
      MatchControlAction._(3, _omitEnumNames ? '' : 'MATCH_PERIOD_START');
  static const MatchControlAction MATCH_FINAL_WHISTLE =
      MatchControlAction._(4, _omitEnumNames ? '' : 'MATCH_FINAL_WHISTLE');
  static const MatchControlAction MATCH_CLOCK_PAUSE =
      MatchControlAction._(5, _omitEnumNames ? '' : 'MATCH_CLOCK_PAUSE');
  static const MatchControlAction MATCH_CLOCK_RESUME =
      MatchControlAction._(6, _omitEnumNames ? '' : 'MATCH_CLOCK_RESUME');

  static const $core.List<MatchControlAction> values = <MatchControlAction>[
    MATCH_ACTION_UNKNOWN,
    MATCH_KICKOFF,
    MATCH_PERIOD_END,
    MATCH_PERIOD_START,
    MATCH_FINAL_WHISTLE,
    MATCH_CLOCK_PAUSE,
    MATCH_CLOCK_RESUME,
  ];

  static final $core.List<MatchControlAction?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MatchControlAction? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MatchControlAction._(super.value, super.name);
}

class MatchStatus extends $pb.ProtobufEnum {
  static const MatchStatus MATCH_STATUS_UNKNOWN =
      MatchStatus._(0, _omitEnumNames ? '' : 'MATCH_STATUS_UNKNOWN');
  static const MatchStatus MATCH_NOT_STARTED =
      MatchStatus._(1, _omitEnumNames ? '' : 'MATCH_NOT_STARTED');
  static const MatchStatus MATCH_ACTIVE =
      MatchStatus._(2, _omitEnumNames ? '' : 'MATCH_ACTIVE');
  static const MatchStatus MATCH_PAUSED =
      MatchStatus._(3, _omitEnumNames ? '' : 'MATCH_PAUSED');
  static const MatchStatus MATCH_HALF_TIME =
      MatchStatus._(4, _omitEnumNames ? '' : 'MATCH_HALF_TIME');
  static const MatchStatus MATCH_FINISHED =
      MatchStatus._(5, _omitEnumNames ? '' : 'MATCH_FINISHED');

  static const $core.List<MatchStatus> values = <MatchStatus>[
    MATCH_STATUS_UNKNOWN,
    MATCH_NOT_STARTED,
    MATCH_ACTIVE,
    MATCH_PAUSED,
    MATCH_HALF_TIME,
    MATCH_FINISHED,
  ];

  static final $core.List<MatchStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static MatchStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MatchStatus._(super.value, super.name);
}

class RecordingAction extends $pb.ProtobufEnum {
  static const RecordingAction RECORDING_ACTION_UNKNOWN =
      RecordingAction._(0, _omitEnumNames ? '' : 'RECORDING_ACTION_UNKNOWN');
  static const RecordingAction RECORDING_START =
      RecordingAction._(1, _omitEnumNames ? '' : 'RECORDING_START');
  static const RecordingAction RECORDING_STOP =
      RecordingAction._(2, _omitEnumNames ? '' : 'RECORDING_STOP');
  static const RecordingAction RECORDING_PAUSE =
      RecordingAction._(3, _omitEnumNames ? '' : 'RECORDING_PAUSE');
  static const RecordingAction RECORDING_RESUME =
      RecordingAction._(4, _omitEnumNames ? '' : 'RECORDING_RESUME');

  static const $core.List<RecordingAction> values = <RecordingAction>[
    RECORDING_ACTION_UNKNOWN,
    RECORDING_START,
    RECORDING_STOP,
    RECORDING_PAUSE,
    RECORDING_RESUME,
  ];

  static final $core.List<RecordingAction?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static RecordingAction? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecordingAction._(super.value, super.name);
}

class StreamingAction extends $pb.ProtobufEnum {
  static const StreamingAction STREAMING_ACTION_UNKNOWN =
      StreamingAction._(0, _omitEnumNames ? '' : 'STREAMING_ACTION_UNKNOWN');
  static const StreamingAction STREAMING_START =
      StreamingAction._(1, _omitEnumNames ? '' : 'STREAMING_START');
  static const StreamingAction STREAMING_STOP =
      StreamingAction._(2, _omitEnumNames ? '' : 'STREAMING_STOP');

  static const $core.List<StreamingAction> values = <StreamingAction>[
    STREAMING_ACTION_UNKNOWN,
    STREAMING_START,
    STREAMING_STOP,
  ];

  static final $core.List<StreamingAction?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static StreamingAction? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StreamingAction._(super.value, super.name);
}

/// Shape types.
class OverlayShape extends $pb.ProtobufEnum {
  static const OverlayShape SHAPE_UNKNOWN =
      OverlayShape._(0, _omitEnumNames ? '' : 'SHAPE_UNKNOWN');
  static const OverlayShape SHAPE_RECT =
      OverlayShape._(1, _omitEnumNames ? '' : 'SHAPE_RECT');
  static const OverlayShape SHAPE_TEXT =
      OverlayShape._(2, _omitEnumNames ? '' : 'SHAPE_TEXT');
  static const OverlayShape SHAPE_CIRCLE =
      OverlayShape._(3, _omitEnumNames ? '' : 'SHAPE_CIRCLE');

  static const $core.List<OverlayShape> values = <OverlayShape>[
    SHAPE_UNKNOWN,
    SHAPE_RECT,
    SHAPE_TEXT,
    SHAPE_CIRCLE,
  ];

  static final $core.List<OverlayShape?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static OverlayShape? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OverlayShape._(super.value, super.name);
}

/// Data bindings for TEXT elements.
/// When bound, the camera updates the element's rendered text automatically
/// whenever the corresponding data changes via an event command.
class OverlayBinding extends $pb.ProtobufEnum {
  static const OverlayBinding BINDING_STATIC =
      OverlayBinding._(0, _omitEnumNames ? '' : 'BINDING_STATIC');
  static const OverlayBinding BINDING_SCORE_A =
      OverlayBinding._(1, _omitEnumNames ? '' : 'BINDING_SCORE_A');
  static const OverlayBinding BINDING_SCORE_B =
      OverlayBinding._(2, _omitEnumNames ? '' : 'BINDING_SCORE_B');
  static const OverlayBinding BINDING_SCORE_VS =
      OverlayBinding._(3, _omitEnumNames ? '' : 'BINDING_SCORE_VS');
  static const OverlayBinding BINDING_TEAM_A_NAME =
      OverlayBinding._(4, _omitEnumNames ? '' : 'BINDING_TEAM_A_NAME');
  static const OverlayBinding BINDING_TEAM_B_NAME =
      OverlayBinding._(5, _omitEnumNames ? '' : 'BINDING_TEAM_B_NAME');
  static const OverlayBinding BINDING_MATCH_CLOCK =
      OverlayBinding._(6, _omitEnumNames ? '' : 'BINDING_MATCH_CLOCK');
  static const OverlayBinding BINDING_PERIOD_LABEL =
      OverlayBinding._(7, _omitEnumNames ? '' : 'BINDING_PERIOD_LABEL');

  static const $core.List<OverlayBinding> values = <OverlayBinding>[
    BINDING_STATIC,
    BINDING_SCORE_A,
    BINDING_SCORE_B,
    BINDING_SCORE_VS,
    BINDING_TEAM_A_NAME,
    BINDING_TEAM_B_NAME,
    BINDING_MATCH_CLOCK,
    BINDING_PERIOD_LABEL,
  ];

  static final $core.List<OverlayBinding?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static OverlayBinding? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OverlayBinding._(super.value, super.name);
}

class TextAlign extends $pb.ProtobufEnum {
  static const TextAlign TEXT_ALIGN_LEFT =
      TextAlign._(0, _omitEnumNames ? '' : 'TEXT_ALIGN_LEFT');
  static const TextAlign TEXT_ALIGN_CENTER =
      TextAlign._(1, _omitEnumNames ? '' : 'TEXT_ALIGN_CENTER');
  static const TextAlign TEXT_ALIGN_RIGHT =
      TextAlign._(2, _omitEnumNames ? '' : 'TEXT_ALIGN_RIGHT');

  static const $core.List<TextAlign> values = <TextAlign>[
    TEXT_ALIGN_LEFT,
    TEXT_ALIGN_CENTER,
    TEXT_ALIGN_RIGHT,
  ];

  static final $core.List<TextAlign?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TextAlign? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TextAlign._(super.value, super.name);
}

class FontWeight extends $pb.ProtobufEnum {
  static const FontWeight FONT_WEIGHT_NORMAL =
      FontWeight._(0, _omitEnumNames ? '' : 'FONT_WEIGHT_NORMAL');
  static const FontWeight FONT_WEIGHT_BOLD =
      FontWeight._(1, _omitEnumNames ? '' : 'FONT_WEIGHT_BOLD');

  static const $core.List<FontWeight> values = <FontWeight>[
    FONT_WEIGHT_NORMAL,
    FONT_WEIGHT_BOLD,
  ];

  static final $core.List<FontWeight?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static FontWeight? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FontWeight._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
