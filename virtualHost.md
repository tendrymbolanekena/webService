TODO – Configuration VirtualHost CDN avec XAMPP
Objectif

Configurer un VirtualHost Apache avec XAMPP pour accéder aux fichiers stockés dans :

```text
/usr/local/cdn
```

Le serveur CDN sera accessible via :

```text
http://cdn.local:8101
```

Exemple d'image :

```text
http://cdn.local:8101/patient/2/qrcode/2-patient.jpg
```
1. Vérifier le répertoire CDN
```bash
ls -la /usr/local/cdn
```

Structure :

```text
/usr/local/cdn/
└── patient/
    └── 2/
        └── qrcode/
            └── 2-patient.jpg
```
2. Configurer les permissions
```bash
sudo chmod 755 /usr/local/cdn
sudo chmod 755 /usr/local/cdn/patient
```

Vérifier que les autres sous-répertoires et fichiers sont accessibles en lecture par Apache.

3. Configurer le port 8101 dans XAMPP

Ouvrir :

```bash
sudo nano /opt/lampp/etc/httpd.conf
```

Ajouter :

```apache
Listen 8101
```

Conserver également :

```apache
Listen 80
```
4. Activer la configuration des VirtualHosts

Dans le fichier :

```bash
sudo nano /opt/lampp/etc/httpd.conf
```

Vérifier que cette ligne est activée :

```apache
Include etc/extra/httpd-vhosts.conf
```

Ne pas mettre # devant cette directive.

5. Créer le VirtualHost CDN

Ouvrir :

```bash
sudo nano /opt/lampp/etc/extra/httpd-vhosts.conf
```

Ajouter :

```apache
<VirtualHost *:8101>

    ServerName cdn.local

    DocumentRoot "/usr/local/cdn"

    <Directory "/usr/local/cdn">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog "logs/cdn_error.log"
    CustomLog "logs/cdn_access.log" combined

</VirtualHost>
```
6. Configurer le fichier hosts

Ouvrir :

```bash
sudo nano /etc/hosts
```

Ajouter :

```text
127.0.0.1 cdn.local
```
7. Vérifier que le port 8101 est disponible
```bash
sudo ss -ltnp | grep ':8101'
```

Si aucun processus n'utilise ce port, il est disponible.

8. Redémarrer XAMPP
```bash
sudo /opt/lampp/lampp restart
```
9. Tester le VirtualHost

Tester l'accès au serveur :

```bash
curl -I http://cdn.local:8101/
```

Tester directement une image :

```bash
curl -I http://cdn.local:8101/patient/2/qrcode/2-patient.jpg
```

Résultat attendu :

```text
HTTP/1.1 200 OK
```
10. Accès depuis le navigateur

URL du CDN :

```text
http://cdn.local:8101
```

URL de l'image :

```text
http://cdn.local:8101/patient/2/qrcode/2-patient.jpg
```

Configuration finale
Paramètre	Valeur
Serveur Web	Apache XAMPP
Répertoire CDN	/usr/local/cdn
```
Port	8101
VirtualHost	cdn.local
URL CDN	http://cdn.local:8101
Dossier des QR Codes	/usr/local/cdn/patient/2/qrcode/
Maintenance
```

Pour redémarrer XAMPP :

```bash
sudo /opt/lampp/lampp restart
```

Pour vérifier son état :

```bash
sudo /opt/lampp/lampp status
```

Pour consulter les erreurs Apache :

```bash
sudo tail -f /opt/lampp/logs/error_log
```

A autoriser 

```bash
 sudo ufw allow 8101/tcp
```