{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  flexmock,
  git,
  pytestCheckHook,
  rpm,
  setuptools-scm,
  setuptools,
}:

buildPythonPackage (finalAttrs: {
  pname = "specfile";
  version = "0.42.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "packit";
    repo = "specfile";
    tag = finalAttrs.version;
    postFetch = ''
      # export-subst prevents reproducibility
      rm "$out/.git_archival.txt"
    '';
    hash = "sha256-tN4G+6YTkGdLtDNZRG3AvFQPsuv5I2EpuICoChB/6YM=";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [ rpm ];

  nativeCheckInputs = [
    git
    flexmock
    pytestCheckHook
  ];

  pythonImportsCheck = [ "specfile" ];

  disabledTests = [
    # AssertionError
    "test_changelog_timestamps_match_rpm"
    "test_sanitize"
    "test_shell_expansions"
    "test_update_tag"
  ];

  meta = {
    description = "Library for parsing and manipulating RPM spec files";
    homepage = "https://github.com/packit/specfile";
    changelog = "https://github.com/packit/specfile/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
})
