import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

// loading state (full screen, popup)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  MobileModuleScreen? mobileModuleScreen;
  String? message;
  LoadingState({
    required this.stateRendererType,
    this.mobileModuleScreen,
    this.message,
  });
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message ?? AppStrings.emptyString;

  @override
  MobileModuleScreen? getMobileModuleScreen() => mobileModuleScreen;
}
