//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <pag/pag_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) pag_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PagPlugin");
  pag_plugin_register_with_registrar(pag_registrar);
}
