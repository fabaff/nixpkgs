{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  pyserial,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "pyavaccess";
  version = "0.2.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-s+F667eblZXwDiRs87AfZmH3HgEEbLZRVYDS46oqTpA=";
  };

  build-system = [ hatchling ];

  dependencies = [ pyserial ];

  # Module has no test
  doCheck = false;

  pythonImportsCheck = [ "pyavaccess" ];

  meta = with lib; {
    description = "Automation library for AV Access devices";
    homepage = "https://pypi.org/project/pyavaccess/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ fab ];
  };
}
