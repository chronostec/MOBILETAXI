# fredy_client

    <!-- Always include this permission -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <!-- Include only if your app benefits from precise location access. -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <!-- Required only when requesting background location access on
       Android 10 (API level 29) and higher. -->
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
 <meta-data android:name="com.google.android.geo.API_KEY" android:value="AIzaSyC0FbHA9SZBofCJ1H98ifZe90XcmHc_iU0"/># MOBILETAXI

echo "# MOBILETAXI" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/chronostec/MOBILETAXI.git
git push -u origin main


git remote add origin https://github.com/chronostec/MOBILETAXI.git
git branch -M main
git push -u origin main