# [From brakets to parens](https://www.vimgolf.com/challenges/9v00686695ea000000000723)
This is one of the most common problem when you wrap an array for error handling. Vim is useful when you convert foo[i][j][k] into foo(i, j, k) for many times.
## Input
```

int main() {
	glm::vec3 umax(
		(vx[i+1][j][k]-vx[i][j][k])/2,
		(vy[i][j+1][k]-vy[i-1][j+1][k])/2,
		(vz[i][j][k+1]-vz[i-1][j][k+1])/2
	);
	glm::vec3 umin(
		(m_vx[i][j][k]-m_vx[i-1][j][k])/2,
		(m_vy[i][j][k]-m_vy[i-1][j][k])/2,
		(m_vz[i][j][k]-m_vz[i-1][j][k])/2
	);
}
```
## Output
```
int main() {
	glm::vec3 umax(
		(vx(i+1, j, k)-vx(i, j, k))/2,
		(vy(i, j+1, k)-vy(i-1, j+1, k))/2,
		(vz(i, j, k+1)-vz(i-1, j, k+1))/2
	);
	glm::vec3 umin(
		(m_vx(i, j, k)-m_vx(i-1, j, k))/2,
		(m_vy(i, j, k)-m_vy(i-1, j, k))/2,
		(m_vz(i, j, k)-m_vz(i-1, j, k))/2
	);
}

```