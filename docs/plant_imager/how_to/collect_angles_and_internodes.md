# How to extract phyllotactic angle and internode measurements from a PlantDB database

**Goal**:
Obtain a single CSV file that lists, for each plant scan, the genotype, plant ID, internode order, angle (in radians or degrees), and internode length.
This file can be imported into downstream statistical or visualization tools.

---

## Step‑by‑step workflow

1. Open a terminal and activate your conda environment
  ```shell
  conda activate plant3dvision
  ```
2. Run the CLI on the whole database, converting radian angles to degrees
  ```shell
  python plant3dvision/cli/collect_angles_and_internodes.py \
      /path/to/your/database
  ```

Using the option `-r` / `--to_degrees` tells the CLI to apply `math.degrees()` to each angle before writing the CSV.

**What happens**:

- the script iterates over every scan in the database,
- it keeps only those that contain the `AnglesAndInternodes.json` file,
- it concatenates the measurements,
- it writes a CSV table inside the specified folder.

## CLI Options

### Extract only a subset of scans (_e.g._, all *Col‑0* plants)

```shell
python plant3dvision/cli/collect_angles_and_internodes.py \
    /path/to/your/database -r -f "Col-0*"
```

**How the filter works**:

- the option `-f` / `--filter` expects a **regular‑expression** that is matched against the full scan ID.
- `"Col-0*"` selects any scan whose ID starts with `Col-0`.

### Preview which scans would be processed without writing a file

```shell
python plant3dvision/cli/collect_angles_and_internodes.py \
    /path/to/your/database -c
```

Using the option `-c` / `--check_only` prints two lists:

1. **Valid datasets**: scans that contain a well‑formed `AnglesAndInternodes.json`.
2. **Discarded datasets**: scans that were filtered out or lacked the required file, together with a brief reason.

Use this step to verify your filter expression before running a full extraction.

### Choose a custom output filename and/or destination folder

```shell
python plant3dvision/cli/collect_angles_and_internodes.py \
    /path/to/your/database \
    -r -f "Col-0*" -o col0_measures.tsv -p /path/to/results/
```

| Option            | Meaning                                                                               |
|-------------------|---------------------------------------------------------------------------------------|
| `-o` / `--output` | Name of the result file (default is `<db_name>_measures.csv`).                        |
| `-p` / `--path`   | Directory where the result file will be saved (default is the input database folder). |

## Inspect the resulting CSV

The file is **tab‑separated** (`\t`).
Open it with LibreOffice Calc, R, Python `pandas.read_csv(..., sep="\t")`, or any tool that accepts CSV.

Typical columns:

| Column           | Description                                                  |
|------------------|--------------------------------------------------------------|
| `Genotype`       | Genotype label taken from the scan’s metadata (_e.g._, `Col-0`). |
| `Plant`          | Scan identifier (the folder name).                           |
| `Order_Interval` | Internode/angle index (1, 2, 3, ...).                        |
| `Angles`         | Angle value (radians *or* degrees, depending on `-r`).       |
| `Internodes`     | Internode length.                                            |

## Handling warnings (if any)

The CLI may print two kinds of warnings:

1. **Empty measure
   files**: the JSON existed but contained no data. The corresponding rows are omitted from the final CSV.
2. **Very low angle
   values**: if the mean angle is `< 10`, the script suspects you may have unintentionally left angles in radians when your downstream analysis expects degrees. Re‑run with `-r` if needed.

---

## Common troubleshooting scenarios

| Symptom                                                         | Likely cause                                                            | Fix                                                                                    |
|-----------------------------------------------------------------|-------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| “The input database does not contain any valid ROMI datasets.”  | No `AnglesAndInternodes.json` files were found (or they are malformed). | Verify that the ROMI pipeline completed successfully for the scans you expect.         |
| “The JSON file of measures was not found.”                      | The task fileset exists but the JSON file is missing or mis‑named.      | Check the scan folder manually; ensure the file is exactly `AnglesAndInternodes.json`. |
| Output file is empty or only contains header rows.              | All selected scans failed the `has_angles_and_internodes` check.        | Run the CLI with `-c` to see which scans are considered valid.                         |
| Angles look like values around 0.1–0.3 when you expected 30–90. | Angles are still in radians.                                            | Add the `-r` flag to convert to degrees.                                               |

---

## Quick reference cheat‑sheet

```shell
# Basic extraction (radians)
python plant3dvision/cli/collect_angles_and_internodes.py /path/to/db

# Degrees + filter to Col‑0 only
python plant3dvision/cli/collect_angles_and_internodes.py /path/to/db -r -f "Col-0*"

# Dry‑run – list what would be processed
python plant3dvision/cli/collect_angles_and_internodes.py /path/to/db -c

# Custom output location
python plant3dvision/cli/collect_angles_and_internodes.py /path/to/db \
    -r -f "Col-0*" -o col0_measures.tsv -p /my/results/
```
