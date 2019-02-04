package testdata

import "testing"

func TestSomeIndirectImportedStructFoo037(t *testing.T) {
	tests := []struct {
		name string
		smtg *someIndirectImportedStruct
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		tt.smtg.Foo037()
	}
}
