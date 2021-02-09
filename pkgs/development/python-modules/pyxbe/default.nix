{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pyxbe";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "mborgerson";
    repo = pname;
    rev = "v${version}";
    sha256 = "0gjf0cb4xms1m0spcnvq7alx3rncc53gi312j99m4myshh5ap4xl";
  };

  checkInputs = [ pytestCheckHook ];

  # Update location for run with pytest
  preCheck = ''
    substituteInPlace tests/test_load.py --replace "'xbefiles'" "'tests/xbefiles'"
  '';

  pythonImportsCheck = [ "xbe" ];

  meta = with lib; {
    description = "Library to work with XBE files";
    homepage = "https://github.com/mborgerson/pyxbe";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
