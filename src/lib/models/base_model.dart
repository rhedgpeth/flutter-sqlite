abstract class BaseModel {
  int? id;

  void setId(int id) {
    this.id = id;
  }

  static fromMap() {}

  toMap() {}
}