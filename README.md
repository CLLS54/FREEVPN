# FREEVPN

[![Invitame un cafe en Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/clls54)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Inv%C3%ADtame%20un%20caf%C3%A9-FF5E5B?logo=ko-fi&logoColor=white)](https://ko-fi.com/clls54)

Cliente automático para [VPN Gate](https://www.vpngate.net/) usando el cliente oficial **SoftEther** en Windows.

Descubre servidores públicos gratuitos, elige el mejor según ping y velocidad, y establece la conexión sin configurar nada a mano.

## Qué hace

- Consulta la API pública de VPN Gate y descarta los servidores caídos.
- Resuelve el **puerto real** de cada servidor desde su configuración OpenVPN (la causa habitual de que una conexión manual falle).
- Hace una sonda TCP previa y ordena por ping/velocidad según la política configurada.
- Crea la cuenta y el adaptador virtual en el cliente SoftEther y conecta.
- Mantiene la rotación automática de servidores (`rotate`) con reintentos.

## Requisitos

- Windows 10/11 de 64 bits, con permisos de administrador.
- Conexión a Internet (los servidores son de voluntarios y pueden caerse).
- Cliente **SoftEther VPN Client 5.2.5187 x64**, que **no se incluye** en este repositorio.

## Instalación (3 pasos)

1. Descarga el instalador oficial desde <https://www.softether.org/> y guárdalo como:
   ```
   instaladores\softether-vpnclient-5.2.5187.x64.exe
   ```
2. Doble clic en **`Instalar-SoftEther.bat`** y acepta el aviso de administrador.
   Instala el cliente, registra el servicio y crea el adaptador virtual.
3. Doble clic en **`FREEVPN.bat`** → opción **3 (connect)**.

Comprueba con la opción **4 (status)**: debe indicar `estado: Connected`.

## Uso diario

```
FREEVPN.bat  →  3 (conectar)  →  4 (ver estado)  →  5 (desconectar)
```

La opción **6 (clean)** elimina la cuenta y el adaptador; después hay que repetir el paso 2. La opción **1 (doctor)** muestra permisos, estado del servicio, integridad SHA-256 de los binarios y estado de la API.

El menú completo y su salida esperada están en **`MANUAL.html`**.

## Línea de comandos

| Comando | Descripción |
|---|---|
| `autovpn.exe connect` | Sondea y conecta al mejor servidor. |
| `autovpn.exe connect --attempts 8` | Prueba hasta 8 servidores vivos. |
| `autovpn.exe connect --country JP` | Restringe la selección a Japón. |
| `autovpn.exe connect --refresh` | Ignora la caché y consulta la API. |
| `autovpn.exe connect --host <IP>` | Servidor concreto (resuelve su puerto real). |
| `autovpn.exe status` | Estado de la sesión. |
| `autovpn.exe disconnect` | Desconecta. |
| `autovpn.exe list --limit 50 --country KR` | Lista servidores filtrados. |
| `autovpn.exe rotate --max-cycles 0` | Supervisión continua con rotación. |
| `autovpn.exe doctor` | Diagnóstico del entorno. |
| `autovpn.exe setup --installer <exe>` | Instalación automatizada. |
| `autovpn.exe clean` | Elimina cuenta y adaptador. |

## Contenido del repositorio

| Archivo | Función |
|---|---|
| `FREEVPN.bat` | Lanzador principal; abre el menú con permisos de administrador. |
| `Instalar-SoftEther.bat` | Instala el cliente SoftEther (solo la primera vez). |
| `autovpn.exe` | El programa. |
| `MANUAL.html` | Manual completo, con arquitectura y auditoría de seguridad. |
| `config.ejemplo.toml` | Configuración comentada. |
| `LEEME.txt` | Guía rápida en texto plano. |
| `.gitignore` | Excluye instaladores, binarios de Tor y logs. |

## Configuración

Copia `config.ejemplo.toml` a `%APPDATA%\AutoVPN\config.toml` (la primera ejecución ya crea uno con esos valores). Lo más relevante:

```toml
nic_name   = "VPN"        # el adaptador debe empezar por "VPN" (regla del driver)
account_name = "AutoVPN"
hub        = "VPNGATE"    # no cambiar: otro valor da "hub inexistente"
port       = 443

[policy]
max_ping_ms     = 500     # 0 = sin límite
min_speed_mbps  = 1.0
countries       = []      # vacío = todos
exclude_countries = []
```

## Solución de problemas

| Síntoma | Causa y solución |
|---|---|
| `Error Code 1 / Connection to the server failed` | Ese servidor está caído: vuelve a conectar y elegirá otro. |
| `Error 31` al crear el adaptador | Reinstala con `Instalar-SoftEther.bat`. |
| No aparece SoftEther en el menú Inicio | Ejecuta `Instalar-SoftEther.bat`, que lo registra en Windows. |
| Windows Defender pide confirmación | Es tu propio ejecutable; acepta. |

Empieza siempre por `autovpn.exe doctor` o la opción **1 (doctor)** del menú.

## Seguridad y limitaciones

- Los servidores son **públicos, gratuitos y operados por terceros**. El tráfico va cifrado hasta el relay, pero el operador del relay puede verlo: no los uses para datos sensibles.
- Las credenciales `usuario: vpn` / `contraseña: vpn` son las **públicas de VPN Gate**, no secretas.
- El manual documenta la integridad SHA-256 de los binarios y el staging privado con ACL (SEC-01 a SEC-03).
- `Tor-US/` e `instaladores/` no se versionan aquí: contienen binarios pesados y un perfil de navegador.

## Documentación

Abre **`MANUAL.html`** en el navegador. Incluye el funcionamiento interno (descubrimiento, ranking, puerto real, sonda TCP, sesión SoftEther), la arquitectura del código y la sección de seguridad.


## Apoyar el proyecto

Si esta herramienta te resulta util, puedes invitarme un cafe. El dinero se
destina a mantener las pruebas, el hardware de verificacion y las horas de
desarrollo.

[![Invitame un cafe en Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/clls54)

[![Ko-fi](https://img.shields.io/badge/Ko--fi-Inv%C3%ADtame%20un%20caf%C3%A9-FF5E5B?logo=ko-fi&logoColor=white)](https://ko-fi.com/clls54)


## Licencia

Este repositorio no incluye archivo de licencia. Todos los derechos reservados por el autor salvo que se indique lo contrario.
