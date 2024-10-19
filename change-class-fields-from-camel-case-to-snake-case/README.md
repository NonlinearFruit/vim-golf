# [Change class fields from camel case to snake case](https://www.vimgolf.com/challenges/9v0067056336000000000514)
This is the reverse of the previous challenge: https://www.vimgolf.com/challenges/9v006705493c000000000513
## Input
```
case class User(
  id: Long,
  username: String,
  email: String,
  firstName: String,
  lastName: String,
  age: Int,
  gender: String,
  phoneNumber: String,
  address: String,
  city: String,
  country: String,
  postalCode: String,
  occupation: String,
  company: String,
  salary: Double,
  isActive: Boolean,
  registrationDate: java.time.LocalDate,
  lastLoginDate: java.time.LocalDateTime,
  preferences: Map[String, String],
  roles: List[String]
)
```
## Output
```
case class User(
  id: Long,
  username: String,
  email: String,
  first_name: String,
  last_name: String,
  age: Int,
  gender: String,
  phone_number: String,
  address: String,
  city: String,
  country: String,
  postal_code: String,
  occupation: String,
  company: String,
  salary: Double,
  is_active: Boolean,
  registration_date: java.time.LocalDate,
  last_login_date: java.time.LocalDateTime,
  preferences: Map[String, String],
  roles: List[String]
)
```