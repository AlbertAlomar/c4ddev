# Command-line Tools

**c4ddev** comes with a set of command-line tools that can be installed via Pip.

```
$ pip install c4ddev
$ c4ddev --help
Usage: c4ddev [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  pypkg    Reads a JSON configuration file, by default...
  rpkg
  symbols
```

## Commands

### pypkg

    c4ddev pypkg [CONFIG]

The **pypkg** command compiles Python modules and packages into `.pyc` files
and merges them into a Python Egg archive or directory. This is useful to
protect your Python code and to distribute your Python plugin.

!!!note
    Keep in mind that you should always use [`localimport`](localimport)
    to import any third-party Python modules from a Cinema 4D plugin in
    order to keep the global importer state clean.

__Example Configuration__ (`.pypkg`)

This is a real-world example configuration file.

```json
{
  "output": "res/modules{target}/cloudui.egg",
  "include": [
    "devel/res.py",
    "../vendor/python/c4dtools/c4dtools",
    "../vendor/python/nr/nr",
    "../vendor/python/cloudui/cloudui"
  ]
}
```

### rpkg

For more information, see [Resource Packages](rpkg).


### symbols

    c4ddev symbols [-f,--format] [-o,--outfile] [-d,--res-dir]

Extracts the resource symbols from all header files in `res/` directory or the
directory/ies specified via `-d,--res-dir` and formats them as a Python class,
Python file or JSON.

```
$ pwd
/Users/niklas/Applications/Cinema 4D R18/plugins/myplugin
$ c4ddev symbols

exec ("""class res(object):
 # Automatically generated with c4ddev v1.3.
 project_path = os.path.dirname(__file__)
 def string(self, name, *subst):
  result = __res__.LoadString(getattr(self, name))
  for item in subst: result = result.replace('#', item, 1)
  return result
 def tup(self, name, *subst):
  return (getattr(self, name), self.string(name, *subst))
 def path(self, *parts):
  path = os.path.join(*parts)
  if not os.path.isabs(path):
   path = os.path.join(self.project_path, path)
  return path
 file = path  # backwards compatibility
 def bitmap(self, *parts):
  b = c4d.bitmaps.BaseBitmap()
  if b.InitWith(self.path(*parts))[0] != c4d.IMAGERESULT_OK: return None
  return b
 MYSYMBOL = 1000
 MYOTHERSYMBOLS = 1001
 res=res()""")
```

__Available Formats__

  - Python class (`class`) [default] -- Can be copied into the Python plugin source
  - Python file (`file`)  -- Can be loaded as a module (make use of [`localimport`](localimport))
  - JSON (`json`) -- Can be loaded using the `json` module


### build-loader

    Usage: c4ddev build-loader [OPTIONS]

      Generate a Cinema 4D Python plugin that uses Node.py to load an
      entrypoint.

    Options:
      -e, --entry-point ENTRYPOINT
      -c, --compress
      -m, --minify
      -o, --output FILENAME
      --help                  Show this message and exit.

Creates a Cinema 4D `.pyp` file that loads the specified ENTRYPOINT with
[Node.py]. From that point on, the complete Node.py environment may be used
and plugins can use `require()` to load other components. Also, the plugin
will be automatically loaded completely isolated in a [`localimport`](localimport)
context, as it comes built-in with Node.py.

  [Node.py]: https://github.com/nodepy/nodepy


### pip-get

    Usage: c4ddev pip-get [OPTIONS]

      Installs Pip into the Cinema 4D Python distribution. Specify the path to
      Cinema 4D explicitly or run this command from inside the Cinema 4D
      application directory.

    Options:
      --c4d DIRECTORY
      --help      Show this message and exit.


### pip

    Usage: c4ddev pip [OPTIONS] [ARGS]...

      Invokes Pip in the current Cinema 4D Python distribution. Must be used
      from inside the Cinema 4D applications directory or specified with --c4d.

    Options:
      --c4d DIRECTORY
      --help      Show this message and exit.