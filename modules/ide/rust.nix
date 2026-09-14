{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    clang
    pkg-config
    llvmPackages.libclang
  ];

  environment.sessionVariables = {
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
    BINDGEN_EXTRA_CLANG_ARGS = "-isystem ${pkgs.linuxHeaders}/include -isystem ${pkgs.glibc.dev}/include";
  };
}
