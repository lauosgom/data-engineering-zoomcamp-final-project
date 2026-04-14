with stg_lists_firebase as (
        SELECT
           *,
           CASE lista
                WHEN 'Actitud ante el orientador'              THEN 'L_Actitud'
                WHEN 'Actitud ante el problema'                THEN 'L_Actitud_Problema_1'
                WHEN 'Actitudes equivocadas'                   THEN 'O_Actitudes_1'
                WHEN 'Asiduidad'                               THEN 'L_Asiduidad'
                WHEN 'Autoevaluación'                          THEN 'O_Autoevaluacion'
                WHEN 'C_duracion'                              THEN 'Duracion'
                WHEN 'Comoconoce'                              THEN 'Como_Conocio'
                WHEN 'Condicion Socioeconomica'                THEN 'L_Condicion'
                WHEN 'Convive'                                 THEN 'L_Convive'
                WHEN 'E.Civil'                                 THEN 'L_Estado_Civil'
                WHEN 'Edad'                                    THEN 'L_Edad'
                WHEN 'Inicio'                                  THEN 'L_Inicio'
                WHEN 'Llamada derivada'                        THEN 'L_Derivada'
                WHEN 'Medio de contacto'                       THEN 'Medio_de_Contacto'
                WHEN 'Naturaleza'                              THEN 'L_Naturaleza'
                WHEN 'Nivel de ayuda'                          THEN 'O_Nivel_Ayuda_1'
                WHEN 'O_clave'                                 THEN 'O_Clave'
                WHEN 'Paralenguaje'                            THEN 'L_Paralenguaje'
                WHEN 'Petición'                                THEN 'L_Peticion'
                WHEN 'Presentación'                            THEN 'L_Presentacion'
                WHEN 'Problema'                                THEN 'L_Problema_1'
                WHEN 'Problemática'                            THEN 'L_Problematica_1'
                WHEN 'Procedencia'                             THEN 'L_Procedencia'
                WHEN 'Relación'                                THEN 'T_Relacion'
                WHEN 'Resultado'                               THEN 'Resultado'
                WHEN 'Sentimientos'                            THEN 'O_Sentimientos_1'
                WHEN 'Sexo'                                    THEN 'L_Sexo'
                WHEN 'Tercero Actitud ante el problema'        THEN 'T_Actitud_Problema_1'
                WHEN 'Volvera a llamar'                        THEN 'O_Volvera_Llamar'
                WHEN 'Satisfacción del llamante'               THEN 'O_Satisfaccion_1'
                ELSE lista
            END AS lista_column
        FROM {{ source('raw_data', 'llamatel_lists_firebase') }}
),

calls_firebase as (
    select *
    from {{ ref('stg_calls_firebase') }}
)

