import math, random

class ATM:
    def __init__(self, account_num, password_true, balance):
        self.account_num = account_num
        self.password_true = password_true
        self.balance = balance

    def __str__(self):
        return "This is ATM working."

    def deposit(self, amount_dep):
        self.balance += amount_dep 
        print(f"Your Deposite: {amount_dep} bath")
        self.check_balance()


    def withdraw(self, amount_with):
        print(f"Your Account Number: {self.account_num} \n")
        n=0
        while (n<3) :
            password = input(f"Enter Your Password: ")
            if password == self.password_true:
                print(f"Password: xxxxxx !!Verify Identity Complete!!")
                if self.balance > amount_with:
                    self.balance -= amount_with
                else:
                    print(f"You can't withdraw => Your money not enough!") 
                print(f"Your Withdraw: {amount_with} bath")
                break
            else:
                print(f"Your Password !!WRONG!!")
                n +=1
        self.check_balance()
 
    def check_balance(self):
        print(f"Total Balance: {self.balance} bath")

    def get_otp(self):
        digits = "0123456789"
        otp = ""
        for i in range(4) :
            otp += digits[math.floor(random.random() * 10)]   # math.floor ปัดเศษตัวเลขเป็นจำนวนเต็ม
        return otp

    def transfer(self, money_transfer):
        acc_other = input(f"Account do you want transfer: ")
        if self.balance > money_transfer:
            password = input(f"Enter Your Password: ")
            while (password == self.password_true):
                self.balance -= money_transfer
                print(f"Transfer Complete!! \n")
                print(f"You transfer money to {acc_other} , Amount: {money_transfer} bath")
                break
        else:
            print(f"Your balance not enough!")

        self.check_balance()

       
# create instances
atm1 = ATM("058123456", "654321", 5000)

print(f"Account Number: {atm1.account_num} Balance: {atm1.balance} bath.")

# how to use:
atm1.deposit(1000)
atm1.withdraw(4500)
atm1.transfer(1500)
atm1.check_balance()
atm1.get_otp()
