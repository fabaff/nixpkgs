{ lib
, fetchFromGitHub
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "certsync";
  version = "0.1.6";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "zblurx";
    repo = "certsync";
    rev = "refs/tags/${version}";
    hash = "sha256-UNeO9Ldf6h6ykziKVCdAoBIzL5QedbRLFEwyeWDCtUU";
  };

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
  ];

  propagatedBuildInputs = with python3.pkgs; [
    certipy-ad
    tqdm
  ];

  pythonImportsCheck = [
    "certsync"
  ];

  meta = with lib; {
    description = "Dump NTDS with golden certificates and UnPAC the hash";
    homepage = "https://github.com/zblurx/certsync";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
    mainProgram = "certsync";
  };
}
