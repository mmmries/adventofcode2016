package row_parser

import (
  "io/ioutil"
  "net/textproto"
  "strconv"
  "strings"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func ParseFromFile(filepath string) [][3]uint16 {
  dat, err := ioutil.ReadFile(filepath)
  check(err)
  str := string(dat)
  str = textproto.TrimString(str)
  lines := strings.Split(str, "\n")
  triangles := make([][3]uint16, len(lines))
  for i := 0; i < len(lines); i++ {
    numbers := strings.Fields(lines[i])
    a, _ := strconv.ParseUint(numbers[0], 10, 16)
    b, _ := strconv.ParseUint(numbers[1], 10, 16)
    c, _ := strconv.ParseUint(numbers[2], 10, 16)
    sides := [3]uint16{uint16(a), uint16(b), uint16(c)}
    triangles[i] = sides
  }
  return triangles
}
