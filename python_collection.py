from collections import Counter
from collections import OrderedDict
#group by value for dict pairs######################################
def group_by_sources(files):

    sourcedict = {}

    for key, value in files.items():
        if value in sourcedict:
            sourcedict[value].append(key)
        else:
            sourcedict[value] = [key]
    return sourcedict


if __name__ == "__main__":    
    files = {
        'apple.csv': 'nasdaq',
        'meta.json': 'nasdaq',
        'intc.txt': 'dow30',
        'visa.json': 'dow30'
    }   
    print(group_by_sources(files))

    #Class (advanced): rank scores with multi factors for sports or other events          ##########################################################<
class PlayerRank:
    def __init__(self, players):
        self.standings = OrderedDict([(player, Counter()) for player in players])

    def record_result(self, player, score):
        self.standings[player]['games_played'] += 1
        self.standings[player]['score'] += score

    def player_rank(self, rank):
        ranks = [(-counter['score'], counter['games_played'], i, name)
                 for i, (name, counter) in enumerate(self.standings.items())]

        return sorted(ranks)[rank-1][3]


table = PlayerRank(['William', 'Henry', 'Luke'])
table.record_result('William', 2)
table.record_result('William', 3)
table.record_result('Henry', 5)
table.record_result('Luke', 5)
print(table.player_rank(1))



#Merge two lists and de-dedup the result list for the merged lists##############################################################################<
def unique_names(names1, names2):
    #print(names12)
    names12 = names1 + names2 #merged list with dups
    res = []
    for item in names12:
        if item not in res:
            res.append(item)
    return res


names1 = ["Betty", "Jack", "Mark"]
names2 = ["Mark", "Suzie", "Jack"]
print(unique_names(names1, names2)) # should print ['Betty', 'Jack', 'Mark', 'Suzie']