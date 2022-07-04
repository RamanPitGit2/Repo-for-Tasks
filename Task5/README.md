## Task5
Использовал AWS cloud 

### Шаг1
желаемая инфраструктура: 
- 3 виртуальные машины t2.micro
- ОС Ubuntu
- ОС содержит пользователя ansible и ubuntu
- пользоватеь ansible может выполнять команды sudo без пароля
- одна машина из 3 - master node. Пользователь ansible этой машины может подключаться по SSH с использованием ключа без пароля к другим нодам и к своей машине 

### Реализация 
- сгенирировал SSH для пользователя ansible и сохранил его локально 
- создал userdata в cloud-init формате для мастер ноды [userdata_ubuntu_master](terraform/userdata_ubuntu_master); публичный SSH ключ из первого пункта добавил в ssh_authorized_keys
- создал userdata в cloud-init формате для нод [userdata_ubuntu](terraform/userdata_ubuntu); публичный SSH ключ из первого пункта добавил в ssh_authorized_keys
- написал [terraform скрипт](terraform) и запустил его для деплоймента инфраструктуры 
- зашел на мастер ноду по SSH под пользователем ubuntu. Переключился на пользователя ansible командой
```
sudo su - ansible
```
- создал файл .ssh/id_rsa и поместил туда приватный ключ. Поменял права командой 
```
chmod 600 .ssh/id_rsa
```
- посмотрел приватный ip всех инстансов и по очереди подключился к ним по SSH, таким образом файл known_hosts заполнился  
- создал структуру для [playbook](playbook)
- создал [inventory](playbook/inventory/hosts.yaml)
- сгрупировал хосты в группы linux и docker 
- для группы linux добавил [параметры подключения](playbook/inventory/group_vars/linux.yaml)

### Шаг2
- проверил inventory
```
git clone https://github.com/RamanPitGit2/Repo-for-Tasks.git
cd Repo-for-Tasks/playbook
ansible-inventory -i inventory --list --vars
ansible -i inventory all -m ping 
ansible -i inventory docker -m ping 
```

### Шаг3
решил что playbook будет с использованием ролей
- создал структуру для [роли docker](playbook/roles/docker/)
- в секцию files добавил скрипт для установки докера из предыдущих заданий 
- в [основном таске](playbook/roles/docker/tasks/main.yml) сделал выбор файла с тасками в зависимости от ОС 
- написал [файл с тасками для ubuntu](playbook/roles/docker/tasks/docker-task-Ubuntu.yml), который вызывает скрипт для установки docker
- добавил в [основной таск](playbook/roles/docker/tasks/main.yml) проверку наличия пакета docker-ce, файлы дял ос не вполняются, если пакет установлен
- запустил [playbook](playbook/docker.yaml)
```
ansible-playbook -i inventory docker.yaml
```

### Шаг4-5 Extra1/Extra2
- решил что буду устанавливать приложения через docker compose
- решил устанавливать LAMP и нашел репозиторий для docker compose -> [https://github.com/sprintcube/docker-compose-lamp.git](https://github.com/sprintcube/docker-compose-lamp.git)
- переделал его, протестировал вручную на ноде, запаковал в [архив](playbook/roles/LAMP/files/LAMP.tgz) и добавил в роль [LAMP](playbook/roles/LAMP)
- структура LAMP роли такая же как и у docker роли
- пароли определил как [переменные](playbook/roles/LAMP/defaults/main.yml) но значения для переменных беруться из enviroment пользователя ansible на главной ноде 
- создал новый [playbook](playbook/lamp.yaml) в который добавил 2 роли 
- запустил командой 
```
ansible-playbook -i inventory lamp.yaml
```

### Шаг6 
- создал в IAM роль с доступом только для чтения ресурсов EC2
- назначил эту роль мастер инстансу дял доступа к AWS без ключей 
- установил плагин для inventory на мастер ноде
```
ansible-galaxy collection install amazon.aws
```
- установил зависимости 
```
pip3 install boto3 botocore
```
- написал [inventory config file](playbook/inventory_aws_ec2.yml)
- добавил фильтр для поиска только запущенных инстансов 
- назначил ansible_host = private ip
- проверил inventory командой 
```
ansible-inventory -i inventory_aws_ec2.yml --list
```