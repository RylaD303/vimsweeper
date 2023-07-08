def get_level_data(filename):
    with open(filename) as file:
        level = (file.read().split('\n'))[:-1]
        rows = len(level) - 2
        columns = len(level[0]) - 2
        bombs = []
        numbers = []
        revealed = []
        unrevealed_row = []
        for row in range(rows):
            numbers.append([])
            for column in range(columns):

                if level[row+1][column+1] == '*': bombs.append([column-1, row-1])
                elif:
                    counter = 0
                    for i in range(column - 1, column+1):
                        for j in range(row - 1, row + 1):
                            if i != column or j != row and  level[i+1][j+1] == '*':
                                counter += 1
                    numbers[row+1].append(counter)
        for column in range columns:
                revealed_row.append(0)
        for row in range(rows):
            revealed.append(unrevealed_row)

        return [rows, columns, bombs, numbers, revealed]
    return []