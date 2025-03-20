#!/bin/bash

DIR_REMNAWAVE="/usr/local/remnawave_reverse/"
SCRIPT_URL="https://raw.githubusercontent.com/eGamesAPI/remnawave-reverse-proxy/refs/heads/dev/install_remnawave.sh"

COLOR_RESET="\033[0m"
COLOR_GREEN="\033[1;32m"
COLOR_YELLOW="\033[1;33m"
COLOR_WHITE="\033[1;37m"
COLOR_RED="\033[1;31m"

# Language variables
declare -A LANG=(
    [CHOOSE_LANG]="Select language:"
    [LANG_EN]="English"
    [LANG_RU]="Russian"
)

set_language() {
    case $1 in
        en)
            LANG=(
                #Lang
                [CHOOSE_LANG]="Select language:"
                [LANG_EN]="English"
                [LANG_RU]="Russian"
                #check
                [ERROR_ROOT]="Script must be run as root"
                [ERROR_OS]="Supported only Debian 11/12 and Ubuntu 22.04/24.04"
                #Menu
                [MENU_TITLE]="REMNAWAVE REVERSE-PROXY"
                [MENU_1]="Installation with panel and node"
                [MENU_2]="Installing only the panel"
                [MENU_3]="Installing only the node"
                [MENU_4]="Reinstall panel"
                [MENU_5]="Select random site template"
                [MENU_6]="Exit"
                [PROMPT_ACTION]="Select action (1-6):"
                [INVALID_CHOICE]="Invalid choice. Please select 1-6."
                [EXITING]="Exiting"
                #Remna
                [INSTALL_PACKAGES]="Installing required packages..."
                [INSTALLING]="Installing Remnawave"
                [ENTER_PANEL_DOMAIN]="Enter panel domain (e.g. panel.example.com):"
                [ENTER_SUB_DOMAIN]="Enter subscription domain (e.g. sub.example.com):"
		[ENTER_NODE_DOMAIN]="Enter selfsteal domain for node (e.g. node.example.com):"
                [ENTER_CF_TOKEN]="Enter your Cloudflare API token or global API key:"
                [ENTER_CF_EMAIL]="Enter your Cloudflare registered email:"
                [CHECK_CERTS]="Checking certificates..."
                [CERT_EXIST1]="Certificates found in /etc/letsencrypt/live/"
                [CERT_EXIST]="Using existing certificates"
                [CF_VALIDATING]="Cloudflare API key and email are valid"
                [CF_INVALID]="Invalid Cloudflare API token or email after %d attempts."
                [CF_INVALID_ATTEMPT]="Invalid Cloudflare API key or email. Attempt %d of %d."
                [CERT_MISSING]="Certificates not found. Obtaining new ones..."
                [WAITING]="Please wait..."
                #API
                [REGISTERING_REMNAWAVE]="Registering in Remnawave"
                [CHECK_SERVER]="Checking server availability..."
                [SERVER_NOT_READY]="Server is not ready, waiting..."
                [REGISTRATION_SUCCESS]="Registration completed successfully!"
                [GET_PUBLIC_KEY]="Getting public key..."
                [PUBLIC_KEY_SUCCESS]="Public key successfully obtained."
                [GENERATE_KEYS]="Generating x25519 keys..."
                [GENERATE_KEYS_SUCCESS]="Keys successfully generated."
                [UPDATING_XRAY_CONFIG]="Updating Xray configuration..."
                [XRAY_CONFIG_UPDATED]="Xray configuration successfully updated."
                [NODE_CREATED]="Node successfully created."
                [CREATE_HOST]="Creating host with UUID: "
                [HOST_CREATED]="Host successfully created."
                #Stop/Start
                [STARTING_REMNAWAVE]="Starting Remnawave"
                [STOPPING_REMNAWAVE]="Stopping Remnawave"
                #Menu End
                [INSTALL_COMPLETE]="               INSTALLATION COMPLETE!"
                [PANEL_ACCESS]="Panel URL:"
                [ADMIN_CREDS]="To log into the panel, use the following data:"
                [USERNAME]="Username:"
                [PASSWORD]="Password:"
                [RELAUNCH_CMD]="To relaunch script use command:"
                #RandomHTML
                [RANDOM_TEMPLATE]="Installing random template for camouflage site"
                [DOWNLOAD_FAIL]="Download failed, retrying..."
                [UNPACK_ERROR]="Error unpacking archive"
                [TEMPLATE_COPY]="Template copied to /var/www/html/"
                [SELECT_TEMPLATE]="Selected template:"
                #Error
                [ERROR_TOKEN]="Failed to get token."
                [ERROR_EXTRACT_TOKEN]="Failed to extract token from response."
                [ERROR_PUBLIC_KEY]="Failed to get public key."
                [ERROR_EXTRACT_PUBLIC_KEY]="Failed to extract public key from response."
                [ERROR_GENERATE_KEYS]="Failed to generate keys."
                [ERROR_EMPTY_RESPONSE_CONFIG]="Empty response from server when updating configuration."
                [ERROR_UPDATE_XRAY_CONFIG]="Failed to update Xray configuration."
                [ERROR_EMPTY_RESPONSE_NODE]="Empty response from server when creating node."
                [ERROR_CREATE_NODE]="Failed to create node."
                [ERROR_EMPTY_RESPONSE_INBOUNDS]="Empty response from server when getting inbounds."
                [ERROR_EXTRACT_UUID]="Failed to extract UUID from response."
                [ERROR_EMPTY_RESPONSE_HOST]="Empty response from server when creating host."
                [ERROR_CREATE_HOST]="Failed to create host."
                [ERROR_EMPTY_RESPONSE_REGISTER]="Registration error - empty server response"
                [ERROR_REGISTER]="Registration error"
                #Reinstall
                [REINSTALL_TYPE_TITLE]="Select installation type after reinstall:"
                [REINSTALL_PROMPT]="Select action (1-2):"
                [POST_PANEL_MESSAGE]="The panel is installed, now run this script on the server where the node will be"
                [POST_PANEL_INSTRUCTION]="And select 'Install only the node'"
                [SELFSTEAL_PROMPT]="Enter the selfsteal domain for the node (e.g. node.example.com):"
                [SELFSTEAL]="Enter the selfsteal domain for the node specified during panel installation:"
                [PANEL_IP_PROMPT]="Enter the IP address of the panel to establish a connection between the panel and the node:"
                [IP_ERROR]="Enter a valid IP address in the format X.X.X.X (e.g., 192.168.1.1)"
                [CERT_PROMPT]="Enter the server certificate (paste the content and press Enter twice):"
                [CERT_CONFIRM]="Are you sure the certificate is correct? (y/n):"
                [ABORT_MESSAGE]="Installation aborted by user"
                [SUCCESS_MESSAGE]="Node successfully connected"
            )
            ;;
        ru)
            LANG=(
                #check
                [ERROR_ROOT]="Скрипт нужно запускать с правами root"
                [ERROR_OS]="Поддержка только Debian 11/12 и Ubuntu 22.04/24.04"
                [MENU_TITLE]="REMNAWAVE REVERSE-PROXY"
                #Menu
                [MENU_1]="Установка панели и ноды на этом же сервере"
                [MENU_2]="Установить только панель"
                [MENU_3]="Установить только ноду"
                [MENU_4]="Переустановить панель"
                [MENU_5]="Выбрать случайный шаблон"
                [MENU_6]="Выход"
                [PROMPT_ACTION]="Выберите действие (1-6):"
                [INVALID_CHOICE]="Неверный выбор. Выберите 1-6."
                [EXITING]="Выход"
                #Remna
                [INSTALL_PACKAGES]="Установка необходимых пакетов..."
                [INSTALLING]="Установка Remnawave"
                [ENTER_PANEL_DOMAIN]="Введите домен панели (например, panel.example.com):"
                [ENTER_SUB_DOMAIN]="Введите домен подписки (например, sub.example.com):"
                [ENTER_NODE_DOMAIN]="Введите selfsteal домен для ноды (например, node.example.com):"
                [ENTER_CF_TOKEN]="Введите Cloudflare API токен или глобальный ключ:"
                [ENTER_CF_EMAIL]="Введите зарегистрированную почту Cloudflare:"
                [CHECK_CERTS]="Проверка сертификатов..."
                [CERT_EXIST1]="Сертификаты найдены в /etc/letsencrypt/live/"
                [CERT_EXIST]="Используем существующие сертификаты"
                [CF_VALIDATING]="Cloudflare API ключ и email валидны"
                [CF_INVALID]="Неверный Cloudflare API ключ или email после %d попыток."
                [CF_INVALID_ATTEMPT]="Неверный Cloudflare API ключ или email. Попытка %d из %d."
                [CERT_MISSING]="Сертификаты не найдены. Получаем новые..."
                [WAITING]="Пожалуйста, подождите..."
                #API
                [REGISTERING_REMNAWAVE]="Регистрация в Remnawave"
                [CHECK_SERVER]="Проверка доступности сервера..."
                [SERVER_NOT_READY]="Сервер не готов, ожидание..."
                [REGISTRATION_SUCCESS]="Регистрация прошла успешно!"
                [GET_PUBLIC_KEY]="Получаем публичный ключ..."
                [PUBLIC_KEY_SUCCESS]="Публичный ключ успешно получен."
                [GENERATE_KEYS]="Генерация ключей x25519..."
                [GENERATE_KEYS_SUCCESS]="Ключи успешно сгенерированы."
                [UPDATING_XRAY_CONFIG]="Обновление конфигурации Xray..."
                [XRAY_CONFIG_UPDATED]="Конфигурация Xray успешно обновлена."
                [NODE_CREATED]="Узел успешно создан."
                [CREATE_HOST]="Создаем хост с UUID: "
                [HOST_CREATED]="Хост успешно создан."
                #Stop/Start
                [STOPPING_REMNAWAVE]="Остановка Remnawave"
                [STARTING_REMNAWAVE]="Запуск Remnawave"
                #Menu End
                [INSTALL_COMPLETE]="               УСТАНОВКА ЗАВЕРШЕНА!"
                [PANEL_ACCESS]="Панель доступна по адресу:"
                [ADMIN_CREDS]="Для входа в панель используйте следующие данные:"
                [USERNAME]="Логин:"
                [PASSWORD]="Пароль:"
                [RELAUNCH_CMD]="Для повторного запуска:"
                #RandomHTML
                [DOWNLOAD_FAIL]="Ошибка загрузки, повторная попытка..."
                [UNPACK_ERROR]="Ошибка распаковки архива"
                [RANDOM_TEMPLATE]="Установка случайного шаблона для маскировочного сайта"
                [TEMPLATE_COPY]="Шаблон скопирован в /var/www/html/"
                [SELECT_TEMPLATE]="Выбран шаблон:"
                #Error
                [ERROR_TOKEN]="Не удалось получить токен."
                [ERROR_EXTRACT_TOKEN]="Не удалось извлечь токен из ответа."
                [ERROR_PUBLIC_KEY]="Не удалось получить публичный ключ."
                [ERROR_EXTRACT_PUBLIC_KEY]="Не удалось извлечь публичный ключ из ответа."
                [ERROR_GENERATE_KEYS]="Не удалось сгенерировать ключи."
                [ERROR_EMPTY_RESPONSE_CONFIG]="Пустой ответ от сервера при обновлении конфигурации."
                [ERROR_UPDATE_XRAY_CONFIG]="Не удалось обновить конфигурацию Xray."
                [ERROR_EMPTY_RESPONSE_NODE]="Пустой ответ от сервера при создании узла."
                [ERROR_CREATE_NODE]="Не удалось создать узел."
                [ERROR_EMPTY_RESPONSE_INBOUNDS]="Пустой ответ от сервера при получении inbounds."
                [ERROR_EXTRACT_UUID]="Не удалось извлечь UUID из ответа."
                [ERROR_EMPTY_RESPONSE_HOST]="Пустой ответ от сервера при создании хоста."
                [ERROR_CREATE_HOST]="Не удалось создать хост."
                [ERROR_EMPTY_RESPONSE_REGISTER]="Ошибка при регистрации - пустой ответ сервера"
                [ERROR_REGISTER]="Ошибка регистрации"
                #Reinstall
                [REINSTALL_TYPE_TITLE]="Выберите тип установки после переустановки:"
                [REINSTALL_PROMPT]="Выберите действие (1-2):"
                [POST_PANEL_MESSAGE]="Панель установлена, теперь запустите этот скрипт на сервере, где будет нода"
                [POST_PANEL_INSTRUCTION]="И выберите 'Установить только ноду'"
                [SELFSTEAL]="Введите selfsteal домен для ноды, который указали при установке панели:"
                [PANEL_IP_PROMPT]="Введите IP адрес панели, чтобы установить соединение между панелью и ноды:"
                [IP_ERROR]="Введите корректный IP-адрес в формате X.X.X.X (например, 192.168.1.1)"
                [CERT_PROMPT]="Введите сертификат сервера (вставьте содержимое и 2 раза нажмите Enter):"
                [CERT_CONFIRM]="Вы уверены, что сертификат правильный? (y/n):"
                [ABORT_MESSAGE]="Установка прервана пользователем"
                [SUCCESS_MESSAGE]="Нода успешно подключена"
            )
            ;;
    esac
}

