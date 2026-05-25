class AdbAppPermissions {
  AdbAppPermissions({
    required this.backgroundActivity,
    required this.restrictBackgroundData,
  });

  BackgroundActivity backgroundActivity;
  bool restrictBackgroundData;

  @override
  bool operator ==(Object other) =>
      other is AdbAppPermissions &&
      backgroundActivity == other.backgroundActivity &&
      restrictBackgroundData == other.restrictBackgroundData;

  @override
  int get hashCode => Object.hash(backgroundActivity, restrictBackgroundData);

  factory AdbAppPermissions.fromJson(Map<String, dynamic> json) {
    final BackgroundActivity backgroundActivity;
    final backgroundActivityIndex = json['backgroundActivity'];
    if (backgroundActivityIndex is int) {
      backgroundActivity = .values[backgroundActivityIndex];
    } else {
      final runInBackground = json['runAnyInBackground'] as bool;
      backgroundActivity = runInBackground ? .optimized : .reduced;
    }

    return AdbAppPermissions(
      backgroundActivity: backgroundActivity,
      restrictBackgroundData: json['restrictBackgroundData'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'backgroundActivity': backgroundActivity.index,
      'restrictBackgroundData': restrictBackgroundData,
    };
  }

  AdbAppPermissions copy() => AdbAppPermissions(
    backgroundActivity: backgroundActivity,
    restrictBackgroundData: restrictBackgroundData,
  );
}

enum BackgroundActivity {
  /// The app isn't normally allowed to run in the background.
  /// Note that it may still run in some cases, e.g. in response to push events.
  reduced,

  /// Background activity is allowed depending on your usage patterns.
  /// Lesser used apps are restricted more than frequently used apps.
  optimized,

  /// Unrestricted background activity, regardless of your usage patterns.
  unrestricted;

  static BackgroundActivity fromFlags({
    required bool runAnyInBackground,
    required bool whitelistedBackground,
  }) {
    if (whitelistedBackground) {
      // Whitelist takes precedence
      return .unrestricted;
    }
    return runAnyInBackground ? .optimized : .reduced;
  }
}
