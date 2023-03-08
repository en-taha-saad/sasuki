import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

// content state (full screen, popup)
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.emptyStr;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

  @override
  MobileModuleScreen? getMobileModuleScreen() => null;
}
