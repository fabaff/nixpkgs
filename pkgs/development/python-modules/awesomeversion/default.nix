{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  pytest-codspeed,
  pytest-snapshot,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "awesomeversion";
  version = "25.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ludeeus";
    repo = "awesomeversion";
    tag = version;
    hash = "sha256-fnF1pImS0dsVeKtvLu4pcCHcrZ+oNfZ+dWBR/WusIjw=";
  };

  postPatch = ''
    # Upstream doesn't set a version
    substituteInPlace pyproject.toml \
      --replace-fail 'version = "0"' 'version = "${version}"'
  '';

  nativeBuildInputs = [ poetry-core ];

  pythonImportsCheck = [ "awesomeversion" ];

  nativeCheckInputs = [
    pytest-codspeed
    pytest-snapshot
    pytestCheckHook
  ];

  meta = with lib; {
    description = "Python module to deal with versions";
    homepage = "https://github.com/ludeeus/awesomeversion";
    changelog = "https://github.com/ludeeus/awesomeversion/releases/tag/${src.tag}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
