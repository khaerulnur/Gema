class Account {
  String? deskripsi;
  int? harga;
  String? idPenjual;
  String? informasiGame;
  String? status;
  String? tautanGambar;
  String? waktuPost;

  Account(
      {this.deskripsi,
      this.harga,
      this.idPenjual,
      this.informasiGame,
      this.status,
      this.tautanGambar,
      this.waktuPost});

  Account.fromJson(Map<String, dynamic> json) {
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    idPenjual = json['idPenjual'];
    informasiGame = json['informasiGame'];
    status = json['status'];
    tautanGambar = json['tautanGambar'];
    waktuPost = json['waktuPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deskripsi'] = deskripsi;
    data['harga'] = harga;
    data['idPenjual'] = idPenjual;
    data['informasiGame'] = informasiGame;
    data['status'] = status;
    data['tautanGambar'] = tautanGambar;
    data['waktuPost'] = waktuPost;
    return data;
  }
}
