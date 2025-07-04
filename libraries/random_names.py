import random
import string

def generate_random_name():
    name = [
    "Luis", "María", "Angel", "Sofía", "Carlos", "Valeria",
    "Fernando", "Camila", "José", "Isabela", "Miguel", "Lucía",
    "Juan", "Daniela", "Andrés", "Paula", "Diego", "Renata",
    "Jorge", "Antonella", "Ricardo", "Fernanda", "Raúl", "Regina",
    "Héctor", "Jimena", "Emilio", "Natalia", "Víctor", "Elena"
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