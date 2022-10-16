class ZCL_GUIS_CLASS_WITH_TESTS definition
  public
  create public .

public section.

  class-methods ALV_GRID_CHECK_VALUE
    raising
      ZCX_GUIS_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GUIS_CLASS_WITH_TESTS IMPLEMENTATION.


  method ALV_GRID_CHECK_VALUE.
    MESSAGE 'Test' TYPE 'I'.
    "RAISE EXCEPTION TYPE zcx_guis_error.
  endmethod.
ENDCLASS.