select
        --identifiers
        orientador,
        orientador_uid,
        created_at,
        calls.document_id,
        calls.last_updated,

        --general call info
        {{ strip_code_prefix('list_medio_contacto.label') }} as medio_contacto,
        {{ strip_code_prefix('list_como_conocio.label') }} as como_conocio,
        {{ strip_code_prefix('list_llamada_derivada.label') }} as llamante_llamada_derivada,
        
        datetime(
                CAST(llamada_fecha AS DATE),
                CAST(CONCAT(llamada_hora, ':00') AS TIME)
        ) as llamada_datetime,
        
        {{ strip_code_prefix('list_resultado.label')}} as llamada_resultado,
        {{ strip_code_prefix('list_duracion.label')}} as llamada_duracion,
        sintesis,

        --caller info
        {{ strip_code_prefix('list_sexo.label')}} as llamante_sexo,
        {{ strip_code_prefix('list_edad.label')}} as llamante_edad,
        {{ strip_code_prefix('list_estado_civil.label')}} as llamante_estado_civil,
        {{ strip_code_prefix('list_convive.label')}} as llamante_convive,
        {{ strip_code_prefix('list_asiduidad.label')}} as llamante_asiduidad,
        {{ strip_code_prefix('list_procedencia.label')}} as llamante_procedencia,
        {{ strip_code_prefix('list_condicion.label')}} as llamante_condicion,

        --caller problem
        {{ strip_code_prefix('list_problematica_1.label')}} as llamante_problematica_1,
        {{ strip_code_prefix('list_problema_1.label')}} as llamante_problema_1,
        {{ strip_code_prefix('list_problematica_2.label')}} as llamante_problematica_2,
        {{ strip_code_prefix('list_problema_2.label')}} as llamante_problema_2,
        {{ strip_code_prefix('list_problematica_3.label')}} as llamante_problematica_3,
        {{ strip_code_prefix('list_problema_3.label')}} as llamante_problema_3,
        {{ strip_code_prefix('list_naturaleza.label')}} as llamante_naturaleza,
        {{ strip_code_prefix('list_inicio.label')}} as llamante_inicio,
        {{ strip_code_prefix('list_peticion.label')}} as llamante_peticion,
  
        --caller language and attitude
        {{ strip_code_prefix('list_actitud.label')}} as llamante_actitud_orientador,
        {{ strip_code_prefix('list_presentacion.label')}} as llamante_presentacion,
        {{ strip_code_prefix('list_paralenguaje.label')}} as llamante_paralenguaje,
        {{ strip_code_prefix('list_actitud_problema_1.label')}} as llamante_actitud_problema_1,
        {{ strip_code_prefix('list_actitud_problema_2.label')}} as llamante_actitud_problema_2,

        --third party info
        {{ strip_code_prefix('list_tercero_sexo.label')}} as tercero_sexo,
        {{ strip_code_prefix('list_tercero_edad.label')}} as tercero_edad,
        {{ strip_code_prefix('list_tercero_estado_civil.label')}} as tercero_estado_civil,
        {{ strip_code_prefix('list_tercero_convive.label')}} as tercero_convive,
        {{ strip_code_prefix('list_tercero_relacion.label')}} as tercero_relacion,

        --third party problem
        {{ strip_code_prefix('list_tercero_problematica_1.label')}} as tercero_problematica_1,
        {{ strip_code_prefix('list_tercero_problema_1.label')}} as tercero_problema_1,
        {{ strip_code_prefix('list_tercero_problematica_2.label')}} as tercero_problematica_2,
        {{ strip_code_prefix('list_tercero_problema_2.label')}} as tercero_problema_2,
        {{ strip_code_prefix('list_tercero_problematica_3.label')}} as tercero_problematica_3,
        {{ strip_code_prefix('list_tercero_problema_3.label')}} as tercero_problema_3,
        {{ strip_code_prefix('list_tercero_actitud_problema_1.label')}} as tercero_actitud_problema_1,
        {{ strip_code_prefix('list_tercero_actitud_problema_2.label')}} as tercero_actitud_problema_2,

        --orientador info
        orientador_clave,

        --orientador perception of call
        {{ strip_code_prefix('list_orientador_nivel_ayuda_1.label')}} as orientador_nivel_ayuda_1,
        {{ strip_code_prefix('list_orientador_nivel_ayuda_2.label')}} as orientador_nivel_ayuda_2,
        {{ strip_code_prefix('list_orientador_sentimientos_1.label')}} as orientador_sentimientos_1,
        {{ strip_code_prefix('list_orientador_sentimientos_2.label')}} as orientador_sentimientos_2,
        {{ strip_code_prefix('list_orientador_sentimientos_3.label')}} as orientador_sentimientos_3,
        {{ strip_code_prefix('list_orientador_autoevaluacion.label')}} as orientador_autoevaluacion,
        {{ strip_code_prefix('list_orientador_actitudes_equivocadas_1.label')}} as orientador_actitudes_equivocadas_1,
        {{ strip_code_prefix('list_orientador_actitudes_equivocadas_2.label')}} as orientador_actitudes_equivocadas_2,
        {{ strip_code_prefix('list_orientador_satisfaccion_llamante_1.label')}} as orientador_satisfaccion_llamante_1,
        {{ strip_code_prefix('list_orientador_satisfaccion_llamante_2.label')}} as orientador_satisfaccion_llamante_2,
        {{ strip_code_prefix('list_volvera_llamar.label')}} as orientador_volvera_llamar,

        'firebase' as source