question() {
    echo -e "${COLOR_GREEN}[?]${COLOR_RESET} ${COLOR_YELLOW}$*${COLOR_RESET}"
}

reading() {
    read -rp " $(question "$1")" "$2"
}

error() {
    echo -e "${COLOR_RED}$*${COLOR_RESET}"
    exit 1
}

check_os() {
    if ! grep -q "bullseye" /etc/os-release && ! grep -q "bookworm" /etc/os-release && ! grep -q "jammy" /etc/os-release && ! grep -q "noble" /etc/os-release; then
        error "${LANG[ERROR_OS]}"
    fi
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "${LANG[ERROR_ROOT]}"
    fi
}

log_clear() {
  sed -i -e 's/\x1b\[[0-9;]*[a-zA-Z]//g' "$LOGFILE"
}

log_entry() {
  mkdir -p ${DIR_REMNAWAVE}
  LOGFILE="${DIR_REMNAWAVE}remnawave_reverse.log"
  exec > >(tee -a "$LOGFILE") 2>&1
}

update_remnawave_reverse() {
  UPDATE_SCRIPT="${DIR_REMNAWAVE}remnawave_reverse"
  wget -q -O $UPDATE_SCRIPT $SCRIPT_URL
  ln -sf $UPDATE_SCRIPT /usr/local/bin/remnawave_reverse
  chmod +x "$UPDATE_SCRIPT"
}

generate_user() {
    local length=8
    tr -dc 'a-zA-Z' < /dev/urandom | fold -w $length | head -n 1
}

generate_password() {
    local length=24
    local password=""
    local upper_chars='A-Z'
    local lower_chars='a-z'
    local digit_chars='0-9'
    local special_chars='!@#$%^&*()_+'
    local all_chars='A-Za-z0-9!@#$%^&*()_+'

    password+=$(head /dev/urandom | tr -dc "$upper_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$lower_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$digit_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$special_chars" | head -c 3)
    password+=$(head /dev/urandom | tr -dc "$all_chars" | head -c $(($length - 6)))

    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')

    echo "$password"
}

show_language() {
    echo -e "${COLOR_GREEN}${LANG[CHOOSE_LANG]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}1. ${LANG[LANG_EN]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}2. ${LANG[LANG_RU]}${COLOR_RESET}"
    echo -e ""
}

