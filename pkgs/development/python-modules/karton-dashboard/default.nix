{ lib
, buildPythonPackage
, fetchFromGitHub
, flask
, karton-core
, mistune
, prometheus-client
}:

buildPythonPackage rec {
  pname = "karton-dashboard";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "CERT-Polska";
    repo = pname;
    rev = "v${version}";
    sha256 = "0hh21s5r8jnpnm09hskq3g37fj8r24fsvd97x5956kmfgjj2sp0b";
  };

  propagatedBuildInputs = [
    flask
    karton-core
    mistune
    prometheus-client
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "Flask==1.1.1" "Flask" \
      --replace "prometheus-client==0.9.0" "prometheus-client"
  '';

  # Project has no tests. pythonImportsCheck requires MinIO configuration
  doCheck = false;

  meta = with lib; {
    description = "Web application that allows for Karton task and queue introspection";
    homepage = "https://github.com/CERT-Polska/karton-dashboard";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ fab ];
  };
}
