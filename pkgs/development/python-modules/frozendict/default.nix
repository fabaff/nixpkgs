{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "frozendict";
  version = "2.0.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-wb7hwHDY2fZA4SjluHV2pEAAhgCfeGLRPAv4YA5iE9M=";
  };

  # frozendict does not come with tests
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/slezica/python-frozendict";
    description = "An immutable dictionary";
    license = licenses.mit;
  };
}
