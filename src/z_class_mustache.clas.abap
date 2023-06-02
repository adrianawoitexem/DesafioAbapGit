CLASS z_class_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF ty_items,
             animal    TYPE string,
             categoria TYPE string,
    END OF ty_items,

    ty_items_tt TYPE STANDARD TABLE OF ty_items WITH DEFAULT KEY,

    BEGIN OF ty_out,
       animal_list TYPE string,
       type  TYPE ty_items_tt,
    END OF ty_out.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_class_mustache IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  DATA: lo_mustache TYPE REF TO            zcl_mustache,
        lr_data     TYPE REF TO            ty_out,
        lt_out      TYPE STANDARD TABLE OF ty_out.

  APPEND INITIAL LINE TO lt_out REFERENCE INTO lr_data.
  lr_data->animal_list = 'List of animals:'.
  lr_data->type = VALUE ty_items_tt( ( animal = 'Cat'       categoria = 'Domestic'   )
                                      ( animal = 'Dog'      categoria = 'Domestic' )
                                      ( animal = 'Macaw'    categoria = 'Wild' )
                                      ( animal = 'Hamster'  categoria = 'Domestic' )
                                      ( animal = 'Caracara' categoria = 'Wild' )
                                      ( animal = 'Rabbit'   categoria = 'Domestic' )
                                      ( animal = 'Capybara' categoria = 'Wild' )
                                      ( animal = 'Anteater' categoria = 'Wild' ) ).
TRY.

  lo_mustache = zcl_mustache=>create(
    'Do NOT buy wild animals!'     && cl_abap_char_utilities=>newline &&
    '{{animal_list}}'              && cl_abap_char_utilities=>newline &&
    '{{#type}}'                    && cl_abap_char_utilities=>newline &&
    '- {{animal}}: {{categoria}}'  && cl_abap_char_utilities=>newline &&
    '{{/type}}'                    && cl_abap_char_utilities=>newline ).

  out->write( lo_mustache->render( lt_out ) ).

CATCH zcx_mustache_error.
  out->write( 'error in mustache' ).
ENDTRY.

  ENDMETHOD.

ENDCLASS.
