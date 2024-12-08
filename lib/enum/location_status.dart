// enum Status { employeeNotFound, locationMismatch, success }
enum LoginStatus {
  success,
  employeeNotVerified,
  employeeNotExists,
  faceNotExists,
  faceNotVerified,
  reRegisteredFace,
  locationMismatch,
  unknownError,
}



enum RegisterStatus {
  employeeNotFound,
  locationMismatch,
  success,
  alreadyRegistered,
  reRegisteredFace,
}