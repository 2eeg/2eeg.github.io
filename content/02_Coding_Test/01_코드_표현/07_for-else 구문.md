for 루프가 break문에 의해 중단되지 않고 정상적으로 모두 실행되었을 때 else문을 실행하게 된다.
```python
numbers = [1, 5, 9, 11]

# 1. 9를 찾는 경우 (break 발생)
for num in numbers:
    if num == 9:
        print(f"{num}을(를) 찾았습니다!")
        break
else:
    # 이 'else' 블록은 실행되지 않습니다.
    print("리스트에 9가 없습니다.")

print("---")

# 2. 7을 찾는 경우 (break 미발생)
for num in numbers:
    if num == 7:
        print(f"{num}을(를) 찾았습니다!")
        break
else:
    # for 루프가 끝까지 돌았으므로 이 'else' 블록이 실행됩니다.
    print("리스트에 7이 없습니다.")
```
