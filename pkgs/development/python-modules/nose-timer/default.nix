{ buildPythonPackage, fetchPypi, lib, nose, }:

buildPythonPackage rec {
  pname = "nose-timer";
  version = "1.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-j3DRA7f/2RIqWJ3g350Den2WdRm/beEiYh0hhmCbnjo=";
  };

  propagatedBuildInputs = [ nose ];

  meta = with lib; {
    homepage = "https://github.com/mahmoudimus/nose-timer";
    license = licenses.mit;
    description = "A timer plugin for nosetests (how much time does every test take?)";
    maintainers = with maintainers; [ doronbehar ];
  };
}
