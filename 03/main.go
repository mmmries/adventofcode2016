package main

import (
  "fmt"
  "column_parser"
  "row_parser"
  "triangle"
  "os"
)

func main(){
  filepath := os.Args[1]
  fmt.Printf("counting valid triangles in %s (by row)\n", filepath)

  triangles := row_parser.ParseFromFile(filepath)

  valid_count := 0
  for i := 0; i < len(triangles); i++ {
    if triangle.IsValid(triangles[i]) {
      valid_count++
    }
  }
  fmt.Printf("found %d valid triangles out of %d\n", valid_count, len(triangles))

  fmt.Printf("counting valid triangles in %s (by columns)\n", filepath)

  triangles = column_parser.ParseFromFile(filepath)

  valid_count = 0
  for i := 0; i < len(triangles); i++ {
    if triangle.IsValid(triangles[i]) {
      valid_count++
    }
  }
  fmt.Printf("found %d valid triangles out of %d\n", valid_count, len(triangles))
}
