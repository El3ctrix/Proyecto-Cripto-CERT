from Crypto.Cipher import AES
import os
from os import remove
from os import listdir
from os.path import isfile, join

def decrypt(encrypted_data):
     nonce, tag, ciphertext = [encrypted_data.read(x) for x in (16, 16, -1)]
     return nonce, tag, ciphertext
    

def main():
    key = open(os.path.expanduser('~') + "\Desktop\key.bin", "rb").read()
    mypath = r"{}\Documents".format(os.path.expanduser('~'))
    files = []
    for f in listdir(mypath):
        file = join(mypath, f)
        if isfile(file):
            if file.endswith(".bin"):
                files.append(file)
    for path in files:
        file_to_decrypt = open(path, "rb")
        old_file = path.split(".")
        encrypted_data = decrypt(file_to_decrypt)
        file_to_decrypt.close()
        cipher = AES.new(key, AES.MODE_EAX, nonce=encrypted_data[0])
        decrypted_data = cipher.decrypt_and_verify(encrypted_data[2], encrypted_data[1])
        old_file_name = ''
        if old_file[0][len(old_file[0])-1] == "d":
            old_file_name = old_file[0][0:len(old_file[0])-1] + ".docx"
        elif old_file[0][len(old_file[0])-1] == "x":
            old_file_name = old_file[0][0:len(old_file[0])-1] + ".xlsx"
        elif old_file[0][len(old_file[0])-1] == "p":
            old_file_name = old_file[0][0:len(old_file[0])-1] + ".pdf"
        elif old_file[0][len(old_file[0])-1] == "j":
            old_file_name = old_file[0][0:len(old_file[0])-1] + ".jpeg"
        elif old_file[0][len(old_file[0])-1] == "J":
            old_file_name = old_file[0][0:len(old_file[0])-1] + ".jpg"
        decrypted_file = open(old_file_name, "wb")
        decrypted_file.write(decrypted_data)
        remove(path)
        decrypted_file.close()

if __name__ == "__main__":
    main()
