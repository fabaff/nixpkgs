{
  lib,
  buildPythonPackage,
  colorama,
  dnspython,
  fetchFromGitHub,
  httpx,
  mock,
  poetry-core,
  poetry-dynamic-versioning,
  pyfakefs,
  pytest-asyncio,
  pytest-httpx,
  pytest-mock,
  pytestCheckHook,
  python-dateutil,
  python-whois,
  pythonRelaxDepsHook,
  pyyaml,
  setuptools,
  tldextract,
}:

buildPythonPackage rec {
  pname = "baddns";
  version = "1.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "blacklanternsecurity";
    repo = "baddns";
    # https://github.com/blacklanternsecurity/baddns/issues/473
    rev = "14b2567edaac8f457ea3bb41f30e51aa2df88b2d";
    hash = "sha256-BRAHxjX16i1X/LsDsGsl0p8vmdk2+Q+QMYhIrKTrc3I=";
  };

  pythonRelaxDeps = [
    "httpx"
    "tldextract"
  ];

  build-system = [
    poetry-core
    poetry-dynamic-versioning
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];

  dependencies = [
    colorama
    dnspython
    httpx
    python-dateutil
    python-whois
    pyyaml
    setuptools
    tldextract
  ];

  nativeCheckInputs = [
    mock
    pyfakefs
    pytest-asyncio
    pytest-httpx
    pytest-mock
    pytestCheckHook
  ];

  pythonImportsCheck = [ "baddns" ];

  disabledTests = [
    # Tests require network access
    "test_cli"
    "test_modules_customnameservers"
    "test_references_cname"
    "test_references_direct"
  ];

  meta = with lib; {
    description = "Check subdomains for subdomain takeovers and other DNS";
    homepage = "https://github.com/blacklanternsecurity/baddns";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ fab ];
    mainProgram = "baddns";
  };
}
