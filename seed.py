import sqlite3
from faker import Faker
import random

DB_NAME = "tasks.db"

fake = Faker()

def seed():
    conn = sqlite3.connect(DB_NAME)
    conn.execute("PRAGMA foreign_keys = ON;")
    cur = conn.cursor()

    # Статуси
    statuses = ['new', 'in progress', 'completed']
    for status in statuses:
        cur.execute(
            "INSERT OR IGNORE INTO status (name) VALUES (?)",
            (status,)
        )

    users = []
    for _ in range(10):
        fullname = fake.name()
        email = fake.unique.email()
        cur.execute(
            "INSERT INTO users (fullname, email) VALUES (?, ?)",
            (fullname, email)
        )
        users.append(cur.lastrowid)


    cur.execute("SELECT id FROM status")
    status_ids = [row[0] for row in cur.fetchall()]

    for _ in range(30):
        title = fake.sentence(nb_words=4)
        description = fake.text() if random.choice([True, False]) else None
        status_id = random.choice(status_ids)
        user_id = random.choice(users)

        cur.execute(
            """
            INSERT INTO tasks (title, description, status_id, user_id)
            VALUES (?, ?, ?, ?)
            """,
            (title, description, status_id, user_id)
        )

    conn.commit()
    conn.close()

if __name__ == "__main__":
    seed()
