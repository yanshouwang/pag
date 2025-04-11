package dev.hebei.pag_android

import org.libpag.PAGScaleMode

val Int.api: Long get() = toLong()
val Long.impl: Int get() = toInt()

val Int.scaleModeApi: PAGScaleModeApi
    get() = when (this) {
        PAGScaleMode.None -> PAGScaleModeApi.NONE
        PAGScaleMode.Stretch -> PAGScaleModeApi.STRETCH
        PAGScaleMode.LetterBox -> PAGScaleModeApi.LETTER_BOX
        PAGScaleMode.Zoom -> PAGScaleModeApi.ZOOM
        else -> throw IllegalArgumentException()
    }

val PAGScaleModeApi.impl: Int
    get() = when (this) {
        PAGScaleModeApi.NONE -> PAGScaleMode.None
        PAGScaleModeApi.STRETCH -> PAGScaleMode.Stretch
        PAGScaleModeApi.LETTER_BOX -> PAGScaleMode.LetterBox
        PAGScaleModeApi.ZOOM -> PAGScaleMode.Zoom
    }