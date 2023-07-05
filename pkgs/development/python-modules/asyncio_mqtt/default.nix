{ lib
, anyio
, buildPythonPackage
, fetchFromGitHub
, paho-mqtt
, poetry-core
, poetry-dynamic-versioning
, pytestCheckHook
, pythonOlder
, typing-extensions
}:

buildPythonPackage rec {
  pname = "asyncio-mqtt";
  version = "1.0.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "sbtinstruments";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-ct4KIGxiC5m0yrid0tOa/snO9oErxbqhLLH9kD69aEQ=";
  };

  nativeBuildInputs = [
    poetry-core
    poetry-dynamic-versioning
  ];

  propagatedBuildInputs = [
    paho-mqtt
  ] ++ lib.optionals (pythonOlder "3.10") [
    typing-extensions
  ];

  nativeCheckInputs = [
    anyio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aiomqtt"
  ];

  disabledTests = [
    # Tests require network access
    "test_client_connect_disconnect"
    "test_client_connecting_disconnected_done"
    "test_client_disconnected_done"
    "test_client_disconnected_exception"
    "test_client_filtered_messages"
    "test_client_logger"
    "test_client_max_concurrent_outgoing_calls"
    "test_client_no_pending_calls_warnings_with_max_concurrent_outgoing_calls"
    "test_client_not_reentrant"
    "test_client_pending_calls_threshold"
    "test_client_reusable_message"
    "test_client_reusable"
    "test_client_tls_context"
    "test_client_tls_params"
    "test_client_unfiltered_messages"
    "test_client_unsubscribe"
    "test_client_use_connect_disconnect_multiple_message"
    "test_client_username_password "
    "test_client_websockets"
    "test_client_will"
    "test_multiple_messages_generators"
  ];

  meta = with lib; {
    description = "Idomatic asyncio wrapper around paho-mqtt";
    homepage = "https://github.com/sbtinstruments/asyncio-mqtt";
    license = licenses.bsd3;
    changelog = "https://github.com/sbtinstruments/asyncio-mqtt/blob/v${version}/CHANGELOG.md";
    maintainers = with maintainers; [ hexa ];
  };
}