show_menu() {
    echo -e ""
    echo -e "${COLOR_GREEN}${LANG[MENU_TITLE]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}1. ${LANG[MENU_1]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}2. ${LANG[MENU_2]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}3. ${LANG[MENU_3]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}4. ${LANG[MENU_4]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}5. ${LANG[MENU_5]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}6. ${LANG[MENU_6]}${COLOR_RESET}"
    echo -e ""
}

show_reinstall_options() {
    echo -e ""
    echo -e "${COLOR_GREEN}${LANG[REINSTALL_TYPE_TITLE]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}1. ${LANG[MENU_1]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}2. ${LANG[MENU_2]}${COLOR_RESET}"
    echo -e ""
}

reinstall_remnawave() {
    if [ -d "/root/remnawave" ]; then
        cd /root/remnawave || return
        docker compose down -v --rmi all --remove-orphans > /dev/null 2>&1 &
        spinner $! "${LANG[WAITING]}"
    fi
    docker system prune -a --volumes -f > /dev/null 2>&1 &
    spinner $! "${LANG[WAITING]}"
    rm -rf /root/remnawave 2>/dev/null
}

choose_reinstall_type() {
    show_reinstall_options
    reading "${LANG[REINSTALL_PROMPT]}" REINSTALL_OPTION
    case $REINSTALL_OPTION in
        1)
            if [ ! -f ${DIR_REMNAWAVE}install_packages ]; then
                install_packages
            fi
            installation
            ;;
        2)
            if [ ! -f ${DIR_REMNAWAVE}install_packages ]; then
                install_packages
            fi
            installation_panel
            ;;
        *)
            echo -e "${COLOR_YELLOW}${LANG[INVALID_CHOICE]}${COLOR_RESET}"
            exit 1
            ;;
    esac
}

add_cron_rule() {
    local rule="$1"
    local logged_rule="${rule} >> ${DIR_REMNAWAVE}cron_jobs.log 2>&1"

    ( crontab -l | grep -Fxq "$logged_rule" ) || ( crontab -l 2>/dev/null; echo "$logged_rule" ) | crontab -
}

