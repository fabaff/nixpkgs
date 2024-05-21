{ lib
, buildPythonPackage
, fetchPypi
, setuptools
}:

buildPythonPackage rec {
  pname = "types-setuptools";
  version = "69.5.0.20240519";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-J1+3IEiwID0/vvJoKY6nigkTzRFKdIctk/hjjMxbfGM=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  # Module doesn't have tests
  doCheck = false;

  pythonImportsCheck = [
    "setuptools-stubs"
  ];

  meta = with lib; {
    description = "Typing stubs for setuptools";
    homepage = "https://github.com/python/typeshed";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
