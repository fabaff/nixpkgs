{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, google-auth
, grpc-google-iam-v1
, mock
, proto-plus
, protobuf
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, setuptools
}:

buildPythonPackage rec {
  pname = "google-cloud-vm-migration";
  version = "1.8.3";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-hLQt5pGSh2Cjl5gL/aomr3BR0qeSbp0YMEjYau6mt+Y=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    google-api-core
    google-auth
    grpc-google-iam-v1
    proto-plus
    protobuf
  ] ++ google-api-core.optional-dependencies.grpc;

  nativeCheckInputs = [
    mock
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "google.cloud.vmmigration"
    "google.cloud.vmmigration_v1"
  ];

  meta = with lib; {
    description = "Python Client for Cloud VM Migration";
    homepage = "https://github.com/googleapis/google-cloud-python/tree/main/packages/google-cloud-vm-migration";
    changelog = "https://github.com/googleapis/google-cloud-python/blob/google-cloud-vm-migration-v${version}/packages/google-cloud-vm-migration/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
