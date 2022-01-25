{ lib
, buildPythonPackage
, fetchFromGitHub
, pyserial
, pyserial-asyncio
, pytestCheckHook
, pythonOlder
, pytz
, tailer
}:

buildPythonPackage rec {
  pname = "dsmr-parser";
  version = "0.32";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ndokter";
    repo = "dsmr_parser";
    rev = "v${version}";
    sha256 = "sha256-NFnFeWnXhRFqV75Tz4B4y0dz+mB3OX218uXqytpLJkI=";
  };

  propagatedBuildInputs = [
    pyserial
    pyserial-asyncio
    pytz
    tailer
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "dsmr_parser"
  ];

  meta = with lib; {
    description = "Python module to parse Dutch Smart Meter Requirements (DSMR)";
    homepage = "https://github.com/ndokter/dsmr_parser";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
