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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bluetooth.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'bluetooth.pbenum.dart';

class ChunkedPayload extends $pb.GeneratedMessage {
  factory ChunkedPayload({
    $core.String? correlationId,
    $core.int? chunkIndex,
    $core.int? totalChunks,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (chunkIndex != null) result.chunkIndex = chunkIndex;
    if (totalChunks != null) result.totalChunks = totalChunks;
    if (data != null) result.data = data;
    return result;
  }

  ChunkedPayload._();

  factory ChunkedPayload.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChunkedPayload.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChunkedPayload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'correlationId')
    ..aI(2, _omitFieldNames ? '' : 'chunkIndex', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'totalChunks',
        fieldType: $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkedPayload clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkedPayload copyWith(void Function(ChunkedPayload) updates) =>
      super.copyWith((message) => updates(message as ChunkedPayload))
          as ChunkedPayload;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChunkedPayload create() => ChunkedPayload._();
  @$core.override
  ChunkedPayload createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChunkedPayload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChunkedPayload>(create);
  static ChunkedPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get chunkIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set chunkIndex($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChunkIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunkIndex() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalChunks => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalChunks($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalChunks() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalChunks() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => $_clearField(4);
}

class ChunkAck extends $pb.GeneratedMessage {
  factory ChunkAck({
    $core.String? correlationId,
    $core.int? chunkIndex,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (chunkIndex != null) result.chunkIndex = chunkIndex;
    return result;
  }

  ChunkAck._();

  factory ChunkAck.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChunkAck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChunkAck',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'correlationId')
    ..aI(2, _omitFieldNames ? '' : 'chunkIndex', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkAck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChunkAck copyWith(void Function(ChunkAck) updates) =>
      super.copyWith((message) => updates(message as ChunkAck)) as ChunkAck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChunkAck create() => ChunkAck._();
  @$core.override
  ChunkAck createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChunkAck getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChunkAck>(create);
  static ChunkAck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get chunkIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set chunkIndex($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChunkIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunkIndex() => $_clearField(2);
}

enum Command_Payload {
  getDeviceInfo,
  thumbnail,
  getTelemetry,
  getMatchState,
  matchControl,
  scoreUpdate,
  bannerEvent,
  recordingControl,
  streamingControl,
  listRecordings,
  downloadRequest,
  rawCapture,
  setWifiConfig,
  setStreamingConfig,
  factoryReset,
  firmwareUpdate,
  pushSessionConfig,
  startWifiDirect,
  stopWifiDirect,
  pushOverlayLayout,
  notSet
}

class Command extends $pb.GeneratedMessage {
  factory Command({
    $core.String? correlationId,
    GetDeviceInfoCommand? getDeviceInfo,
    ThumbnailRequest? thumbnail,
    GetTelemetryCommand? getTelemetry,
    GetMatchStateCommand? getMatchState,
    MatchControlCommand? matchControl,
    ScoreUpdateCommand? scoreUpdate,
    BannerEventCommand? bannerEvent,
    RecordingControlCommand? recordingControl,
    StreamingControlCommand? streamingControl,
    ListRecordingsCommand? listRecordings,
    DownloadRequestCommand? downloadRequest,
    RawCaptureControlCommand? rawCapture,
    SetWifiConfigCommand? setWifiConfig,
    SetStreamingConfigCommand? setStreamingConfig,
    FactoryResetCommand? factoryReset,
    FirmwareUpdateCommand? firmwareUpdate,
    PushSessionConfigCommand? pushSessionConfig,
    StartWifiDirectCommand? startWifiDirect,
    StopWifiDirectCommand? stopWifiDirect,
    PushOverlayLayoutCommand? pushOverlayLayout,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (getDeviceInfo != null) result.getDeviceInfo = getDeviceInfo;
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (getTelemetry != null) result.getTelemetry = getTelemetry;
    if (getMatchState != null) result.getMatchState = getMatchState;
    if (matchControl != null) result.matchControl = matchControl;
    if (scoreUpdate != null) result.scoreUpdate = scoreUpdate;
    if (bannerEvent != null) result.bannerEvent = bannerEvent;
    if (recordingControl != null) result.recordingControl = recordingControl;
    if (streamingControl != null) result.streamingControl = streamingControl;
    if (listRecordings != null) result.listRecordings = listRecordings;
    if (downloadRequest != null) result.downloadRequest = downloadRequest;
    if (rawCapture != null) result.rawCapture = rawCapture;
    if (setWifiConfig != null) result.setWifiConfig = setWifiConfig;
    if (setStreamingConfig != null)
      result.setStreamingConfig = setStreamingConfig;
    if (factoryReset != null) result.factoryReset = factoryReset;
    if (firmwareUpdate != null) result.firmwareUpdate = firmwareUpdate;
    if (pushSessionConfig != null) result.pushSessionConfig = pushSessionConfig;
    if (startWifiDirect != null) result.startWifiDirect = startWifiDirect;
    if (stopWifiDirect != null) result.stopWifiDirect = stopWifiDirect;
    if (pushOverlayLayout != null) result.pushOverlayLayout = pushOverlayLayout;
    return result;
  }

  Command._();

  factory Command.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Command.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Command_Payload> _Command_PayloadByTag = {
    10: Command_Payload.getDeviceInfo,
    11: Command_Payload.thumbnail,
    12: Command_Payload.getTelemetry,
    13: Command_Payload.getMatchState,
    21: Command_Payload.matchControl,
    22: Command_Payload.scoreUpdate,
    23: Command_Payload.bannerEvent,
    30: Command_Payload.recordingControl,
    31: Command_Payload.streamingControl,
    32: Command_Payload.listRecordings,
    33: Command_Payload.downloadRequest,
    34: Command_Payload.rawCapture,
    40: Command_Payload.setWifiConfig,
    41: Command_Payload.setStreamingConfig,
    50: Command_Payload.factoryReset,
    51: Command_Payload.firmwareUpdate,
    52: Command_Payload.pushSessionConfig,
    53: Command_Payload.startWifiDirect,
    54: Command_Payload.stopWifiDirect,
    55: Command_Payload.pushOverlayLayout,
    0: Command_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Command',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..oo(0, [
      10,
      11,
      12,
      13,
      21,
      22,
      23,
      30,
      31,
      32,
      33,
      34,
      40,
      41,
      50,
      51,
      52,
      53,
      54,
      55
    ])
    ..aOS(1, _omitFieldNames ? '' : 'correlationId')
    ..aOM<GetDeviceInfoCommand>(10, _omitFieldNames ? '' : 'getDeviceInfo',
        subBuilder: GetDeviceInfoCommand.create)
    ..aOM<ThumbnailRequest>(11, _omitFieldNames ? '' : 'thumbnail',
        subBuilder: ThumbnailRequest.create)
    ..aOM<GetTelemetryCommand>(12, _omitFieldNames ? '' : 'getTelemetry',
        subBuilder: GetTelemetryCommand.create)
    ..aOM<GetMatchStateCommand>(13, _omitFieldNames ? '' : 'getMatchState',
        subBuilder: GetMatchStateCommand.create)
    ..aOM<MatchControlCommand>(21, _omitFieldNames ? '' : 'matchControl',
        subBuilder: MatchControlCommand.create)
    ..aOM<ScoreUpdateCommand>(22, _omitFieldNames ? '' : 'scoreUpdate',
        subBuilder: ScoreUpdateCommand.create)
    ..aOM<BannerEventCommand>(23, _omitFieldNames ? '' : 'bannerEvent',
        subBuilder: BannerEventCommand.create)
    ..aOM<RecordingControlCommand>(
        30, _omitFieldNames ? '' : 'recordingControl',
        subBuilder: RecordingControlCommand.create)
    ..aOM<StreamingControlCommand>(
        31, _omitFieldNames ? '' : 'streamingControl',
        subBuilder: StreamingControlCommand.create)
    ..aOM<ListRecordingsCommand>(32, _omitFieldNames ? '' : 'listRecordings',
        subBuilder: ListRecordingsCommand.create)
    ..aOM<DownloadRequestCommand>(33, _omitFieldNames ? '' : 'downloadRequest',
        subBuilder: DownloadRequestCommand.create)
    ..aOM<RawCaptureControlCommand>(34, _omitFieldNames ? '' : 'rawCapture',
        subBuilder: RawCaptureControlCommand.create)
    ..aOM<SetWifiConfigCommand>(40, _omitFieldNames ? '' : 'setWifiConfig',
        subBuilder: SetWifiConfigCommand.create)
    ..aOM<SetStreamingConfigCommand>(
        41, _omitFieldNames ? '' : 'setStreamingConfig',
        subBuilder: SetStreamingConfigCommand.create)
    ..aOM<FactoryResetCommand>(50, _omitFieldNames ? '' : 'factoryReset',
        subBuilder: FactoryResetCommand.create)
    ..aOM<FirmwareUpdateCommand>(51, _omitFieldNames ? '' : 'firmwareUpdate',
        subBuilder: FirmwareUpdateCommand.create)
    ..aOM<PushSessionConfigCommand>(
        52, _omitFieldNames ? '' : 'pushSessionConfig',
        subBuilder: PushSessionConfigCommand.create)
    ..aOM<StartWifiDirectCommand>(53, _omitFieldNames ? '' : 'startWifiDirect',
        subBuilder: StartWifiDirectCommand.create)
    ..aOM<StopWifiDirectCommand>(54, _omitFieldNames ? '' : 'stopWifiDirect',
        subBuilder: StopWifiDirectCommand.create)
    ..aOM<PushOverlayLayoutCommand>(
        55, _omitFieldNames ? '' : 'pushOverlayLayout',
        subBuilder: PushOverlayLayoutCommand.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command copyWith(void Function(Command) updates) =>
      super.copyWith((message) => updates(message as Command)) as Command;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Command create() => Command._();
  @$core.override
  Command createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Command getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Command>(create);
  static Command? _defaultInstance;

  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(23)
  @$pb.TagNumber(30)
  @$pb.TagNumber(31)
  @$pb.TagNumber(32)
  @$pb.TagNumber(33)
  @$pb.TagNumber(34)
  @$pb.TagNumber(40)
  @$pb.TagNumber(41)
  @$pb.TagNumber(50)
  @$pb.TagNumber(51)
  @$pb.TagNumber(52)
  @$pb.TagNumber(53)
  @$pb.TagNumber(54)
  @$pb.TagNumber(55)
  Command_Payload whichPayload() => _Command_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(23)
  @$pb.TagNumber(30)
  @$pb.TagNumber(31)
  @$pb.TagNumber(32)
  @$pb.TagNumber(33)
  @$pb.TagNumber(34)
  @$pb.TagNumber(40)
  @$pb.TagNumber(41)
  @$pb.TagNumber(50)
  @$pb.TagNumber(51)
  @$pb.TagNumber(52)
  @$pb.TagNumber(53)
  @$pb.TagNumber(54)
  @$pb.TagNumber(55)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => $_clearField(1);

  @$pb.TagNumber(10)
  GetDeviceInfoCommand get getDeviceInfo => $_getN(1);
  @$pb.TagNumber(10)
  set getDeviceInfo(GetDeviceInfoCommand value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasGetDeviceInfo() => $_has(1);
  @$pb.TagNumber(10)
  void clearGetDeviceInfo() => $_clearField(10);
  @$pb.TagNumber(10)
  GetDeviceInfoCommand ensureGetDeviceInfo() => $_ensure(1);

  @$pb.TagNumber(11)
  ThumbnailRequest get thumbnail => $_getN(2);
  @$pb.TagNumber(11)
  set thumbnail(ThumbnailRequest value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasThumbnail() => $_has(2);
  @$pb.TagNumber(11)
  void clearThumbnail() => $_clearField(11);
  @$pb.TagNumber(11)
  ThumbnailRequest ensureThumbnail() => $_ensure(2);

  @$pb.TagNumber(12)
  GetTelemetryCommand get getTelemetry => $_getN(3);
  @$pb.TagNumber(12)
  set getTelemetry(GetTelemetryCommand value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasGetTelemetry() => $_has(3);
  @$pb.TagNumber(12)
  void clearGetTelemetry() => $_clearField(12);
  @$pb.TagNumber(12)
  GetTelemetryCommand ensureGetTelemetry() => $_ensure(3);

  @$pb.TagNumber(13)
  GetMatchStateCommand get getMatchState => $_getN(4);
  @$pb.TagNumber(13)
  set getMatchState(GetMatchStateCommand value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasGetMatchState() => $_has(4);
  @$pb.TagNumber(13)
  void clearGetMatchState() => $_clearField(13);
  @$pb.TagNumber(13)
  GetMatchStateCommand ensureGetMatchState() => $_ensure(4);

  @$pb.TagNumber(21)
  MatchControlCommand get matchControl => $_getN(5);
  @$pb.TagNumber(21)
  set matchControl(MatchControlCommand value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasMatchControl() => $_has(5);
  @$pb.TagNumber(21)
  void clearMatchControl() => $_clearField(21);
  @$pb.TagNumber(21)
  MatchControlCommand ensureMatchControl() => $_ensure(5);

  @$pb.TagNumber(22)
  ScoreUpdateCommand get scoreUpdate => $_getN(6);
  @$pb.TagNumber(22)
  set scoreUpdate(ScoreUpdateCommand value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasScoreUpdate() => $_has(6);
  @$pb.TagNumber(22)
  void clearScoreUpdate() => $_clearField(22);
  @$pb.TagNumber(22)
  ScoreUpdateCommand ensureScoreUpdate() => $_ensure(6);

  @$pb.TagNumber(23)
  BannerEventCommand get bannerEvent => $_getN(7);
  @$pb.TagNumber(23)
  set bannerEvent(BannerEventCommand value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasBannerEvent() => $_has(7);
  @$pb.TagNumber(23)
  void clearBannerEvent() => $_clearField(23);
  @$pb.TagNumber(23)
  BannerEventCommand ensureBannerEvent() => $_ensure(7);

  @$pb.TagNumber(30)
  RecordingControlCommand get recordingControl => $_getN(8);
  @$pb.TagNumber(30)
  set recordingControl(RecordingControlCommand value) => $_setField(30, value);
  @$pb.TagNumber(30)
  $core.bool hasRecordingControl() => $_has(8);
  @$pb.TagNumber(30)
  void clearRecordingControl() => $_clearField(30);
  @$pb.TagNumber(30)
  RecordingControlCommand ensureRecordingControl() => $_ensure(8);

  @$pb.TagNumber(31)
  StreamingControlCommand get streamingControl => $_getN(9);
  @$pb.TagNumber(31)
  set streamingControl(StreamingControlCommand value) => $_setField(31, value);
  @$pb.TagNumber(31)
  $core.bool hasStreamingControl() => $_has(9);
  @$pb.TagNumber(31)
  void clearStreamingControl() => $_clearField(31);
  @$pb.TagNumber(31)
  StreamingControlCommand ensureStreamingControl() => $_ensure(9);

  @$pb.TagNumber(32)
  ListRecordingsCommand get listRecordings => $_getN(10);
  @$pb.TagNumber(32)
  set listRecordings(ListRecordingsCommand value) => $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasListRecordings() => $_has(10);
  @$pb.TagNumber(32)
  void clearListRecordings() => $_clearField(32);
  @$pb.TagNumber(32)
  ListRecordingsCommand ensureListRecordings() => $_ensure(10);

  @$pb.TagNumber(33)
  DownloadRequestCommand get downloadRequest => $_getN(11);
  @$pb.TagNumber(33)
  set downloadRequest(DownloadRequestCommand value) => $_setField(33, value);
  @$pb.TagNumber(33)
  $core.bool hasDownloadRequest() => $_has(11);
  @$pb.TagNumber(33)
  void clearDownloadRequest() => $_clearField(33);
  @$pb.TagNumber(33)
  DownloadRequestCommand ensureDownloadRequest() => $_ensure(11);

  @$pb.TagNumber(34)
  RawCaptureControlCommand get rawCapture => $_getN(12);
  @$pb.TagNumber(34)
  set rawCapture(RawCaptureControlCommand value) => $_setField(34, value);
  @$pb.TagNumber(34)
  $core.bool hasRawCapture() => $_has(12);
  @$pb.TagNumber(34)
  void clearRawCapture() => $_clearField(34);
  @$pb.TagNumber(34)
  RawCaptureControlCommand ensureRawCapture() => $_ensure(12);

  @$pb.TagNumber(40)
  SetWifiConfigCommand get setWifiConfig => $_getN(13);
  @$pb.TagNumber(40)
  set setWifiConfig(SetWifiConfigCommand value) => $_setField(40, value);
  @$pb.TagNumber(40)
  $core.bool hasSetWifiConfig() => $_has(13);
  @$pb.TagNumber(40)
  void clearSetWifiConfig() => $_clearField(40);
  @$pb.TagNumber(40)
  SetWifiConfigCommand ensureSetWifiConfig() => $_ensure(13);

  @$pb.TagNumber(41)
  SetStreamingConfigCommand get setStreamingConfig => $_getN(14);
  @$pb.TagNumber(41)
  set setStreamingConfig(SetStreamingConfigCommand value) =>
      $_setField(41, value);
  @$pb.TagNumber(41)
  $core.bool hasSetStreamingConfig() => $_has(14);
  @$pb.TagNumber(41)
  void clearSetStreamingConfig() => $_clearField(41);
  @$pb.TagNumber(41)
  SetStreamingConfigCommand ensureSetStreamingConfig() => $_ensure(14);

  @$pb.TagNumber(50)
  FactoryResetCommand get factoryReset => $_getN(15);
  @$pb.TagNumber(50)
  set factoryReset(FactoryResetCommand value) => $_setField(50, value);
  @$pb.TagNumber(50)
  $core.bool hasFactoryReset() => $_has(15);
  @$pb.TagNumber(50)
  void clearFactoryReset() => $_clearField(50);
  @$pb.TagNumber(50)
  FactoryResetCommand ensureFactoryReset() => $_ensure(15);

  @$pb.TagNumber(51)
  FirmwareUpdateCommand get firmwareUpdate => $_getN(16);
  @$pb.TagNumber(51)
  set firmwareUpdate(FirmwareUpdateCommand value) => $_setField(51, value);
  @$pb.TagNumber(51)
  $core.bool hasFirmwareUpdate() => $_has(16);
  @$pb.TagNumber(51)
  void clearFirmwareUpdate() => $_clearField(51);
  @$pb.TagNumber(51)
  FirmwareUpdateCommand ensureFirmwareUpdate() => $_ensure(16);

  @$pb.TagNumber(52)
  PushSessionConfigCommand get pushSessionConfig => $_getN(17);
  @$pb.TagNumber(52)
  set pushSessionConfig(PushSessionConfigCommand value) =>
      $_setField(52, value);
  @$pb.TagNumber(52)
  $core.bool hasPushSessionConfig() => $_has(17);
  @$pb.TagNumber(52)
  void clearPushSessionConfig() => $_clearField(52);
  @$pb.TagNumber(52)
  PushSessionConfigCommand ensurePushSessionConfig() => $_ensure(17);

  @$pb.TagNumber(53)
  StartWifiDirectCommand get startWifiDirect => $_getN(18);
  @$pb.TagNumber(53)
  set startWifiDirect(StartWifiDirectCommand value) => $_setField(53, value);
  @$pb.TagNumber(53)
  $core.bool hasStartWifiDirect() => $_has(18);
  @$pb.TagNumber(53)
  void clearStartWifiDirect() => $_clearField(53);
  @$pb.TagNumber(53)
  StartWifiDirectCommand ensureStartWifiDirect() => $_ensure(18);

  @$pb.TagNumber(54)
  StopWifiDirectCommand get stopWifiDirect => $_getN(19);
  @$pb.TagNumber(54)
  set stopWifiDirect(StopWifiDirectCommand value) => $_setField(54, value);
  @$pb.TagNumber(54)
  $core.bool hasStopWifiDirect() => $_has(19);
  @$pb.TagNumber(54)
  void clearStopWifiDirect() => $_clearField(54);
  @$pb.TagNumber(54)
  StopWifiDirectCommand ensureStopWifiDirect() => $_ensure(19);

  /// Overlay layout spec — sent once after PushSessionConfigCommand.
  /// Defines the full visual design for overlays; firmware renders exactly
  /// what this spec describes. Can be resent to change designs mid-session.
  @$pb.TagNumber(55)
  PushOverlayLayoutCommand get pushOverlayLayout => $_getN(20);
  @$pb.TagNumber(55)
  set pushOverlayLayout(PushOverlayLayoutCommand value) =>
      $_setField(55, value);
  @$pb.TagNumber(55)
  $core.bool hasPushOverlayLayout() => $_has(20);
  @$pb.TagNumber(55)
  void clearPushOverlayLayout() => $_clearField(55);
  @$pb.TagNumber(55)
  PushOverlayLayoutCommand ensurePushOverlayLayout() => $_ensure(20);
}

enum CommandResponse_Payload {
  deviceInfo,
  thumbnail,
  recordingList,
  downloadToken,
  telemetry,
  matchState,
  wifiDirectGroup,
  notSet
}

class CommandResponse extends $pb.GeneratedMessage {
  factory CommandResponse({
    $core.String? correlationId,
    ResponseStatus? status,
    $core.String? errorMessage,
    DeviceInfoResponse? deviceInfo,
    ThumbnailResponse? thumbnail,
    RecordingListResponse? recordingList,
    DownloadTokenResponse? downloadToken,
    DeviceTelemetry? telemetry,
    MatchState? matchState,
    WifiDirectGroupResponse? wifiDirectGroup,
  }) {
    final result = create();
    if (correlationId != null) result.correlationId = correlationId;
    if (status != null) result.status = status;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (deviceInfo != null) result.deviceInfo = deviceInfo;
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (recordingList != null) result.recordingList = recordingList;
    if (downloadToken != null) result.downloadToken = downloadToken;
    if (telemetry != null) result.telemetry = telemetry;
    if (matchState != null) result.matchState = matchState;
    if (wifiDirectGroup != null) result.wifiDirectGroup = wifiDirectGroup;
    return result;
  }

  CommandResponse._();

  factory CommandResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommandResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, CommandResponse_Payload>
      _CommandResponse_PayloadByTag = {
    10: CommandResponse_Payload.deviceInfo,
    11: CommandResponse_Payload.thumbnail,
    12: CommandResponse_Payload.recordingList,
    13: CommandResponse_Payload.downloadToken,
    14: CommandResponse_Payload.telemetry,
    15: CommandResponse_Payload.matchState,
    23: CommandResponse_Payload.wifiDirectGroup,
    0: CommandResponse_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommandResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14, 15, 23])
    ..aOS(1, _omitFieldNames ? '' : 'correlationId')
    ..aE<ResponseStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: ResponseStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<DeviceInfoResponse>(10, _omitFieldNames ? '' : 'deviceInfo',
        subBuilder: DeviceInfoResponse.create)
    ..aOM<ThumbnailResponse>(11, _omitFieldNames ? '' : 'thumbnail',
        subBuilder: ThumbnailResponse.create)
    ..aOM<RecordingListResponse>(12, _omitFieldNames ? '' : 'recordingList',
        subBuilder: RecordingListResponse.create)
    ..aOM<DownloadTokenResponse>(13, _omitFieldNames ? '' : 'downloadToken',
        subBuilder: DownloadTokenResponse.create)
    ..aOM<DeviceTelemetry>(14, _omitFieldNames ? '' : 'telemetry',
        subBuilder: DeviceTelemetry.create)
    ..aOM<MatchState>(15, _omitFieldNames ? '' : 'matchState',
        subBuilder: MatchState.create)
    ..aOM<WifiDirectGroupResponse>(23, _omitFieldNames ? '' : 'wifiDirectGroup',
        subBuilder: WifiDirectGroupResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandResponse copyWith(void Function(CommandResponse) updates) =>
      super.copyWith((message) => updates(message as CommandResponse))
          as CommandResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandResponse create() => CommandResponse._();
  @$core.override
  CommandResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommandResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommandResponse>(create);
  static CommandResponse? _defaultInstance;

  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(23)
  CommandResponse_Payload whichPayload() =>
      _CommandResponse_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(23)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get correlationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set correlationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCorrelationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCorrelationId() => $_clearField(1);

  @$pb.TagNumber(2)
  ResponseStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(ResponseStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => $_clearField(3);

  @$pb.TagNumber(10)
  DeviceInfoResponse get deviceInfo => $_getN(3);
  @$pb.TagNumber(10)
  set deviceInfo(DeviceInfoResponse value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasDeviceInfo() => $_has(3);
  @$pb.TagNumber(10)
  void clearDeviceInfo() => $_clearField(10);
  @$pb.TagNumber(10)
  DeviceInfoResponse ensureDeviceInfo() => $_ensure(3);

  @$pb.TagNumber(11)
  ThumbnailResponse get thumbnail => $_getN(4);
  @$pb.TagNumber(11)
  set thumbnail(ThumbnailResponse value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasThumbnail() => $_has(4);
  @$pb.TagNumber(11)
  void clearThumbnail() => $_clearField(11);
  @$pb.TagNumber(11)
  ThumbnailResponse ensureThumbnail() => $_ensure(4);

  @$pb.TagNumber(12)
  RecordingListResponse get recordingList => $_getN(5);
  @$pb.TagNumber(12)
  set recordingList(RecordingListResponse value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasRecordingList() => $_has(5);
  @$pb.TagNumber(12)
  void clearRecordingList() => $_clearField(12);
  @$pb.TagNumber(12)
  RecordingListResponse ensureRecordingList() => $_ensure(5);

  @$pb.TagNumber(13)
  DownloadTokenResponse get downloadToken => $_getN(6);
  @$pb.TagNumber(13)
  set downloadToken(DownloadTokenResponse value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasDownloadToken() => $_has(6);
  @$pb.TagNumber(13)
  void clearDownloadToken() => $_clearField(13);
  @$pb.TagNumber(13)
  DownloadTokenResponse ensureDownloadToken() => $_ensure(6);

  @$pb.TagNumber(14)
  DeviceTelemetry get telemetry => $_getN(7);
  @$pb.TagNumber(14)
  set telemetry(DeviceTelemetry value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasTelemetry() => $_has(7);
  @$pb.TagNumber(14)
  void clearTelemetry() => $_clearField(14);
  @$pb.TagNumber(14)
  DeviceTelemetry ensureTelemetry() => $_ensure(7);

  @$pb.TagNumber(15)
  MatchState get matchState => $_getN(8);
  @$pb.TagNumber(15)
  set matchState(MatchState value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasMatchState() => $_has(8);
  @$pb.TagNumber(15)
  void clearMatchState() => $_clearField(15);
  @$pb.TagNumber(15)
  MatchState ensureMatchState() => $_ensure(8);

  @$pb.TagNumber(23)
  WifiDirectGroupResponse get wifiDirectGroup => $_getN(9);
  @$pb.TagNumber(23)
  set wifiDirectGroup(WifiDirectGroupResponse value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasWifiDirectGroup() => $_has(9);
  @$pb.TagNumber(23)
  void clearWifiDirectGroup() => $_clearField(23);
  @$pb.TagNumber(23)
  WifiDirectGroupResponse ensureWifiDirectGroup() => $_ensure(9);
}

class GetDeviceInfoCommand extends $pb.GeneratedMessage {
  factory GetDeviceInfoCommand() => create();

  GetDeviceInfoCommand._();

  factory GetDeviceInfoCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDeviceInfoCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeviceInfoCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeviceInfoCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDeviceInfoCommand copyWith(void Function(GetDeviceInfoCommand) updates) =>
      super.copyWith((message) => updates(message as GetDeviceInfoCommand))
          as GetDeviceInfoCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeviceInfoCommand create() => GetDeviceInfoCommand._();
  @$core.override
  GetDeviceInfoCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetDeviceInfoCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeviceInfoCommand>(create);
  static GetDeviceInfoCommand? _defaultInstance;
}

class GetTelemetryCommand extends $pb.GeneratedMessage {
  factory GetTelemetryCommand() => create();

  GetTelemetryCommand._();

  factory GetTelemetryCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTelemetryCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTelemetryCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelemetryCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTelemetryCommand copyWith(void Function(GetTelemetryCommand) updates) =>
      super.copyWith((message) => updates(message as GetTelemetryCommand))
          as GetTelemetryCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTelemetryCommand create() => GetTelemetryCommand._();
  @$core.override
  GetTelemetryCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTelemetryCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTelemetryCommand>(create);
  static GetTelemetryCommand? _defaultInstance;
}

class GetMatchStateCommand extends $pb.GeneratedMessage {
  factory GetMatchStateCommand() => create();

  GetMatchStateCommand._();

  factory GetMatchStateCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMatchStateCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMatchStateCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMatchStateCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMatchStateCommand copyWith(void Function(GetMatchStateCommand) updates) =>
      super.copyWith((message) => updates(message as GetMatchStateCommand))
          as GetMatchStateCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMatchStateCommand create() => GetMatchStateCommand._();
  @$core.override
  GetMatchStateCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetMatchStateCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMatchStateCommand>(create);
  static GetMatchStateCommand? _defaultInstance;
}

class ListRecordingsCommand extends $pb.GeneratedMessage {
  factory ListRecordingsCommand() => create();

  ListRecordingsCommand._();

  factory ListRecordingsCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRecordingsCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRecordingsCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecordingsCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRecordingsCommand copyWith(
          void Function(ListRecordingsCommand) updates) =>
      super.copyWith((message) => updates(message as ListRecordingsCommand))
          as ListRecordingsCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRecordingsCommand create() => ListRecordingsCommand._();
  @$core.override
  ListRecordingsCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRecordingsCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRecordingsCommand>(create);
  static ListRecordingsCommand? _defaultInstance;
}

class FactoryResetCommand extends $pb.GeneratedMessage {
  factory FactoryResetCommand() => create();

  FactoryResetCommand._();

  factory FactoryResetCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FactoryResetCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FactoryResetCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FactoryResetCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FactoryResetCommand copyWith(void Function(FactoryResetCommand) updates) =>
      super.copyWith((message) => updates(message as FactoryResetCommand))
          as FactoryResetCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FactoryResetCommand create() => FactoryResetCommand._();
  @$core.override
  FactoryResetCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FactoryResetCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FactoryResetCommand>(create);
  static FactoryResetCommand? _defaultInstance;
}

class FirmwareUpdateCommand extends $pb.GeneratedMessage {
  factory FirmwareUpdateCommand() => create();

  FirmwareUpdateCommand._();

  factory FirmwareUpdateCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FirmwareUpdateCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FirmwareUpdateCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FirmwareUpdateCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FirmwareUpdateCommand copyWith(
          void Function(FirmwareUpdateCommand) updates) =>
      super.copyWith((message) => updates(message as FirmwareUpdateCommand))
          as FirmwareUpdateCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FirmwareUpdateCommand create() => FirmwareUpdateCommand._();
  @$core.override
  FirmwareUpdateCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FirmwareUpdateCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FirmwareUpdateCommand>(create);
  static FirmwareUpdateCommand? _defaultInstance;
}

class DeviceInfoResponse extends $pb.GeneratedMessage {
  factory DeviceInfoResponse({
    $core.String? deviceId,
    $core.String? name,
    $core.String? firmwareVersion,
    $core.String? model,
    $core.int? protocolVersion,
  }) {
    final result = create();
    if (deviceId != null) result.deviceId = deviceId;
    if (name != null) result.name = name;
    if (firmwareVersion != null) result.firmwareVersion = firmwareVersion;
    if (model != null) result.model = model;
    if (protocolVersion != null) result.protocolVersion = protocolVersion;
    return result;
  }

  DeviceInfoResponse._();

  factory DeviceInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceInfoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'firmwareVersion')
    ..aOS(4, _omitFieldNames ? '' : 'model')
    ..aI(5, _omitFieldNames ? '' : 'protocolVersion',
        fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceInfoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceInfoResponse copyWith(void Function(DeviceInfoResponse) updates) =>
      super.copyWith((message) => updates(message as DeviceInfoResponse))
          as DeviceInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceInfoResponse create() => DeviceInfoResponse._();
  @$core.override
  DeviceInfoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceInfoResponse>(create);
  static DeviceInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firmwareVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set firmwareVersion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirmwareVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirmwareVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get model => $_getSZ(3);
  @$pb.TagNumber(4)
  set model($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get protocolVersion => $_getIZ(4);
  @$pb.TagNumber(5)
  set protocolVersion($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProtocolVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearProtocolVersion() => $_clearField(5);
}

class DeviceTelemetry extends $pb.GeneratedMessage {
  factory DeviceTelemetry({
    $fixnum.Int64? storageFreeBytes,
    $fixnum.Int64? storageTotalBytes,
    WifiState? wifiState,
    $core.String? wifiSsid,
    $core.int? wifiSignalDbm,
    $core.bool? internetReachable,
    $core.double? tempCelsius,
    $core.double? ramUsedPct,
    $core.double? cpuUsedPct,
    $fixnum.Int64? uptimeSeconds,
    $core.bool? isRecording,
    $core.bool? isStreaming,
    $core.int? batteryLevelPct,
    $core.bool? isRawCapturing,
  }) {
    final result = create();
    if (storageFreeBytes != null) result.storageFreeBytes = storageFreeBytes;
    if (storageTotalBytes != null) result.storageTotalBytes = storageTotalBytes;
    if (wifiState != null) result.wifiState = wifiState;
    if (wifiSsid != null) result.wifiSsid = wifiSsid;
    if (wifiSignalDbm != null) result.wifiSignalDbm = wifiSignalDbm;
    if (internetReachable != null) result.internetReachable = internetReachable;
    if (tempCelsius != null) result.tempCelsius = tempCelsius;
    if (ramUsedPct != null) result.ramUsedPct = ramUsedPct;
    if (cpuUsedPct != null) result.cpuUsedPct = cpuUsedPct;
    if (uptimeSeconds != null) result.uptimeSeconds = uptimeSeconds;
    if (isRecording != null) result.isRecording = isRecording;
    if (isStreaming != null) result.isStreaming = isStreaming;
    if (batteryLevelPct != null) result.batteryLevelPct = batteryLevelPct;
    if (isRawCapturing != null) result.isRawCapturing = isRawCapturing;
    return result;
  }

  DeviceTelemetry._();

  factory DeviceTelemetry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceTelemetry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceTelemetry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'storageFreeBytes', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'storageTotalBytes', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<WifiState>(3, _omitFieldNames ? '' : 'wifiState',
        enumValues: WifiState.values)
    ..aOS(4, _omitFieldNames ? '' : 'wifiSsid')
    ..aI(5, _omitFieldNames ? '' : 'wifiSignalDbm',
        fieldType: $pb.PbFieldType.OS3)
    ..aOB(6, _omitFieldNames ? '' : 'internetReachable')
    ..aD(7, _omitFieldNames ? '' : 'tempCelsius', fieldType: $pb.PbFieldType.OF)
    ..aD(8, _omitFieldNames ? '' : 'ramUsedPct', fieldType: $pb.PbFieldType.OF)
    ..aD(9, _omitFieldNames ? '' : 'cpuUsedPct', fieldType: $pb.PbFieldType.OF)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'uptimeSeconds', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(11, _omitFieldNames ? '' : 'isRecording')
    ..aOB(12, _omitFieldNames ? '' : 'isStreaming')
    ..aI(13, _omitFieldNames ? '' : 'batteryLevelPct',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(14, _omitFieldNames ? '' : 'isRawCapturing')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceTelemetry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceTelemetry copyWith(void Function(DeviceTelemetry) updates) =>
      super.copyWith((message) => updates(message as DeviceTelemetry))
          as DeviceTelemetry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceTelemetry create() => DeviceTelemetry._();
  @$core.override
  DeviceTelemetry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceTelemetry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceTelemetry>(create);
  static DeviceTelemetry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get storageFreeBytes => $_getI64(0);
  @$pb.TagNumber(1)
  set storageFreeBytes($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStorageFreeBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageFreeBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get storageTotalBytes => $_getI64(1);
  @$pb.TagNumber(2)
  set storageTotalBytes($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStorageTotalBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearStorageTotalBytes() => $_clearField(2);

  @$pb.TagNumber(3)
  WifiState get wifiState => $_getN(2);
  @$pb.TagNumber(3)
  set wifiState(WifiState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWifiState() => $_has(2);
  @$pb.TagNumber(3)
  void clearWifiState() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get wifiSsid => $_getSZ(3);
  @$pb.TagNumber(4)
  set wifiSsid($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasWifiSsid() => $_has(3);
  @$pb.TagNumber(4)
  void clearWifiSsid() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get wifiSignalDbm => $_getIZ(4);
  @$pb.TagNumber(5)
  set wifiSignalDbm($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWifiSignalDbm() => $_has(4);
  @$pb.TagNumber(5)
  void clearWifiSignalDbm() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get internetReachable => $_getBF(5);
  @$pb.TagNumber(6)
  set internetReachable($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInternetReachable() => $_has(5);
  @$pb.TagNumber(6)
  void clearInternetReachable() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get tempCelsius => $_getN(6);
  @$pb.TagNumber(7)
  set tempCelsius($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTempCelsius() => $_has(6);
  @$pb.TagNumber(7)
  void clearTempCelsius() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get ramUsedPct => $_getN(7);
  @$pb.TagNumber(8)
  set ramUsedPct($core.double value) => $_setFloat(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRamUsedPct() => $_has(7);
  @$pb.TagNumber(8)
  void clearRamUsedPct() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get cpuUsedPct => $_getN(8);
  @$pb.TagNumber(9)
  set cpuUsedPct($core.double value) => $_setFloat(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCpuUsedPct() => $_has(8);
  @$pb.TagNumber(9)
  void clearCpuUsedPct() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get uptimeSeconds => $_getI64(9);
  @$pb.TagNumber(10)
  set uptimeSeconds($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUptimeSeconds() => $_has(9);
  @$pb.TagNumber(10)
  void clearUptimeSeconds() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isRecording => $_getBF(10);
  @$pb.TagNumber(11)
  set isRecording($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsRecording() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsRecording() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isStreaming => $_getBF(11);
  @$pb.TagNumber(12)
  set isStreaming($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsStreaming() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsStreaming() => $_clearField(12);

  /// optional so an absent value (device has no battery) is distinguishable from
  /// a real 0% reading via has_battery_level_pct().
  @$pb.TagNumber(13)
  $core.int get batteryLevelPct => $_getIZ(12);
  @$pb.TagNumber(13)
  set batteryLevelPct($core.int value) => $_setUnsignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBatteryLevelPct() => $_has(12);
  @$pb.TagNumber(13)
  void clearBatteryLevelPct() => $_clearField(13);

  /// Raw dual-camera capture running state, mirroring is_recording /
  /// is_streaming. absent ⇒ false. Reflects RawCaptureControlCommand lifecycle,
  /// independent of is_recording.
  @$pb.TagNumber(14)
  $core.bool get isRawCapturing => $_getBF(13);
  @$pb.TagNumber(14)
  set isRawCapturing($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsRawCapturing() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsRawCapturing() => $_clearField(14);
}

class ThumbnailRequest extends $pb.GeneratedMessage {
  factory ThumbnailRequest({
    $core.int? width,
    $core.int? height,
    $core.int? quality,
  }) {
    final result = create();
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (quality != null) result.quality = quality;
    return result;
  }

  ThumbnailRequest._();

  factory ThumbnailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ThumbnailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ThumbnailRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'width', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'height', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'quality', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThumbnailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThumbnailRequest copyWith(void Function(ThumbnailRequest) updates) =>
      super.copyWith((message) => updates(message as ThumbnailRequest))
          as ThumbnailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ThumbnailRequest create() => ThumbnailRequest._();
  @$core.override
  ThumbnailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ThumbnailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ThumbnailRequest>(create);
  static ThumbnailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get width => $_getIZ(0);
  @$pb.TagNumber(1)
  set width($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quality => $_getIZ(2);
  @$pb.TagNumber(3)
  set quality($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuality() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuality() => $_clearField(3);
}

class ThumbnailResponse extends $pb.GeneratedMessage {
  factory ThumbnailResponse({
    $core.List<$core.int>? jpegBytes,
    $fixnum.Int64? captureTimestamp,
  }) {
    final result = create();
    if (jpegBytes != null) result.jpegBytes = jpegBytes;
    if (captureTimestamp != null) result.captureTimestamp = captureTimestamp;
    return result;
  }

  ThumbnailResponse._();

  factory ThumbnailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ThumbnailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ThumbnailResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'jpegBytes', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'captureTimestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThumbnailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThumbnailResponse copyWith(void Function(ThumbnailResponse) updates) =>
      super.copyWith((message) => updates(message as ThumbnailResponse))
          as ThumbnailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ThumbnailResponse create() => ThumbnailResponse._();
  @$core.override
  ThumbnailResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ThumbnailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ThumbnailResponse>(create);
  static ThumbnailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get jpegBytes => $_getN(0);
  @$pb.TagNumber(1)
  set jpegBytes($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJpegBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearJpegBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get captureTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set captureTimestamp($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCaptureTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaptureTimestamp() => $_clearField(2);
}

class MatchControlCommand extends $pb.GeneratedMessage {
  factory MatchControlCommand({
    MatchControlAction? action,
    $core.int? period,
  }) {
    final result = create();
    if (action != null) result.action = action;
    if (period != null) result.period = period;
    return result;
  }

  MatchControlCommand._();

  factory MatchControlCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MatchControlCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MatchControlCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aE<MatchControlAction>(1, _omitFieldNames ? '' : 'action',
        enumValues: MatchControlAction.values)
    ..aI(2, _omitFieldNames ? '' : 'period', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchControlCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchControlCommand copyWith(void Function(MatchControlCommand) updates) =>
      super.copyWith((message) => updates(message as MatchControlCommand))
          as MatchControlCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchControlCommand create() => MatchControlCommand._();
  @$core.override
  MatchControlCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MatchControlCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MatchControlCommand>(create);
  static MatchControlCommand? _defaultInstance;

  @$pb.TagNumber(1)
  MatchControlAction get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(MatchControlAction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get period => $_getIZ(1);
  @$pb.TagNumber(2)
  set period($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => $_clearField(2);
}

class ScoreUpdateCommand extends $pb.GeneratedMessage {
  factory ScoreUpdateCommand({
    $core.String? teamId,
    $core.int? delta,
  }) {
    final result = create();
    if (teamId != null) result.teamId = teamId;
    if (delta != null) result.delta = delta;
    return result;
  }

  ScoreUpdateCommand._();

  factory ScoreUpdateCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScoreUpdateCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScoreUpdateCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'teamId')
    ..aI(2, _omitFieldNames ? '' : 'delta', fieldType: $pb.PbFieldType.OS3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreUpdateCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScoreUpdateCommand copyWith(void Function(ScoreUpdateCommand) updates) =>
      super.copyWith((message) => updates(message as ScoreUpdateCommand))
          as ScoreUpdateCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScoreUpdateCommand create() => ScoreUpdateCommand._();
  @$core.override
  ScoreUpdateCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScoreUpdateCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScoreUpdateCommand>(create);
  static ScoreUpdateCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get teamId => $_getSZ(0);
  @$pb.TagNumber(1)
  set teamId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTeamId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTeamId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get delta => $_getIZ(1);
  @$pb.TagNumber(2)
  set delta($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDelta() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelta() => $_clearField(2);
}

class BannerEventCommand extends $pb.GeneratedMessage {
  factory BannerEventCommand({
    $core.String? templateId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? params,
    $core.int? durationS,
    $core.String? playerId,
  }) {
    final result = create();
    if (templateId != null) result.templateId = templateId;
    if (params != null) result.params.addEntries(params);
    if (durationS != null) result.durationS = durationS;
    if (playerId != null) result.playerId = playerId;
    return result;
  }

  BannerEventCommand._();

  factory BannerEventCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BannerEventCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BannerEventCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'templateId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'params',
        entryClassName: 'BannerEventCommand.ParamsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('sst_cam'))
    ..aI(3, _omitFieldNames ? '' : 'durationS', fieldType: $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'playerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BannerEventCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BannerEventCommand copyWith(void Function(BannerEventCommand) updates) =>
      super.copyWith((message) => updates(message as BannerEventCommand))
          as BannerEventCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BannerEventCommand create() => BannerEventCommand._();
  @$core.override
  BannerEventCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BannerEventCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BannerEventCommand>(create);
  static BannerEventCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get templateId => $_getSZ(0);
  @$pb.TagNumber(1)
  set templateId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTemplateId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTemplateId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get params => $_getMap(1);

  @$pb.TagNumber(3)
  $core.int get durationS => $_getIZ(2);
  @$pb.TagNumber(3)
  set durationS($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDurationS() => $_has(2);
  @$pb.TagNumber(3)
  void clearDurationS() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get playerId => $_getSZ(3);
  @$pb.TagNumber(4)
  set playerId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPlayerId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlayerId() => $_clearField(4);
}

class MatchState extends $pb.GeneratedMessage {
  factory MatchState({
    MatchStatus? status,
    $core.int? currentPeriod,
    $core.int? timeRemainingS,
    $core.int? scoreA,
    $core.int? scoreB,
    $core.String? teamAId,
    $core.String? teamBId,
    $fixnum.Int64? updatedAt,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (currentPeriod != null) result.currentPeriod = currentPeriod;
    if (timeRemainingS != null) result.timeRemainingS = timeRemainingS;
    if (scoreA != null) result.scoreA = scoreA;
    if (scoreB != null) result.scoreB = scoreB;
    if (teamAId != null) result.teamAId = teamAId;
    if (teamBId != null) result.teamBId = teamBId;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  MatchState._();

  factory MatchState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MatchState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MatchState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aE<MatchStatus>(1, _omitFieldNames ? '' : 'status',
        enumValues: MatchStatus.values)
    ..aI(2, _omitFieldNames ? '' : 'currentPeriod',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'timeRemainingS',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'scoreA', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'scoreB', fieldType: $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'teamAId')
    ..aOS(7, _omitFieldNames ? '' : 'teamBId')
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'updatedAt', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchState copyWith(void Function(MatchState) updates) =>
      super.copyWith((message) => updates(message as MatchState)) as MatchState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchState create() => MatchState._();
  @$core.override
  MatchState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MatchState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MatchState>(create);
  static MatchState? _defaultInstance;

  @$pb.TagNumber(1)
  MatchStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(MatchStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentPeriod => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentPeriod($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPeriod() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get timeRemainingS => $_getIZ(2);
  @$pb.TagNumber(3)
  set timeRemainingS($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeRemainingS() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeRemainingS() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get scoreA => $_getIZ(3);
  @$pb.TagNumber(4)
  set scoreA($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScoreA() => $_has(3);
  @$pb.TagNumber(4)
  void clearScoreA() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get scoreB => $_getIZ(4);
  @$pb.TagNumber(5)
  set scoreB($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasScoreB() => $_has(4);
  @$pb.TagNumber(5)
  void clearScoreB() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get teamAId => $_getSZ(5);
  @$pb.TagNumber(6)
  set teamAId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTeamAId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTeamAId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get teamBId => $_getSZ(6);
  @$pb.TagNumber(7)
  set teamBId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTeamBId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTeamBId() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get updatedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set updatedAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => $_clearField(8);
}

class RecordingControlCommand extends $pb.GeneratedMessage {
  factory RecordingControlCommand({
    RecordingAction? action,
  }) {
    final result = create();
    if (action != null) result.action = action;
    return result;
  }

  RecordingControlCommand._();

  factory RecordingControlCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordingControlCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordingControlCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aE<RecordingAction>(1, _omitFieldNames ? '' : 'action',
        enumValues: RecordingAction.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingControlCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingControlCommand copyWith(
          void Function(RecordingControlCommand) updates) =>
      super.copyWith((message) => updates(message as RecordingControlCommand))
          as RecordingControlCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordingControlCommand create() => RecordingControlCommand._();
  @$core.override
  RecordingControlCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordingControlCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordingControlCommand>(create);
  static RecordingControlCommand? _defaultInstance;

  @$pb.TagNumber(1)
  RecordingAction get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(RecordingAction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);
}

/// Independent raw dual-camera training capture, distinct from
/// RecordingControlCommand. "RAW_DUAL" = both physical sensors captured raw in
/// one session, yielding two per-camera files (camera_index 0 and 1) paired by
/// a shared capture_group_id. Runs concurrently with final-match recording
/// (recording_control) and streaming (streaming_control) — its lifecycle does
/// not touch is_recording.
///
/// Reuses RecordingAction but only RECORDING_START / RECORDING_STOP are honored.
/// `action` is proto3 `optional` so firmware can distinguish a genuinely unset
/// field (has_action()==false) from an explicit value. The app MUST always set
/// it; firmware behavior (not this contract) answers an absent `action` or the
/// zero-value RECORDING_ACTION_UNKNOWN, plus PAUSE / RESUME, with UNSUPPORTED /
/// ERROR — it must NEVER treat absent/UNKNOWN as START.
///
/// capture_group_id is minted by the APP and sent on START; firmware stamps it
/// onto both per-camera files' RecordingMetadata (see RecordingMetadata fields
/// 8–10). The app MUST set it on RECORDING_START and firmware MUST reject a
/// START lacking it; it MUST be absent on RECORDING_STOP and firmware MUST
/// ignore it there. Treat it as an OPAQUE string: firmware MUST stamp it onto
/// both files verbatim — no inspection, truncation, or re-encoding (UUID v4
/// recommended; compared only by equality). This is the app-as-source-of-truth
/// pairing key, so the response stays status-only (no payload) — like
/// RecordingControlCommand, this is NOT in the CommandResponse payload oneof.
/// The app already knows the id it minted, so no payload is needed to learn it.
class RawCaptureControlCommand extends $pb.GeneratedMessage {
  factory RawCaptureControlCommand({
    RecordingAction? action,
    $core.String? captureGroupId,
  }) {
    final result = create();
    if (action != null) result.action = action;
    if (captureGroupId != null) result.captureGroupId = captureGroupId;
    return result;
  }

  RawCaptureControlCommand._();

  factory RawCaptureControlCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RawCaptureControlCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RawCaptureControlCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aE<RecordingAction>(1, _omitFieldNames ? '' : 'action',
        enumValues: RecordingAction.values)
    ..aOS(2, _omitFieldNames ? '' : 'captureGroupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RawCaptureControlCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RawCaptureControlCommand copyWith(
          void Function(RawCaptureControlCommand) updates) =>
      super.copyWith((message) => updates(message as RawCaptureControlCommand))
          as RawCaptureControlCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RawCaptureControlCommand create() => RawCaptureControlCommand._();
  @$core.override
  RawCaptureControlCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RawCaptureControlCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RawCaptureControlCommand>(create);
  static RawCaptureControlCommand? _defaultInstance;

  @$pb.TagNumber(1)
  RecordingAction get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(RecordingAction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get captureGroupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set captureGroupId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCaptureGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaptureGroupId() => $_clearField(2);
}

class StreamingControlCommand extends $pb.GeneratedMessage {
  factory StreamingControlCommand({
    StreamingAction? action,
    $core.String? destination,
  }) {
    final result = create();
    if (action != null) result.action = action;
    if (destination != null) result.destination = destination;
    return result;
  }

  StreamingControlCommand._();

  factory StreamingControlCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingControlCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingControlCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aE<StreamingAction>(1, _omitFieldNames ? '' : 'action',
        enumValues: StreamingAction.values)
    ..aOS(2, _omitFieldNames ? '' : 'destination')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingControlCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingControlCommand copyWith(
          void Function(StreamingControlCommand) updates) =>
      super.copyWith((message) => updates(message as StreamingControlCommand))
          as StreamingControlCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingControlCommand create() => StreamingControlCommand._();
  @$core.override
  StreamingControlCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingControlCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingControlCommand>(create);
  static StreamingControlCommand? _defaultInstance;

  @$pb.TagNumber(1)
  StreamingAction get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(StreamingAction value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get destination => $_getSZ(1);
  @$pb.TagNumber(2)
  set destination($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDestination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestination() => $_clearField(2);
}

class RecordingMetadata extends $pb.GeneratedMessage {
  factory RecordingMetadata({
    $core.String? id,
    $fixnum.Int64? durationS,
    $fixnum.Int64? sizeBytes,
    $fixnum.Int64? startedAt,
    $core.String? sport,
    $core.String? teams,
    $core.String? thumbnailId,
    $core.bool? isRaw,
    $core.int? cameraIndex,
    $core.String? captureGroupId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (durationS != null) result.durationS = durationS;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (startedAt != null) result.startedAt = startedAt;
    if (sport != null) result.sport = sport;
    if (teams != null) result.teams = teams;
    if (thumbnailId != null) result.thumbnailId = thumbnailId;
    if (isRaw != null) result.isRaw = isRaw;
    if (cameraIndex != null) result.cameraIndex = cameraIndex;
    if (captureGroupId != null) result.captureGroupId = captureGroupId;
    return result;
  }

  RecordingMetadata._();

  factory RecordingMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordingMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordingMetadata',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'durationS', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'sizeBytes', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'startedAt', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'sport')
    ..aOS(6, _omitFieldNames ? '' : 'teams')
    ..aOS(7, _omitFieldNames ? '' : 'thumbnailId')
    ..aOB(8, _omitFieldNames ? '' : 'isRaw')
    ..aI(9, _omitFieldNames ? '' : 'cameraIndex',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(10, _omitFieldNames ? '' : 'captureGroupId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingMetadata copyWith(void Function(RecordingMetadata) updates) =>
      super.copyWith((message) => updates(message as RecordingMetadata))
          as RecordingMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordingMetadata create() => RecordingMetadata._();
  @$core.override
  RecordingMetadata createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordingMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordingMetadata>(create);
  static RecordingMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get durationS => $_getI64(1);
  @$pb.TagNumber(2)
  set durationS($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDurationS() => $_has(1);
  @$pb.TagNumber(2)
  void clearDurationS() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get sizeBytes => $_getI64(2);
  @$pb.TagNumber(3)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSizeBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearSizeBytes() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get startedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set startedAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sport => $_getSZ(4);
  @$pb.TagNumber(5)
  set sport($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSport() => $_has(4);
  @$pb.TagNumber(5)
  void clearSport() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get teams => $_getSZ(5);
  @$pb.TagNumber(6)
  set teams($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTeams() => $_has(5);
  @$pb.TagNumber(6)
  void clearTeams() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get thumbnailId => $_getSZ(6);
  @$pb.TagNumber(7)
  set thumbnailId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasThumbnailId() => $_has(6);
  @$pb.TagNumber(7)
  void clearThumbnailId() => $_clearField(7);

  /// Raw dual-camera capture identity (see RawCaptureControlCommand). Absent on
  /// a final-match recording. JOINT INVARIANT: when is_raw == true, BOTH
  /// camera_index and capture_group_id MUST be present; when is_raw is
  /// absent/false, BOTH MUST be absent. A consumer MUST treat a raw file lacking
  /// either as malformed.
  ///
  /// is_raw: absent ⇒ false ⇒ final recording.
  @$pb.TagNumber(8)
  $core.bool get isRaw => $_getBF(7);
  @$pb.TagNumber(8)
  set isRaw($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsRaw() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsRaw() => $_clearField(8);

  /// camera_index: IDENTITY KEY, 0/1, pinned to the physical nvarguscamerasrc
  /// sensor-id (0 = primary sensor, 1 = secondary). Same referent on both
  /// stacks — front/back must NOT be assumed oppositely. Meaningful only when
  /// is_raw == true.
  @$pb.TagNumber(9)
  $core.int get cameraIndex => $_getIZ(8);
  @$pb.TagNumber(9)
  set cameraIndex($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCameraIndex() => $_has(8);
  @$pb.TagNumber(9)
  void clearCameraIndex() => $_clearField(9);

  /// capture_group_id: pairs the cam-0 / cam-1 files of one raw session. Equals
  /// the app-minted id sent on RawCaptureControlCommand START. Absent for final
  /// recordings.
  @$pb.TagNumber(10)
  $core.String get captureGroupId => $_getSZ(9);
  @$pb.TagNumber(10)
  set captureGroupId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCaptureGroupId() => $_has(9);
  @$pb.TagNumber(10)
  void clearCaptureGroupId() => $_clearField(10);
}

class RecordingListResponse extends $pb.GeneratedMessage {
  factory RecordingListResponse({
    $core.Iterable<RecordingMetadata>? recordings,
  }) {
    final result = create();
    if (recordings != null) result.recordings.addAll(recordings);
    return result;
  }

  RecordingListResponse._();

  factory RecordingListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordingListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordingListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..pPM<RecordingMetadata>(1, _omitFieldNames ? '' : 'recordings',
        subBuilder: RecordingMetadata.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordingListResponse copyWith(
          void Function(RecordingListResponse) updates) =>
      super.copyWith((message) => updates(message as RecordingListResponse))
          as RecordingListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordingListResponse create() => RecordingListResponse._();
  @$core.override
  RecordingListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RecordingListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordingListResponse>(create);
  static RecordingListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RecordingMetadata> get recordings => $_getList(0);
}

class DownloadRequestCommand extends $pb.GeneratedMessage {
  factory DownloadRequestCommand({
    $core.String? recordingId,
  }) {
    final result = create();
    if (recordingId != null) result.recordingId = recordingId;
    return result;
  }

  DownloadRequestCommand._();

  factory DownloadRequestCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DownloadRequestCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadRequestCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recordingId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadRequestCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadRequestCommand copyWith(
          void Function(DownloadRequestCommand) updates) =>
      super.copyWith((message) => updates(message as DownloadRequestCommand))
          as DownloadRequestCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadRequestCommand create() => DownloadRequestCommand._();
  @$core.override
  DownloadRequestCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DownloadRequestCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadRequestCommand>(create);
  static DownloadRequestCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recordingId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recordingId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecordingId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecordingId() => $_clearField(1);
}

class DownloadTokenResponse extends $pb.GeneratedMessage {
  factory DownloadTokenResponse({
    $core.String? recordingId,
    $core.String? httpUrl,
    $core.String? authToken,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (recordingId != null) result.recordingId = recordingId;
    if (httpUrl != null) result.httpUrl = httpUrl;
    if (authToken != null) result.authToken = authToken;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  DownloadTokenResponse._();

  factory DownloadTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DownloadTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recordingId')
    ..aOS(2, _omitFieldNames ? '' : 'httpUrl')
    ..aOS(3, _omitFieldNames ? '' : 'authToken')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'expiresAt', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DownloadTokenResponse copyWith(
          void Function(DownloadTokenResponse) updates) =>
      super.copyWith((message) => updates(message as DownloadTokenResponse))
          as DownloadTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTokenResponse create() => DownloadTokenResponse._();
  @$core.override
  DownloadTokenResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DownloadTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTokenResponse>(create);
  static DownloadTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recordingId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recordingId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecordingId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecordingId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get httpUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set httpUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHttpUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearHttpUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get authToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set authToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
}

class SetWifiConfigCommand extends $pb.GeneratedMessage {
  factory SetWifiConfigCommand({
    $core.String? ssid,
    $core.String? password,
  }) {
    final result = create();
    if (ssid != null) result.ssid = ssid;
    if (password != null) result.password = password;
    return result;
  }

  SetWifiConfigCommand._();

  factory SetWifiConfigCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetWifiConfigCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetWifiConfigCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ssid')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetWifiConfigCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetWifiConfigCommand copyWith(void Function(SetWifiConfigCommand) updates) =>
      super.copyWith((message) => updates(message as SetWifiConfigCommand))
          as SetWifiConfigCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetWifiConfigCommand create() => SetWifiConfigCommand._();
  @$core.override
  SetWifiConfigCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SetWifiConfigCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetWifiConfigCommand>(create);
  static SetWifiConfigCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ssid => $_getSZ(0);
  @$pb.TagNumber(1)
  set ssid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSsid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSsid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class SetStreamingConfigCommand extends $pb.GeneratedMessage {
  factory SetStreamingConfigCommand({
    StreamingConfig? config,
  }) {
    final result = create();
    if (config != null) result.config = config;
    return result;
  }

  SetStreamingConfigCommand._();

  factory SetStreamingConfigCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetStreamingConfigCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetStreamingConfigCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOM<StreamingConfig>(1, _omitFieldNames ? '' : 'config',
        subBuilder: StreamingConfig.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetStreamingConfigCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetStreamingConfigCommand copyWith(
          void Function(SetStreamingConfigCommand) updates) =>
      super.copyWith((message) => updates(message as SetStreamingConfigCommand))
          as SetStreamingConfigCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetStreamingConfigCommand create() => SetStreamingConfigCommand._();
  @$core.override
  SetStreamingConfigCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SetStreamingConfigCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetStreamingConfigCommand>(create);
  static SetStreamingConfigCommand? _defaultInstance;

  @$pb.TagNumber(1)
  StreamingConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(StreamingConfig value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => $_clearField(1);
  @$pb.TagNumber(1)
  StreamingConfig ensureConfig() => $_ensure(0);
}

class StreamingConfig extends $pb.GeneratedMessage {
  factory StreamingConfig({
    $core.String? youtubeStreamKey,
    $core.String? instagramStreamKey,
    $core.String? customRtmpUrl,
  }) {
    final result = create();
    if (youtubeStreamKey != null) result.youtubeStreamKey = youtubeStreamKey;
    if (instagramStreamKey != null)
      result.instagramStreamKey = instagramStreamKey;
    if (customRtmpUrl != null) result.customRtmpUrl = customRtmpUrl;
    return result;
  }

  StreamingConfig._();

  factory StreamingConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'youtubeStreamKey')
    ..aOS(2, _omitFieldNames ? '' : 'instagramStreamKey')
    ..aOS(3, _omitFieldNames ? '' : 'customRtmpUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingConfig copyWith(void Function(StreamingConfig) updates) =>
      super.copyWith((message) => updates(message as StreamingConfig))
          as StreamingConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingConfig create() => StreamingConfig._();
  @$core.override
  StreamingConfig createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingConfig>(create);
  static StreamingConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get youtubeStreamKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set youtubeStreamKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYoutubeStreamKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearYoutubeStreamKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get instagramStreamKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set instagramStreamKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInstagramStreamKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearInstagramStreamKey() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get customRtmpUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set customRtmpUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomRtmpUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomRtmpUrl() => $_clearField(3);
}

class PushSessionConfigCommand extends $pb.GeneratedMessage {
  factory PushSessionConfigCommand({
    $core.String? matchUuid,
    $core.String? userUuid,
    $core.String? sport,
    $core.int? numPeriods,
    $core.int? periodLengthSeconds,
    $core.String? rtmpUrl,
    $core.String? streamKey,
    $core.String? videoOutputPath,
    $core.String? thumbnailOutputPath,
    $core.String? teamAId,
    $core.String? teamBId,
    $core.String? teamAName,
    $core.String? teamBName,
    $core.String? teamAColorHex,
    $core.String? teamBColorHex,
  }) {
    final result = create();
    if (matchUuid != null) result.matchUuid = matchUuid;
    if (userUuid != null) result.userUuid = userUuid;
    if (sport != null) result.sport = sport;
    if (numPeriods != null) result.numPeriods = numPeriods;
    if (periodLengthSeconds != null)
      result.periodLengthSeconds = periodLengthSeconds;
    if (rtmpUrl != null) result.rtmpUrl = rtmpUrl;
    if (streamKey != null) result.streamKey = streamKey;
    if (videoOutputPath != null) result.videoOutputPath = videoOutputPath;
    if (thumbnailOutputPath != null)
      result.thumbnailOutputPath = thumbnailOutputPath;
    if (teamAId != null) result.teamAId = teamAId;
    if (teamBId != null) result.teamBId = teamBId;
    if (teamAName != null) result.teamAName = teamAName;
    if (teamBName != null) result.teamBName = teamBName;
    if (teamAColorHex != null) result.teamAColorHex = teamAColorHex;
    if (teamBColorHex != null) result.teamBColorHex = teamBColorHex;
    return result;
  }

  PushSessionConfigCommand._();

  factory PushSessionConfigCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PushSessionConfigCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PushSessionConfigCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'matchUuid')
    ..aOS(2, _omitFieldNames ? '' : 'userUuid')
    ..aOS(3, _omitFieldNames ? '' : 'sport')
    ..aI(4, _omitFieldNames ? '' : 'numPeriods')
    ..aI(5, _omitFieldNames ? '' : 'periodLengthSeconds')
    ..aOS(6, _omitFieldNames ? '' : 'rtmpUrl')
    ..aOS(7, _omitFieldNames ? '' : 'streamKey')
    ..aOS(8, _omitFieldNames ? '' : 'videoOutputPath')
    ..aOS(9, _omitFieldNames ? '' : 'thumbnailOutputPath')
    ..aOS(10, _omitFieldNames ? '' : 'teamAId')
    ..aOS(11, _omitFieldNames ? '' : 'teamBId')
    ..aOS(12, _omitFieldNames ? '' : 'teamAName')
    ..aOS(13, _omitFieldNames ? '' : 'teamBName')
    ..aOS(14, _omitFieldNames ? '' : 'teamAColorHex')
    ..aOS(15, _omitFieldNames ? '' : 'teamBColorHex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushSessionConfigCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushSessionConfigCommand copyWith(
          void Function(PushSessionConfigCommand) updates) =>
      super.copyWith((message) => updates(message as PushSessionConfigCommand))
          as PushSessionConfigCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PushSessionConfigCommand create() => PushSessionConfigCommand._();
  @$core.override
  PushSessionConfigCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PushSessionConfigCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PushSessionConfigCommand>(create);
  static PushSessionConfigCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get matchUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set matchUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMatchUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearMatchUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userUuid => $_getSZ(1);
  @$pb.TagNumber(2)
  set userUuid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserUuid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserUuid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sport => $_getSZ(2);
  @$pb.TagNumber(3)
  set sport($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSport() => $_has(2);
  @$pb.TagNumber(3)
  void clearSport() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get numPeriods => $_getIZ(3);
  @$pb.TagNumber(4)
  set numPeriods($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNumPeriods() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumPeriods() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get periodLengthSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set periodLengthSeconds($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriodLengthSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriodLengthSeconds() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get rtmpUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set rtmpUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRtmpUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearRtmpUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get streamKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set streamKey($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStreamKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearStreamKey() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get videoOutputPath => $_getSZ(7);
  @$pb.TagNumber(8)
  set videoOutputPath($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVideoOutputPath() => $_has(7);
  @$pb.TagNumber(8)
  void clearVideoOutputPath() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get thumbnailOutputPath => $_getSZ(8);
  @$pb.TagNumber(9)
  set thumbnailOutputPath($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasThumbnailOutputPath() => $_has(8);
  @$pb.TagNumber(9)
  void clearThumbnailOutputPath() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get teamAId => $_getSZ(9);
  @$pb.TagNumber(10)
  set teamAId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTeamAId() => $_has(9);
  @$pb.TagNumber(10)
  void clearTeamAId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get teamBId => $_getSZ(10);
  @$pb.TagNumber(11)
  set teamBId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTeamBId() => $_has(10);
  @$pb.TagNumber(11)
  void clearTeamBId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get teamAName => $_getSZ(11);
  @$pb.TagNumber(12)
  set teamAName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTeamAName() => $_has(11);
  @$pb.TagNumber(12)
  void clearTeamAName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get teamBName => $_getSZ(12);
  @$pb.TagNumber(13)
  set teamBName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTeamBName() => $_has(12);
  @$pb.TagNumber(13)
  void clearTeamBName() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get teamAColorHex => $_getSZ(13);
  @$pb.TagNumber(14)
  set teamAColorHex($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTeamAColorHex() => $_has(13);
  @$pb.TagNumber(14)
  void clearTeamAColorHex() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get teamBColorHex => $_getSZ(14);
  @$pb.TagNumber(15)
  set teamBColorHex($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTeamBColorHex() => $_has(14);
  @$pb.TagNumber(15)
  void clearTeamBColorHex() => $_clearField(15);
}

class StartWifiDirectCommand extends $pb.GeneratedMessage {
  factory StartWifiDirectCommand() => create();

  StartWifiDirectCommand._();

  factory StartWifiDirectCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StartWifiDirectCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartWifiDirectCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartWifiDirectCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartWifiDirectCommand copyWith(
          void Function(StartWifiDirectCommand) updates) =>
      super.copyWith((message) => updates(message as StartWifiDirectCommand))
          as StartWifiDirectCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartWifiDirectCommand create() => StartWifiDirectCommand._();
  @$core.override
  StartWifiDirectCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StartWifiDirectCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartWifiDirectCommand>(create);
  static StartWifiDirectCommand? _defaultInstance;
}

class StopWifiDirectCommand extends $pb.GeneratedMessage {
  factory StopWifiDirectCommand() => create();

  StopWifiDirectCommand._();

  factory StopWifiDirectCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StopWifiDirectCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopWifiDirectCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StopWifiDirectCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StopWifiDirectCommand copyWith(
          void Function(StopWifiDirectCommand) updates) =>
      super.copyWith((message) => updates(message as StopWifiDirectCommand))
          as StopWifiDirectCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopWifiDirectCommand create() => StopWifiDirectCommand._();
  @$core.override
  StopWifiDirectCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StopWifiDirectCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopWifiDirectCommand>(create);
  static StopWifiDirectCommand? _defaultInstance;
}

class WifiDirectGroupResponse extends $pb.GeneratedMessage {
  factory WifiDirectGroupResponse({
    $core.String? ssid,
    $core.String? psk,
    $core.String? groupOwnerIp,
    $core.int? previewPort,
    $core.int? downloadPort,
    $core.String? role,
  }) {
    final result = create();
    if (ssid != null) result.ssid = ssid;
    if (psk != null) result.psk = psk;
    if (groupOwnerIp != null) result.groupOwnerIp = groupOwnerIp;
    if (previewPort != null) result.previewPort = previewPort;
    if (downloadPort != null) result.downloadPort = downloadPort;
    if (role != null) result.role = role;
    return result;
  }

  WifiDirectGroupResponse._();

  factory WifiDirectGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WifiDirectGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WifiDirectGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ssid')
    ..aOS(2, _omitFieldNames ? '' : 'psk')
    ..aOS(3, _omitFieldNames ? '' : 'groupOwnerIp')
    ..aI(4, _omitFieldNames ? '' : 'previewPort',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'downloadPort',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'role')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WifiDirectGroupResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WifiDirectGroupResponse copyWith(
          void Function(WifiDirectGroupResponse) updates) =>
      super.copyWith((message) => updates(message as WifiDirectGroupResponse))
          as WifiDirectGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WifiDirectGroupResponse create() => WifiDirectGroupResponse._();
  @$core.override
  WifiDirectGroupResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WifiDirectGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WifiDirectGroupResponse>(create);
  static WifiDirectGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ssid => $_getSZ(0);
  @$pb.TagNumber(1)
  set ssid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSsid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSsid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get psk => $_getSZ(1);
  @$pb.TagNumber(2)
  set psk($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPsk() => $_has(1);
  @$pb.TagNumber(2)
  void clearPsk() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupOwnerIp => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupOwnerIp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGroupOwnerIp() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupOwnerIp() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get previewPort => $_getIZ(3);
  @$pb.TagNumber(4)
  set previewPort($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPreviewPort() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreviewPort() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get downloadPort => $_getIZ(4);
  @$pb.TagNumber(5)
  set downloadPort($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDownloadPort() => $_has(4);
  @$pb.TagNumber(5)
  void clearDownloadPort() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => $_clearField(6);
}

class PushOverlayLayoutCommand extends $pb.GeneratedMessage {
  factory PushOverlayLayoutCommand({
    OverlayLayout? layout,
  }) {
    final result = create();
    if (layout != null) result.layout = layout;
    return result;
  }

  PushOverlayLayoutCommand._();

  factory PushOverlayLayoutCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PushOverlayLayoutCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PushOverlayLayoutCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOM<OverlayLayout>(1, _omitFieldNames ? '' : 'layout',
        subBuilder: OverlayLayout.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushOverlayLayoutCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PushOverlayLayoutCommand copyWith(
          void Function(PushOverlayLayoutCommand) updates) =>
      super.copyWith((message) => updates(message as PushOverlayLayoutCommand))
          as PushOverlayLayoutCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PushOverlayLayoutCommand create() => PushOverlayLayoutCommand._();
  @$core.override
  PushOverlayLayoutCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PushOverlayLayoutCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PushOverlayLayoutCommand>(create);
  static PushOverlayLayoutCommand? _defaultInstance;

  @$pb.TagNumber(1)
  OverlayLayout get layout => $_getN(0);
  @$pb.TagNumber(1)
  set layout(OverlayLayout value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLayout() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayout() => $_clearField(1);
  @$pb.TagNumber(1)
  OverlayLayout ensureLayout() => $_ensure(0);
}

class OverlayLayout extends $pb.GeneratedMessage {
  factory OverlayLayout({
    $core.int? canvasWidth,
    $core.int? canvasHeight,
    $core.Iterable<OverlayElement>? elements,
    $core.Iterable<OverlayTemplate>? templates,
  }) {
    final result = create();
    if (canvasWidth != null) result.canvasWidth = canvasWidth;
    if (canvasHeight != null) result.canvasHeight = canvasHeight;
    if (elements != null) result.elements.addAll(elements);
    if (templates != null) result.templates.addAll(templates);
    return result;
  }

  OverlayLayout._();

  factory OverlayLayout.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverlayLayout.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverlayLayout',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'canvasWidth',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'canvasHeight',
        fieldType: $pb.PbFieldType.OU3)
    ..pPM<OverlayElement>(3, _omitFieldNames ? '' : 'elements',
        subBuilder: OverlayElement.create)
    ..pPM<OverlayTemplate>(4, _omitFieldNames ? '' : 'templates',
        subBuilder: OverlayTemplate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayLayout clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayLayout copyWith(void Function(OverlayLayout) updates) =>
      super.copyWith((message) => updates(message as OverlayLayout))
          as OverlayLayout;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverlayLayout create() => OverlayLayout._();
  @$core.override
  OverlayLayout createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverlayLayout getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverlayLayout>(create);
  static OverlayLayout? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get canvasWidth => $_getIZ(0);
  @$pb.TagNumber(1)
  set canvasWidth($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCanvasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearCanvasWidth() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get canvasHeight => $_getIZ(1);
  @$pb.TagNumber(2)
  set canvasHeight($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCanvasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearCanvasHeight() => $_clearField(2);

  /// Persistent elements: always visible once the layout is applied.
  /// Use for the scoreboard background, team names, score, clock, etc.
  @$pb.TagNumber(3)
  $pb.PbList<OverlayElement> get elements => $_getList(2);

  /// Event-triggered templates: shown transiently when a matching
  /// BannerEventCommand(template_id) arrives; hidden after duration_ms.
  /// Text content may use {{param_name}} substitution with BannerEventCommand.params.
  @$pb.TagNumber(4)
  $pb.PbList<OverlayTemplate> get templates => $_getList(3);
}

/// A single visual element in the overlay.
class OverlayElement extends $pb.GeneratedMessage {
  factory OverlayElement({
    $core.String? id,
    OverlayShape? shape,
    OverlayRect? bounds,
    OverlayStyle? style,
    OverlayBinding? binding,
    $core.bool? visible,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (shape != null) result.shape = shape;
    if (bounds != null) result.bounds = bounds;
    if (style != null) result.style = style;
    if (binding != null) result.binding = binding;
    if (visible != null) result.visible = visible;
    return result;
  }

  OverlayElement._();

  factory OverlayElement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverlayElement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverlayElement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<OverlayShape>(2, _omitFieldNames ? '' : 'shape',
        enumValues: OverlayShape.values)
    ..aOM<OverlayRect>(3, _omitFieldNames ? '' : 'bounds',
        subBuilder: OverlayRect.create)
    ..aOM<OverlayStyle>(4, _omitFieldNames ? '' : 'style',
        subBuilder: OverlayStyle.create)
    ..aE<OverlayBinding>(5, _omitFieldNames ? '' : 'binding',
        enumValues: OverlayBinding.values)
    ..aOB(6, _omitFieldNames ? '' : 'visible')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayElement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayElement copyWith(void Function(OverlayElement) updates) =>
      super.copyWith((message) => updates(message as OverlayElement))
          as OverlayElement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverlayElement create() => OverlayElement._();
  @$core.override
  OverlayElement createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverlayElement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverlayElement>(create);
  static OverlayElement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  OverlayShape get shape => $_getN(1);
  @$pb.TagNumber(2)
  set shape(OverlayShape value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasShape() => $_has(1);
  @$pb.TagNumber(2)
  void clearShape() => $_clearField(2);

  @$pb.TagNumber(3)
  OverlayRect get bounds => $_getN(2);
  @$pb.TagNumber(3)
  set bounds(OverlayRect value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBounds() => $_has(2);
  @$pb.TagNumber(3)
  void clearBounds() => $_clearField(3);
  @$pb.TagNumber(3)
  OverlayRect ensureBounds() => $_ensure(2);

  @$pb.TagNumber(4)
  OverlayStyle get style => $_getN(3);
  @$pb.TagNumber(4)
  set style(OverlayStyle value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStyle() => $_has(3);
  @$pb.TagNumber(4)
  void clearStyle() => $_clearField(4);
  @$pb.TagNumber(4)
  OverlayStyle ensureStyle() => $_ensure(3);

  @$pb.TagNumber(5)
  OverlayBinding get binding => $_getN(4);
  @$pb.TagNumber(5)
  set binding(OverlayBinding value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasBinding() => $_has(4);
  @$pb.TagNumber(5)
  void clearBinding() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get visible => $_getBF(5);
  @$pb.TagNumber(6)
  set visible($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVisible() => $_has(5);
  @$pb.TagNumber(6)
  void clearVisible() => $_clearField(6);
}

/// Position and layer of an element in canvas space.
class OverlayRect extends $pb.GeneratedMessage {
  factory OverlayRect({
    $core.double? x1,
    $core.double? y1,
    $core.int? z,
    $core.double? x2,
    $core.double? y2,
  }) {
    final result = create();
    if (x1 != null) result.x1 = x1;
    if (y1 != null) result.y1 = y1;
    if (z != null) result.z = z;
    if (x2 != null) result.x2 = x2;
    if (y2 != null) result.y2 = y2;
    return result;
  }

  OverlayRect._();

  factory OverlayRect.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverlayRect.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverlayRect',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'x1', fieldType: $pb.PbFieldType.OF)
    ..aD(2, _omitFieldNames ? '' : 'y1', fieldType: $pb.PbFieldType.OF)
    ..aI(3, _omitFieldNames ? '' : 'z', fieldType: $pb.PbFieldType.OU3)
    ..aD(4, _omitFieldNames ? '' : 'x2', fieldType: $pb.PbFieldType.OF)
    ..aD(5, _omitFieldNames ? '' : 'y2', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayRect clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayRect copyWith(void Function(OverlayRect) updates) =>
      super.copyWith((message) => updates(message as OverlayRect))
          as OverlayRect;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverlayRect create() => OverlayRect._();
  @$core.override
  OverlayRect createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverlayRect getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverlayRect>(create);
  static OverlayRect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x1 => $_getN(0);
  @$pb.TagNumber(1)
  set x1($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX1() => $_has(0);
  @$pb.TagNumber(1)
  void clearX1() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y1 => $_getN(1);
  @$pb.TagNumber(2)
  set y1($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY1() => $_has(1);
  @$pb.TagNumber(2)
  void clearY1() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get z => $_getIZ(2);
  @$pb.TagNumber(3)
  set z($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get x2 => $_getN(3);
  @$pb.TagNumber(4)
  set x2($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasX2() => $_has(3);
  @$pb.TagNumber(4)
  void clearX2() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get y2 => $_getN(4);
  @$pb.TagNumber(5)
  set y2($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasY2() => $_has(4);
  @$pb.TagNumber(5)
  void clearY2() => $_clearField(5);
}

/// Visual style properties.
class OverlayStyle extends $pb.GeneratedMessage {
  factory OverlayStyle({
    $core.String? fillColor,
    $core.String? textColor,
    $core.double? opacity,
    $core.double? cornerRadius,
    $core.String? fontFamily,
    $core.double? fontSize,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    $core.String? staticText,
  }) {
    final result = create();
    if (fillColor != null) result.fillColor = fillColor;
    if (textColor != null) result.textColor = textColor;
    if (opacity != null) result.opacity = opacity;
    if (cornerRadius != null) result.cornerRadius = cornerRadius;
    if (fontFamily != null) result.fontFamily = fontFamily;
    if (fontSize != null) result.fontSize = fontSize;
    if (textAlign != null) result.textAlign = textAlign;
    if (fontWeight != null) result.fontWeight = fontWeight;
    if (staticText != null) result.staticText = staticText;
    return result;
  }

  OverlayStyle._();

  factory OverlayStyle.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverlayStyle.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverlayStyle',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fillColor')
    ..aOS(2, _omitFieldNames ? '' : 'textColor')
    ..aD(3, _omitFieldNames ? '' : 'opacity', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'cornerRadius',
        fieldType: $pb.PbFieldType.OF)
    ..aOS(5, _omitFieldNames ? '' : 'fontFamily')
    ..aD(6, _omitFieldNames ? '' : 'fontSize', fieldType: $pb.PbFieldType.OF)
    ..aE<TextAlign>(7, _omitFieldNames ? '' : 'textAlign',
        enumValues: TextAlign.values)
    ..aE<FontWeight>(8, _omitFieldNames ? '' : 'fontWeight',
        enumValues: FontWeight.values)
    ..aOS(9, _omitFieldNames ? '' : 'staticText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayStyle clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayStyle copyWith(void Function(OverlayStyle) updates) =>
      super.copyWith((message) => updates(message as OverlayStyle))
          as OverlayStyle;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverlayStyle create() => OverlayStyle._();
  @$core.override
  OverlayStyle createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverlayStyle getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverlayStyle>(create);
  static OverlayStyle? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fillColor => $_getSZ(0);
  @$pb.TagNumber(1)
  set fillColor($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFillColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearFillColor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get textColor => $_getSZ(1);
  @$pb.TagNumber(2)
  set textColor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTextColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearTextColor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get opacity => $_getN(2);
  @$pb.TagNumber(3)
  set opacity($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOpacity() => $_has(2);
  @$pb.TagNumber(3)
  void clearOpacity() => $_clearField(3);

  /// See overlay-rendering.md "Element defaults".
  @$pb.TagNumber(4)
  $core.double get cornerRadius => $_getN(3);
  @$pb.TagNumber(4)
  set cornerRadius($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCornerRadius() => $_has(3);
  @$pb.TagNumber(4)
  void clearCornerRadius() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fontFamily => $_getSZ(4);
  @$pb.TagNumber(5)
  set fontFamily($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFontFamily() => $_has(4);
  @$pb.TagNumber(5)
  void clearFontFamily() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get fontSize => $_getN(5);
  @$pb.TagNumber(6)
  set fontSize($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFontSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearFontSize() => $_clearField(6);

  @$pb.TagNumber(7)
  TextAlign get textAlign => $_getN(6);
  @$pb.TagNumber(7)
  set textAlign(TextAlign value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTextAlign() => $_has(6);
  @$pb.TagNumber(7)
  void clearTextAlign() => $_clearField(7);

  @$pb.TagNumber(8)
  FontWeight get fontWeight => $_getN(7);
  @$pb.TagNumber(8)
  set fontWeight(FontWeight value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFontWeight() => $_has(7);
  @$pb.TagNumber(8)
  void clearFontWeight() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get staticText => $_getSZ(8);
  @$pb.TagNumber(9)
  set staticText($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStaticText() => $_has(8);
  @$pb.TagNumber(9)
  void clearStaticText() => $_clearField(9);
}

/// An event-triggered template: activated by BannerEventCommand(event_type),
/// shown for duration_ms, then removed. Text in style.static_text may contain
/// {{param_name}} placeholders substituted from BannerEventCommand.params.
class OverlayTemplate extends $pb.GeneratedMessage {
  factory OverlayTemplate({
    $core.String? eventType,
    $core.int? durationMs,
    $core.Iterable<OverlayElement>? elements,
  }) {
    final result = create();
    if (eventType != null) result.eventType = eventType;
    if (durationMs != null) result.durationMs = durationMs;
    if (elements != null) result.elements.addAll(elements);
    return result;
  }

  OverlayTemplate._();

  factory OverlayTemplate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OverlayTemplate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverlayTemplate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sst_cam'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventType')
    ..aI(2, _omitFieldNames ? '' : 'durationMs', fieldType: $pb.PbFieldType.OU3)
    ..pPM<OverlayElement>(3, _omitFieldNames ? '' : 'elements',
        subBuilder: OverlayElement.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayTemplate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OverlayTemplate copyWith(void Function(OverlayTemplate) updates) =>
      super.copyWith((message) => updates(message as OverlayTemplate))
          as OverlayTemplate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverlayTemplate create() => OverlayTemplate._();
  @$core.override
  OverlayTemplate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OverlayTemplate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverlayTemplate>(create);
  static OverlayTemplate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventType => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventType() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get durationMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set durationMs($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDurationMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearDurationMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<OverlayElement> get elements => $_getList(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
