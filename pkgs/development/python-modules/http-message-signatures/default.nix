{
  lib,
  buildPythonPackage,
  cryptography,
  fetchFromGitHub,
  hatch-vcs,
  hatchling,
  http-sfv,
  pytestCheckHook,
  requests,
}:

buildPythonPackage rec {
  pname = "http-message-signatures";
  version = "0.6.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pyauth";
    repo = "http-message-signatures";
    tag = "v${version}";
    hash = "sha256-ravobyV8SLKOXJbtc383Xmys06aG/Z/OOjFDTa5yBrg=";
  };

  build-system = [
    hatch-vcs
    hatchling
  ];

  dependencies = [
    cryptography
    http-sfv
  ];

  nativeCheckInputs = [
    pytestCheckHook
    requests
  ];

  pytestFlagsArray = [ "test/test.py" ];

  pythonImportsCheck = [ "http_message_signatures" ];

  meta = with lib; {
    description = "Requests authentication module for HTTP Signature";
    homepage = "https://github.com/pyauth/http-message-signatures";
    changelog = "https://github.com/pyauth/http-message-signatures/releases/tag/${src.tag}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
