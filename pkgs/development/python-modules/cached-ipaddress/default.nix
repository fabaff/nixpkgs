{
  lib,
  buildPythonPackage,
  cython,
  fetchFromGitHub,
  poetry-core,
  pytest-cov-stub,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  propcache,
}:

buildPythonPackage rec {
  pname = "cached-ipaddress";
  version = "0.8.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = "cached-ipaddress";
    tag = "v${version}";
    hash = "sha256-tgbglTn3XcQQbNB5rrmU2F54DxSzYSTpPuXv5xEgs9g=";
  };

  build-system = [
    cython
    poetry-core
    setuptools
  ];

  dependencies = [ propcache ];

  nativeCheckInputs = [
    pytest-cov-stub
    pytestCheckHook
  ];

  pythonImportsCheck = [ "cached_ipaddress" ];

  meta = with lib; {
    description = "Cache construction of ipaddress objects";
    homepage = "https://github.com/bdraco/cached-ipaddress";
    changelog = "https://github.com/bdraco/cached-ipaddress/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = [ ];
  };
}
