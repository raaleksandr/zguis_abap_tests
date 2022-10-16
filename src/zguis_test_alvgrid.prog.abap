*&---------------------------------------------------------------------*
*& Report zguis_test_alvgrid
*&---------------------------------------------------------------------*
*& Program with ALV grid to perform tests
*&---------------------------------------------------------------------*
REPORT zguis_test_alvgrid.

PARAMETERS: p_order TYPE char10.

START-OF-SELECTION.
  PERFORM start_of_selection.

FORM start_of_selection.
  TYPES: BEGIN OF ty_grid_line,
           order_num     TYPE char10,
           order_date    TYPE datum,
           order_amount  TYPE i,
           customer_name TYPE rstxtmd,
         END OF ty_grid_line.

  DATA: lt_grid TYPE TABLE OF ty_grid_line,
        ls_grid TYPE ty_grid_line,
        lo_grid TYPE REF TO cl_salv_table.

  ls_grid-order_num     = '123/25'.
  ls_grid-order_date    = '20221015'.
  ls_grid-order_amount  = '100'.
  ls_grid-customer_name = 'John Smith'.
  APPEND ls_grid TO lt_grid.

  ls_grid-order_num     = '5555&2'.
  ls_grid-order_date    = '20221016'.
  ls_grid-order_amount  = '200'.
  ls_grid-customer_name = 'Bill Gates'.
  APPEND ls_grid TO lt_grid.

  ls_grid-order_num     = '8889-98'.
  ls_grid-order_date    = '20221102'.
  ls_grid-order_amount  = '50'.
  ls_grid-customer_name = 'John Doe'.
  APPEND ls_grid TO lt_grid.

  IF p_order IS NOT INITIAL.
    DELETE lt_grid
        WHERE order_num <> p_order.
  ENDIF.

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_grid
                              CHANGING  t_table      = lt_grid ).

      DATA: lo_columns TYPE REF TO cl_salv_columns_table,
            lo_column  TYPE REF TO cl_salv_column.

      lo_columns = lo_grid->get_columns( ).

      lo_column = lo_columns->get_column( 'ORDER_NUM' ).
      lo_column->set_medium_text( 'Order num' ).

      lo_column = lo_columns->get_column( 'ORDER_DATE' ).
      lo_column->set_medium_text( 'Order date' ).

      lo_column = lo_columns->get_column( 'ORDER_AMOUNT' ).
      lo_column->set_medium_text( 'Order amount' ).

      lo_column = lo_columns->get_column( 'CUSTOMER_NAME' ).
      lo_column->set_short_text( 'Customer' ).
      lo_column->set_medium_text( 'Customer name' ).
      lo_column->set_long_text( 'Customer name' ).

      lo_grid->display( ).
    CATCH cx_root.
      MESSAGE 'Error occured' TYPE 'I'.
  ENDTRY.
ENDFORM.