spinner() {
  local pid=$1
  local text=$2

  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local text_code="$COLOR_GREEN"
  local bg_code=""
  local effect_code="\033[1m"
  local delay=0.1
  local reset_code="$COLOR_RESET"

  printf "${effect_code}${text_code}${bg_code}%s${reset_code}" "$text" > /dev/tty

  while kill -0 "$pid" 2>/dev/null; do
    for (( i=0; i<${#spinstr}; i++ )); do
      printf "\r${effect_code}${text_code}${bg_code}[%s] %s${reset_code}" "$(echo -n "${spinstr:$i:1}")" "$text" > /dev/tty
      sleep $delay
    done
  done

  printf "\r\033[K" > /dev/tty
}

randomhtml() {
    cd /root/ || { echo "${LANG[UNPACK_ERROR]}"; exit 1; }
    
    rm -f main.zip 2>/dev/null
    rm -rf simple-web-templates-main/ 2>/dev/null
    
    echo -e "${COLOR_YELLOW}${LANG[RANDOM_TEMPLATE]}${COLOR_RESET}"
    spinner $$ "${LANG[WAITING]}" &
    spinner_pid=$!

    while ! wget -q --timeout=30 --tries=10 --retry-connrefused "https://github.com/cortez24rus/xui-rp-web/archive/refs/heads/main.zip"; do
        echo "${LANG[DOWNLOAD_FAIL]}"
        sleep 3
    done

    unzip -o main.zip &>/dev/null || { echo "${LANG[UNPACK_ERROR]}"; exit 0; }
    rm -f main.zip

    cd simple-web-templates-main/ || { echo "${LANG[UNPACK_ERROR]}"; exit 0; }

    rm -rf assets ".gitattributes" "README.md" "_config.yml"

    RandomHTML=$(for i in *; do echo "$i"; done | shuf -n1 2>&1)
    
    kill "$spinner_pid" 2>/dev/null
    wait "$spinner_pid" 2>/dev/null
    printf "\r\033[K" > /dev/tty
    
    echo "${LANG[SELECT_TEMPLATE]}" "${RandomHTML}"

    if [[ -d "${RandomHTML}" && -d "/var/www/html/" ]]; then
        rm -rf /var/www/html/*
        cp -a "${RandomHTML}"/. "/var/www/html/"
        echo "${LANG[TEMPLATE_COPY]}"
    else
        echo "${LANG[UNPACK_ERROR]}" && exit 0
    fi

    cd /root/
    rm -rf simple-web-templates-main/
}

install_packages() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALL_PACKAGES]}${COLOR_RESET}"
    apt-get update -y
    apt-get install -y ca-certificates curl jq ufw wget gnupg unzip nano dialog git certbot python3-certbot-dns-cloudflare unattended-upgrades locales
    
    locale-gen en_US.UTF-8
    update-locale LANG=en_US.UTF-8
    
    if grep -q "Ubuntu" /etc/os-release; then
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/keyrings/docker.asc > /dev/null
        chmod a+r /etc/apt/keyrings/docker.asc
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    elif grep -q "Debian" /etc/os-release; then
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/keyrings/docker.asc > /dev/null
        chmod a+r /etc/apt/keyrings/docker.asc
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi

    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # BBR
    if ! grep -q "net.core.default_qdisc = fq" /etc/sysctl.conf; then
        echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    fi
    if ! grep -q "net.ipv4.tcp_congestion_control = bbr" /etc/sysctl.conf; then
        echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    fi

    # IPv6
    interface_name=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo | head -n 1)
    if ! grep -q "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
        echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi
    if ! grep -q "net.ipv6.conf.default.disable_ipv6 = 1" /etc/sysctl.conf; then
        echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi
    if ! grep -q "net.ipv6.conf.lo.disable_ipv6 = 1" /etc/sysctl.conf; then
        echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi
    if ! grep -q "net.ipv6.conf.$interface_name.disable_ipv6 = 1" /etc/sysctl.conf; then
        echo "net.ipv6.conf.$interface_name.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi

    sysctl -p > /dev/null 2>&1

    # UFW
    ufw --force reset
    ufw allow 22/tcp comment 'SSH'
    ufw allow 443/tcp comment 'HTTPS'
    ufw --force enable
    
    # Unattended-upgrade
    echo 'Unattended-Upgrade::Mail "root";' >> /etc/apt/apt.conf.d/50unattended-upgrades
    echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
    dpkg-reconfigure -f noninteractive unattended-upgrades
    systemctl restart unattended-upgrades

    touch ${DIR_REMNAWAVE}install_packages
    clear
}

extract_domain() {
    local SUBDOMAIN=$1
    echo "$SUBDOMAIN" | awk -F'.' '{if (NF > 2) {print $(NF-1)"."$NF} else {print $0}}'
}

check_certificates() {
    local DOMAIN=$1

    if [ -d "/etc/letsencrypt/live/$DOMAIN" ]; then
        if [ -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ] && [ -f "/etc/letsencrypt/live/$DOMAIN/privkey.pem" ]; then
            echo "${LANG[CERT_EXIST1]}""$DOMAIN"
            return 0
        fi
    fi
    return 1
}

get_certificates() {
    local DOMAIN=$1
    local WILDCARD_DOMAIN="*.$DOMAIN"

    reading "${LANG[ENTER_CF_TOKEN]}" CLOUDFLARE_API_KEY
    reading "${LANG[ENTER_CF_EMAIL]}" CLOUDFLARE_EMAIL

    check_api() {
        local attempts=3
        local attempt=1

        while [ $attempt -le $attempts ]; do
            if [[ $CLOUDFLARE_API_KEY =~ [A-Z] ]]; then
                api_response=$(curl --silent --request GET --url https://api.cloudflare.com/client/v4/zones --header "Authorization: Bearer ${CLOUDFLARE_API_KEY}" --header "Content-Type: application/json")
            else
                api_response=$(curl --silent --request GET --url https://api.cloudflare.com/client/v4/zones --header "X-Auth-Key: ${CLOUDFLARE_API_KEY}" --header "X-Auth-Email: ${CLOUDFLARE_EMAIL}" --header "Content-Type: application/json")
            fi

            if echo "$api_response" | grep -q '"success":true'; then
                echo -e "${COLOR_GREEN}${LANG[CF_VALIDATING]}${COLOR_RESET}"
                return 0
            else
                echo -e "${COLOR_RED}$(printf "${LANG[CF_INVALID_ATTEMPT]}" "$attempt" "$attempts")${COLOR_RESET}"
            if [ $attempt -lt $attempts ]; then
                reading "${LANG[ENTER_CF_TOKEN]}" CLOUDFLARE_API_KEY
                reading "${LANG[ENTER_CF_EMAIL]}" CLOUDFLARE_EMAIL
            fi
                attempt=$((attempt + 1))
            fi
        done
        error "$(printf "${LANG[CF_INVALID]}" "$attempts")"
    }

    check_api

    mkdir -p ~/.secrets/certbot
    if [[ $CLOUDFLARE_API_KEY =~ [A-Z] ]]; then
        cat > ~/.secrets/certbot/cloudflare.ini <<EOL
dns_cloudflare_api_token = $CLOUDFLARE_API_KEY
EOL
    else
        cat > ~/.secrets/certbot/cloudflare.ini <<EOL
dns_cloudflare_email = $CLOUDFLARE_EMAIL
dns_cloudflare_api_key = $CLOUDFLARE_API_KEY
EOL
    fi
    chmod 600 ~/.secrets/certbot/cloudflare.ini

    certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
        --dns-cloudflare-propagation-seconds 60 \
        -d $DOMAIN \
        -d $WILDCARD_DOMAIN \
        --email $CLOUDFLARE_EMAIL \
        --agree-tos \
        --non-interactive \
        --key-type ecdsa \
        --elliptic-curve secp384r1

    echo "renew_hook = sh -c 'cd /root/remnawave && docker compose exec remnawave-nginx nginx -s reload'" >> /etc/letsencrypt/renewal/$DOMAIN.conf
    add_cron_rule "0 5 1 */2 * /usr/bin/certbot renew --quiet"
}

### API ###
register_remnawave() {
    local domain_url=$1
    local username=$2
    local password=$3
    local panel_domain=$4

    local register_response=$(curl -s "http://$domain_url/api/auth/register" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https" \
        -H "Content-Type: application/json" \
        --data-raw '{"username":"'"$username"'","password":"'"$password"'"}')

    if [ -z "$register_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_REGISTER]}${COLOR_RESET}"
    elif [[ "$register_response" == *"accessToken"* ]]; then
        echo "$register_response" | jq -r '.response.accessToken'
    else
        echo -e "${COLOR_RED}${LANG[ERROR_REGISTER]}: $register_response${COLOR_RESET}"
    fi
}

get_public_key() {
    local domain_url=$1
    local token=$2
    local panel_domain=$3
    local target_dir=$4

    local api_response=$(curl -s -X GET "http://$domain_url/api/keygen/get" \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https")

    if [ -z "$api_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_PUBLIC_KEY]}${COLOR_RESET}"
    fi

    local pubkey=$(echo "$api_response" | jq -r '.response.pubKey')
    if [ -z "$pubkey" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EXTRACT_PUBLIC_KEY]}${COLOR_RESET}"
    fi

    local env_node_file="$target_dir/.env-node"
    cat > "$env_node_file" <<EOL
### APP ###
APP_PORT=2222

### XRAY ###
SSL_CERT="$pubkey"
EOL
    echo -e "${COLOR_YELLOW}${LANG[PUBLIC_KEY_SUCCESS]}${COLOR_RESET}"
    echo "$pubkey"
}

generate_xray_keys() {
    docker run --rm ghcr.io/xtls/xray-core x25519 > /tmp/xray_keys.txt 2>&1 &
    spinner $! "${LANG[WAITING]}"
    wait $!
    
    local keys=$(cat /tmp/xray_keys.txt)
    rm -f /tmp/xray_keys.txt

    if [ -z "$keys" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_GENERATE_KEYS]}${COLOR_RESET}"
    fi

    local private_key=$(echo "$keys" | grep "Private key:" | awk '{print $3}')
    local public_key=$(echo "$keys" | grep "Public key:" | awk '{print $3}')

    echo "$private_key $public_key"
}

update_xray_config() {
    local domain_url=$1
    local token=$2
    local panel_domain=$3
    local target_dir=$4
    local domain=$5
    local public_key=$6
    local private_key=$7

    local short_id=$(openssl rand -hex 8)
    local config_file="$target_dir/config.json"
    cat > "$config_file" <<EOL
{
    "log": {
        "loglevel": "warning"
    },
    "dns": {
        "queryStrategy": "ForceIPv4",
        "servers": [
            {
                "address": "https://dns.google/dns-query",
                "skipFallback": false
            }
        ]
    },
    "inbounds": [
        {
            "tag": "Steal",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [],
                "decryption": "none"
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "xver": 1,
                    "dest": "/dev/shm/nginx.sock",
                    "spiderX": "",
                    "shortIds": [
                        "$short_id"
                    ],
                    "publicKey": "$public_key",
                    "privateKey": "$private_key",
                    "serverNames": [
                        "$domain"
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "tag": "DIRECT",
            "protocol": "freedom"
        },
        {
            "tag": "BLOCK",
            "protocol": "blackhole"
        }
    ],
    "routing": {
        "rules": [
            {
                "ip": [
                    "geoip:private"
                ],
                "type": "field",
                "outboundTag": "BLOCK"
            },
            {
                "type": "field",
                "domain": [
                    "geosite:private"
                ],
                "outboundTag": "BLOCK"
            },
            {
                "type": "field",
                "protocol": [
                    "bittorrent"
                ],
                "outboundTag": "BLOCK"
            }
        ]
    }
}
EOL

    if [ ! -f "$config_file" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_CONFIG]}${COLOR_RESET}"
    fi

    echo -e "${COLOR_YELLOW}${LANG[CONFIG_CREATED]}${COLOR_RESET}"

    local new_config=$(cat "$config_file")
    local update_response=$(curl -s -X POST "http://$domain_url/api/xray/update-config" \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https" \
        -d "$new_config")

    if [ -z "$update_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_CONFIG]}${COLOR_RESET}"
    fi

    if echo "$update_response" | jq -e '.response.config' > /dev/null; then
        printf "${COLOR_GREEN}${LANG[XRAY_CONFIG_UPDATED]}${COLOR_RESET}\n"
    else
        echo -e "${COLOR_RED}${LANG[ERROR_UPDATE_XRAY_CONFIG]}${COLOR_RESET}"
    fi
}

create_node() {
    local domain_url=$1
    local token=$2
    local panel_domain=$3
    local node_address=${4:-"remnanode"}
    
    local node_data=$(cat <<EOF
{
    "name": "Steal",
    "address": "$node_address",
    "port": 2222,
    "isTrafficTrackingActive": false,
    "trafficLimitBytes": 0,
    "notifyPercent": 0,
    "trafficResetDay": 31,
    "excludedInbounds": [],
    "countryCode": "XX",
    "consumptionMultiplier": 1.0
}
EOF
)

    local node_response=$(curl -s -X POST "http://$domain_url/api/nodes/create" \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https" \
        -d "$node_data")

    if [ -z "$node_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_NODE]}${COLOR_RESET}"
    fi

    if echo "$node_response" | jq -e '.response.uuid' > /dev/null; then
        printf "${COLOR_GREEN}${LANG[NODE_CREATED]}${COLOR_RESET}\n"
    else
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_NODE]}${COLOR_RESET}"
    fi
}

get_inbound_uuid() {
    local domain_url=$1
    local token=$2
    local panel_domain=$3

    local inbounds_response=$(curl -s -X GET "http://$domain_url/api/inbounds" \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https")

    if [ -z "$inbounds_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_INBOUNDS]}${COLOR_RESET}"
    fi

    local inbound_uuid=$(echo "$inbounds_response" | jq -r '.response[0].uuid')
    if [ -z "$inbound_uuid" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EXTRACT_UUID]}${COLOR_RESET}"
    fi

    echo "$inbound_uuid"
}

create_host() {
    local domain_url=$1
    local token=$2
    local panel_domain=$3
    local inbound_uuid=$4
    local domain=$5

    local host_data=$(cat <<EOF
{
    "inboundUuid": "$inbound_uuid",
    "remark": "Steal",
    "address": "$domain",
    "port": 443,
    "path": "",
    "sni": "$domain",
    "host": "$domain",
    "alpn": "h2",
    "fingerprint": "chrome",
    "allowInsecure": false,
    "isDisabled": false
}
EOF
)

    local host_response=$(curl -s -X POST "http://$domain_url/api/hosts/create" \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -H "Host: $panel_domain" \
        -H "X-Forwarded-For: $domain_url" \
        -H "X-Forwarded-Proto: https" \
        -d "$host_data")

    if [ -z "$host_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_HOST]}${COLOR_RESET}"
    fi

    if echo "$host_response" | jq -e '.response.uuid' > /dev/null; then
        echo -e "${COLOR_GREEN}${LANG[HOST_CREATED]}${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_HOST]}${COLOR_RESET}"
    fi
}

install_remnawave() {
    mkdir -p ~/remnawave && cd ~/remnawave

    reading "${LANG[ENTER_PANEL_DOMAIN]}" PANEL_DOMAIN
    reading "${LANG[ENTER_SUB_DOMAIN]}" SUB_DOMAIN

    DOMAIN=$(extract_domain $PANEL_DOMAIN)

    SUPERADMIN_USERNAME=$(generate_user)
    SUPERADMIN_PASSWORD=$(generate_password)

    cookies_random1=$(generate_user)
    cookies_random2=$(generate_user)

    METRICS_USER=$(generate_user)
    METRICS_PASS=$(generate_password)

    JWT_AUTH_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)
    JWT_API_TOKENS_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)

    cat > .env-node <<EOL
### APP ###
APP_PORT=2222

### XRAY ###
SSL_CERT="PUBLIC KEY FROM REMNAWAVE-PANEL"
EOL

    cat > .env <<EOL
### APP ###
APP_PORT=3000
METRICS_PORT=3001

### API ###
# Possible values: max (start instances on all cores), number (start instances on number of cores), -1 (start instances on all cores - 1)
# !!! Do not set this value more that physical cores count in your machine !!!
API_INSTANCES=1

### DATABASE ###
# FORMAT: postgresql://{user}:{password}@{host}:{port}/{database}
DATABASE_URL="postgresql://postgres:postgres@remnawave-db:5432/postgres"

### REDIS ###
REDIS_HOST=remnawave-redis
REDIS_PORT=6379

### JWT ###
JWT_AUTH_SECRET=$JWT_AUTH_SECRET
JWT_API_TOKENS_SECRET=$JWT_API_TOKENS_SECRET

### TELEGRAM ###
IS_TELEGRAM_ENABLED=false
TELEGRAM_BOT_TOKEN=
TELEGRAM_ADMIN_ID=
NODES_NOTIFY_CHAT_ID=

### FRONT_END ###
FRONT_END_DOMAIN=$PANEL_DOMAIN

### SUBSCRIPTION PUBLIC DOMAIN ###
### RAW DOMAIN, WITHOUT HTTP/HTTPS, DO NOT PLACE / to end of domain ###
### Used in "profile-web-page-url" response header ###
SUB_PUBLIC_DOMAIN=$SUB_DOMAIN

### SWAGGER ###
SWAGGER_PATH=/docs
SCALAR_PATH=/scalar
IS_DOCS_ENABLED=true

### PROMETHEUS ###
METRICS_USER=$METRICS_USER
METRICS_PASS=$METRICS_PASS

### WEBHOOK ###
WEBHOOK_ENABLED=false
### Only https:// is allowed
WEBHOOK_URL=https://webhook.site/1234567890
### This secret is used to sign the webhook payload, must be exact 64 characters. Only a-z, 0-9, A-Z are allowed.
WEBHOOK_SECRET_HEADER=vsmu67Kmg6R8FjIOF1WUY8LWBHie4scdEqrfsKmyf4IAf8dY3nFS0wwYHkhh6ZvQ

### CLOUDFLARE ###
# USED ONLY FOR docker-compose-prod-with-cf.yml
# NOT USED BY THE APP ITSELF
CLOUDFLARE_TOKEN=ey...

### Database ###
### For Postgres Docker container ###
# NOT USED BY THE APP ITSELF
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
EOL

    cat > docker-compose.yml <<EOL
services:
  remnawave-db:
    image: postgres:17
    container_name: 'remnawave-db'
    hostname: remnawave-db
    restart: always
    env_file:
      - .env
    environment:
      - POSTGRES_USER=\${POSTGRES_USER}
      - POSTGRES_PASSWORD=\${POSTGRES_PASSWORD}
      - POSTGRES_DB=\${POSTGRES_DB}
      - TZ=UTC
    ports:
      - '127.0.0.1:6767:5432'
    volumes:
      - remnawave-db-data:/var/lib/postgresql/data
    networks:
      - remnawave-network
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U \$\${POSTGRES_USER} -d \$\${POSTGRES_DB}']
      interval: 3s
      timeout: 10s
      retries: 3

  remnawave:
    image: remnawave/backend:dev
    container_name: remnawave
    hostname: remnawave
    restart: always
    env_file:
      - .env
    ports:
      - '127.0.0.1:3000:3000'
    networks:
      - remnawave-network
    depends_on:
      remnawave-db:
        condition: service_healthy
      remnawave-redis:
        condition: service_healthy

  remnawave-redis:
    image: valkey/valkey:8.0.2-alpine
    container_name: remnawave-redis
    hostname: remnawave-redis
    restart: always
    networks:
      - remnawave-network
    volumes:
      - remnawave-redis-data:/data
    healthcheck:
      test: [ "CMD", "valkey-cli", "ping" ]
      interval: 3s
      timeout: 10s
      retries: 3

  remnawave-nginx:
    image: nginx:1.27
    container_name: remnawave-nginx
    hostname: remnawave-nginx
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - /etc/letsencrypt/live/$DOMAIN/fullchain.pem:/etc/nginx/ssl/$DOMAIN/fullchain.pem:ro
      - /etc/letsencrypt/live/$DOMAIN/privkey.pem:/etc/nginx/ssl/$DOMAIN/privkey.pem:ro
      - /dev/shm:/dev/shm
      - /var/www/html:/var/www/html:ro
    command: sh -c 'rm -f /dev/shm/nginx.sock && nginx -g "daemon off;"'
    ports:
      - '80:80'
    networks:
      - remnawave-network
    depends_on:
      - remnawave
      - remnawave-subscription-page

  remnawave-subscription-page:
    image: remnawave/subscription-page:latest
    container_name: remnawave-subscription-page
    hostname: remnawave-subscription-page
    restart: always
    environment:
      - REMNAWAVE_PLAIN_DOMAIN=remnawave:3000
      - REQUEST_REMNAWAVE_SCHEME=http
      - SUBSCRIPTION_PAGE_PORT=3010
    ports:
      - '127.0.0.1:3010:3010'
    networks:
      - remnawave-network

  remnanode:
    image: remnawave/node:dev
    container_name: remnanode
    hostname: remnanode
    restart: always
    env_file:
      - .env-node
    ports:
      - '443:443'
    volumes:
      - /dev/shm:/dev/shm
    networks:
      - remnawave-network

networks:
  remnawave-network:
    name: remnawave-network
    driver: bridge
    external: false

volumes:
  remnawave-db-data:
    driver: local
    external: false
    name: remnawave-db-data
  remnawave-redis-data:
    driver: local
    external: false
    name: remnawave-redis-data
EOL

    cat > nginx.conf <<EOL
upstream remnawave {
    server remnawave:3000;
}

upstream json {
    server remnawave-subscription-page:3010;
}

map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ""      close;
}

map \$http_cookie \$auth_cookie {
    default 0;
    "~*${cookies_random1}=${cookies_random2}" 1;
}

map \$arg_${cookies_random1} \$auth_query {
    default 0;
    "${cookies_random2}" 1;
}

map "\$auth_cookie\$auth_query" \$authorized {
    "~1" 1;
    default 0;
}

map \$arg_${cookies_random1} \$set_cookie_header {
    "${cookies_random2}" "${cookies_random1}=${cookies_random2}; Path=/; HttpOnly; Secure; SameSite=Strict; Max-Age=31536000";
    default "";
}

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers on;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m;

ssl_stapling on;
ssl_stapling_verify on;
resolver 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220;

server {
    server_name $PANEL_DOMAIN;
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

    add_header Set-Cookie \$set_cookie_header;

    location ~ ^/api/sub/[^/]+ {
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        error_page 404 =404;
    }

    location = / {
        if (\$authorized = 0) {
            return 302 https://$DOMAIN;
        }
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    location / {
        if (\$authorized = 0) {
            return 302 https://$DOMAIN;
        }
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}

server {
    server_name $SUB_DOMAIN;
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

    add_header Set-Cookie \$set_cookie_header;

     location / {
        proxy_http_version 1.1;
        proxy_pass http://json;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        proxy_intercept_errors on;
        error_page 400 404 500 @redirect;
    }

    location @redirect {
        return 404;
    }
}

server {
    server_name $DOMAIN;
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

    root /var/www/html;
    index index.html;
}

server {
    listen 80 default_server;
    listen [::]:80;
    server_name _;
    return 301 https://\$host\$request_uri;
}

server {
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol default_server;
    server_name _;
    ssl_reject_handshake on;
    return 444;
}
EOL
}

installation() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALLING]}${COLOR_RESET}"
    sleep 1

    install_remnawave

    echo -e "${COLOR_YELLOW}${LANG[CHECK_CERTS]}${COLOR_RESET}"
    sleep 1
    if check_certificates $DOMAIN; then
        echo -e "${COLOR_GREEN}${LANG[CERT_EXIST]}${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}${LANG[CERT_MISSING]}${COLOR_RESET}"
        get_certificates $DOMAIN
    fi

    echo -e "${COLOR_YELLOW}${LANG[STARTING_REMNAWAVE]}${COLOR_RESET}"
    sleep 1
    cd /root/remnawave
    docker compose up -d > /dev/null 2>&1 &
    
    spinner $! "${LANG[WAITING]}"
	
    local domain_url="127.0.0.1:3000"
    local target_dir="/root/remnawave"
    local config_file="$target_dir/config.json"

    echo -e "${COLOR_YELLOW}${LANG[REGISTERING_REMNAWAVE]}${COLOR_RESET}"
    sleep 20
	
    echo -e "${COLOR_YELLOW}${LANG[CHECK_SERVER]}${COLOR_RESET}"
    until curl -s "http://$domain_url/api/auth/register" > /dev/null; do
        echo -e "${COLOR_RED}${LANG[SERVER_NOT_READY]}${COLOR_RESET}"
        sleep 5
    done

    # Register Remnawave
    local token=$(register_remnawave "$domain_url" "$SUPERADMIN_USERNAME" "$SUPERADMIN_PASSWORD" "$PANEL_DOMAIN")
    echo -e "${COLOR_GREEN}${LANG[REGISTRATION_SUCCESS]}${COLOR_RESET}"
	
    # Get public key
    echo -e "${COLOR_YELLOW}${LANG[GET_PUBLIC_KEY]}${COLOR_RESET}"
    sleep 1
    local pubkey=$(get_public_key "$domain_url" "$token" "$PANEL_DOMAIN" "$target_dir")
    echo -e "${COLOR_GREEN}${LANG[PUBLIC_KEY_SUCCESS]}${COLOR_RESET}"

    # Generate Xray keys
    echo -e "${COLOR_YELLOW}${LANG[GENERATE_KEYS]}${COLOR_RESET}"
    sleep 1
    local keys=$(generate_xray_keys)
    local private_key=$(echo "$keys" | awk '{print $1}')
    local public_key=$(echo "$keys" | awk '{print $2}')
    printf "${COLOR_GREEN}${LANG[GENERATE_KEYS_SUCCESS]}${COLOR_RESET}"
    
    # Create and update Xray configuration
    update_xray_config "$domain_url" "$token" "$PANEL_DOMAIN" "$target_dir" "$DOMAIN" "$public_key" "$private_key"
    
    # Create node
    create_node "$domain_url" "$token" "$PANEL_DOMAIN"

    # Get UUID for inbound
    local inbound_uuid=$(get_inbound_uuid "$domain_url" "$token" "$PANEL_DOMAIN")
    echo -e "${COLOR_YELLOW}${LANG[CREATE_HOST]}$inbound_uuid${COLOR_RESET}"

    # Create host
    create_host "$domain_url" "$token" "$PANEL_DOMAIN" "$inbound_uuid" "$DOMAIN"

    # Stop and start Remnawave
    echo -e "${COLOR_YELLOW}${LANG[STOPPING_REMNAWAVE]}${COLOR_RESET}"
    sleep 1
    docker compose down > /dev/null 2>&1 &
    spinner $! "${LANG[WAITING]}"
	
    echo -e "${COLOR_YELLOW}${LANG[STARTING_REMNAWAVE]}${COLOR_RESET}"
    sleep 1
    docker compose up -d > /dev/null 2>&1 &
    spinner $! "${LANG[WAITING]}"

    clear

    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[INSTALL_COMPLETE]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PANEL_ACCESS]}${COLOR_RESET}"
    echo -e "${COLOR_WHITE}https://${PANEL_DOMAIN}/auth/login?${cookies_random1}=${cookies_random2}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[ADMIN_CREDS]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[USERNAME]} ${COLOR_WHITE}$SUPERADMIN_USERNAME${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PASSWORD]} ${COLOR_WHITE}$SUPERADMIN_PASSWORD${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[RELAUNCH_CMD]}${COLOR_RESET}"
    echo -e "${COLOR_WHITE}remnawave_reverse${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"

    randomhtml
}

install_remnawave_panel() {
    mkdir -p ~/remnawave && cd ~/remnawave

    reading "${LANG[ENTER_PANEL_DOMAIN]}" PANEL_DOMAIN
    reading "${LANG[ENTER_SUB_DOMAIN]}" SUB_DOMAIN
    reading "${LANG[ENTER_NODE_DOMAIN]}" SELFSTEAL_DOMAIN

    DOMAIN=$(extract_domain $PANEL_DOMAIN)

    SUPERADMIN_USERNAME=$(generate_user)
    SUPERADMIN_PASSWORD=$(generate_password)

    cookies_random1=$(generate_user)
    cookies_random2=$(generate_user)

    METRICS_USER=$(generate_user)
    METRICS_PASS=$(generate_user)

    JWT_AUTH_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)
    JWT_API_TOKENS_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)

    cat > .env <<EOL
### APP ###
APP_PORT=3000
METRICS_PORT=3001

### API ###
# Possible values: max (start instances on all cores), number (start instances on number of cores), -1 (start instances on all cores - 1)
# !!! Do not set this value more that physical cores count in your machine !!!
API_INSTANCES=1

### DATABASE ###
# FORMAT: postgresql://{user}:{password}@{host}:{port}/{database}
DATABASE_URL="postgresql://postgres:postgres@remnawave-db:5432/postgres"

### REDIS ###
REDIS_HOST=remnawave-redis
REDIS_PORT=6379

### JWT ###
JWT_AUTH_SECRET=$JWT_AUTH_SECRET
JWT_API_TOKENS_SECRET=$JWT_API_TOKENS_SECRET

### TELEGRAM ###
IS_TELEGRAM_ENABLED=false
TELEGRAM_BOT_TOKEN=
TELEGRAM_ADMIN_ID=
NODES_NOTIFY_CHAT_ID=

### FRONT_END ###
FRONT_END_DOMAIN=$PANEL_DOMAIN

### SUBSCRIPTION PUBLIC DOMAIN ###
### RAW DOMAIN, WITHOUT HTTP/HTTPS, DO NOT PLACE / to end of domain ###
### Used in "profile-web-page-url" response header ###
SUB_PUBLIC_DOMAIN=$SUB_DOMAIN

### SWAGGER ###
SWAGGER_PATH=/docs
SCALAR_PATH=/scalar
IS_DOCS_ENABLED=true

### PROMETHEUS ###
METRICS_USER=$METRICS_USER
METRICS_PASS=$METRICS_PASS

### WEBHOOK ###
WEBHOOK_ENABLED=false
### Only https:// is allowed
WEBHOOK_URL=https://webhook.site/1234567890
### This secret is used to sign the webhook payload, must be exact 64 characters. Only a-z, 0-9, A-Z are allowed.
WEBHOOK_SECRET_HEADER=vsmu67Kmg6R8FjIOF1WUY8LWBHie4scdEqrfsKmyf4IAf8dY3nFS0wwYHkhh6ZvQ

### CLOUDFLARE ###
# USED ONLY FOR docker-compose-prod-with-cf.yml
# NOT USED BY THE APP ITSELF
CLOUDFLARE_TOKEN=ey...

### Database ###
### For Postgres Docker container ###
# NOT USED BY THE APP ITSELF
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
EOL

    cat > docker-compose.yml <<EOL
services:
  remnawave-db:
    image: postgres:17
    container_name: 'remnawave-db'
    hostname: remnawave-db
    restart: always
    env_file:
      - .env
    environment:
      - POSTGRES_USER=\${POSTGRES_USER}
      - POSTGRES_PASSWORD=\${POSTGRES_PASSWORD}
      - POSTGRES_DB=\${POSTGRES_DB}
      - TZ=UTC
    ports:
      - '127.0.0.1:6767:5432'
    volumes:
      - remnawave-db-data:/var/lib/postgresql/data
    networks:
      - remnawave-network
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U \$\${POSTGRES_USER} -d \$\${POSTGRES_DB}']
      interval: 3s
      timeout: 10s
      retries: 3

  remnawave:
    image: remnawave/backend:dev
    container_name: remnawave
    hostname: remnawave
    restart: always
    env_file:
      - .env
    ports:
      - '127.0.0.1:3000:3000'
    networks:
      - remnawave-network
    depends_on:
      remnawave-db:
        condition: service_healthy
      remnawave-redis:
        condition: service_healthy

  remnawave-redis:
    image: valkey/valkey:8.0.2-alpine
    container_name: remnawave-redis
    hostname: remnawave-redis
    restart: always
    networks:
      - remnawave-network
    volumes:
      - remnawave-redis-data:/data
    healthcheck:
      test: [ "CMD", "valkey-cli", "ping" ]
      interval: 3s
      timeout: 10s
      retries: 3

  remnawave-nginx:
    image: nginx:1.27
    container_name: remnawave-nginx
    hostname: remnawave-nginx
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - /etc/letsencrypt/live/$DOMAIN/fullchain.pem:/etc/nginx/ssl/$DOMAIN/fullchain.pem:ro
      - /etc/letsencrypt/live/$DOMAIN/privkey.pem:/etc/nginx/ssl/$DOMAIN/privkey.pem:ro
    network_mode: host
    depends_on:
      - remnawave
      - remnawave-subscription-page

  remnawave-subscription-page:
    image: remnawave/subscription-page:latest
    container_name: remnawave-subscription-page
    hostname: remnawave-subscription-page
    restart: always
    environment:
      - REMNAWAVE_PLAIN_DOMAIN=remnawave:3000
      - REQUEST_REMNAWAVE_SCHEME=http
      - SUBSCRIPTION_PAGE_PORT=3010
    ports:
      - '127.0.0.1:3010:3010'
    networks:
      - remnawave-network

networks:
  remnawave-network:
    name: remnawave-network
    driver: bridge
    external: false

volumes:
  remnawave-db-data:
    driver: local
    external: false
    name: remnawave-db-data
  remnawave-redis-data:
    driver: local
    external: false
    name: remnawave-redis-data
EOL

    cat > nginx.conf <<EOL
upstream remnawave {
    server 127.0.0.1:3000;
}

upstream json {
    server 127.0.0.1:3010;
}

map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ""      close;
}

map \$http_cookie \$auth_cookie {
    default 0;
    "~*${cookies_random1}=${cookies_random2}" 1;
}

map \$arg_${cookies_random1} \$auth_query {
    default 0;
    "${cookies_random2}" 1;
}

map "\$auth_cookie\$auth_query" \$authorized {
    "~1" 1;
    default 0;
}

map \$arg_${cookies_random1} \$set_cookie_header {
    "${cookies_random2}" "${cookies_random1}=${cookies_random2}; Path=/; HttpOnly; Secure; SameSite=Strict; Max-Age=31536000";
    default "";
}

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers on;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m;

ssl_stapling on;
ssl_stapling_verify on;
resolver 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220;

server {
    server_name $PANEL_DOMAIN;
    listen 443 ssl;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

    add_header Set-Cookie \$set_cookie_header;

    location ~ ^/api/sub/[^/]+ {
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        error_page 404 =404;
    }

    location = / {
        if (\$authorized = 0) {
            return 404;
        }
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    location / {
        if (\$authorized = 0) {
            return 404;
        }
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}

server {
    server_name $SUB_DOMAIN;
    listen 443 ssl;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

     location / {
        proxy_http_version 1.1;
        proxy_pass http://json;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        proxy_intercept_errors on;
        error_page 400 404 500 @redirect;
    }

    location @redirect {
        return 404;
    }
}

server {
    listen 443 ssl default_server;
    server_name _;
    ssl_reject_handshake on;
}
EOL
}

installation_panel() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALLING]}${COLOR_RESET}"
    sleep 1

    install_remnawave_panel

    echo -e "${COLOR_YELLOW}${LANG[CHECK_CERTS]}${COLOR_RESET}"
    sleep 1
    if check_certificates $DOMAIN; then
        echo -e "${COLOR_YELLOW}${LANG[CERT_EXIST]}${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}${LANG[CERT_MISSING]}${COLOR_RESET}"
        get_certificates $DOMAIN
    fi

    echo -e "${COLOR_YELLOW}${LANG[STARTING_REMNAWAVE]}${COLOR_RESET}"
    sleep 1
    cd /root/remnawave
    docker compose up -d > /dev/null 2>&1 &
    
    spinner $! "${LANG[WAITING]}"

    echo -e "${COLOR_YELLOW}${LANG[REGISTERING_REMNAWAVE]}${COLOR_RESET}"
    sleep 20
	
    local domain_url="127.0.0.1:3000"
    echo -e "${COLOR_YELLOW}${LANG[CHECK_SERVER]}${COLOR_RESET}"
    until curl -s "http://$domain_url/api/auth/register" > /dev/null; do
        echo -e "${COLOR_RED}${LANG[SERVER_NOT_READY]}${COLOR_RESET}"
        sleep 5
    done

    # Register Remnawave
    local token=$(register_remnawave "$domain_url" "$SUPERADMIN_USERNAME" "$SUPERADMIN_PASSWORD" "$PANEL_DOMAIN")
    echo -e "${COLOR_GREEN}${LANG[REGISTRATION_SUCCESS]}${COLOR_RESET}"
	
    # Generate Xray keys
    echo -e "${COLOR_YELLOW}${LANG[GENERATE_KEYS]}${COLOR_RESET}"
    sleep 1
    local keys=$(generate_xray_keys)
    local private_key=$(echo "$keys" | awk '{print $1}')
    local public_key=$(echo "$keys" | awk '{print $2}')
    printf "${COLOR_GREEN}${LANG[GENERATE_KEYS_SUCCESS]}${COLOR_RESET}"

    # Create and update Xray configuration
    update_xray_config "$domain_url" "$token" "$PANEL_DOMAIN" "$target_dir" "$SELFSTEAL_DOMAIN" "$public_key" "$private_key"
    
    # Create node
    create_node "$domain_url" "$token" "$PANEL_DOMAIN" "$SELFSTEAL_DOMAIN"

    # Get UUID for inbound
    local inbound_uuid=$(get_inbound_uuid "$domain_url" "$token" "$PANEL_DOMAIN")
    echo -e "${COLOR_YELLOW}${LANG[CREATE_HOST]}$inbound_uuid${COLOR_RESET}"

    # Create host
    create_host "$domain_url" "$token" "$PANEL_DOMAIN" "$inbound_uuid" "$SELFSTEAL_DOMAIN"

    #clear

    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_RED}${LANG[POST_PANEL_MESSAGE]}${COLOR_RESET}"
    echo -e "${COLOR_RED}${LANG[POST_PANEL_INSTRUCTION]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PANEL_ACCESS]}${COLOR_RESET}"
    echo -e "${COLOR_WHITE}https://${PANEL_DOMAIN}/auth/login?${cookies_random1}=${cookies_random2}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[ADMIN_CREDS]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[USERNAME]} ${COLOR_WHITE}$SUPERADMIN_USERNAME${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PASSWORD]} ${COLOR_WHITE}$SUPERADMIN_PASSWORD${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
}

