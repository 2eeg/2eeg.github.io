# 01. BFS(Breadth-First Search) 알고리즘
한국어로 넓이 우선 탐색 알고리즘이다. 그래프나 트리와 같은 구조에서 시작 노트부터 가까운 노트를 먼저 방문하고, 멀리 떨어져 있는 노드를 나중에 방문하는 순차적인 탐색 알고리즘이다.
# 02. 작동 단계
1. 시작 노드를 큐에 넣고 방문 처리를 한다.
2. 큐가 빌 때까지 다음 과정을 반복한다.
	1. 큐에서 노드를 꺼낸다.
	2. 해당 노드와 인접한 노드 중 방문하지 않은 노드를 모두 찾는다.
	3. 찾은 노드를 모두 큐에 삽입하고 방문 처리를 한다.

# 03. BFS의 활용
## 03-01. Flood Fill
Flood Fill이란, 한 점에서 시작해서 같은 조건을 만족하는 연결된 영역을 전부 탐색하는 문제이다. DFS로 풀 수도 있고 BFS로 풀 수도 있다.
### 예
아래는 [[1926_BFS]] 중 일부.
2차원 배열에서 BFS를 활용하여 해당 배열 내부의 1로 이루어진 도형의 면적을 계산하는 문제이다.
`board`는 입력으로 받은 2차원 배열 이고 `i`,와 `j`는 bfs의 시작점이다.
```python
from collections import deque

def solve():
    # ... (입력 처리 부분 생략)
    
    q = deque([(i, j)])
    vis[i][j] = True
    area = 1
    
    while q:
        r, c = q.popleft() # 현재 위치 (Row, Col)
        
        # 4방향 탐색 (상, 하, 좌, 우)
        for dr, dc in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            nr, nc = r + dr, c + dc
            
            # 1. 범위를 벗어났는가?
            if not (0 <= nr < n and 0 <= nc < m):
                continue
            # 2. 이미 방문했거나, 색칠되지 않은 영역(0)인가?
            if vis[nr][nc] or board[nr][nc] == 0:
                continue
                
            # 3. 조건을 만족하면 큐에 삽입하고 '즉시' 방문 처리
            vis[nr][nc] = True
            q.append((nr, nc))
            area += 1

```
대상이 되는 2차원 배열과 같은 크기의 vis 배열을 따로 두어 방문 여부를 표시하고 또 python의 deque에 `(열,행)`을 넣도록 활용하여 노드 선입 선출을 구현한다.

## 03-02. 거리 측정
거리를 측정할 때에도 BFS를 활용할 수 있다.
Flood Fill에서는 단순히 해당 칸을 방문했는지만 기록했다면 거리 측정애서는 **시작점에서 여기까지 몇칸이나 왔는가?** 를 기록해야 한다.
- `dist` 배열의 역할:
	- **방문 여부 확인**: 값이 `-1`이면 아직 가지 않은 곳, 아니면 방문한 곳.
	- **거리 저장**: 시작점으로부터의 누적 거리를 저장.
- 거리 갱신 공식:
	- `다음 칸의 거리 = 현재 칸의 거리 + 1`
	- $dist[nx][ny] = dist[x][y]+1$
### 예
[[2178_BFS]]
2차원 미로에서 $(0, 0)$에서 시작해 $(N-1, M-1)$까지 가는 최소 칸 수를 구하는 문제이다. BFS는 너비를 우선해서 퍼져나가기 때문에, 목표 지점에 처음 도달했을 때의 값이 곧 최단 거리가 된다.

```python
# ... 입력 부 생략...

from collections import deque 

# n: 행(Row), m: 열(Column) 
# board: 미로 데이터 (1은 이동 가능, 0은 벽)

dist = [[-1]*m for _ in range(n)]

q = deque([(0,0)])
dist[0][0] = 1 # 시작 위치의 거리를 1로 설정
while q:
    x, y = q.popleft()
    
    # 상하좌우 네 방향 확인
    for dx, dy in [(1,0),(-1,0),(0,1),(0,-1)]:
        nx, ny = x+dx, y+dy
        # 1. 미로 범위 안에 있는가?
        if not (0<=nx<n and 0<=ny<m):
            continue
		# 2. 아직 방문하지 않았는가?
        if not dist[nx][ny] == -1:
            continue
		# 3. 이동 가능한 칸(1)인가?
        if not board[nx][ny] == 1:
            continue
        q.append((nx, ny))
        dist[nx][ny] = dist[x][y] + 1
```

## 03-03. 거리 측정, 시작점이 여러 개 일 때
보통 BFS는 한 지점에서 시작하지만, **여러 지점에서 동시에 번져나가는 상황**도 있다. 이떄 핵심은 **"모든 시적점을 미리 큐에 넣고 시작하는 것이다"**

**왜 시작점을 한꺼번에 넣어야 하나?**
만약 시작점이 A와 B 두 곳인데, A에서 BFS를 다 끝내고 B에서 다시 시작한다면 '최소 시간'을 구할 수 없다.
모든 시작점을 큐에 먼저 넣고 BFS를 돌리면, 마치 여러곳에서 동시에 불이 번지는 것처럼 각 시작점에서 가장 가까운 곳부터 차례대로 탐색한다. 이를 통해 각 칸에 도달하는 **최단 거리** 를 보장할 수 있다.
### 예
[[7576_BFS]]
2차원 배열에서 익은 토마토(1)가 여러 개 있을 때, 창고 안의 모든 토마토가 익는 최소 일수를 구하는 문제이다.

