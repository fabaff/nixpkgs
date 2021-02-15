{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "libreddit";
  version = "0.2.9";

  src = fetchFromGitHub {
    owner = "spikecodes";
    repo = pname;
    rev = "v${version}";
    sha256 = "06mrqdbypl1mkhpm4dcrdmr2ha7mf4z3g1vs3qb8yvqar36gw77d";
  };

  cargoSha256 = "00m6npb9rahzk6nmhp10cn2ia3qbimvfiybk2d0x3d8wf21w84rn";

  meta = with lib; {
    description = "Private front-end for Reddit";
    homepage = "https://github.com/spikecodes/libreddit";
    license = with licenses; [ agpl3Only ];
    maintainers = with maintainers; [ fab ];
  };
}
