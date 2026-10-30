{
  lib,
  aiohttp,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  pynacl,
  pytest-asyncio,
  pytestCheckHook,
  segno,
}:

buildPythonPackage (finalAttrs: {
  pname = "aiothreema";
  version = "0.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "LukasQ";
    repo = "aiothreema";
    tag = "v${finalAttrs.version}";
    hash = "sha256-VHZhb3mJc7DA7utcJ+ZDM6cevIuev+30NiZvROdwAlE=";
  };

  build-system = [ hatchling ];

  dependencies = [
    aiohttp
    pynacl
    segno
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [ "aiothreema" ];

  meta = {
    description = "Async Python client for the Threema Gateway HTTP API";
    homepage = "https://github.com/LukasQ/aiothreema";
    changelog = "https://github.com/LukasQ/aiothreema/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.jamiemagee ];
  };
})
