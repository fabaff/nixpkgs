{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "nextdns";
  version = "1.42.0";

  src = fetchFromGitHub {
    owner = "nextdns";
    repo = "nextdns";
    rev = "refs/tags/v${version}";
    hash = "sha256-aQUz6FK04h3nzieK9fX7odVVt/zcdhXlX3T1Z1rN/ak=";
  };

  vendorHash = "sha256-DATSGSFRMrX972CWCiSIlOhDuAG3zcVyuILZ3IpVirM=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.version=${version}"
  ];

  meta = with lib; {
    description = "NextDNS DNS/53 to DoH Proxy";
    homepage = "https://nextdns.io";
    changelog = "https://github.com/nextdns/nextdns/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ pnelson ];
    mainProgram = "nextdns";
  };
}
