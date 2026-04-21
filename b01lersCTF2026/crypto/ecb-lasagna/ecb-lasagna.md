The zip for this challenge contained 3 files: chall.py, flag.txt, and output.txt.

flag.txt simply contained 'bctf{fake_flag}'. Maybe a hint that I could use the part of the plaintext ( such as ' bctf{ ' ) at some point to help reveal a key?

Looking in output.txt, the contents was made up entirely of uppercase, lowercase, numbers, '+' and '/' - clearly base64. I stuck this in cyberchef to see if I got anything from it, but the result was unintelligible.

I opened chall.py. The code started by reading from the flag.txt file, and finished by outputting base64-encoded data, so it seemed very likely this was the script used to encrypt the original flag into output.txt. So to find the plaintext, I would likely need to go through this script and figure out what it did so I could reverse it.  Istarted going through the code, testing and annotating each section as I went. 


