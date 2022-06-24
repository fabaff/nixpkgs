{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, cryptography
}:

buildPythonPackage rec {
  pname = "chacha20poly1305-reuseable";
  version = "0.0.3";
  format = "setuptools";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-KKY9HG5DjT34ZSAM7ISH3l1xagNbJ1odTuEyDmy2gJY=";
  };

  propagatedBuildInputs = [
    cryptography
  ];

  checkInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=chacha20poly1305_reuseable --cov-report=term-missing:skip-covered" ""
  '';

  pythonImportsCheck = [
    "chacha20poly1305_reuseable"
  ];

  meta = with lib; {
    description = "Module for using ChaCha20Poly1305 with asyncio";
    homepage = "https://github.com/bdraco/chacha20poly1305-reuseable";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
