package com.example.wellnet

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.usage.UsageStatsManager
import android.content.Context
import android.app.usage.UsageStats
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "wellnet/downtime"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getUsedMinutes") {
                    val minutes = getUsageMinutes()
                    result.success(minutes)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun getUsageMinutes(): Int {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val endTime = System.currentTimeMillis()
        val startTime = endTime - 1000 * 60 * 60 * 24 // 24 jam terakhir
        val stats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY, startTime, endTime
        )
        var totalMillis: Long = 0
        for (usageStat in stats) {
            totalMillis += usageStat.totalTimeInForeground
        }
        return (totalMillis / 60000).toInt()
    }
}
