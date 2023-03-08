import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

// error state (full screen, popup)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;

  @override
  MobileModuleScreen? getMobileModuleScreen() => null;
}
