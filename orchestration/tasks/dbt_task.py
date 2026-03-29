import subprocess
from pathlib import Path
from prefect import task

DBT_BIN = Path.home() / "data-engineering-zoomcamp-final-project" / "transform" / ".venv" / "bin" / "dbt"
DBT_PROJECT_DIR = Path.home() / "data-engineering-zoomcamp-final-project" / "transform"

@task(name="run-dbt", retries=1, retry_delay_seconds=60)
def dbt_task() -> None:
    import os
    result = subprocess.run(
        [str(DBT_BIN), "run"],
        cwd=str(DBT_PROJECT_DIR),
        capture_output=True,
        text=True,
        env=os.environ.copy()
    )
    print("STDOUT:", result.stdout)
    print("STDERR:", result.stderr)
    if result.returncode != 0:
        raise Exception(result.stdout + result.stderr)
