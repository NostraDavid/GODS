# Python Profiling

Meant for code that shows how to profile Python code, as I have NO idea how to do this.

This is ofcourse relative, as Python is slow AF.

```Python
python -m timeit '"-".join(str(n) for n in range(100))'
```

## Python Profilers

https://docs.python.org/3/library/profile.html

## Dev guide:

### Setup

Setup development environment, so you can just `pip install` whatever you want, without messing up your global package installation.

```bash
# create virtual environment folder called `venv` using the `venv` module.
python -m venv venv
# activate this venv
source venv/bin/activate
```

How to disable the venv so `pip install`

```bash
deactivate
```

### Running

Prerequisite: The `.py` files need to be executable.

```bash
cd python-profiling
# make all python scripts runnable
chmod +x *.py
# Then run a script (yes, `./` is needed for scripts to run)
./broken_example.py
```

All due to this line in each script (and the chmod command)

```python
#!/usr/bin/env python3
```

If you're on Windows, you can just directly run a script either way - the hashbang is unnecessary on Windows.
