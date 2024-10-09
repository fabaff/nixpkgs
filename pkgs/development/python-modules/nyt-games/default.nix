{
  lib,
  aiohttp,
  aioresponses,
  buildPythonPackage,
  fetchFromGitHub,
  mashumaro,
  orjson,
  poetry-core,
  pytest-asyncio,
  pytest-cov-stub,
  pytestCheckHook,
  pythonOlder,
  syrupy,
  yarl,
}:

buildPythonPackage rec {
  pname = "nyt-games";
  version = "0.4.3";
  pyproject = true;

  disabled = pythonOlder "3.11";

  src = fetchFromGitHub {
    owner = "joostlek";
    repo = "python-nyt-games";
    rev = "refs/tags/v${version}";
    hash = "sha256-Is6ReGrz0R+UtmWpW2pZwRihcF9oXPNRqMve5M5pq/4=";
  };

  build-system = [ poetry-core ];

  dependencies = [
    aiohttp
    mashumaro
    orjson
    yarl
  ];

  nativeCheckInputs = [
    aioresponses
    syrupy
    pytest-asyncio
    pytest-cov-stub
    pytestCheckHook
  ];

  pythonImportsCheck = [ "nyt_games" ];

  disabledTests = [
    # Tests require network access
    "test_get"
    "session"
    "test_unauthorized"
  ];

  meta = {
    description = "Module for NYT Games";
    homepage = "https://github.com/joostlek/python-nyt-games";
    changelog = "https://github.com/joostlek/python-nyt-games/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
}
