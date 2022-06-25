## Task3
### Шаг 1 (Читаю задание и понимаю структуру работы)
,,,,,,,,,,,,,,,,,,,,,,,,,,
### Шаг 2 (приступаю к созданию Vpc) vpc.tf
1. resource "aws_vpc" "terra_vpc" - создаю vpc так как он мне нужен дальше для всего:)
  cidr_block = var.vpc_cidr - указан в исходном файле variables.tf
следующие две команды дают возможность хостам получать имена, а не ip-шники
  enable_dns_hostnames = true 
  enable_dns_support   = true

2. resource "aws_internet_gateway" "terra_igw" - нужен для доступа в интернет и из интеренета к публичным сетям, которые имеют публичные ip-шники
тут все стандартно

3. resource "aws_subnet" "public" и resource "aws_subnet" "private"
тут я создаю нужные мне подсети, а так же присваивать им имена по следующему шаблону: Name = "Subnet-public-${count.index+1}"
availability_zone = element(var.azs,count.index) - выбираю в таком же порядке как и заданы сабнеты (element - выбор элемента из массива по его номеру)
cidr_block = element(var.subnets_cidr,count.index) - аналогично предыдущему 
map_public_ip_on_launch = true - позволяет сразу же назначать публичные ip адреса 

для приватной все так же только в 37 строке не назначаем публичный адрес: map_public_ip_on_launch = false

4. resource "aws_route_table" "public_rt"
по дефолту подсети имеют маршруты только внутри vpc, соответственно, если я собираюсь разрешить публичной 
сети доступ в интернет я должен добавить нулевой маршрут через internet_gateway. собственно, с 43 про 53 строчку я это и делаю

5. resource "aws_route_table_association" "a"
ну и после создания таблицы маршрутизации надо назначить ее подсетям , что я тут и делаю
просто выбирая паблик сабнет и таблицу с созданием зависимости от vpc

собственно, я с этим разобрался, запустил, создал сеть, дальше я уже стал разрабатывать слудующие элементы

### Шаг 3 (Security Groups) security.tf
1. так как у меня уже была запущена сеть то сработал закомментированны вариант
находил себе подсети, фильтровал по тагам и перебирая их находил их cidr
``` 
# data "aws_subnets" "selected" {
#  filter {
#     name   = "tag:Name"
#     values = local.subnet_list
#   }
#   depends_on=[aws_subnet.public,aws_subnet.private]
# }

# data "aws_subnet" "subnet" {
#   for_each = toset(data.aws_subnets.selected.ids)
#   id = each.value
#   depends_on=[data.aws_subnets.selected]
# }

# locals {
#   subnet_cidrs = [for s in data.aws_subnet.subnet : s.cidr_block]
# } 
```
2. resource "aws_security_group" "Security_Group_Public" и resource "aws_security_group" "Security_Group_Private"
в Security_Group_Public вообще ничего интересного, все чисто по заданию (как я понимаю там кроме моего есть еще несколько варинтов как создать, но я остановился на этом)

в Security_Group_Private тоже все по заданию, но изначально,вместо security_groups = [aws_security_group.Security_Group_Public.id] 
было cidr_blocks = local.subnet_cidrs собственно варианты для экстра и мэин частей задания соответственно 

3. locals {
  subnet_list = [var.subnet_Ubuntu, var.subnet_CentOS]
  subnet_cidrs = [for subnet in flatten([aws_subnet.public,aws_subnet.private]) : subnet.cidr_block if contains(local.subnet_list, lookup(subnet.tags,"Name","Not Found")) ] 
}
но, конечно же тут самое интересное - это эти 4 строчки или же 6 часов разборок с синтаксисом(flatten,toset,tolist......)
но в итоге понял, что надо именно через flatten чтобы получить массив без вложенных масивов 

собственно, Security_Group у меня создаются, так что перехожу на создание Ubuntu

