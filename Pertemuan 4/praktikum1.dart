void main() {
  List<String?> list = [null, null, null, null, null];
  assert(list.length == 5);
  list[1] = 'Afrizal dwi septian';
  assert(list[1] == "Afrizal dwi septian");
  print(list.length);
  print(list[1]);

  list[2] = '2241720122';
  assert(list[2] == "2241720122");
  print(list[2]);
  print(list);
}