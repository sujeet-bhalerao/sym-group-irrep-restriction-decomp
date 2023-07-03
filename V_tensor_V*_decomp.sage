from sage.groups.perm_gps.permgroup_named import SymmetricGroup
from sage.combinat.partition import Partitions
from sage.groups.class_function import ClassFunction

def decompose_tensor_product(n):
    S = SymmetricGroup(n)
    M = S.character_table()
    group_order = S.order()  
    for k in range(len(M[0])):   
        tensor_char = [M[k][j]**2 for j in range(len(M[0]))]  
        print(f'character of U tensor U_dual for partition {Partitions(n)[k]} is:')
        print(tensor_char)
        constituents = [ClassFunction(S, M[i]) for i in range(len(M[0]))]
        tensor_product = ClassFunction(S, tensor_char)
        multiplicities = [tensor_product.scalar_product(c) for c in constituents]
        for i, mult in enumerate(multiplicities):  
                print(f'irrep for partition {Partitions(n)[i]} appears with multiplicity {mult}')

for s in range(3,10):
    print(f" \n Symmetric group S{s}")
    decompose_tensor_product(s)
