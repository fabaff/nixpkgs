{
  lib,
  buildPythonPackage,
  fetchPypi,
  msrest,
  msrestazure,
  azure-common,
  azure-mgmt-core,
  setuptools,
}:

buildPythonPackage rec {
  pname = "azure-mgmt-media";
  version = "10.2.1";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_mgmt_media";
    inherit version;
    hash = "sha256-1lTc6SqFw66yUafg0MjY+jd9Jq5NOINu9puFybSGkRM=";
  };

  build-system = [ setuptools ];

  dependencies = [
    msrest
    msrestazure
    azure-common
    azure-mgmt-core
  ];

  # has no tests
  doCheck = false;

  pythonImportsCheck = [ "azure.mgmt.media" ];

  meta = with lib; {
    description = "This is the Microsoft Azure Media Services Client Library";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/media/azure-mgmt-media";
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-media_${version}/sdk/media/azure-mgmt-media/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ maxwilson ];
  };
}