install_remnawave_node() {
    mkdir -p ~/remnawave && cd ~/remnawave

    reading "${LANG[SELFSTEAL]}" SELFSTEAL_DOMAIN
    
    while true; do
        reading "${LANG[PANEL_IP_PROMPT]}" PANEL_IP
        if echo "$PANEL_IP" | grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' >/dev/null && \
           [[ $(echo "$PANEL_IP" | tr '.' '\n' | wc -l) -eq 4 ]] && \
           [[ ! $(echo "$PANEL_IP" | tr '.' '\n' | grep -vE '^[0-9]{1,3}$') ]] && \
           [[ ! $(echo "$PANEL_IP" | tr '.' '\n' | grep -E '^(25[6-9]|2[6-9][0-9]|[3-9][0-9]{2})$') ]]; then
            break
        else
            echo -e "${COLOR_RED}${LANG[IP_ERROR]}${COLOR_RESET}"
        fi
    done

    echo -e "${COLOR_YELLOW}${LANG[CERT_PROMPT]}${COLOR_RESET}"
    CERTIFICATE=""
    while IFS= read -r line; do
        if [ -z "$line" ]; then
            if [ -n "$CERTIFICATE" ]; then
                break
            fi
        else
            CERTIFICATE="$CERTIFICATE$line\n"
        fi
    done

    echo -e "${COLOR_YELLOW}${LANG[CERT_CONFIRM]}${COLOR_RESET}"
    read confirm
    echo

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${COLOR_RED}${LANG[ABORT_MESSAGE]}${COLOR_RESET}"
        exit 1
    fi

cat > .env-node <<EOL
### APP ###
APP_PORT=2222

### XRAY ###
$(echo -e "$CERTIFICATE" | sed 's/\\n$//')
EOL

    DOMAIN=$(extract_domain $SELFSTEAL_DOMAIN)

cat > docker-compose.yml <<EOL
services:
  remnawave-nginx:
    image: nginx:1.27
    container_name: remnawave-nginx
    hostname: remnawave-nginx
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - /etc/letsencrypt/live/$DOMAIN/fullchain.pem:/etc/nginx/ssl/$DOMAIN/fullchain.pem:ro
      - /etc/letsencrypt/live/$DOMAIN/privkey.pem:/etc/nginx/ssl/$DOMAIN/privkey.pem:ro
      - /dev/shm:/dev/shm
      - /var/www/html:/var/www/html:ro
    command: sh -c 'rm -f /dev/shm/nginx.sock && nginx -g "daemon off;"'
    network_mode: host
    depends_on:
      - remnanode

  remnanode:
    image: remnawave/node:dev
    container_name: remnanode
    hostname: remnanode
    restart: always
    network_mode: host
    env_file:
      - path: /root/remnawave/.env-node
        required: false
    volumes:
      - /dev/shm:/dev/shm
EOL

    cat > nginx.conf <<EOL
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ""      close;
}

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers on;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m;

