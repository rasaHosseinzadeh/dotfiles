user_pref("browser.startup.page", 3); // continue where you left off
user_pref("keyword.enabled", true); // Search in URL bar
/*
 * The next couple of lines are in order to keep history.
 */
user_pref("privacy.clearOnShutdown.cache", false);     // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.downloads", false); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.formdata", false);  // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.history", false);   // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.sessions", false);  // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.offlineApps", false);
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.resistFingerprinting.letterboxing", false); //Do not anonymize window size
user_pref("ui.systemUsesDarkTheme", 1); // [FF67+] [HIDDEN PREF]
user_pref("extensions.pocket.enabled", false); // Pocket Account [FF46+]
user_pref("identity.fxaccounts.enabled", false); // Firefox Accounts & Sync [FF60+] [RESTART]
user_pref("reader.parse-on-load.enabled", true); // Reader View
