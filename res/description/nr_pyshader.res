CONTAINER nr_pyshader {
  NAME nr_pyshader;
  INCLUDE Xbase;
  GROUP ID_SHADERPROPERTIES {
    SCALE_V;
    STATICTEXT NR_PYSHADER_INFO { }
    STRING NR_PYSHADER_CODE { CUSTOMGUI MULTISTRING; PYTHON; SCALE_V; ANIM OFF; }
    BUTTON NR_PYSHADER_OPENEDITOR { }
  }
}
