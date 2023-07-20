def get_level_data(filename):
    with open(filename) as file:
        level = (file.read().split('\n'))
        print(level)
        rows = len(level) - 2
        columns = len(level[0]) - 2
        bombs = []
        numbers = []
        revealed = []
        unrevealed_row = []
        for row in range(rows):
            numbers.append([])
            for column in range(columns):
                counter =0
                if level[row+1][column+1] == '*':
                    bombs.append([column, row])
                else:
                    for i in range(row - 1, row +2):
                        for j in range(column - 1, column + 2):
                            if level[i+1][j+1] == '*':
                                counter += 1
                numbers[row].append(counter)
        for column in range(columns):
                unrevealed_row.append(0)
        for row in range(rows):
            revealed.append(unrevealed_row)

        print(numbers)
        return [rows, columns, bombs, numbers, revealed]
    return []