from calls_firebase calls

left join stg_lists_firebase list_medio_contacto 
        on list_medio_contacto.lista_column = 'Medio_de_Contacto'
        and list_medio_contacto.value = CAST(calls.medio_contacto AS STRING)

left join stg_lists_firebase list_como_conocio 
        on list_como_conocio.lista_column = 'Como_Conocio'
        and list_como_conocio.value = CAST(calls.como_conocio AS STRING)

left join stg_lists_firebase list_llamada_derivada 
        on list_llamada_derivada.lista_column = 'L_Derivada'
        and list_llamada_derivada.value = CAST(calls.llamante_llamada_derivada AS STRING)

left join stg_lists_firebase list_resultado 
        on list_resultado.lista_column = 'Resultado'
        and list_resultado.value = CAST(calls.llamada_resultado AS STRING)

left join stg_lists_firebase list_duracion
        on list_duracion.lista_column = 'Duracion'
        and list_duracion.value = CAST(calls.llamada_duracion AS STRING)

left join stg_lists_firebase list_sexo
        on list_sexo.lista_column = 'L_Sexo'
        and list_sexo.value = CAST(calls.llamante_sexo AS STRING)

left join stg_lists_firebase list_edad
        on list_edad.lista_column = 'L_Edad'
        and list_edad.value = CAST(calls.llamante_edad AS STRING)

left join stg_lists_firebase list_estado_civil
        on list_estado_civil.lista_column = 'L_Estado_Civil'
        and list_estado_civil.value = CAST(calls.llamante_estado_civil AS STRING)

left join stg_lists_firebase list_convive
        on list_convive.lista_column = 'L_Convive'
        and list_convive.value = CAST(calls.llamante_convive AS STRING)

left join stg_lists_firebase list_asiduidad
        on list_asiduidad.lista_column = 'L_Asiduidad'
        and list_asiduidad.value = CAST(calls.llamante_asiduidad AS STRING)

left join stg_lists_firebase list_procedencia
        on list_procedencia.lista_column = 'L_Procedencia'
        and list_procedencia.value = CAST(calls.llamante_procedencia AS STRING)

left join stg_lists_firebase list_condicion
        on list_condicion.lista_column = 'L_Condicion'
        and list_condicion.value = CAST(calls.llamante_condicion AS STRING)

left join stg_lists_firebase list_problematica_1 
        on list_problematica_1.lista_column = 'L_Problematica_1'
        and list_problematica_1.value = CAST(calls.llamante_problematica_1 AS STRING)

left join stg_lists_firebase list_problema_1
        on list_problema_1.lista_column = 'L_Problema_1'
        and list_problema_1.value = CAST(calls.llamante_problema_1 AS STRING)

left join stg_lists_firebase list_problematica_2 
        on list_problematica_2.lista_column = 'L_Problematica_1'
        and list_problematica_2.value = CAST(calls.llamante_problematica_2 AS STRING)

left join stg_lists_firebase list_problema_2
        on list_problema_2.lista_column = 'L_Problema_1'
        and list_problema_2.value = CAST(calls.llamante_problema_2 AS STRING)

left join stg_lists_firebase list_problematica_3
        on list_problematica_3.lista_column = 'L_Problematica_1'
        and list_problematica_3.value = CAST(calls.llamante_problematica_3 AS STRING)

left join stg_lists_firebase list_problema_3
        on list_problema_3.lista_column = 'L_Problema_1'
        and list_problema_3.value = CAST(calls.llamante_problema_3 AS STRING)

