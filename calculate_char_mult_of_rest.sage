import os


def calculate_partitions(n):
    """
    Calculate the number of ways an integer can be partitioned.
    """
    partitions = [1] + [0]*n
    for t in range(1, n+1):
        for i, x in enumerate(range(t, n+1)):
            partitions[x] += partitions[i]
    return partitions[n]

def calculate_character_multiplicities(symgroup_number):
    """
    Calculate the character multiplicities for the Symmetric Group of a given order.
    """
    G = SymmetricGroup(symgroup_number)
    character_table = G.character_table()

    # Print the character table for user's reference
    print(f"\nCharacter Table for Symmetric Group of order {symgroup_number}:")
    for i, character in enumerate(character_table):
        print(f"Character {i + 1}: {character}")

    # Calculate the restricted characters of the Symmetric Group
    restricted_characters = []
    sylow_subgroup = G.sylow_subgroup(2)
    for character in character_table:
        chi = ClassFunction(G , character)
        chi_new = chi.restrict(sylow_subgroup)
        restricted_characters.append(chi_new.values())

    # Calculate the multiplicities of the characters
    multiplicities = [[0 for _ in range(len(restricted_characters[0]))] for _ in range(calculate_partitions(symgroup_number))]
    for sym_character_number in range(calculate_partitions(symgroup_number)):
        for character_number in range(len(restricted_characters[0])):
            for conjugacy_class_number in range(len(restricted_characters[0])):
                multiplicities[sym_character_number][character_number] += (restricted_characters[sym_character_number][conjugacy_class_number] * list(sylow_subgroup.character_table()[character_number])[conjugacy_class_number] * sylow_subgroup.conjugacy_class(sylow_subgroup[conjugacy_class_number]).cardinality())
            multiplicities[sym_character_number][character_number] = floor(multiplicities[sym_character_number][character_number] / sylow_subgroup.cardinality())

    # Print the decompositions of the characters
    for sym_character_number in range(calculate_partitions(symgroup_number)):
        decomposition = []
        for character_number in range(len(restricted_characters[0])):
            while multiplicities[sym_character_number][character_number] > 0:
                decomposition.append(character_number + 1)
                multiplicities[sym_character_number][character_number] -= 1
        print(f"Decomposition of {sym_character_number + 1} character of {G} is: {decomposition}")

for symgroup_number in range(4, 17):
    print(f"--------- Calculating character multiplicities for Symmetric Group of order {symgroup_number} ---------")
    calculate_character_multiplicities(symgroup_number)
    print("------------------------------------------------------------------")
