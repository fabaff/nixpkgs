{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  nix-update-script,
  versionCheckHook,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "rustsweep";
  version = "0.1.0-unstable-2025-07-29";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "f42h";
    repo = "rustsweep";
    # https://github.com/f42h/rustsweep/issues/1
    rev = "1d9e8d4f0a054e37d535f3cc92b9dc2f9d3ce863";
    hash = "sha256-HQQlAPdrz1KMveXuFd94KtGXOaKNIKmEap7NVO34IrE=";
  };

  cargoHash = "sha256-9+ccVJz9Il9z5cwtXk/y9rwwpcWTPN+mVWLQz6d2q+o=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  nativeInstallCheckInputs = [ versionCheckHook ];

  doInstallCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Fast Rust-Based CLI Pingsweeping Tool";
    homepage = "https://github.com/f42h/rustsweep";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "rustsweep";
  };
})
