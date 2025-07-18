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
