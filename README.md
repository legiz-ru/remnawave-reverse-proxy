<div align="center">
  <a href="https://remna.st">
    <img src="https://cdn.remna.st/logos/logo.svg" alt="Logo" width="160" height="160">
  </a>
     <h1 align="center">REMNAWAVE REVERSE-PROXY</h3>
</div>

English | [Русский](/README-RU.md)

> [!CAUTION]
> THIS REPOSITORY IS AN EDUCATIONAL EXAMPLE FOR LEARNING NGINX, REVERSE PROXY AND NETWORK SECURITY BASICS. THIS SCRIPT DEMONSTRATES NGINX CONFIGURATION AS A REVERSE PROXY. NOT FOR PROD AND NOT FOR PRODUCTION USE! IF YOU DON'T UNDERSTAND HOW THE CONTROL PANEL WORKS - THAT'S YOUR PROBLEM, NOT THE SCRIPT AUTHOR'S. USE AT YOUR OWN RISK!

### Server Using NGINX Reverse Proxy
This script is designed to streamline the setup of a reverse proxy server using NGINX and Xray, as well as to automate the installation of the Remnawave control panel and node. In this configuration, Xray operates directly on port 443, forwarding traffic through a socket that NGINX listens to. This approach minimizes unnecessary TCP overhead, delivering improved performance and connection reliability.
> [!IMPORTANT]
> Supports Debian and Ubuntu. The script has been tested in a KVM virtualization environment. For proper operation, you will need your own domain. It is recommended to run it with root privileges on a freshly installed system.

The script supports deployment on either a single server (with both the panel and node together) or two separate servers, depending on your needs:

- Single Server: Ideal for a compact setup where the control panel and Xray node are installed on the same machine.
- Panel Server: Serves as the central management hub, without hosting an Xray node.
- Node Server: Hosts the Xray node along with a Self Steal stub for VLESS REALITY.
To ensure proper operation, you need to prepare three domains (or subdomains) in advance: the first will be used for the control panel, the second for handling subscriptions, and the third for the Self Steal stub site, which is hosted on the node server.
-----
### Domain Configuration
The script supports two methods of domain configuration: via Cloudflare or using ACME with your hosting provider.

### DNS Records Setup for Panel + Node on the Same Server

| Type  | Name              | Content          | Proxy status  |
| ----- | ----------------- | ---------------- | ------------- |
| A     | example.com       | your_server_ip   | DNS only      |
| CNAME | panel.example.com | example.com      | DNS only      |
| CNAME | sub.example.com   | example.com      | DNS only      |
| CNAME | node.example.com  | example.com      | DNS only      |

> [!IMPORTANT]
> The node.example.com record is not mandatory for a selfsteal node — you can also use example.com for selfsteal.

### DNS Records Setup for Panel and Node on Separate Servers

| Type  | Name              | Content                 | Proxy status  |
| ----- | ----------------- | ----------------------- | ------------- |
| A     | example.com       | your_server_ip          | DNS only      |
| CNAME | panel.example.com | example.com             | DNS only      |
| CNAME | sub.example.com   | example.com             | DNS only      |
| A     | node.example.com  | your_server_ip_vps_node | DNS only      |

-----
### Installation Guidelines
### 1. Single Server Setup:
   - Select the option to install both the panel and node on the same machine. Once the process is complete, the script will automatically restart the panel and provide all necessary login credentials.
### 2. Dual Server Setup
   - Start by installing the panel on the first server. Wait for the script to finish the setup and provide the login credentials for the panel.
   - Log into the control panel, navigate to Nodes → Management, select the desired node, and click the Important button. In the pop-up window, you’ll see an icon to copy the certificate — copy it.
   - Proceed to the second server and initiate the node installation. When prompted, paste the certificate you copied earlier.
   - Upon completion, you’ll see a message confirming that the node has been successfully connected.
-----
### Panel Protection via URL Parameter
To enhance the security of the panel, an additional layer of protection against detection has been implemented in the NGINX configuration:
- To access the panel, you must navigate to a URL in the following format:
  ```
  https://panel.example.com/auth/login?<SECRET_KEY>=<SECRET_KEY>
  ```
- This request automatically sets a special Cookie in the browser with the name <SECRET_KEY> and the value <SECRET_KEY>.
- If the Cookie is missing or the URL request lacks the specified parameter, the user will encounter either a blank page or a 404 error, depending on the requested path.

This mechanism ensures the panel remains hidden from unauthorized access. Even if an attacker attempts to scan the host or brute-force paths, they will be unable to access the panel without the correct parameter and corresponding Cookie.

-----
### Proxy server configuration:
1. Proxy server configuration:
   - Support for automatic configuration updates via subscription and JSON subscription with the ability to convert to formats for popular applications.
2. NGINX reverse proxy setup in combination with Xray.
3. Security measures:
   - UFW (Uncomplicated Firewall) setup for access management.
   - Disabling IPv6 to prevent potential vulnerabilities.
   - Selecting a random website template from an array.
4. Enabling BBR — improving TCP connection performance.
-----
### Server Setup:

To set up the server, run this command on it:

```
bash <(curl -Ls https://raw.githubusercontent.com/eGamesAPI/remnawave-reverse-proxy/refs/heads/main/install_remnawave.sh)
```
<p align="center"><a href="#"><img src="./media/remnawave-reverse-proxy_en.png" alt="Image"></a></p>

-----
> [!IMPORTANT]
> This repository is intended solely for educational purposes and for studying the principles of reverse proxy servers and network security. The script demonstrates the setup of a proxy server using NGINX for reverse proxy, traffic management, and attack protection.
>
>We strongly remind you that using this tool to bypass network restrictions or censorship is illegal in certain countries that have laws regulating the use of technologies to circumvent internet restrictions.
>
>This project is not intended for use in ways that violate information protection laws or interfere with censorship mechanisms. We take no responsibility for any legal consequences arising from the use of this script.
>
>Use this tool/script only for demonstration purposes, as an example of reverse proxy operation and data protection. We strongly recommend removing the script after reviewing it. Further use is at your own risk.
>
>If you are unsure whether the use of this tool or its components violates the laws of your country, refrain from interacting with this tool.
