{ lib, buildPythonPackage, fetchPypi
, pytest, pytest-cov, mock, coverage, setuptools
, Mako, sqlalchemy, python-editor, python-dateutil
}:

buildPythonPackage rec {
  pname = "alembic";
  version = "1.7.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "aea964d3dcc9c205b8759e4e9c1c3935ea3afeee259bffd7ed8414f8085140fb";
  };

  buildInputs = [ pytest pytest-cov mock coverage ];
  propagatedBuildInputs = [ Mako sqlalchemy python-editor python-dateutil setuptools ];

  # no traditional test suite
  doCheck = false;

  meta = with lib; {
    homepage = "https://bitbucket.org/zzzeek/alembic";
    description = "A database migration tool for SQLAlchemy";
    license = licenses.mit;
  };
}
