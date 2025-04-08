#ifndef FLUTTER_PLUGIN_PAG_PLUGIN_H_
#define FLUTTER_PLUGIN_PAG_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace pag {

class PagPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PagPlugin();

  virtual ~PagPlugin();

  // Disallow copy and assign.
  PagPlugin(const PagPlugin&) = delete;
  PagPlugin& operator=(const PagPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace pag

#endif  // FLUTTER_PLUGIN_PAG_PLUGIN_H_
