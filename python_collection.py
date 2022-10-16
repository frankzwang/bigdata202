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