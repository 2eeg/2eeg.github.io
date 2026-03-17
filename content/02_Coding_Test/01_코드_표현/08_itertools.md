# 순열
```python
from itertools import permutations

arr = [1, 2, 3]

# 모든 순열 (3P3)
for p in permutations(arr):
    print(p)
# (1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)

# 2개만 선택하는 순열 (3P2)
for p in permutations(arr, 2):
    print(p)
# (1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2)
```
# 조합
```python
from itertools import combinations

arr = [1, 2, 3, 4]

# 4개 중 2개 선택 (4C2)
for c in combinations(arr, 2):
    print(c)
# (1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)
```
# 데카르트 곱(중복 순열)
```python
from itertools import product

# 중복 허용 순열
for p in product([1, 2, 3], repeat=2):
    print(p)
# (1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3)

# 여러 리스트의 모든 조합
for p in product([1, 2], ['a', 'b']):
    print(p)
# (1, 'a'), (1, 'b'), (2, 'a'), (2, 'b')
```
# 중복 조합
```python
from itertools import combinations_with_replacement

# 중복 허용 조합
for c in combinations_with_replacement([1, 2, 3], 2):
    print(c)
# (1, 1), (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)
```
