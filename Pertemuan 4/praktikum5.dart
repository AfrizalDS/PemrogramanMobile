(String, int, int, String) tukar((String, int, int, String) record) {
  var (a, b, c, d) = record;
  return (d, c, b, a);
}

// void main() {
//   var record = (1, 2);
//   print(record);
//   print(tukar(record));
// }

void main() {
  // var record = ('first', a: 2, b: true, 'last');
  var record = ('first', 2, 4, 'last');
  print(record);
  print(tukar(record));

  // Record type annotation in a variable declaration:
(String, int) mahasiswa = ('Afrizal Dwi Septian', 2241720122);
print(mahasiswa);

var mahasiswa2 = ('first', a:'Afrizal Dwi Septian', b:2241720122, 'last');

print(mahasiswa2.$1); // Prints 'first'
print(mahasiswa2.a); // Prints 2
print(mahasiswa2.b); // Prints true
print(mahasiswa2.$2); // Prints 'last'

}
