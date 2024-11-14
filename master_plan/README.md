# Pertemuan 11 - Dasar State Management

## Praktikum 1: Dasar State dengan Model-View

### Langkah 1: Buat Project Baru

![alt text](assets/image.png)

### Langkah 2: Membuat model task.dart

Praktik terbaik untuk memulai adalah pada lapisan data (data layer). Ini akan memberi Anda gambaran yang jelas tentang aplikasi Anda, tanpa masuk ke detail antarmuka pengguna Anda. **Di folder model, buat file bernama task.dart dan buat class Task.** Class ini memiliki atribut description dengan tipe data String dan complete dengan tipe data Boolean, serta ada konstruktor. Kelas ini akan menyimpan data tugas untuk aplikasi kita. Tambahkan kode berikut:

```dart
class Task {
  final String description;
  final bool complete;

  const Task({
    this.complete = false,
    this.description = '',
  });
}
```

![alt text](assets/image-1.png)

### Langkah 3: Buat file plan.dart

Kita juga perlu sebuah List untuk menyimpan daftar rencana dalam aplikasi to-do ini. Buat **file plan.dart** di dalam folder **models** dan isi kode seperti berikut.

```dart
import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});
}
```

![alt text](assets/image-2.png)

### Langkah 4: Buat file data_layer.dart

Kita dapat membungkus beberapa data layer ke dalam sebuah file yang nanti akan mengekspor kedua model tersebut. Dengan begitu, proses impor akan lebih ringkas seiring berkembangnya aplikasi. Buat file bernama **data_layer.dart** di folder **models**. Kodenya hanya berisi **export** seperti berikut.

```dart
export 'plan.dart';
export 'task.dart';
```

![alt text](assets/image-3.png)

### Langkah 5: Pindah ke file main.dart

Ubah isi kode main.dart sebagai berikut.

```dart
import 'package:flutter/material.dart';
import './views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(primarySwatch: Colors.purple),
     home: PlanScreen(),
    );
  }
}
```

![alt text](assets/image-4.png)

### Langkah 6: buat plan_screen.dart

Pada folder **views**, buatlah sebuah file **plan_screen.dart** dan gunakan templat StatefulWidget untuk membuat class PlanScreen. Isi kodenya adalah sebagai berikut. Gantilah teks ‘Namaku' dengan nama panggilan Anda pada title AppBar.

```dart
import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    // ganti ‘Namaku' dengan Nama panggilan Anda
    appBar: AppBar(title: const Text('Master Plan Nurul Mustofa')),
    body: _buildList(),
    floatingActionButton: _buildAddTaskButton(),
   );
  }
}
```

![alt text](assets/image-5.png)

### Langkah 7: buat method \_buildAddTaskButton()

Anda akan melihat beberapa error di langkah 6, karena method yang belum dibuat. Ayo kita buat mulai dari yang paling mudah yaitu tombol Tambah Rencana. Tambah kode berikut di bawah method build di dalam **class \_PlanScreenState**.

```dart
  Widget _buildAddTaskButton() {
  return FloatingActionButton(
   child: const Icon(Icons.add),
   onPressed: () {
     setState(() {
      plan = Plan(
       name: plan.name,
       tasks: List<Task>.from(plan.tasks)
       ..add(const Task()),
     );
    });
   },
  );
}
```

![alt text](assets/image-6.png)

### Langkah 8: buat widget \_buildList()

Kita akan buat widget berupa List yang dapat dilakukan scroll, yaitu ListView.builder. Buat widget **ListView** seperti kode berikut ini.

```dart
Widget _buildList() {
  return ListView.builder(
   itemCount: plan.tasks.length,
   itemBuilder: (context, index) =>
   _buildTaskTile(plan.tasks[index], index),
  );
}
```

![alt text](assets/image-7.png)

### Langkah 9: buat widget \_buildTaskTile

Dari langkah 8, kita butuh ListTile untuk menampilkan setiap nilai dari **plan.tasks**. Kita buat dinamis untuk setiap index data, sehingga membuat **view** menjadi lebih mudah. Tambahkan kode berikut ini.

```dart
Widget _buildTaskTile(Task task, int index) {
    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              plan = Plan(
                name: plan.name,
                tasks: List<Task>.from(plan.tasks)
                  ..[index] = Task(
                    description: task.description,
                    complete: selected ?? false,
                  ),
              );
            });
          }),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
          });
        },
      ),
    );
  }
```

![alt text](assets/image-8.png)

### Langkah 10: Tambah Scroll Controller

Anda dapat menambah tugas sebanyak-banyaknya, menandainya jika sudah beres, dan melakukan scroll jika sudah semakin banyak isinya. Namun, ada salah satu fitur tertentu di iOS perlu kita tambahkan. Ketika keyboard tampil, Anda akan kesulitan untuk mengisi yang paling bawah. Untuk mengatasi itu, Anda dapat menggunakan **ScrollController** untuk menghapus focus dari semua **TextField** selama event scroll dilakukan. Pada file **plan_screen.dart**, tambahkan variabel scroll controller di class State tepat setelah variabel **plan**.

```dart
late ScrollController scrollController;
```

![alt text](assets/image-9.png)

### Langkah 11: Tambah Scroll Listener

Tambahkan method **initState()** setelah deklarasi variabel **scrollController** seperti kode berikut.

```dart
@override
void initState() {
  super.initState();
  scrollController = ScrollController()
    ..addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
}
```

![alt text](assets/image-10.png)

### Langkah 12: Tambah controller dan keyboard behavior

Tambahkan controller dan keyboard behavior pada ListView di method \_buildList seperti kode berikut ini.

```dart
Widget _buildList() {
  return ListView.builder(
    controller: scrollController,
    keyboardDismissBehavior: Theme.of(context).platform ==
    TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
  );
}
```

![alt text](assets/image-11.png)

### Langkah 13: Terakhir, tambah method dispose()

```dart
@override
void dispose() {
  scrollController.dispose();
  super.dispose();
}
```

![alt text](assets/image-12.png)

## Tugas Praktikum 1: Dasar State dengan Model-View

1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki.

2. Jelaskan maksud dari langkah 4 pada praktikum tersebut! Mengapa dilakukan demikian?  
   **Jawab:**
   Langkah 4 berperan sebagai titik pusat ekspor untuk semua model terkait, seperti plan.dart dan task.dart, yang memungkinkan proses impor menjadi lebih efisien dan terstruktur. Pendekatan ini mempermudah pengelolaan layer data, mengurangi kemungkinan terjadinya impor yang berlebihan, serta meningkatkan keterbacaan kode secara keseluruhan.

3. Mengapa perlu variabel plan di langkah 6 pada praktikum tersebut? Mengapa dibuat konstanta ?  
   **Jawab:**
   Variabel plan berfungsi untuk menyimpan dan mengelola data yang akan ditampilkan serta dimodifikasi di layar PlanScreen. Variabel ini diinisialisasi sebagai konstanta untuk memastikan nilai awalnya tetap konstan dan tidak berubah, yang membantu menjaga stabilitas aplikasi sebelum data dimasukkan atau diubah oleh pengguna.

4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!  
   **Jawab:**

   ![alt text](assets/ss-tugas1.png)

5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?  
   **Jawab:** Langkah 11 initState() digunakan untuk menginisialisasi kontrol scroll saat layar pertama kali dibuka, memastikan fungsionalitas pengguliran berjalan dengan baik. Sedangkan langkah 13 dispose() berfungsi untuk membersihkan kontrol dan sumber daya lainnya ketika layar ditutup, yang membantu menjaga efisiensi aplikasi dan mencegah kebocoran memori.