ssl_stapling on;
ssl_stapling_verify on;
resolver 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220;

server {
    server_name $SELFSTEAL_DOMAIN;
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$DOMAIN/fullchain.pem";

    root /var/www/html;
    index index.html;
}

server {
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol default_server;
    server_name _;
    ssl_reject_handshake on;
    return 444;
}
EOL
}

installation_node() {

echo -e "${COLOR_YELLOW}${LANG[INSTALLING]}${COLOR_RESET}"
    sleep 1

    install_remnawave_node

    ufw allow from $PANEL_IP to any port 2222 

    echo -e "${COLOR_YELLOW}${LANG[CHECK_CERTS]}${COLOR_RESET}"
    sleep 1
    if check_certificates $DOMAIN; then
        echo -e "${COLOR_YELLOW}${LANG[CERT_EXIST]}${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}${LANG[CERT_MISSING]}${COLOR_RESET}"
        get_certificates $DOMAIN
    fi

    echo -e "${COLOR_YELLOW}${LANG[STARTING_REMNAWAVE]}${COLOR_RESET}"
    sleep 3
    cd /root/remnawave
    docker compose up -d > /dev/null 2>&1 &
    
    spinner $! "${LANG[WAITING]}"

    randomhtml

    echo -e "${COLOR_GREEN}${LANG[SUCCESS_MESSAGE]}${COLOR_RESET}"
}

