#INSTALL pip FIRST!!!
from colorama import Fore, Style

def printBar(message, prog, outof=10):
    pE = prog
    pM = outof - pE
    print(Style.BRIGHT, end="")
    print(Fore.YELLOW + "[",end="")
    print(Fore.LIGHTGREEN_EX, end="")
    while pE > 0:
        print("=",end="")
        pE-=1

    print(Fore.LIGHTRED_EX, end="")
    while pM > 0:
        print("-",end="")
        pM-=1

    print(Fore.YELLOW + "]",end="")
    print(Fore.LIGHTBLUE_EX + message + Style.RESET_ALL)
