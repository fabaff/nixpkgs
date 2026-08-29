{
  lib,
  stdenv,
  autoreconfHook,
  pkg-config,
  fetchFromGitHub,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "libemu";
  version = "1.0.5";

  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "buffer";
    repo = "libemu";
    tag = "v${finalAttrs.version}";
    hash = "sha256-VqP14VGUeYnF57e+wSr3zPcf3CXRp/dXbZwbw7T0wMI=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  installFlags = [ "pkgconfigdir=$(out)/lib/pkgconfig" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "X86 emulation and shellcode detection";
    homepage = "https://github.com/buffer/libemu";
    changelog = "https://github.com/buffer/libemu/blob/${finalAttrs.src.rev}/CHANGES";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "libemu";
    platforms = lib.platforms.all;
  };
})
