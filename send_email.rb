require "google_drive"
require 'json'
require 'gmail'

puts "veuillez entrez votre adresse mail"
adress_mail = gets.chomp()
puts "veuillez entrez votre mot de passe"
mots_de_passe = gets.chomp()

session = GoogleDrive::Session.from_config("config.json")
#on se connecte sur la feuille qui contient les données sur les mairies
@ws = session.spreadsheet_by_key("1J5Ajhk5-g6TAKFw8g4hsMhv92aDp1_SNCmKbgyghjn8").worksheets[0]

@gmail = Gmail.connect(adress_mail,mots_de_passe)#penser à enlever les ids



#cette fonction recois un array de 2 élements (nom_de_commune, email)
def send_email_to_line(array)
  townhall_name= array[0]
  townhall_email = array[1]

  #si l'adresse mail existe
  unless townhall_email == ""
    @gmail.deliver do
      to townhall_email
      subject "The hacking project!"
      text_part do
        body
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body get_the_email_html(townhall_name)
      end
    end
    p "mail bien envoyé à #{townhall_name} à l'adresse #{townhall_email}"
  end

end

#permet un bon formatage du texte dans le mail (html)
#prend entré le nom de la commune et le prenom de l'utilisateur(optionnel)
def get_the_email_html(townhall_name, prenom= "Cedric")
  return %(<!DOCTYPE html>
              <html>
                <head>
                  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                  <meta name="viewport" content="width=device-width, initial-scale=1">
                  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                  <style type="text/css">
                  @media screen {
                                  @font-face {
                                              font-family: 'Lato';
                                              font-style: normal;
                                              font-weight: 400;
                                              src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff');
                                              }

                                  @font-face {
                                              font-family: 'Lato';
                                              font-style: normal;
                                              font-weight: 700;
                                              src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff');
                                              }

                                  @font-face {
                                              font-family: 'Lato';
                                              font-style: italic;
                                              font-weight: 400;
                                              src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff');
                                              }

                                  @font-face {
                                              font-family: 'Lato';
                                              font-style: italic;
                                              font-weight: 700;
                                              src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff');
                                              }
                                }

                  body, table, td, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }
                  table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }
                  img { -ms-interpolation-mode: bicubic; }
                  img { border: 0; height: auto; line-height: 100%; outline: none; text-decoration: none; }
                  table { border-collapse: collapse !important; }
                  body { height: 100% !important; margin: 0 !important; padding: 0 !important; width: 100% !important; }
                  a[x-apple-data-detectors] {
                                             color: inherit !important;
                                             text-decoration: none !important;
                                             font-size: inherit !important;
                                             font-family: inherit !important;
                                             font-weight: inherit !important;
                                             line-height: inherit !important;
                                            }

                  @media screen and (max-width:600px){
                                                      h1 {
                                                          font-size: 32px !important;
                                                          line-height: 32px !important;
                                                          }
                                                      }
                  div[style*="margin: 16px 0;"] { margin: 0 !important; }
                  </style>
                </head>
              <body style="background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tr>
                    <td bgcolor="#FF4500" align="center">
                      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;" >
                        <tr>
                          <td align="center" valign="top" style="padding: 40px 10px 40px 10px;">
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td bgcolor="#FF4500" align="center" style="padding: 0px 10px 0px 10px;">
                      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;" >
                        <tr>
                          <td bgcolor="#ffffff" align="center" valign="top" style="padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;">
                            <h1 style="font-size: 48px; font-weight: 400; margin: 0;">The hacking project</h1>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px;">
                      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;" >
                        <tr>
                          <td bgcolor="#ffffff" align="left" style="padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;" >
                            <p style="margin: 0;"> Vos administrés ont du talent ! Encouragez-les à se reconvertir ou booster leurs carrières en devenant développeur web grâce à The Hacking Project. Le secteur du numérique est parmi ceux qui recrutent le plus et c'est une opportunité pour les habitants de votre commune !</p>
                            <p> Le programme est entièrement gratuit et peut être réalisé de n'importe où ! </p>
                          </td>
                        </tr>
                        <tr>
                          <td bgcolor="#ffffff" align="left">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td bgcolor="#ffffff" align="center" style="padding: 20px 30px 60px 30px;">
                                  <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td align="center" style="border-radius: 3px;" bgcolor="#FF4500"><a href="http://bit.ly/2Foh5OE" target="_blank" style="font-size: 20px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; text-decoration: none; color: #ffffff; text-decoration: none; padding: 15px 25px; border-radius: 2px; border: 1px solid #ec6d64; display: inline-block;">Decouvrir</a></td>
                                   </tr>
                                  </table>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>

                  <tr>
                    <td bgcolor="#f4f4f4" align="center" style="padding: 30px 10px 0px 10px;">
                      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;" >
                        <tr>
                          <td bgcolor="#FFE0DE" align="center" style="padding: 30px 30px 30px 30px; border-radius: 4px 4px 4px 4px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;" >
                            <h2 style="font-size: 20px; font-weight: 400; color: #111111; margin: 0;">Encore plus d'informations ?</h2>
                              <p style="margin: 0;"><a href="http://litmus.com" target="_blank" style="color: #ec6d64;">https://www.thehackingproject.org/contact</a></p>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px;">
                      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;" >

                        <tr>
                          <td bgcolor="#f4f4f4" align="center" style="padding: 0px 30px 30px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400; line-height: 18px;" >
                            <p style="margin: 0;">THP - 226, rue Saint-Denis - 75002 Paris - France</p>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </body>
            </html>)
end



#parcours toutes les linges du googleSheet
#chaque ligne est sous forme d'un array de deux élements
def go_through_all_the_lines()
  #enlève les cases vide de l'array
  array = @ws.rows.compact.uniq
  array.each{|row|  p row }
  #array.each{|row|  send_email_to_line(row) }
end

#l'exécution prend un peu de temps
go_through_all_the_lines()



@gmail.logout
