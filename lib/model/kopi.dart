class Coffe {
  String nama;
  String img;
  double harga;
  double rate;
  String desk;

  Coffe({
    required this.nama,
    required this.img,
    required this.harga,
    required this.rate,
    required this.desk,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'img': img,
      'harga': harga,
      'rating': rate,
      'deskripsi': desk,
    };
  }

  factory Coffe.fromMap(Map<String, dynamic> map) {
    return Coffe(
      nama: map['nama'] as String,
      img: map['img'] as String,
      harga: map['harga'] as double,
      rate: map['rating'] as double,
      desk: map['deskripsi'] as String,
    );
  }
}
