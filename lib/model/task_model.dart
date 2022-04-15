class TaskModel implements Comparable{
  final int id;
  int order;
  String orderPrefix;

  TaskModel(this.id, this.order, this.orderPrefix);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'orderPrefix': orderPrefix,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      map['id'] as int,
      map['order'] as int,
      map['order_prefix'] as String,
    );
  }


  @override
  String toString() {
    return '{id: $id, order: $order, orderPrefix: $orderPrefix}';
  }

  @override
  int compareTo(other) {
    other = other as TaskModel;
    if(order != other.order){
      return order - other.order;
    }else{
      return orderPrefix.codeUnitAt(0) - other.orderPrefix.codeUnitAt(0);
    }
  }
}