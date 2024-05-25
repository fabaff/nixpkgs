{ lib
, buildHomeAssistantComponent
, fetchFromGitHub
, hahomematic
}:

buildHomeAssistantComponent rec {
  owner = "danielperna84";
  domain = "homematicip_local";
  version = "1.64.0";

  src = fetchFromGitHub {
    owner = "danielperna84";
    repo = "custom_homematic";
    rev = "refs/tags/${version}";
    hash = "sha256-uKqX7TJrqujH8C9K8VPx977GsDeAdMh94390G5omUMY=";
  };

  postPatch = ''
    # pyhahomematic is maintained by the same person as homematicip_local
    # homematicip_local has simply a slightly different release cycle
    substituteInPlace custom_components/homematicip_local/manifest.json \
      --replace-fail "hahomematic==" "hahomematic>="
  '';

  dependencies = [ hahomematic ];

  meta = {
    changelog = "https://github.com/danielperna84/custom_homematic/blob/${version}/changelog.md";
    description = "Custom Home Assistant Component for HomeMatic";
    homepage = "https://github.com/danielperna84/custom_homematic";
    maintainers = with lib.maintainers; [ dotlambda ];
    license = lib.licenses.mit;
  };
}
