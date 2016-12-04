package column_parser

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
  for i := 0; i < len(lines) / 3; i++ {
    numbers1 := strings.Fields(lines[i*3])
    numbers2 := strings.Fields(lines[i*3 + 1])
    numbers3 := strings.Fields(lines[i*3 + 2])
    a1, _ := strconv.ParseUint(numbers1[0], 10, 16)
    b1, _ := strconv.ParseUint(numbers1[1], 10, 16)
    c1, _ := strconv.ParseUint(numbers1[2], 10, 16)
    a2, _ := strconv.ParseUint(numbers2[0], 10, 16)
    b2, _ := strconv.ParseUint(numbers2[1], 10, 16)
    c2, _ := strconv.ParseUint(numbers2[2], 10, 16)
    a3, _ := strconv.ParseUint(numbers3[0], 10, 16)
    b3, _ := strconv.ParseUint(numbers3[1], 10, 16)
    c3, _ := strconv.ParseUint(numbers3[2], 10, 16)
    triangles[i*3] = [3]uint16{uint16(a1), uint16(a2), uint16(a3)}
    triangles[i*3 + 1] = [3]uint16{uint16(b1), uint16(b2), uint16(b3)}
    triangles[i*3 + 2] = [3]uint16{uint16(c1), uint16(c2), uint16(c3)}
  }
  return triangles
}
