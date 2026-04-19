{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "cvemap";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "projectdiscovery";
    repo = "cvemap";
    tag = "v${finalAttrs.version}";
    hash = "sha256-HejAK/KXpQ9HouA3JpX7MoMzMUoMmKX7eEKwMGfgSx4=";
  };

  vendorHash = "sha256-WVskArdIieEof/GDlzEZbY4QDYfAQyP0+Le24q+Kfu0=";

  subPackages = [ "cmd/cvemap/" ];

  ldflags = [ "-s" ];

  meta = {
    description = "Tool to work with CVEs";
    homepage = "https://github.com/projectdiscovery/cvemap";
    changelog = "https://github.com/projectdiscovery/cvemap/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "cvemap";
  };
})
