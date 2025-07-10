import random
import string

def generate_random_name():
    name = [
    "Luis", "Maria", "Angel", "Sofia", "Carlos", "Valeria",
    "Fernando", "Camila", "Jose", "Isabela", "Miguel", "Lucia",
    "Juan", "Daniela", "Andres", "Paula", "Diego", "Renata",
    "Jorge", "Antonella", "Ricardo", "Fernanda", "Raul", "Regina",
    "Hector", "Jimena", "Emilio", "Natalia", "Victor", "Elena", "Andrea"
]
    return random.choice(name)

def generate_random_last_name():
    last_name = [
    "Garcia", "Martinez", "Lopez", "Hernandez", "Gonzalez", "Perez",
    "Rodriguez", "Sanchez", "Ramirez", "Torres", "Flores", "Rivera",
    "Gomez", "Diaz", "Cruz", "Morales", "Ortiz", "Vargas",
    "Castillo", "Jimenez", "Ruiz", "Silva", "Reyes", "Romero",
    "Mendoza", "Ramos", "Aguilar", "Medina", "Castro", "Delgado"
]
    return random.choice(last_name)

def generate_random_email():
    name = generate_random_name()
    last_name = generate_random_last_name()
    domains = ["gmail.com", "outlook.com", "yahoo.com", "hotmail.com", "live.com", "icloud.com"]
    domain = random.choice(domains)
    email = f"{name.lower()}_{last_name.lower()}@{domain}"

    return email

def generate_random_password(length=8):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for i in range(length))

    return password

def generate_random_phone_number():
    prefijo = random.choice(["55", "52"])
    bloque2 = random.randint(1000, 9999)
    bloque3 = random.randint(1000, 9999)
    phone_number = f"{prefijo}{bloque2}{bloque3}"

    return phone_number


def generate_random_birthdate():
    year = random.randint(1980, 2020)
    month = random.randint(1, 12)
    day = random.randint(1, 28)
    birthdate = f"{month:02}/{day:02}/{year}"

    return birthdate