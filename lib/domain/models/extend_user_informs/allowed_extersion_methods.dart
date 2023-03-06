class AllowedExtersionMethods {
  int? i0;
  int? status;
  List<Extension>? data;

  AllowedExtersionMethods(this.i0, this.status, this.data);
}

class Extension {
  int? id;
  String? name;
  // String? price;

  Extension(this.id, this.name);
  // Extension(this.id, this.name, this.price);
}
