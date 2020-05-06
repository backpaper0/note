# Jamesで自己署名証明書を用いてSMTP・POP3をSSLに乗せるメモ

Androidさんからのメール送信的なアレを確認するため。apache-james-2.3.2で試しました。

まず`apps/james.sar`を解凍。

次に`apps/james/SAR-INF/config.xml`を編集。

```diff
diff --git a/apps/james/SAR-INF/environment.xml b/apps/james/SAR-INF/environment.xml
index f859a9f..8649d0a 100644
--- a/apps/james/SAR-INF/environment.xml
+++ b/apps/james/SAR-INF/environment.xml
@@ -83,6 +83,12 @@
       <category name="smtpserver" log-level="INFO">
         <log-target id-ref="smtpserver-target"/>
       </category>
+      <category name="pop3server-tls" log-level="INFO">
+        <log-target id-ref="pop3server-tls-target"/>
+      </category>
+      <category name="smtpserver-tls" log-level="INFO">
+        <log-target id-ref="smtpserver-tls-target"/>
+      </category>
       <category name="nntpserver" log-level="INFO">
         <log-target id-ref="nntpserver-target"/>
       </category>
@@ -214,6 +220,28 @@
           </or>
         </rotation>
       </file>
+      <file id="pop3server-tls-target">
+        <filename>${app.home}/logs/pop3server-tls</filename>
+        <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
+        <append>true</append>
+        <rotation type="unique" pattern="-yyyy-MM-dd-HH-mm" suffix=".log">
+          <or>
+            <date>dd</date>
+            <size>10485760</size>
+          </or>
+        </rotation>
+      </file>
+      <file id="smtpserver-tls-target">
+        <filename>${app.home}/logs/smtpserver-tls</filename>
+        <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
+        <append>true</append>
+        <rotation type="unique" pattern="-yyyy-MM-dd-HH-mm" suffix=".log">
+          <or>
+            <date>dd</date>
+            <size>10485760</size>
+          </or>
+        </rotation>
+      </file>
       <file id="nntpserver-target">
         <filename>${app.home}/logs/nntpserver</filename>
         <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
```

`apps/james/SAR-INF/assembly.xml`を編集

```diff
diff --git a/apps/james/SAR-INF/assembly.xml b/apps/james/SAR-INF/assembly.xml
index 1e1bb95..09c63fc 100644
--- a/apps/james/SAR-INF/assembly.xml
+++ b/apps/james/SAR-INF/assembly.xml
@@ -109,6 +109,30 @@
              role="org.apache.avalon.cornerstone.services.threads.ThreadManager" />
   </block>
 
+  <block name="pop3server-tls" class="org.apache.james.pop3server.POP3Server" >
+    <provide name="localusersrepository" role="org.apache.james.services.UsersRepository"/>
+    <provide name="sockets"
+             role="org.apache.avalon.cornerstone.services.sockets.SocketManager"/>
+    <provide name="connections"
+             role="org.apache.james.services.JamesConnectionManager"/>
+    <provide name="James" role="org.apache.james.services.MailServer"/>
+    <provide name="thread-manager"
+             role="org.apache.avalon.cornerstone.services.threads.ThreadManager" />
+  </block>
+
+  <block name="smtpserver-tls" class="org.apache.james.smtpserver.SMTPServer" >
+    <provide name="James" role="org.apache.mailet.MailetContext"/>
+    <provide name="localusersrepository" role="org.apache.james.services.UsersRepository"/>
+    <provide name="dnsserver" role="org.apache.james.services.DNSServer"/>
+    <provide name="sockets"
+             role="org.apache.avalon.cornerstone.services.sockets.SocketManager"/>
+    <provide name="connections"
+             role="org.apache.james.services.JamesConnectionManager"/>
+    <provide name="James" role="org.apache.james.services.MailServer"/>
+    <provide name="thread-manager"
+             role="org.apache.avalon.cornerstone.services.threads.ThreadManager" />
+  </block>
+
   <!-- NNTP Server -->
   <block name="nntpserver" class="org.apache.james.nntpserver.NNTPServer" >
     <provide name="localusersrepository" role="org.apache.james.services.UsersRepository"/>
```

`apps/james/SAR-INF/environment.xml`を編集

```diff
diff --git a/apps/james/SAR-INF/environment.xml b/apps/james/SAR-INF/environment.xml
index f859a9f..e59dfb4 100644
--- a/apps/james/SAR-INF/environment.xml
+++ b/apps/james/SAR-INF/environment.xml
@@ -83,6 +83,12 @@
       <category name="smtpserver" log-level="INFO">
         <log-target id-ref="smtpserver-target"/>
       </category>
+      <category name="pop3server-tls" log-level="INFO">
+        <log-target id-ref="pop3server-tls-target"/>
+      </category>
+      <category name="smtpserver-tls" log-level="INFO">
+        <log-target id-ref="smtpserver-tls-target"/>
+      </category>
       <category name="nntpserver" log-level="INFO">
         <log-target id-ref="nntpserver-target"/>
       </category>
@@ -214,6 +220,28 @@
           </or>
         </rotation>
       </file>
+      <file id="pop3server-tls-target">
+        <filename>${app.home}/logs/pop3server</filename>
+        <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
+        <append>true</append>
+        <rotation type="unique" pattern="-yyyy-MM-dd-HH-mm" suffix=".log">
+          <or>
+            <date>dd</date>
+            <size>10485760</size>
+          </or>
+        </rotation>
+      </file>
+      <file id="smtpserver-tls-target">
+        <filename>${app.home}/logs/smtpserver</filename>
+        <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
+        <append>true</append>
+        <rotation type="unique" pattern="-yyyy-MM-dd-HH-mm" suffix=".log">
+          <or>
+            <date>dd</date>
+            <size>10485760</size>
+          </or>
+        </rotation>
+      </file>
       <file id="nntpserver-target">
         <filename>${app.home}/logs/nntpserver</filename>
         <format>%{time:dd/MM/yy HH:mm:ss} %5.5{priority} %{category}: %{message}\n%{throwable}</format>
```

そして`apps/james/conf`に自己署名証明書を作成します。

```sh
keytool -genkeypair -keyalg RSA -keystore keystore -storepass secret -alias james -keypass keysecret -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown"
```

`lib`に`$JAVA_HOME/jre/lib/ext/sunjce_provider.jar`をコピーします。

あとは`bin/run`を実行すればOK。
