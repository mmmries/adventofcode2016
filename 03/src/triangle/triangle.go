package triangle

func IsValid(sides [3]uint16) bool {
  if sides[0] >= sides[1] + sides[2] {
    return false
  } else if sides[1] >= sides[0] + sides[2] {
    return false
  } else if sides [2] >= sides[0] + sides[1] {
    return false
  } else {
    return true
  }
}
