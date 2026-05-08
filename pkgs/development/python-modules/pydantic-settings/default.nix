{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  pydantic,
  python-dotenv,
  pytestCheckHook,
  pytest-examples,
  pytest-mock,
}:

let
  self = buildPythonPackage rec {
    pname = "pydantic-settings";
    version = "2.14.1";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "pydantic";
      repo = "pydantic-settings";
      tag = "v${version}";
      hash = "sha256-COft7a0yQFC+dhEog1QKtMmBUjqqm494y/fFp+Y2xBw=";
    };

    build-system = [ hatchling ];

    dependencies = [
      pydantic
      python-dotenv
    ];

    pythonImportsCheck = [ "pydantic_settings" ];

    nativeCheckInputs = [
      pytestCheckHook
      pytest-examples
      pytest-mock
    ];

    disabledTests = [
      # expected to fail
      "test_docs_examples[docs/index.md:212-246]"
    ];

    preCheck = ''
      export HOME=$TMPDIR
    '';

    # ruff is a dependency of pytest-examples which is required to run the tests.
    # We do not want all of the downstream packages that depend on pydantic-settings to also depend on ruff.
    doCheck = false;
    passthru.tests = {
      pytest = self.overridePythonAttrs { doCheck = true; };
    };

    meta = {
      description = "Settings management using pydantic";
      homepage = "https://github.com/pydantic/pydantic-settings";
      license = lib.licenses.mit;
      broken = lib.versionOlder pydantic.version "2.0.0";
      maintainers = [ ];
    };
  };
in
self
