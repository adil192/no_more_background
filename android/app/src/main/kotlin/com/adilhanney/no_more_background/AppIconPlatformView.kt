package com.adilhanney.no_more_background;

import android.content.Context
import android.content.pm.PackageManager
import android.view.View
import android.widget.ImageView
import io.flutter.plugin.platform.PlatformView

internal class AppIconPlatformView(context: Context, creationParams: Map<String?, Any?>?) : PlatformView {
    private val packageName: String = (creationParams?.get("packageName") ?: "") as String
    private val imageView: ImageView = ImageView(context)

    override fun getView(): View {
        return imageView
    }

    override fun dispose() {
    }

    init {
        try {
            val icon = context.packageManager.getApplicationIcon(packageName);
            imageView.setImageDrawable(icon)
        } catch (_: PackageManager.NameNotFoundException) {
            imageView.setImageDrawable(context.packageManager.defaultActivityIcon)
            imageView.alpha = 0.3f
        }
    }
}
