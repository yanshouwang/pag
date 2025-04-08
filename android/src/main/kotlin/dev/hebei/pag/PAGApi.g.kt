// Autogenerated from Pigeon (v25.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")

package dev.hebei.pag

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMethodCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is PAGError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): PAGError {
  return PAGError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class PAGError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()
/**
 * Maintains instances used to communicate with the corresponding objects in Dart.
 *
 * Objects stored in this container are represented by an object in Dart that is also stored in
 * an InstanceManager with the same identifier.
 *
 * When an instance is added with an identifier, either can be used to retrieve the other.
 *
 * Added instances are added as a weak reference and a strong reference. When the strong
 * reference is removed with [remove] and the weak reference is deallocated, the
 * `finalizationListener.onFinalize` is called with the instance's identifier. However, if the strong
 * reference is removed and then the identifier is retrieved with the intention to pass the identifier
 * to Dart (e.g. calling [getIdentifierForStrongReference]), the strong reference to the instance
 * is recreated. The strong reference will then need to be removed manually again.
 */
@Suppress("UNCHECKED_CAST", "MemberVisibilityCanBePrivate")
class PAGApiPigeonInstanceManager(private val finalizationListener: PigeonFinalizationListener) {
  /** Interface for listening when a weak reference of an instance is removed from the manager.  */
  interface PigeonFinalizationListener {
    fun onFinalize(identifier: Long)
  }

  private val identifiers = java.util.WeakHashMap<Any, Long>()
  private val weakInstances = HashMap<Long, java.lang.ref.WeakReference<Any>>()
  private val strongInstances = HashMap<Long, Any>()
  private val referenceQueue = java.lang.ref.ReferenceQueue<Any>()
  private val weakReferencesToIdentifiers = HashMap<java.lang.ref.WeakReference<Any>, Long>()
  private val handler = android.os.Handler(android.os.Looper.getMainLooper())
  private var nextIdentifier: Long = minHostCreatedIdentifier
  private var hasFinalizationListenerStopped = false

  /**
   * Modifies the time interval used to define how often this instance removes garbage collected
   * weak references to native Android objects that this instance was managing.
   */
  var clearFinalizedWeakReferencesInterval: Long = 3000
    set(value) {
      handler.removeCallbacks { this.releaseAllFinalizedInstances() }
      field = value
      releaseAllFinalizedInstances()
    }

  init {
    handler.postDelayed(
      { releaseAllFinalizedInstances() },
      clearFinalizedWeakReferencesInterval
    )
  }

  companion object {
    // Identifiers are locked to a specific range to avoid collisions with objects
    // created simultaneously from Dart.
    // Host uses identifiers >= 2^16 and Dart is expected to use values n where,
    // 0 <= n < 2^16.
    private const val minHostCreatedIdentifier: Long = 65536
    private const val tag = "PigeonInstanceManager"

    /**
     * Instantiate a new manager with a listener for garbage collected weak
     * references.
     *
     * When the manager is no longer needed, [stopFinalizationListener] must be called.
     */
    fun create(finalizationListener: PigeonFinalizationListener): PAGApiPigeonInstanceManager {
      return PAGApiPigeonInstanceManager(finalizationListener)
    }
  }

  /**
   * Removes `identifier` and return its associated strongly referenced instance, if present,
   * from the manager.
   */
  fun <T> remove(identifier: Long): T? {
    logWarningIfFinalizationListenerHasStopped()
    return strongInstances.remove(identifier) as T?
  }

  /**
   * Retrieves the identifier paired with an instance, if present, otherwise `null`.
   *
   *
   * If the manager contains a strong reference to `instance`, it will return the identifier
   * associated with `instance`. If the manager contains only a weak reference to `instance`, a new
   * strong reference to `instance` will be added and will need to be removed again with [remove].
   *
   *
   * If this method returns a nonnull identifier, this method also expects the Dart
   * `PAGApiPigeonInstanceManager` to have, or recreate, a weak reference to the Dart instance the
   * identifier is associated with.
   */
  fun getIdentifierForStrongReference(instance: Any?): Long? {
    logWarningIfFinalizationListenerHasStopped()
    val identifier = identifiers[instance]
    if (identifier != null) {
      strongInstances[identifier] = instance!!
    }
    return identifier
  }

  /**
   * Adds a new instance that was instantiated from Dart.
   *
   * The same instance can be added multiple times, but each identifier must be unique. This
   * allows two objects that are equivalent (e.g. the `equals` method returns true and their
   * hashcodes are equal) to both be added.
   *
   * [identifier] must be >= 0 and unique.
   */
  fun addDartCreatedInstance(instance: Any, identifier: Long) {
    logWarningIfFinalizationListenerHasStopped()
    addInstance(instance, identifier)
  }

  /**
   * Adds a new unique instance that was instantiated from the host platform.
   *
   * [identifier] must be >= 0 and unique.
   */
  fun addHostCreatedInstance(instance: Any): Long {
    logWarningIfFinalizationListenerHasStopped()
    require(!containsInstance(instance)) { "Instance of ${instance.javaClass} has already been added." }
    val identifier = nextIdentifier++
    addInstance(instance, identifier)
    return identifier
  }

  /** Retrieves the instance associated with identifier, if present, otherwise `null`. */
  fun <T> getInstance(identifier: Long): T? {
    logWarningIfFinalizationListenerHasStopped()
    val instance = weakInstances[identifier] as java.lang.ref.WeakReference<T>?
    return instance?.get()
  }

  /** Returns whether this manager contains the given `instance`. */
  fun containsInstance(instance: Any?): Boolean {
    logWarningIfFinalizationListenerHasStopped()
    return identifiers.containsKey(instance)
  }

  /**
   * Stops the periodic run of the [PigeonFinalizationListener] for instances that have been garbage
   * collected.
   *
   * The InstanceManager can continue to be used, but the [PigeonFinalizationListener] will no
   * longer be called and methods will log a warning.
   */
  fun stopFinalizationListener() {
    handler.removeCallbacks { this.releaseAllFinalizedInstances() }
    hasFinalizationListenerStopped = true
  }

  /**
   * Removes all of the instances from this manager.
   *
   * The manager will be empty after this call returns.
   */
  fun clear() {
    identifiers.clear()
    weakInstances.clear()
    strongInstances.clear()
    weakReferencesToIdentifiers.clear()
  }

  /**
   * Whether the [PigeonFinalizationListener] is still being called for instances that are garbage
   * collected.
   *
   * See [stopFinalizationListener].
   */
  fun hasFinalizationListenerStopped(): Boolean {
    return hasFinalizationListenerStopped
  }

  private fun releaseAllFinalizedInstances() {
    if (hasFinalizationListenerStopped()) {
      return
    }
    var reference: java.lang.ref.WeakReference<Any>?
    while ((referenceQueue.poll() as java.lang.ref.WeakReference<Any>?).also { reference = it } != null) {
      val identifier = weakReferencesToIdentifiers.remove(reference)
      if (identifier != null) {
        weakInstances.remove(identifier)
        strongInstances.remove(identifier)
        finalizationListener.onFinalize(identifier)
      }
    }
    handler.postDelayed(
      { releaseAllFinalizedInstances() },
      clearFinalizedWeakReferencesInterval
    )
  }

  private fun addInstance(instance: Any, identifier: Long) {
    require(identifier >= 0) { "Identifier must be >= 0: $identifier" }
    require(!weakInstances.containsKey(identifier)) {
      "Identifier has already been added: $identifier"
    }
    val weakReference = java.lang.ref.WeakReference(instance, referenceQueue)
    identifiers[instance] = identifier
    weakInstances[identifier] = weakReference
    weakReferencesToIdentifiers[weakReference] = identifier
    strongInstances[identifier] = instance
  }

  private fun logWarningIfFinalizationListenerHasStopped() {
    if (hasFinalizationListenerStopped()) {
      Log.w(
        tag,
        "The manager was used after calls to the PigeonFinalizationListener has been stopped."
      )
    }
  }
}


/** Generated API for managing the Dart and native `InstanceManager`s. */
private class PAGApiPigeonInstanceManagerApi(val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by PAGApiPigeonInstanceManagerApi. */
    val codec: MessageCodec<Any?> by lazy {
      PAGApiPigeonCodec()
    }

    /**
     * Sets up an instance of `PAGApiPigeonInstanceManagerApi` to handle messages from the
     * `binaryMessenger`.
     */
    fun setUpMessageHandlers(binaryMessenger: BinaryMessenger, instanceManager: PAGApiPigeonInstanceManager?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PigeonInternalInstanceManager.removeStrongReference", codec)
        if (instanceManager != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val identifierArg = args[0] as Long
            val wrapped: List<Any?> = try {
              instanceManager.remove<Any?>(identifierArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PigeonInternalInstanceManager.clear", codec)
        if (instanceManager != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              instanceManager.clear()
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }

  fun removeStrongReference(identifierArg: Long, callback: (Result<Unit>) -> Unit)
{
    val channelName = "dev.flutter.pigeon.pag.PigeonInternalInstanceManager.removeStrongReference"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(identifierArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(PAGError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
/**
 * Provides implementations for each ProxyApi implementation and provides access to resources
 * needed by any implementation.
 */
abstract class PAGApiPigeonProxyApiRegistrar(val binaryMessenger: BinaryMessenger) {
  /** Whether APIs should ignore calling to Dart. */
  public var ignoreCallsToDart = false
  val instanceManager: PAGApiPigeonInstanceManager
  private var _codec: MessageCodec<Any?>? = null
  val codec: MessageCodec<Any?>
    get() {
      if (_codec == null) {
        _codec = PAGApiPigeonProxyApiBaseCodec(this)
      }
      return _codec!!
    }

  init {
    val api = PAGApiPigeonInstanceManagerApi(binaryMessenger)
    instanceManager = PAGApiPigeonInstanceManager.create(
      object : PAGApiPigeonInstanceManager.PigeonFinalizationListener {
        override fun onFinalize(identifier: Long) {
          api.removeStrongReference(identifier) {
            if (it.isFailure) {
              Log.e(
                "PigeonProxyApiRegistrar",
                "Failed to remove Dart strong reference with identifier: $identifier"
              )
            }
          }
        }
      }
    )
  }
  /**
   * An implementation of [PigeonApiPAGViewApi] used to add a new Dart instance of
   * `PAGViewApi` to the Dart `InstanceManager`.
   */
  abstract fun getPigeonApiPAGViewApi(): PigeonApiPAGViewApi

  /**
   * An implementation of [PigeonApiPAGCompositionApi] used to add a new Dart instance of
   * `PAGCompositionApi` to the Dart `InstanceManager`.
   */
  abstract fun getPigeonApiPAGCompositionApi(): PigeonApiPAGCompositionApi

  /**
   * An implementation of [PigeonApiPAGFileApi] used to add a new Dart instance of
   * `PAGFileApi` to the Dart `InstanceManager`.
   */
  abstract fun getPigeonApiPAGFileApi(): PigeonApiPAGFileApi

  fun setUp() {
    PAGApiPigeonInstanceManagerApi.setUpMessageHandlers(binaryMessenger, instanceManager)
    PigeonApiPAGViewApi.setUpMessageHandlers(binaryMessenger, getPigeonApiPAGViewApi())
    PigeonApiPAGCompositionApi.setUpMessageHandlers(binaryMessenger, getPigeonApiPAGCompositionApi())
    PigeonApiPAGFileApi.setUpMessageHandlers(binaryMessenger, getPigeonApiPAGFileApi())
  }
  fun tearDown() {
    PAGApiPigeonInstanceManagerApi.setUpMessageHandlers(binaryMessenger, null)
    PigeonApiPAGViewApi.setUpMessageHandlers(binaryMessenger, null)
    PigeonApiPAGCompositionApi.setUpMessageHandlers(binaryMessenger, null)
    PigeonApiPAGFileApi.setUpMessageHandlers(binaryMessenger, null)
  }
}
private class PAGApiPigeonProxyApiBaseCodec(val registrar: PAGApiPigeonProxyApiRegistrar) : PAGApiPigeonCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        val identifier: Long = readValue(buffer) as Long
        val instance: Any? = registrar.instanceManager.getInstance(identifier)
        if (instance == null) {
          Log.e(
            "PigeonProxyApiBaseCodec",
            "Failed to find instance with identifier: $identifier"
          )
        }
        return instance
      }
      else -> super.readValueOfType(type, buffer)
    }
  }

  override fun writeValue(stream: ByteArrayOutputStream, value: Any?) {
    if (value is Boolean || value is ByteArray || value is Double || value is DoubleArray || value is FloatArray || value is Int || value is IntArray || value is List<*> || value is Long || value is LongArray || value is Map<*, *> || value is String || value is PAGScaleModeApi || value == null) {
      super.writeValue(stream, value)
      return
    }

    if (value is org.libpag.PAGView) {
      registrar.getPigeonApiPAGViewApi().pigeon_newInstance(value) { }
    }
     else if (value is org.libpag.PAGFile) {
      registrar.getPigeonApiPAGFileApi().pigeon_newInstance(value) { }
    }
     else if (value is org.libpag.PAGComposition) {
      registrar.getPigeonApiPAGCompositionApi().pigeon_newInstance(value) { }
    }

    when {
      registrar.instanceManager.containsInstance(value) -> {
        stream.write(128)
        writeValue(stream, registrar.instanceManager.getIdentifierForStrongReference(value))
      }
      else -> throw IllegalArgumentException("Unsupported value: '$value' of type '${value.javaClass.name}'")
    }
  }
}

enum class PAGScaleModeApi(val raw: Int) {
  NONE(0),
  STRETCH(1),
  LETTER_BOX(2),
  ZOOM(3);

  companion object {
    fun ofRaw(raw: Int): PAGScaleModeApi? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}
private open class PAGApiPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          PAGScaleModeApi.ofRaw(it.toInt())
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is PAGScaleModeApi -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }
      else -> super.writeValue(stream, value)
    }
  }
}

@Suppress("UNCHECKED_CAST")
abstract class PigeonApiPAGViewApi(open val pigeonRegistrar: PAGApiPigeonProxyApiRegistrar) {
  abstract fun pigeon_defaultConstructor(): org.libpag.PAGView

  abstract fun getComposition(pigeon_instance: org.libpag.PAGView): org.libpag.PAGComposition

  abstract fun setCompositon(pigeon_instance: org.libpag.PAGView, newComposition: org.libpag.PAGComposition)

  abstract fun repeatCount(pigeon_instance: org.libpag.PAGView): Long

  abstract fun setRepeatCount(pigeon_instance: org.libpag.PAGView, repeatCount: Long)

  abstract fun scaleMode(pigeon_instance: org.libpag.PAGView): PAGScaleModeApi

  abstract fun setScaleMode(pigeon_instance: org.libpag.PAGView, value: PAGScaleModeApi)

  abstract fun getProgress(pigeon_instance: org.libpag.PAGView): Double

  abstract fun setProgress(pigeon_instance: org.libpag.PAGView, value: Double)

  abstract fun sync(pigeon_instance: org.libpag.PAGView): Boolean

  abstract fun setSync(pigeon_instance: org.libpag.PAGView, value: Boolean)

  abstract fun isPlaying(pigeon_instance: org.libpag.PAGView): Boolean

  abstract fun play(pigeon_instance: org.libpag.PAGView)

  abstract fun pause(pigeon_instance: org.libpag.PAGView)

  abstract fun stop(pigeon_instance: org.libpag.PAGView)

  companion object {
    @Suppress("LocalVariableName")
    fun setUpMessageHandlers(binaryMessenger: BinaryMessenger, api: PigeonApiPAGViewApi?) {
      val codec = api?.pigeonRegistrar?.codec ?: PAGApiPigeonCodec()
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.pigeon_defaultConstructor", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_identifierArg = args[0] as Long
            val wrapped: List<Any?> = try {
              api.pigeonRegistrar.instanceManager.addDartCreatedInstance(api.pigeon_defaultConstructor(), pigeon_identifierArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.getComposition", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.getComposition(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.setCompositon", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val newCompositionArg = args[1] as org.libpag.PAGComposition
            val wrapped: List<Any?> = try {
              api.setCompositon(pigeon_instanceArg, newCompositionArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.repeatCount", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.repeatCount(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.setRepeatCount", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val repeatCountArg = args[1] as Long
            val wrapped: List<Any?> = try {
              api.setRepeatCount(pigeon_instanceArg, repeatCountArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.scaleMode", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.scaleMode(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.setScaleMode", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val valueArg = args[1] as PAGScaleModeApi
            val wrapped: List<Any?> = try {
              api.setScaleMode(pigeon_instanceArg, valueArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.getProgress", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.getProgress(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.setProgress", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val valueArg = args[1] as Double
            val wrapped: List<Any?> = try {
              api.setProgress(pigeon_instanceArg, valueArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.sync", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.sync(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.setSync", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val valueArg = args[1] as Boolean
            val wrapped: List<Any?> = try {
              api.setSync(pigeon_instanceArg, valueArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.isPlaying", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              listOf(api.isPlaying(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.play", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              api.play(pigeon_instanceArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.pause", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              api.pause(pigeon_instanceArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGViewApi.stop", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGView
            val wrapped: List<Any?> = try {
              api.stop(pigeon_instanceArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }

  @Suppress("LocalVariableName", "FunctionName")
  /** Creates a Dart instance of PAGViewApi and attaches it to [pigeon_instanceArg]. */
  fun pigeon_newInstance(pigeon_instanceArg: org.libpag.PAGView, callback: (Result<Unit>) -> Unit)
{
    if (pigeonRegistrar.ignoreCallsToDart) {
      callback(
          Result.failure(
              PAGError("ignore-calls-error", "Calls to Dart are being ignored.", "")))
    }     else if (pigeonRegistrar.instanceManager.containsInstance(pigeon_instanceArg)) {
      callback(Result.success(Unit))
    }     else {
      val pigeon_identifierArg = pigeonRegistrar.instanceManager.addHostCreatedInstance(pigeon_instanceArg)
      val binaryMessenger = pigeonRegistrar.binaryMessenger
      val codec = pigeonRegistrar.codec
      val channelName = "dev.flutter.pigeon.pag.PAGViewApi.pigeon_newInstance"
      val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
      channel.send(listOf(pigeon_identifierArg)) {
        if (it is List<*>) {
          if (it.size > 1) {
            callback(Result.failure(PAGError(it[0] as String, it[1] as String, it[2] as String?)))
          } else {
            callback(Result.success(Unit))
          }
        } else {
          callback(Result.failure(createConnectionError(channelName)))
        } 
      }
    }
  }

}
@Suppress("UNCHECKED_CAST")
abstract class PigeonApiPAGCompositionApi(open val pigeonRegistrar: PAGApiPigeonProxyApiRegistrar) {
  abstract fun width(pigeon_instance: org.libpag.PAGComposition): Long

  abstract fun height(pigeon_instance: org.libpag.PAGComposition): Long

  companion object {
    @Suppress("LocalVariableName")
    fun setUpMessageHandlers(binaryMessenger: BinaryMessenger, api: PigeonApiPAGCompositionApi?) {
      val codec = api?.pigeonRegistrar?.codec ?: PAGApiPigeonCodec()
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGCompositionApi.width", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGComposition
            val wrapped: List<Any?> = try {
              listOf(api.width(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGCompositionApi.height", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_instanceArg = args[0] as org.libpag.PAGComposition
            val wrapped: List<Any?> = try {
              listOf(api.height(pigeon_instanceArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }

  @Suppress("LocalVariableName", "FunctionName")
  /** Creates a Dart instance of PAGCompositionApi and attaches it to [pigeon_instanceArg]. */
  fun pigeon_newInstance(pigeon_instanceArg: org.libpag.PAGComposition, callback: (Result<Unit>) -> Unit)
{
    if (pigeonRegistrar.ignoreCallsToDart) {
      callback(
          Result.failure(
              PAGError("ignore-calls-error", "Calls to Dart are being ignored.", "")))
    }     else if (pigeonRegistrar.instanceManager.containsInstance(pigeon_instanceArg)) {
      callback(Result.success(Unit))
    }     else {
      val pigeon_identifierArg = pigeonRegistrar.instanceManager.addHostCreatedInstance(pigeon_instanceArg)
      val binaryMessenger = pigeonRegistrar.binaryMessenger
      val codec = pigeonRegistrar.codec
      val channelName = "dev.flutter.pigeon.pag.PAGCompositionApi.pigeon_newInstance"
      val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
      channel.send(listOf(pigeon_identifierArg)) {
        if (it is List<*>) {
          if (it.size > 1) {
            callback(Result.failure(PAGError(it[0] as String, it[1] as String, it[2] as String?)))
          } else {
            callback(Result.success(Unit))
          }
        } else {
          callback(Result.failure(createConnectionError(channelName)))
        } 
      }
    }
  }

}
@Suppress("UNCHECKED_CAST")
abstract class PigeonApiPAGFileApi(open val pigeonRegistrar: PAGApiPigeonProxyApiRegistrar) {
  abstract fun asset(assetName: String): org.libpag.PAGFile

  abstract fun file(filePath: String): org.libpag.PAGFile

  abstract fun memory(bytes: ByteArray): org.libpag.PAGFile

  companion object {
    @Suppress("LocalVariableName")
    fun setUpMessageHandlers(binaryMessenger: BinaryMessenger, api: PigeonApiPAGFileApi?) {
      val codec = api?.pigeonRegistrar?.codec ?: PAGApiPigeonCodec()
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGFileApi.asset", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_identifierArg = args[0] as Long
            val assetNameArg = args[1] as String
            val wrapped: List<Any?> = try {
              api.pigeonRegistrar.instanceManager.addDartCreatedInstance(api.asset(assetNameArg), pigeon_identifierArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGFileApi.file", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_identifierArg = args[0] as Long
            val filePathArg = args[1] as String
            val wrapped: List<Any?> = try {
              api.pigeonRegistrar.instanceManager.addDartCreatedInstance(api.file(filePathArg), pigeon_identifierArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.pag.PAGFileApi.memory", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val pigeon_identifierArg = args[0] as Long
            val bytesArg = args[1] as ByteArray
            val wrapped: List<Any?> = try {
              api.pigeonRegistrar.instanceManager.addDartCreatedInstance(api.memory(bytesArg), pigeon_identifierArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }

  @Suppress("LocalVariableName", "FunctionName")
  /** Creates a Dart instance of PAGFileApi and attaches it to [pigeon_instanceArg]. */
  fun pigeon_newInstance(pigeon_instanceArg: org.libpag.PAGFile, callback: (Result<Unit>) -> Unit)
{
    if (pigeonRegistrar.ignoreCallsToDart) {
      callback(
          Result.failure(
              PAGError("ignore-calls-error", "Calls to Dart are being ignored.", "")))
    }     else if (pigeonRegistrar.instanceManager.containsInstance(pigeon_instanceArg)) {
      callback(Result.success(Unit))
    }     else {
      val pigeon_identifierArg = pigeonRegistrar.instanceManager.addHostCreatedInstance(pigeon_instanceArg)
      val binaryMessenger = pigeonRegistrar.binaryMessenger
      val codec = pigeonRegistrar.codec
      val channelName = "dev.flutter.pigeon.pag.PAGFileApi.pigeon_newInstance"
      val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
      channel.send(listOf(pigeon_identifierArg)) {
        if (it is List<*>) {
          if (it.size > 1) {
            callback(Result.failure(PAGError(it[0] as String, it[1] as String, it[2] as String?)))
          } else {
            callback(Result.success(Unit))
          }
        } else {
          callback(Result.failure(createConnectionError(channelName)))
        } 
      }
    }
  }

  @Suppress("FunctionName")
  /** An implementation of [PigeonApiPAGCompositionApi] used to access callback methods */
  fun pigeon_getPigeonApiPAGCompositionApi(): PigeonApiPAGCompositionApi
  {
    return pigeonRegistrar.getPigeonApiPAGCompositionApi()
  }

}
