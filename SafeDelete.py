from os import remove
from os import urandom

def secure_delete(path, passes=5):
    with open(path, "ba+") as delfile:
        length = delfile.tell()
    with open(path, "br+") as delfile:
        for i in range(passes):
            delfile.seek(0)
            delfile.write(urandom(length))
    remove(path)


def main():
    secure_delete("C:\Users\hdext\OneDrive\Escritorio\Decipher.py")

if __name__ == "__main__":
    main()