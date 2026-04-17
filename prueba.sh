Muestra la configuracion de red del sistema

ip a 

Limpia la pantalla

clear

Ejecuta automáticamente 5 intentos de conexión SSH fallidos para generar registros en los logs de seguridad.

for i in {1..5}; do ssh administrador_falso@10.0.2.15; done

El comando base para iniciar conexiones remotas seguras a otros servidores.

ssh

Muestra en tiempo real las últimas líneas del archivo de log de autenticación (útil para ver ataques mientras ocurren).


tail -f /var/log/auth.log

Filtra el log de autenticación para mostrar únicamente las líneas donde ha habido una contraseña incorrecta.

grep "Failed password" /var/log/auth.log

Sincroniza la lista de paquetes del sistema con los servidores oficiales para poder instalar software nuevo.
Instala la herramienta encargada de banear automáticamente las IPs que intentan ataques de fuerza bruta.

sudo apt update 
sudo apt install fail2ban

Busca los intentos de acceso fallidos pero limita la salida a los últimos 50 resultados para que sea más legible.

grep "Failed password" /var/log/auth.log | tail -n 50

crear la carpeta scripts

mkdir -p scripts

Entrar en la carpeta scripts

cd scripts

Abrir el editor de texto nano para crear un nuevo script llamado check_intruders.sh

nano check_intruders.sh

Configura el firewall (UFW) para que prohíba cualquier conexión que no hayamos permitido explícitamente.

sudo ufw default deny incoming

Configura el firewall para que el servidor sí pueda realizar consultas o descargas hacia internet.

sudo ufw default allow outgoing

Crea una excepción en el firewall para que podamos seguir administrando el servidor por el puerto 22.

sudo ufw allow 22/tcp

Pone en marcha las reglas de seguridad configuradas anteriormente en el sistema.

sudo ufw enable