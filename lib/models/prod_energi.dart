// model
class DataModel {
  String? day;
  List<KhwProd>? khwProd;

  DataModel({this.day, this.khwProd});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      day: json['day'],
      khwProd: List<KhwProd>.from(
        json['khw_prod'].map(
          (khwProdJson) => KhwProd.fromJson(khwProdJson),
        ),
      ),
    );
  }
}

class KhwProd {
  String? name;
  double? kwhAc;
  double? kwhDc;

  KhwProd({this.name, this.kwhAc, this.kwhDc});

  factory KhwProd.fromJson(Map<String, dynamic> json) {
    String name = '';
    switch (json['name']) {
      case 'Wind Turbine':
        name = 'PLTB';
        break;
      case 'Solar Panel':
        name = 'PLTS';
        break;
      case 'Generator Diesel':
        name = 'PLTD';
        break;
      default:
        name = '';
    }
    return KhwProd(
      name: name,
      kwhAc: json['kwh_ac']?.toDouble() ?? 0,
      kwhDc: json['kwh_dc']?.toDouble() ?? 0,
    );
  }
  String getImageAsset() {
    if (name == 'PLTB') {
      return 'img/pltb.png';
    } else if (name == 'PLTS') {
      return 'img/plts.png';
    } else if (name == 'PLTD') {
      return 'img/pltd.png';
    }
    return "";
  }
}
