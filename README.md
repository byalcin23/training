

# DEVOPS

Goal: Spring boot,minikube ve ingress kullanarak bir web sunucusu oluşturma.
DEVOPS dir'in altında bulunan **web1**  **web2** projeleri spring boot ile oluşturulmuştur.
Projeler içerisinde Dockerfile' lar hazırlanmıştır.

İlerleyen aşamalarda minukube kullanacağımız için docker image'leri docker hub'ıma upload ettim.
- **Start**
 > docker build -t bahadir23/vodafone:web1 ./web1 .
 > docker build -t bahadir23/vodafone:web2 ./web2 .

- **Eğer test etmekj istenir ise aşağıdaki gibi testler gerçekleştirilebilir.**

>docker run -p 8080:8080 bahadir23/vodafone:web1
>curl -k http://localhost:8080

- **Minikube**
Projede k8s olarak minikube cluster kullandım.
 [Minikube kurulumunu](https://minikube.sigs.k8s.io/docs/start/) bu link üzerinden gerçekleştirebilirsiniz.
 Ben local kurulum yerine kolay ve hızlı olan  [Katacoda](https://www.katacoda.com/ )  yı tercih ettim. 
 Online olarak minikube bash ile çalışabiliyorsunuz.
 
Gerekli kurulumlar gerçekleştikten sonra :
- Minikube ingress aktive etme
> minikube addons enable ingress 
- Minikube deployment oluşturma 
> kubectl create deployment web1 --image=bahadir23/vodafone:web1
> kubectl create deployment web2 --image=bahadir23/vodafone:web2

- Minikube port expose ederek projeyi ayağa kaldırma
> kubectl expose deployment web1 --type=NodePort --port=8080 
> kubectl expose deployment web2 --type=NodePort --port=8080 
> 
- Projeler 8080 portundan web yayını yapmaktadır ve son adım olarak ingress e geçiyoruz.

### İngress conf

- İngress conf aktif edilmesi
> kubectl apply -f  ingress.yaml

### Test 
- Service url  
> kubectl get service web1 
> kubectl get service web2

> curl -k <service_url>
> curl -k <service_url>/v2

"Greetings from Spring Boot!"     Ve   "Greetings from Spring Boot! web2"
şeklinde response alabilirsiniz.
#### Not
Yeni şeyler öğrenmek gerçekten çok güzel :)).
Projede CI/CD tarafı için jenkins kullanmam gerekirken gitlab kullanmayı tercih ettim.
[gitlab-ci.yml 'a](https://github.com/byalcin23/training/blob/main/DEVOPS/gitlab-ci.yml "gitlab-ci.yml") buradan ulaşabilirsiniz
Projeyi internet ortamına açmam için sunucum olmadığından yerleştiremedim.


# MONGO SQL
[MongoD.sql](https://github.com/byalcin23/training/blob/main/MONGO/MongoD.sql "MongoD.sql") Buradan ulaşabilirsiniz.

# ORACLE SQL
[ORACLE.sql](https://github.com/byalcin23/training/blob/main/ORACLE/ORACLE.sql "ORACLE.sql") Buradam ulaşabilirsiniz.

# SHELL SCRIPTING
- Tasks:
1-Write a shell script which write "Hello world" for every 10 seconds into a temp file (hello.txt) 
2-Run sh as a daemon process. 
3-Write another shell script to check the count of records in hello.txt, if total count is equal 10 then kill the first sh, delete the temp file and run first sh again.
- Done
 1) [Shell.sh](https://github.com/byalcin23/training/blob/main/SHELL_SCRIPTING/Shell.sh "Shell.sh")
 2)  setsid ./Shell.sh > output.log 2>&1 < output.log &
 3) [Shell_Checker.sh](https://github.com/byalcin23/training/blob/main/SHELL_SCRIPTING/Shell_Checker.sh "Shell_Checker.sh")
4) [crontab.txt](https://github.com/byalcin23/training/blob/main/SHELL_SCRIPTING/crontab.txt "crontab.txt")

#### Not
Crontab minumum 1 dakika interval ile çalıştığı için her dakika çalışıcak şekilde ayarlandı.
Fakat [Shell.sh](https://github.com/byalcin23/training/blob/main/SHELL_SCRIPTING/Shell.sh "Shell.sh") her 10 saniyede bir işlem yaptığı için satır sayısı 10 olduğunda 100 saniye geçmiş oluyordu ve cron 60 saniyede bir devreye girdiği için satır sayısının 10 sayısına eşit olduğunu doğrulayamıyordu.
Bu yüzden [Shell_Checker.sh](https://github.com/byalcin23/training/blob/main/SHELL_SCRIPTING/Shell_Checker.sh "Shell_Checker.sh") içerisine 30 kere 2 saniye bekleme şeklinde for döngüsü eklenmiştir.
***Sonuç olarak***
Her dakika tetiklenen cron  loop sayesinde her 2 saniyede bir  hello.txt dosyasını kontrol ediyor.


flow chart:

```mermaid
graph LR
A[Shell.sh] -- Every 10 seconds write  hello world to file --> B((hello.txt))
C(Cron every min)
C--> D ;
D[Shell_Checker.sh]
D--Check every 2 sec-->B


```
