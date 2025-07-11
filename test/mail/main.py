import smtplib
import random
import pandas as pd
import datetime as dt
 
MY_EMAIL = "eva.unit00.2000@gmail.com"
MY_PASSWORD = "dmtonxzjkqplfpqi"

now = dt.datetime.now()
today = (now.month, now.day)
data = pd.read_csv('test/mail/birthday.csv')
birthday_dic = {(data_row.month, data_row.day): data_row for (index, data_row) in data.iterrows()} 


if (today in birthday_dic):
    # with open('test/mail/quotes.txt') as f:
    #     all_quotes=f.readlines()
    #     quote=random.choice(all_quotes)
    #     print(quote)

    birthday_person =birthday_dic[today]
    file_path = f'test/mail/letter_templates/letter_{random.randint(1,3)}.txt'

    with open(file_path) as letter_file:
        text = letter_file.read()
        text = text.replace('[NAME]', birthday_person['name'])

    with smtplib.SMTP("smtp.gmail.com") as connection:
            connection.starttls() #Transport Layer Security, esta linea nos permite hacer conexión segura
            connection.login(user=MY_EMAIL, password=MY_PASSWORD)
            connection.sendmail(
                from_addr=MY_EMAIL,
                to_addrs='angy25.mtz@gmail.com',
                msg=f"Subject: Happy Birthday\n\n {text}".encode('utf-8')
            )
            
                