package triangle

import (
  "testing"
  "triangle"
)

func TestValidTriangle(t *testing.T) {
  sides := [3]uint16{3, 3, 3}
  if !triangle.IsValid(sides) {
    t.Fail()
  }
}

func TestInvalidTriangle(t *testing.T) {
  sides := [3]uint16{5, 10, 25}
  if triangle.IsValid(sides) {
    t.Fail()
  }
}
