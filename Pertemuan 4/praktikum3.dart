void main() {
  var gifts = <String, String>{
      // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };

  var nobleGases = <int, String>{
    2: 'helium',
    10: 'neon',
    18: 'argon'
  };

  gifts['sixth'] = 'Afrizal Dwi Septian';
  gifts['seventh'] = '2241720122';

  nobleGases[19] = 'Afrizal Dwi Septian';
  nobleGases[20] = '2241720122';

  var mhs1 = <String, String>{};
  mhs1['nama'] = 'Afrizal Dwi Septian';
  mhs1['nim'] = '2241720122';

  var mhs2 = <int, String>{};
  mhs2[1] = 'Afrizal Dwi Septian';
  mhs2[2] = '2241720122';

  // Cetak hasil
  print('Gifts: $gifts');
  print('Noble Gases: $nobleGases');
  print('MHS1: $mhs1');
  print('MHS2: $mhs2');
}