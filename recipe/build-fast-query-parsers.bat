@echo on

set PYTHONIOENCODING="UTF-8"
set PYTHONUTF8=1
set TEMP="%SRC_DIR%\tmpbuild_%PY_VER%"
set PYO3_PYTHON=%PYTHON%

set CARGO_HOME=c:\.cg
copy "%RECIPE_DIR%\cargo-auditable-wrapper.bat" "%BUILD_PREFIX%\Library\bin\cargo-auditable-wrapper.bat"

mkdir "%TEMP%"

%PYTHON% -m pip install -vv . --no-deps --no-build-isolation --disable-pip-version-check ^
    || exit 2

:: dump licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output "%SRC_DIR%\THIRDPARTY.yml" ^
    || exit 3

chcp 65001

"%PYTHON%" -m pip install fast-query-parsers -vv --no-index --find-links "%SRC_DIR%\target\wheels" ^
    || exit 4
