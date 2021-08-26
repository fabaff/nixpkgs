{ lib
, buildPythonPackage
, fetchPypi
, isPy3k
, pytestCheckHook
, setuptoolsBuildHook
, python
}:

buildPythonPackage rec {
  pname = "frozendict";
  version = "2.0.5";
  format = "setuptools";

  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-wb7hwHDY2fZA4SjluHV2pEAAhgCfeGLRPAv4YA5iE9M=";
  };

  pythonImportsCheck = [
    "frozendict"
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # >   ???
    # E   AssertionError
    "test_c_extension"
  ];

  disabledTestPaths = [
    # unpackaged test dependency: coold
    "test/test_coold.py"
    "test/test_coold_subclass.py"
  ];

  meta = with lib; {
    homepage = "https://github.com/slezica/python-frozendict";
    description = "An immutable dictionary";
    license = licenses.mit;
  };
}
