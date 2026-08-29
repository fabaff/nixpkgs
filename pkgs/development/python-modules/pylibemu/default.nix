{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  libemu,
  python,
  setuptools,
}:

buildPythonPackage (finalAttrs: {
  pname = "pylibemu";
  version = "1.0";
  pyproject = true;

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "buffer";
    repo = "pylibemu";
    tag = "v${finalAttrs.version}";
    hash = "sha256-HdXBCA81WkTGStKV58ggBvVOdS920ytwzrAX+09+C7M=";
  };

  build-system = [ setuptools ];

  buildInputs = [ libemu ];

  pythonImportsCheck = [ "pylibemu" ];

  checkPhase = ''
    runHook preCheck

    ${python.interpreter} tests/cpu_mem_test.py

    runHook postCheck
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Libemu Cython wrapper";
    homepage = "https://github.com/buffer/pylibemu";
    changelog = "https://github.com/buffer/pylibemu/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ fab ];
  };
})
