{ lib
, buildPythonPackage
, fetchFromGitHub
, cython
, glibcLocales
, matplotlib
, monty
, networkx
, numpy
, palettable
, pandas
, plotly
, pybtex
, pydispatcher
, pythonOlder
, requests
, ruamel-yaml
, scipy
, spglib
, sympy
, tabulate
, uncertainties
}:

buildPythonPackage rec {
  pname = "pymatgen";
  version = "2023.9.10";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "materialsproject";
    repo = "pymatgen";
    rev= "v${version}";
    hash = "sha256-UrqwMH+T23AUHUtNsUYeQmxSHCi4hFsBi97tMUryNVg=";
  };

  nativeBuildInputs = [
    cython
    glibcLocales
  ];

  propagatedBuildInputs = [
    matplotlib
    monty
    networkx
    numpy
    palettable
    pandas
    plotly
    pybtex
    pydispatcher
    requests
    ruamel-yaml
    scipy
    spglib
    sympy
    tabulate
    uncertainties
  ];

  # Tests are not detected by pytest
  doCheck = false;

  pythonImportsCheck = [
    "pymatgen"
  ];

  meta = with lib; {
    description = "A robust materials analysis code that defines core object representations for structures and molecules";
    homepage = "https://pymatgen.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ psyanticy ];
  };
}
