$MailingList = Import-Csv C:\Users\alandeta\Desktop\ListaContactos.csv

#SMTP Server and port may differ for different email service provider
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"

#Your email id and password
$Username = "reims.spam@gmail.com"
$Password = "spampass"

for($i=0; $i -le 10; $i++)
{
#Iterating data from CSV mailing list and sending email to each person
    foreach ( $person in $MailingList)
    {
        $iName = $person.Name
        $iEmail =  $person.Email    


        $to = $person.Email        
        $subject = "Email Subject"
        $body = "iName"  

        $message = New-Object System.Net.Mail.MailMessage
        $message.subject = $subject
        $message.body = $body
        $message.to.add($to)
        $message.from = $username


        $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
        $smtp.EnableSSL = $true
        $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
        $smtp.send($message)
        Write-Host Mail Sent to $iName

        
    }
    Start-Sleep -s 300
}