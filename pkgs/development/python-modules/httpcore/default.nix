{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, h11
, h2
, pproxy
, pytest-asyncio
, pytestCheckHook
, pytestcov
, sniffio
, trio
, trustme
, uvicorn
}:

buildPythonPackage rec {
  pname = "httpcore";
  version = "0.12.3";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "encode";
    repo = pname;
    rev = version;
    sha256 = "sha256-CQRLlU7wpc2vNf4wSbuK8rQkBma9xeFLzDbDzwuTCyY=";
  };

  propagatedBuildInputs = [
    h11
    h2
    sniffio
  ];

  checkInputs = [
    pproxy
    pytest-asyncio
    pytestCheckHook
    pytestcov
    trio
    trustme
    uvicorn
  ];

  pytestFlagsArray = [
    # these tests fail during DNS lookups: httpcore.ConnectError: [Errno -2] Name or service not known
    "--ignore=tests/sync_tests/test_interfaces.py"
    "--ignore=tests/test_threadsafety.py"
    "--ignore=tests/sync_tests/test_retries.py"
  ];

  pythonImportsCheck = [ "httpcore" ];

  meta = with lib; {
    description = "A minimal low-level HTTP client";
    homepage = "https://github.com/encode/httpcore";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ris ];
  };
}
