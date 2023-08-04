{ lib
, buildPythonPackage
, fetchFromGitea
, pkg-config
, rustPlatform
, cargo
, rustc
, bzip2
, nettle
, openssl
, pcsclite
, stdenv
, darwin
}:

buildPythonPackage rec {
  pname = "pysequoia";
  version = "0.1.20";
  format = "pyproject";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "wiktor";
    repo = "pysequoia";
    rev = "v${version}";
    hash = "sha256-63kUUxZTG33cB/IiD4AiDpLOI6Uew/fETgqhaGc7zp0=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-dMewHVTb31BLreJ+Jcncxupwn6rxjIfha7yDSC4a6SQ=";
  };

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    cargo
    rustc
  ];

  buildInputs = [
    bzip2
    nettle
    openssl
    pcsclite
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
  ];

  pythonImportsCheck = [
    "pysequoia"
  ];

  meta = with lib; {
    description = "This library provides OpenPGP facilities in Python through the Sequoia PGP library";
    homepage = "https://sequoia-pgp.gitlab.io/pysequoia";
    changelog = "https://codeberg.org/wiktor/pysequoia/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ doronbehar ];
  };
}
