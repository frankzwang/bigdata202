#append to list using class to pass in arg (inside is also lists
class VehicleCategory:
    
    def __init__(self, transmission, types):  #transmission is a list, types is a list, togther is [list, list] combolist
        self.transmission = transmission
        self.types = types
        
    def assemble(self): # expcect result is a dict, each key is a element from the transmission list, each value is a element from types list
        result = []
        for i in self.transmission:
            for t in self.types:
                result.append([i,t])
        return result

if __name__ == "__main__":
    machine = VehicleCategory(["manual", "auto"], ["sedan"])
    print(VehicleCategory.assemble()) 