from typing import List

def hello(name: str=None) -> str:
    if (name is None or name == ''):
        return 'Hello!'
    else:
        return 'Hello, ' + name + '!'
        


def int_to_roman(num: int) -> str:
    n1 = num // 1000;
    n2 = (num // 100) % 10
    n3 = (num // 10) % 10
    n4 = num % 10
    ans = ""
    
    if n4 == 9:
        ans = "IX"
    elif n4 >= 5:
        ans = "V" + "I" * (n4 - 5)
    elif n4 == 4:
        ans = "IV"
    elif n4 > 0:
        ans = "I" * n4

    if n3 == 9:
        ans = "XC" + ans
    elif n3 >= 5:
        ans = "L" + "X" * (n3 - 5) + ans
    elif n3 == 4:
        ans = "XL" + ans
    elif n3 > 0:
        ans = "X" * n3 + ans

    if n2 == 9:
        ans = "CM" + ans
    elif n2 >= 5:
        ans = "D" + "C" * (n2 - 5) + ans
    elif n2 == 4:
        ans = "CD" + ans
    elif n2 > 0:
        ans = "C" * n2 + ans

    if n1 > 0:
        ans = "M" * n1 + ans

    return ans

def longest_common_prefix(strs_input: List[str]) -> str:
    if len(strs_input) == 0:
        return ""
    ans = ""
    for i in range(min(len(x.lstrip()) for x in strs_input)):
        for x in strs_input:
            if (x.lstrip()[i] != strs_input[0].lstrip()[i]):
                break
        if (x.lstrip()[i] != strs_input[0].lstrip()[i]):
            break
        else:
            ans += x.lstrip()[i]
    return ans

def primes() -> int:s
    n = 1
    while True:
        if is_prime(n):
            yield n
        n += 1
        
def is_prime(n):
    if n == 1:
        return False
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True

class BankCard:
    def __init__(self, total_sum: int, balance_limit: int=None):
        self.total_sum = total_sum
        if balance_limit is None:
            self.limited = False
        else:
            self.balance_limit = balance_limit
            self.limited = True

    def __call__(self, sum_spent):
        if sum_spent > self.total_sum:
            print("Not enough money to spend", sum_spent, "dollars.")
            raise ValueError
        else:
            self.total_sum -= sum_spent
            print("You spent", sum_spent, "dollars.")

    def __str__(self):
        return "To learn the balance call balance."

    @property
    def balance(self):
        if (self.limited):
            if self.balance_limit == 0:
                print("Balance check limits exceeded.")
                raise ValueError
            self.balance_limit -= 1
        return self.total_sum

    def put(self, sum_put):
        print("You put", sum_put, "dollars.")
        self.total_sum += sum_put

    def __add__(self, b):
        if self.limited and b.limited:
            return BankCard(self.total_sum + b.total_sum, max(self.balance_limit, b.balance_limit))
        else:
            return BankCard(self.total_sum + b.total_sum)
            


