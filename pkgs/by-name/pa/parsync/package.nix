{
  lib,
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
  sqlite,
  zlib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "parsync";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "AlpinDale";
    repo = "parsync";
    tag = "v${finalAttrs.version}";
    hash = "sha256-fHvjeTqTg2RDM6r+/OaAb8K0targAcl+0m+Uz14WbfA=";
  };

  cargoHash = "sha256-SHieyv7Kc9Qtx3C11wxjJTI28h2RDh+YY1Ks++Z1rQ8=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    openssl
    sqlite
    zlib
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = {
    description = "Tool to parallel rsync-like pull sync over SSH";
    homepage = "https://github.com/AlpinDale/parsync";
    changelog = "https://github.com/AlpinDale/parsync/releases/tag/${finalAttrs.src.rev}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "parsync";
  };
})