#### 1. 초기 세팅 (큐에 모든 시작점 삽입)
가장 중요한 부분입니다. `board`를 확인하면서 값이 `1`(익은 토마토)인 좌표를 모두 찾아 큐에 넣고, `dist`를 `0`으로 설정한다.
```python
q = deque()
for i in range(n):
    for j in range(m):
        if board[i][j] == 1:
            q.append((i, j))
            dist[i][j] = 0 # 시작점의 거리는 0일
```
#### 2. BFS 탐색
일반적인 BFS와 동일하게 진행한다. 큐에서 꺼낸 토마토 주변(상하좌우)에 익지 않은 토마토(0)가 있다면, 현재 일수 + 1을 해주고 큐에 넣는다.
```python
while q:
    x, y = q.popleft()
    for dx, dy in [(1,0),(-1,0),(0,1),(0,-1)]:
        nx, ny = x+dx, y+dy
        if not (0<=nx<n and 0<=ny<m):
            continue
        if not dist[nx][ny] == -1:
            continue
        if not board[nx][ny] == 0:
            continue
        q.append((nx, ny))
        dist[nx][ny] = dist[x][y] + 1

```
#### 3. 결과 판별 (예외 처리)
BFS가 끝난 뒤 두 가지를 확인해야 합니다.
1. **안 익은 토마토가 있는가?** : `board`가 0인데 `dist`가 -1인 곳이 있다면 다 익지 못한 것이므로 `-1` 출력.
2. **최대 며칠이 걸렸는가?** : `dist` 배열에서 가장 큰 값이 정답.
```python
for i in range(n):
    for j in range(m):
        if board[i][j] == 0 and dist[i][j] == -1:
            print('-1')
            sys.exit()

print(max(map(max,dist)))
```
## 03-04. 거리 측정, 시작점이 두 종류일 때
성격이 다른 두 종류의 요소가 동시에 퍼져나가는 문제도 있다. 서로 독립적이거나 한 요소가 다른 요소에 일방적으로 영향을 주는 경우라면 BFS만으로도 풀이가 가능하다. 그냥 하나 먼저 BFS 돌리고 나중에 다른 하나를 BFS 돌리면 된다.
### 예
[[4179_BFS]]
해당 문제에서는 2차원 배열에서 지훈이와 불이 주어진다. 이때 지훈이가 최소로 탈출 할 수 있는 이동 횟수를 출력하는 문제이다.
이 문제의 핵심은 **불(Fire)** 의 전파가 **지훈** 이의 이동 경로를 결정한다는 점이다. 지훈이가 특정 칸에 갈 수 있는지 확인하려면, **"지훈이가 도착하는 시간"** 이 **"불이 도착하는 시간"** 보다 빨라야 한다.
1. **불의 BFS (선행):** 모든 불의 시작점을 큐에 넣고, 미로 전체에 불이 번지는 최단 시간(`fire_dist`)을 미리 구해둔다.
```python
directions = [(1,0), (-1,0), (0,1), (0,-1)]

while fire_q:
    x, y = fire_q.popleft()
    for dx, dy in directions:
        nx, ny = x+dx, y+dy
        if not (0<=nx<n and 0<=ny<m):
            continue
        if board[nx][ny] == '#':
            continue
        if not fire_dist[nx][ny] == -1:
            continue
        fire_q.append((nx,ny))
        fire_dist[nx][ny] = fire_dist[x][y] + 1
```
2. **지훈의 BFS (후행):** 지훈이를 이동시키며, 다음 칸의 `jihoon_dist + 1`이 해당 칸의 `fire_dist`보다 **작을 때만** 이동을 허용한다.
```python
# 지훈의 이동 로직
while jihoon_q:
    x, y = jihoon_q.popleft()
    for dx, dy in directions:
        nx, ny = x + dx, y + dy
        
        # [탈출 조건] 미로의 범위를 벗어나면 탈출 성공!
        if not (0 <= nx < n and 0 <= ny < m):
            print(jihoon_dist[x][y] + 1)
            sys.exit()
            
        # [이동 조건] 벽이 아니고, 방문한 적 없어야 함
        if board[nx][ny] == '.' and jihoon_dist[nx][ny] == -1:
            # [중요] 불이 붙지 않았거나, 불보다 빨리 도착할 수 있는 경우만 이동
            if fire_dist[nx][ny] == -1 or fire_dist[nx][ny] > jihoon_dist[x][y] + 1:
                jihoon_q.append((nx, ny))
                jihoon_dist[nx][ny] = jihoon_dist[x][y] + 1
```

우리가 이 문제를 "불 먼저, 지훈이 나중"이라는 순서로 풀 수 있었던 이유는 **불의 전파가 지훈이의 위치에 영향을 받지 않는 '독립적'인 관계**였기 때문이다. 하지만 서로 영향을 주는 관계라면 이런 풀이는 풀가능하다.
- **상호작용이 발생하는 경우:** 만약 지훈이가 소방수여서 불을 끄며 전진한다면? 불은 소방수가 지나간 길을 못 번지고, 소방수는 불이 있는 곳을 꺼야만 갈 수 있게 된다.
- **해결책:** 이렇게 두 요소가 서로에게 영향을 주는 **상호 종속적**인 상황에서는 어느 한 쪽을 먼저 끝까지 계산할 수 없다. 이때는 **A와 B를 동시에 한 단계씩 진행시키는 시뮬레이션 기법**이나, 경로 탐색을 위한 **백트래킹** 등의 추가적인 사고가 필요하다.