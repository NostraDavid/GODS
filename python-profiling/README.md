# Python Profiling

Meant for code that shows how to profile Python code, as I have NO idea how to do this.

This is ofcourse relative, as Python is slow AF.

``` Python
python -m timeit '"-".join(str(n) for n in range(100))'
```