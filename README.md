# 1. FASE DE INVESTIGACIÓN: SEGURIDAD Y AUDITORÍA DEL SISTEMA
Este documento detalla la investigación sobre el estándar Syslog, la gestión de logs en Linux y la importancia de la centralización de registros para el cumplimiento del RGPD.

# 2. RETO DE INVESTIGACIÓN 1: ANATOMÍA DE SYSLOG Y SEGURIDAD LOCAL
El Estándar Syslog

El sistema Syslog es el corazón de la mensajería en Linux y clasifica cada evento cruzando dos variables fundamentales:
Facilidad (Facility)

Se refiere a la categoría o el origen del mensaje. Indica qué parte del sistema ha generado el registro. Ejemplos comunes son auth (autenticación), cron (tareas programadas), kern (núcleo) o daemon (servicios en segundo plano).

Prioridad (Severity)

Determina la importancia o gravedad del evento. La escala va desde debug (información para depuración) hasta emerg (emergencia total donde el sistema queda inestable), pasando por niveles intermedios como info, notice, warning, err, crit y alert.

La Negligencia de los Permisos en /var/log/auth.log

Permitir que usuarios no privilegiados lean este archivo es una falta grave de seguridad. Esto se debe a que el log de autenticación revela información crítica que un atacante puede usar para escalar privilegios. Entre esta información se encuentran los nombres de usuario válidos del sistema, los horarios de conexión de los administradores y, en ocasiones, contraseñas escritas por error en el campo de usuario que quedan registradas en texto plano. Por ello, en sistemas Linux protegidos, solo el usuario root y ciertos grupos de administración tienen acceso a este archivo.

Diferencias entre Intento SSH y Fallo Local

Existen diferencias técnicas clave para distinguir un ataque remoto de un error físico frente al equipo:

En una conexión remota SSH, el registro muestra el identificador de proceso (PID) vinculado al servicio sshd. Además, incluye obligatoriamente la dirección IP de origen y el puerto efímero desde el que se intenta la conexión.

En un fallo local frente a la pantalla, el registro se vincula a procesos como login o getty. En lugar de una dirección IP, el log muestra el identificador de la terminal física, generalmente denominada tty1 o similar.

# RETO DE INVESTIGACIÓN 2: CENTRALIZACIÓN DE LOGS Y CUMPLIMIENTO LEGAL
Importancia de la Gestión Centralizada

Enviar los logs a un servidor externo seguro es una medida de seguridad crítica para cualquier empresa, especialmente bajo la normativa del RGPD en España.

Integridad y Garantía de Inalterabilidad

Si un atacante logra entrar en un servidor, su primera acción será borrar los logs locales para ocultar sus huellas. Al enviar estos registros en tiempo real a un servidor externo, se garantiza que la evidencia permanezca intacta. Esto asegura la cadena de custodia necesaria para cualquier investigación forense o auditoría de la Agencia Española de Protección de Datos (AEPD).

Seguridad y Detección Rápida de Amenazas
La centralización permite la correlación de eventos. Al reunir datos de muchos servidores en un solo lugar, es posible detectar patrones de ataque que de forma aislada parecerían fallos comunes. Esto reduce drásticamente el tiempo de respuesta ante una brecha de seguridad.

Continuidad de Negocio y Resiliencia

Incluso en casos de desastre o ataques de ransomware que cifren el servidor original, los registros de actividad permanecen a salvo en el servidor central. Esto permite reconstruir los hechos y entender el origen de la vulnerabilidad sin perder la información histórica.
Cumplimiento de Plazos Legales

El RGPD obliga a las empresas a notificar cualquier brecha de seguridad a la AEPD en un máximo de 72 horas. Tener los logs centralizados permite realizar búsquedas rápidas y precisas para cumplir con este plazo, evitando posibles sanciones económicas graves por falta de diligencia.

Gestión de Datos Sensibles (PII)

Los logs contienen datos personales como direcciones IP y nombres de usuario. Un servidor centralizado permite aplicar mejores controles de acceso y técnicas de anonimización, cumpliendo con el principio de minimización de datos y confidencialidad que exige la ley. 