left join stg_lists_firebase list_naturaleza 
        on list_naturaleza.lista_column = 'L_Naturaleza'
        and list_naturaleza.value = CAST(calls.llamante_naturaleza AS STRING)

left join stg_lists_firebase list_inicio 
        on list_inicio.lista_column = 'L_Inicio'
        and list_inicio.value = CAST(calls.llamante_inicio AS STRING)

left join stg_lists_firebase list_peticion 
        on list_peticion.lista_column = 'L_Peticion'
        and list_peticion.value = CAST(calls.llamante_peticion AS STRING)

left join stg_lists_firebase list_actitud 
        on list_actitud.lista_column = 'L_Actitud'
        and list_actitud.value = CAST(calls.llamante_actitud_orientador AS STRING)

left join stg_lists_firebase list_presentacion 
        on list_presentacion.lista_column = 'L_Presentacion'
        and list_presentacion.value = CAST(calls.llamante_presentacion AS STRING)

left join stg_lists_firebase list_paralenguaje 
        on list_paralenguaje.lista_column = 'L_Paralenguaje'
        and list_paralenguaje.value = CAST(calls.llamante_paralenguaje AS STRING)

left join stg_lists_firebase list_actitud_problema_1 
        on list_actitud_problema_1.lista_column = 'L_Actitud_Problema_1'
        and list_actitud_problema_1.value = CAST(calls.llamante_actitud_problema_1 AS STRING)

left join stg_lists_firebase list_actitud_problema_2 
        on list_actitud_problema_2.lista_column = 'L_Actitud_Problema_1'
        and list_actitud_problema_2.value = CAST(calls.llamante_actitud_problema_2 AS STRING)

left join stg_lists_firebase list_tercero_sexo
        on list_tercero_sexo.lista_column = 'L_Sexo'
        and list_tercero_sexo.value = CAST(calls.tercero_sexo AS STRING)

left join stg_lists_firebase list_tercero_edad
        on list_tercero_edad.lista_column = 'L_Edad'
        and list_tercero_edad.value = CAST(calls.tercero_edad AS STRING)

left join stg_lists_firebase list_tercero_estado_civil
        on list_tercero_estado_civil.lista_column = 'L_Estado_Civil'
        and list_tercero_estado_civil.value = CAST(calls.tercero_estado_civil AS STRING)

left join stg_lists_firebase list_tercero_convive
        on list_tercero_convive.lista_column = 'L_Convive'
        and list_tercero_convive.value = CAST(calls.tercero_convive AS STRING)

left join stg_lists_firebase list_tercero_relacion
        on list_tercero_relacion.lista_column = 'T_Relacion'
        and list_tercero_relacion.value = CAST(calls.tercero_relacion AS STRING)

left join stg_lists_firebase list_tercero_problematica_1
        on list_tercero_problematica_1.lista_column = 'L_Problematica_1'
        and list_tercero_problematica_1.value = CAST(calls.tercero_problematica_1 AS STRING)

left join stg_lists_firebase list_tercero_problema_1
        on list_tercero_problema_1.lista_column = 'L_Problema_1'
        and list_tercero_problema_1.value = CAST(calls.tercero_problema_1 AS STRING)

left join stg_lists_firebase list_tercero_problematica_2
        on list_tercero_problematica_2.lista_column = 'L_Problematica_1'
        and list_tercero_problematica_2.value = CAST(calls.tercero_problematica_2 AS STRING)

left join stg_lists_firebase list_tercero_problema_2
        on list_tercero_problema_2.lista_column = 'L_Problema_1'
        and list_tercero_problema_2.value = CAST(calls.tercero_problema_2 AS STRING)

left join stg_lists_firebase list_tercero_problematica_3
        on list_tercero_problematica_3.lista_column = 'L_Problematica_1'
        and list_tercero_problematica_3.value = CAST(calls.tercero_problematica_3 AS STRING)

