# Enter your code here. Read input from STDIN. Print output to STDOUT
from collections import Counter

if __name__ == '__main__':
    X = input()
    shoe_list= input()
    n_customers=int(input())
    
    shoe_desired=[]
    for i in range(n_customers):
        shoe_desired.append(input())

    print(X)    
    print(shoe_list)
    print(n_customers)  
    print(shoe_desired)
    
    c=Counter(shoe_list)
    print(c)