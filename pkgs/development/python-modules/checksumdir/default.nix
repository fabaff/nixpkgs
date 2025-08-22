{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
}:

buildPythonPackage rec {
  pname = "checksumdir";
  version = "1.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "to-mc";
    repo = "checksumdir";
    tag = version;
    hash = "sha256-rOHRJAK+Or8bwAtzpbINdnEjK3WQcU+4sEZI91tMvAk=";
  };

  build-system = [ setuptools ];

  doCheck = false; # Package does not contain tests

  pythonImportsCheck = [ "checksumdir" ];

  meta = with lib; {
    description = "Module to compute a single deterministic hash of the file contents of a directory";
    homepage = "https://github.com/to-mc/checksumdir";
    changelog = "https://github.com/to-mc/checksumdir/releases/tag/${src.tag}";
    license = licenses.mit;
    maintainers = with maintainers; [ mbalatsko ];
  };
}
