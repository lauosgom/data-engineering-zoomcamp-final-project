# data-engineering-zoomcamp-final-project
Repository to host the final project of the Data Engineering Zoomcamp
## Problem Statement

Dataset

The Telefono de la Esperanza (Phone of Hope) is a non-governmental organization that cares about mental health. One of their main services is a helpline where people can call for psychological help or just to be heard. All calls are answered by an expert who listens, offers advice and next steps. After every call, the expert, or "orientador," fills out a form cataloging the type of call and problem and providing a short summary of the call.

Currently, they are trying to transition to better software and data infrastructure. However, in order to preserve the old data on their servers, they must download it manually and each call produces a single pdf. This process is time-consuming because it requires downloading each call individually since 20xx. To facilitate this process, I designed a web scraper that logs in to the website with the proper credentials and downloads the data in PDF format. The data is stored in a data lake, a Google Cloud Storage bucket. Then, the data is processed by extracting the call information and building a table. Finally, the data is merged into a table in BigQuery.

The table goes through a series of transformation following business rules provided by members of the organization


then I created a dashboard where we can see some of the basic statistics for the data.

The cadence is every xx

## Data Pipeline
the data is stored in pdf files hosted in a google drive folder
script of extraction using some regex
merge tables into bigquery
dashboard
- have a 'flow' in kestra/prefect to do this every month

medio_contacto:  
codigo_numero:  
codigo_letras:  
total_llamadas:  

llamante_sexo:  
llamante_edad:  
llamante_estado_civil:  
llamante_convive:  
llamante_asiduidad:  
llamante_problema:  
llamante_naturaleza:  
llamante_inicio:  
llamante_actitud_orientador:  
llamante_presentacion:  
llamante_paralenguaje:  
llamante_procedencia:  
llamante_peticion:  
llamante_actitud_problema:  
llamante_llamada_derivada:  

tercero_sexo:  
tercero_edad:  
tercero_estado_civil:  
tercero_convive:  
tercero_relacion:  
tercero_problema:  
tercero_actitud_problema:  

llamada_hora:  
llamada_fecha:  
llamada_resultado:  
llamada_duracion:  
entrevista_clave:  
entrevista_referencia:  
entrevista_hora:  
entrevista_fecha:  

orientador_clave_letras:  
orientador_clave_numero:  
orientador_nivel_ayuda:  
orientador_sentimientos:  
orientador_autoevaluacion:  
orientador_actitudes_equivocadas:  
orientador_satisfaccion_llamante:  

sintesis
## Technologies

1. Create service account and save keys
2. Terraform create bucket and bigquery dataset
3. Kestra: upload data to bigquery table
4. dbt
5. 

## Dashboard
