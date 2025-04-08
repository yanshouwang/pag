#include "include/pag/pag_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "pag_plugin.h"

void PagPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  pag::PagPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