left join stg_lists_firebase list_tercero_problema_3
        on list_tercero_problema_3.lista_column = 'L_Problema_1'
        and list_tercero_problema_3.value = CAST(calls.tercero_problema_3 AS STRING)

left join stg_lists_firebase list_tercero_actitud_problema_1
        on list_tercero_actitud_problema_1.lista_column = 'T_Actitud_Problema_1'
        and list_tercero_actitud_problema_1.value = CAST(calls.tercero_actitud_problema_1 AS STRING)

left join stg_lists_firebase list_tercero_actitud_problema_2
        on list_tercero_actitud_problema_2.lista_column = 'T_Actitud_Problema_1'
        and list_tercero_actitud_problema_2.value = CAST(calls.tercero_actitud_problema_2 AS STRING)

left join stg_lists_firebase list_orientador_nivel_ayuda_1
        on list_orientador_nivel_ayuda_1.lista_column = 'O_Nivel_Ayuda_1'
        and list_orientador_nivel_ayuda_1.value = CAST(calls.orientador_nivel_ayuda_1 AS STRING)

left join stg_lists_firebase list_orientador_nivel_ayuda_2
        on list_orientador_nivel_ayuda_2.lista_column = 'O_Nivel_Ayuda_1'
        and list_orientador_nivel_ayuda_2.value = CAST(calls.orientador_nivel_ayuda_2 AS STRING)

left join stg_lists_firebase list_orientador_sentimientos_1
        on list_orientador_sentimientos_1.lista_column = 'O_Sentimientos_1'
        and list_orientador_sentimientos_1.value = CAST(calls.orientador_sentimientos_1 AS STRING)

left join stg_lists_firebase list_orientador_sentimientos_2
        on list_orientador_sentimientos_2.lista_column = 'O_Sentimientos_1'
        and list_orientador_sentimientos_2.value = CAST(calls.orientador_sentimientos_2 AS STRING)

left join stg_lists_firebase list_orientador_sentimientos_3
        on list_orientador_sentimientos_3.lista_column = 'O_Sentimientos_1'
        and list_orientador_sentimientos_3.value = CAST(calls.orientador_sentimientos_3 AS STRING)

left join stg_lists_firebase list_orientador_autoevaluacion
        on list_orientador_autoevaluacion.lista_column = 'O_Autoevaluacion'
        and list_orientador_autoevaluacion.value = CAST(calls.orientador_autoevaluacion AS STRING)

left join stg_lists_firebase list_orientador_actitudes_equivocadas_1
        on list_orientador_actitudes_equivocadas_1.lista_column = 'O_Actitudes_1'
        and list_orientador_actitudes_equivocadas_1.value = CAST(calls.orientador_actitudes_equivocadas_1 AS STRING)

left join stg_lists_firebase list_orientador_actitudes_equivocadas_2
        on list_orientador_actitudes_equivocadas_2.lista_column = 'O_Actitudes_1'
        and list_orientador_actitudes_equivocadas_2.value = CAST(calls.orientador_actitudes_equivocadas_2 AS STRING)

left join stg_lists_firebase list_orientador_satisfaccion_llamante_1
        on list_orientador_satisfaccion_llamante_1.lista_column = 'O_Satisfaccion_1'
        and list_orientador_satisfaccion_llamante_1.value = CAST(calls.orientador_satisfaccion_llamante_1 AS STRING)

left join stg_lists_firebase list_orientador_satisfaccion_llamante_2
        on list_orientador_satisfaccion_llamante_2.lista_column = 'O_Satisfaccion_1'
        and list_orientador_satisfaccion_llamante_2.value = CAST(calls.orientador_satisfaccion_llamante_2 AS STRING)

LEFT JOIN stg_lists_firebase list_volvera_llamar
        on list_volvera_llamar.lista_column = 'O_Volvera_Llamar'
        and list_volvera_llamar.value = CAST(calls.orientador_volvera_llamar AS STRING)