{
  lib,
  buildPythonPackage,
  black,
  jinja2,
  dirty-equals,
  fastapi,
  fetchFromGitHub,
  pdm-backend,
  pydantic,
  pytest-asyncio,
  pytestCheckHook,
  sqlalchemy,
}:

buildPythonPackage rec {
  pname = "sqlmodel";
  version = "0.0.25";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tiangolo";
    repo = "sqlmodel";
    tag = version;
    hash = "sha256-8eWNLZaMlo2QeiNe1tsTqQOjVHi/N05G8mjkgXuL6YY=";
  };

  build-system = [ pdm-backend ];

  dependencies = [
    pydantic
    sqlalchemy
  ];

  nativeCheckInputs = [
    black
    jinja2
    dirty-equals
    fastapi
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [ "sqlmodel" ];

  disabledTests = [
    # AssertionError: assert 'enum_field VARCHAR(1)
    "test_sqlite_ddl_sql"
  ];

  disabledTestPaths = [
    # Coverage
    "docs_src/tutorial/"
    "tests/test_tutorial/"
  ];

  meta = with lib; {
    description = "Module to work with SQL databases";
    homepage = "https://github.com/tiangolo/sqlmodel";
    changelog = "https://github.com/tiangolo/sqlmodel/releases/tag/${src.tag}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
