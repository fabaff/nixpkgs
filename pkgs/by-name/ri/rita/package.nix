{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "rita";
  version = "5.1.0";

  src = fetchFromGitHub {
    owner = "activecm";
    repo = "rita";
    tag = "v${version}";
    hash = "sha256-+GVjjMwhPePyVaicwyJEImaf+Yd8VzRJfqp0gxOranI=";
  };

  vendorHash = "sha256-7QjrQHkyEYX1WkSuK3u0JVVVeYlAXalXnCsI3rZcJr4=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/activecm/rita/config.Version=${version}"
    "-X=github.com/activecm/rita/config.ExactVersion=${version}"
  ];

  doCheck = false;

  preCheck = ''
    # Test requires network access
    substituteInPlace cmd/cmd_test.go \
      --replace-fail "TestCheckForUpdate" "Skip_TestCheckForUpdate"
    substituteInPlace database/threat_intel_test.go \
      --replace-fail "TestParseOnlineFeeds" "Skip_TestParseOnlineFeeds"
    substituteInPlace database/server_test.go \
      --replace-fail "TestDatabase" "Skip_TestDatabase"
    # Test wants use Docker
    substituteInPlace cmd/cmd_test.go \
      --replace-fail "TestCmdTestSuite" "Skip_TestCmdTestSuite"
  '';

  meta = {
    description = "Framework for detecting command and control communication through network traffic analysis";
    homepage = "https://github.com/activecm/rita";
    changelog = "https://github.com/activecm/rita/releases/tag/${src.tag}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "rita";
  };
}
