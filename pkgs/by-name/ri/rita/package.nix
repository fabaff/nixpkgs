{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "rita";
  version = "5.0.8";

  src = fetchFromGitHub {
    owner = "activecm";
    repo = "rita";
    rev = "refs/tags/v${version}";
    hash = "sha256-zbmXOeYBEanHr58HF67K0WzFAzt0+pHOxyOGdbSeqpg=";
  };

  vendorHash = "sha256-jKV1a11ReZiJUynSSKtDl74m/PSqjDPcKe7ADNG7DwU=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/activecm/rita/config.Version=${version}"
    "-X=github.com/activecm/rita/config.ExactVersion=${version}"
  ];

  # Tests require a Docker setup
  doCheck = false;

  meta = with lib; {
    description = "Framework for detecting command and control communication through network traffic analysis";
    homepage = "https://github.com/activecm/rita";
    changelog = "https://github.com/activecm/rita/releases/tag/v${version}";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ fab ];
    mainProgram = "rita";
  };
}