log_entry
check_root
check_os
update_remnawave_reverse

show_language
reading "Choose option (1-2):" LANG_OPTION

case $LANG_OPTION in
    1) set_language en ;;
    2) set_language ru ;;
    *) error "Invalid choice. Please select 1-2." ;;
esac

show_menu
reading "${LANG[PROMPT_ACTION]}" OPTION

case $OPTION in
    1)
        if [ ! -f ${DIR_REMNAWAVE}install_packages ]; then
            install_packages
        fi
        installation
        log_clear
        ;;
    2)
        if [ ! -f ${DIR_REMNAWAVE}install_packages ]; then
            install_packages
        fi
        installation_panel
        log_clear
        ;;
    3)
        if [ ! -f ${DIR_REMNAWAVE}install_packages ]; then
            install_packages
        fi
        installation_node
        log_clear
        ;;
    4)
        reinstall_remnawave
        choose_reinstall_type
        log_clear
        ;;
    5)
        randomhtml
        log_clear
        ;;
    6)
        echo -e "${COLOR_YELLOW}${LANG[EXITING]}${COLOR_RESET}"
        exit 0
        ;;
    *)
        echo -e "${COLOR_YELLOW}${LANG[INVALID_CHOICE]}${COLOR_RESET}"
        exit 1
        ;;
esac
exit 0
