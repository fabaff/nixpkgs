{ lib
, buildPythonPackage
, cffi
, cryptography
, fetchPypi
, futures
, isPy3k
, mock
, pynacl
, pytest-asyncio
, pytestCheckHook
, six
, trollius
, twisted
, txaio
, zope_interface
}:

buildPythonPackage rec {
  pname = "autobahn";
  version = "21.1.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-k9+PydGCHJ2r/5/tUhgamtbupemYnVMQLDkWB9fBZm4=";
  };

  propagatedBuildInputs = [
    six
    txaio
    twisted
    zope_interface
    cffi
    cryptography
    pynacl
  ] ++ (lib.optionals (!isPy3k) [
    trollius
    futures
  ]);

  checkInputs = [
    mock
    pytest-asyncio
    pytestCheckHook
  ];

  preCheck = ''
    # Run asyncio tests (requires twisted)
    export USE_ASYNCIO=1
  '';

  pytestFlagsArray = [ "--pyargs autobahn" ];

  disabledTests = [
    "TestSerializer"
    "test_basic"
  ];

  pythonImportsCheck = [ "autobahn" ];

  meta = with lib; {
    description = "WebSocket and WAMP in Python for Twisted and asyncio";
    homepage = "https://crossbar.io/autobahn";
    license = licenses.mit;
    maintainers = with maintainers; [ nand0p ];
  };
}
