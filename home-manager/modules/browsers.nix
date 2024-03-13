{ config
, pkgs
, lib
, inputs
, preferences
, ...
}:
let
  cfg = config.programs.browsers;
in
{
  options = {
    programs.browsers.enable = lib.mkEnableOption "Manage browsers";
    programs.browsers.extras = lib.mkEnableOption "Extra browsers";
  };
  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf cfg.extras (with pkgs; [
      epiphany
      lagrange
      bitwarden
      webcord
    ]);

    programs.chromium = {
      enable = preferences.browser == "chromium";
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--ozone-platform=wayland"
        "--process-per-site"
        "--js-flags=--jitless"
      ];
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      ];
    };

    programs.firefox = {
      enable = preferences.browser == "firefox";
      package = pkgs.firefox;
      policies = {
        "CaptivePortal" = false;
        "DisableFirefoxStudies" = true;
        "DisableTelemetry" = true;
        "DisablePocket" = true;
      };
      profiles.${config.home.username} = {
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          tridactyl
          youtube-shorts-block
        ];

        search.force = true;

        settings = {
          app.normandy.api_url = "";
          app.normandy.enabled = false;
          app.shield.optoutstudies.enabled = false;
          app.update.auto = false;
          beacon.enabled = false;
          breakpad.reportURL = "";
          browser.aboutConfig.showWarning = false;
          browser.crashReports.unsubmittedCheck.autoSubmit = false;
          browser.crashReports.unsubmittedCheck.autoSubmit2 = false;
          browser.crashReports.unsubmittedCheck.enabled = false;
          browser.disableResetPrompt = true;
          browser.fixup.alternate.enabled = false;
          browser.newtab.preload = false;
          browser.newtabpage.activity-stream.section.highlights.includePocket = false;
          browser.newtabpage.enhanced = false;
          browser.newtabpage.introShown = true;
          browser.selfsupport.url = "";
          browser.sessionstore.privacy_level = 0;
          browser.shell.checkDefaultBrowser = false;
          browser.startup.homepage_override.mstone = "ignore";
          browser.tabs.crashReporting.sendReport = false;
          browser.urlbar.groupLabels.enabled = false;
          browser.urlbar.quicksuggest.enabled = false;
          browser.urlbar.trimURLs = false;
          datareporting.healthreport.service.enabled = false;
          datareporting.healthreport.uploadEnabled = false;
          datareporting.policy.dataSubmissionEnabled = false;
          dom.security.https_only_mode = true;
          dom.security.https_only_mode_ever_enabled = true;
          experiments.activeExperiment = false;
          experiments.enabled = false;
          experiments.manifest.uri = "";
          experiments.supported = false;
          extensions.getAddons.cache.enabled = false;
          extensions.getAddons.showPane = false;
          extensions.greasemonkey.stats.optedin = false;
          extensions.greasemonkey.stats.url = "";
          extensions.pocket.enabled = false;
          extensions.shield-recipe-client.api_url = "";
          extensions.shield-recipe-client.enabled = false;
          extensions.webservice.discoverURL = "";
          media.autoplay.default = 1;
          media.autoplay.enabled = false;
          network.IDN_show_punycode = true;
          network.allow-experiments = false;
          network.captive-portal-service.enabled = false;
          network.cookie.cookieBehavior = 1;
          network.http.referer.spoofSource = true;
          pdfjs.enableScripting = false;
          privacy.query_stripping = true;
          privacy.trackingprotection.cryptomining.enabled = true;
          privacy.trackingprotection.enabled = true;
          privacy.trackingprotection.fingerprinting.enabled = true;
          privacy.trackingprotection.pbmode.enabled = true;
          privacy.usercontext.about_newtab_segregation.enabled = true;
          services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite = false;
          toolkit.telemetry.archive.enabled = false;
          toolkit.telemetry.bhrPing.enabled = false;
          toolkit.telemetry.cachedClientID = "";
          toolkit.telemetry.enabled = false;
          toolkit.telemetry.firstShutdownPing.enabled = false;
          toolkit.telemetry.hybridContent.enabled = false;
          toolkit.telemetry.newProfilePing.enabled = false;
          toolkit.telemetry.prompted = 2;
          toolkit.telemetry.rejected = true;
          toolkit.telemetry.reportingpolicy.firstRun = false;
          toolkit.telemetry.server = "";
          toolkit.telemetry.shutdownPingSender.enabled = false;
          toolkit.telemetry.unified = false;
          toolkit.telemetry.unifiedIsOptIn = false;
          toolkit.telemetry.updatePing.enabled = false;
          webgl.renderer-string-override = " ";
          webgl.vendor-string-override = " ";
          javascript.options.baselinejit = false;
        };
      };
    };
  };
}