### Шаг 4 Ubuntu ubuntu.tf и userdata_ubuntu.sh
1. для начала, зная что нужен userdata_ubuntu скрипт, взял его из второго таска, выкинул ненужные части и добавил пару команд для докера в конце (81-107 строки)
2. теперь скрипт для того чтобы задеплоить саму машину
resource "aws_instance" "ubuntu"
тут изначально ami был просто id-шником, нашел просто подходящий по запросу "ami aws ubuntu", но потом я сделал ссылку на этот имэдж, 
потом вспомнил о SSH ключе и вспомнил что у меня приватный ключ остался на компе после второго таска 
так что я просто вытащил его публичную часть через PyTTygen и засунул сюда в key_pair.tf запустил, проверил, ключ есть - все супер
3. возращаемся к убунту instance_type = "t2.micro"
  key_name= aws_key_pair.my.key_name - ключ прописал как ссылку на ресурс из key_pair.tf
  count = 1 - колличесто инстансов 
  vpc_security_group_ids = [aws_security_group.Security_Group_Public.id] - ссылка на security_group для убунты 
  
  user_data = "${file("userdata_ubuntu.sh")}" - нашел как включить скрипт через файл 
  subnet_id = data.aws_subnet.ubuntu_subnet.id - тут поиск сабнета через дата блок(строчки 22-32) 
  там просто фильтрация сабнетов по тегу. там variables.tf просто указанно название сабнетаю. 
  там еще depends_on в дата блоке есть, это чтобы запускался точно когда сабнеты уже созданы 
  соответственно, чтобы по тегу сабнет точно нашелся 
 
 ### Шаг 5 CentOS
 1.ну, по факту все то же что и у убунтой только поменял название сабнета(строка 29) 
 ami просто загуглил 
 ключ тот же 
 и security_group приватный, который создавал для центоса

 потом, начав делать экстра нашел как получить инфу про имэдж через cli
 команда aws ec2 describe-images --ids и подставил айдишник убунты 
 получил инфу о имедже(название, архитектура....)
 нагуглил дальше структуру с фильтрами(та что в начале ubuntu.tf и centos.tf)
 а дальше по имени использовал regex, ну а чтобы немного упорядочить этот regex, 
 чтобы не хардкодить сделал такой вот мэп в variables.tf(строки 38-41)  P.S. снова кучка часов на это ушло 

### Шаг 6 Extra
для этой части решил использовать packer так как доступ в интерент у центоса нет, то пакеты надо поставить зарание, до запуска инстанса 
можно было конечно и руками, но сделал через packer(решил попутно посмотреть как это) 
у меня винда, так что запуск пакера только через докер был возможен
docker desktop у меня установлен(я студент так что нет проблем с лицензией) 
завел в iam пользователя админа и дал ему только програмный доступ
папка Task3/packer - пробрасывается в докер как mount и файлы из нее доступны внутри контейнера пакера
все команды запуска записанны в packer-docker-deskrtop.bat
перед запуском этого файла надо сделать 
set AWS_ACCESS_KEY_ID=< AWS_ACCESS_KEY_ID>
set AWS_SECRET_ACCESS_KEY=< AWS_ACCESS_KEY_ID>
центос я сразу запустил в aws с интернетом, нашел как поставить nginx, выполнил эти команды 
было проблема с установкой из еpеl репозитория заработало только после команды yum find nginx (убитые N часов)
конфигурацию для nginx выполнил примерно как и для apache и столкнулся с selinux для кaталога /var/www/ 
нагуглил команду которая востановила лэйбэлинг. после, УРА, все заработало.
все команды есть в init.sh 
ну и в конце поменял security_group для соответствия экстар таску 
у убунты все по прежнему(в плане что это группа только для убунты, без варинта добавления других машин), 
а для центоса теперь вместо cidr ставлю security_group убунты. разрешая трафик только из этой security_group
ну и добавил свою же security_group центосу в рулы 
после рапуска выяснилось что надо было добавить в centos_userdata следующие команды 
```
systemctl enable nginx
systemctl start nginx
```
что я и сделал 
скриншоты тут [скрины](Task3/images)

извиняюсь что без ссылок на файлы и конкретные строки, устал уже слишком, может потом доделаю красоту)
