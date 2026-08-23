{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:

buildGoModule (finalAttrs: {
  pname = "shuffledns";
  version = "1.2.1";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "projectdiscovery";
    repo = "shuffledns";
    tag = "v${finalAttrs.version}";
    hash = "sha256-hdlFmUfAKvBaFBIraOyLTuPbwykwIpqX5VzIPRP1lz8=";
  };

  vendorHash = "sha256-dWO/Dut4zwEkJfuBeXvE4Yx85hn0ufCPS9mV09gUrnc=";

  subPackages = [ "cmd/shuffledns" ];

  nativeInstallCheckInputs = [
    versionCheckHook
    writableTmpDirAsHomeHook
  ];

  ldflags = [ "-s" ];

  versionCheckKeepEnvironment = [ "HOME" ];

  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "massDNS wrapper to bruteforce and resolve the subdomains with wildcard handling support";
    longDescription = ''
      MassDNS wrapper written in go to enumerate valid subdomains using active bruteforce as well as resolve
      subdomains with wildcard filtering and easy input-output support.
    '';
    homepage = "https://github.com/projectdiscovery/shuffledns";
    changelog = "https://github.com/projectdiscovery/shuffledns/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Plus;
    maintainers = [ lib.maintainers.michaelBelsanti ];
    mainProgram = "shuffledns";
  };
})
