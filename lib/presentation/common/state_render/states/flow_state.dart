import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
  
  MobileModuleScreen? getMobileModuleScreen();
}
