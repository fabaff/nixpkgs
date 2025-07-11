{
  lib,
  buildPythonPackage,
  cryptography,
  dnspython,
  expiringdict,
  fetchFromGitHub,
  hatchling,
  importlib-resources,
  pem,
  publicsuffixlist,
  pyleri,
  pyopenssl,
  pytestCheckHook,
  requests,
  timeout-decorator,
  xmltodict,
}:

buildPythonPackage rec {
  pname = "checkdmarc";
  version = "5.8.6";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "domainaware";
    repo = "checkdmarc";
    tag = version;
    hash = "sha256-MlHRBedBbcFbVga5q0havdD6M/YOlFW8SX0k1tRngmc=";
  };

  pythonRelaxDeps = [ "xmltodict" ];

  build-system = [ hatchling ];

  dependencies = [
    cryptography
    dnspython
    expiringdict
    importlib-resources
    pem
    publicsuffixlist
    pyleri
    pyopenssl
    requests
    timeout-decorator
    xmltodict
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "checkdmarc" ];

  pytestFlagsArray = [ "tests.py" ];

  disabledTests = [
    # Tests require network access
    "testBIMI"
    "testDMARCPctLessThan100Warning"
    "testSPFMissingARecord"
    "testSPFMissingMXRecord"
    "testSplitSPFRecord"
    "testTooManySPFDNSLookups"
    "testTooManySPFVoidDNSLookups"
  ];

  meta = with lib; {
    description = "Parser for SPF and DMARC DNS records";
    homepage = "https://github.com/domainaware/checkdmarc";
    changelog = "https://github.com/domainaware/checkdmarc/blob/${src.tag}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
    mainProgram = "checkdmarc";
  };
}
