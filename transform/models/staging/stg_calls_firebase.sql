select
--identifiers
Orientador as orientador,
OrientadorUid as orientador_uid,
CreatedAt as created_at,
document_id,
last_updated,

--general call info
Medio_de_Contacto as medio_contacto,
Como_Conocio as como_conocio,
L_Derivada as llamante_llamada_derivada,
Hora as llamada_hora,
Fecha as llamada_fecha,
Resultado as llamada_resultado,
Duracion as llamada_duracion,
Sintesis as sintesis,

--caller info
L_Sexo as llamante_sexo,
L_Edad as llamante_edad,
L_Estado_Civil as llamante_estado_civil,
L_Convive as llamante_convive,
L_Asiduidad as llamante_asiduidad,
L_Procedencia as llamante_procedencia,
L_Condicion as llamante_condicion,

--caller problem
L_Problematica_1 as llamante_problematica_1,
L_Problema_1 as llamante_problema_1,
L_Problematica_2 as llamante_problematica_2,
L_Problema_2 as llamante_problema_2,
L_Problematica_3 as llamante_problematica_3,
L_Problema_3 as llamante_problema_3,
L_Naturaleza as llamante_naturaleza,
L_Inicio as llamante_inicio,
L_Peticion as llamante_peticion,

--caller language and attitude
L_Actitud as llamante_actitud_orientador,
L_Presentacion as llamante_presentacion,
L_Paralenguaje as llamante_paralenguaje,
L_Actitud_Problema_1 as llamante_actitud_problema_1,
L_Actitud_Problema_2 as llamante_actitud_problema_2,

--third party info
T_Sexo as tercero_sexo,
T_Edad as tercero_edad,
T_Estado_Civil as tercero_estado_civil,
T_Convive as tercero_convive,
T_Relacion as tercero_relacion,

--third party problem
T_Problematica_1 as tercero_problematica_1,
T_Problema_1 as tercero_problema_1,
T_Problematica_2 as tercero_problematica_2,
T_Problema_2 as tercero_problema_2,
T_Problematica_3 as tercero_problematica_3,
T_Problema_3 as tercero_problema_3,
T_Actitud_Problema_1 as tercero_actitud_problema_1,
T_Actitud_Problema_2 as tercero_actitud_problema_2,

--orientador info
O_Clave as orientador_clave,

--orientator perception of call
O_Nivel_Ayuda_1 as orientador_nivel_ayuda_1,
O_Nivel_Ayuda_2 as orientador_nivel_ayuda_2,
O_Sentimientos_1 as orientador_sentimientos_1,
O_Sentimientos_2 as orientador_sentimientos_2,
O_Sentimientos_3 as orientador_sentimientos_3,
O_Autoevaluacion as orientador_autoevaluacion,
O_Actitudes_1 as orientador_actitudes_equivocadas_1,
O_Actitudes_2 as orientador_actitudes_equivocadas_2,
O_Satisfaccion_1 as orientador_satisfaccion_llamante_1,
O_Satisfaccion_2 as orientador_satisfaccion_llamante_2,

O_Volvera_Llamar as orientador_volvera_llamar

from {{ source('raw_data', 'llamatel_llamadas_firebase') }}