enum OrderStatus {
  WAITING(value: 'Đợi chấp nhận'),
  ACCEPTED(value: 'Được chấp nhận'),
  DENIED(value: 'Từ chối'),
  DONE(value: 'Hoàn thành');

  const OrderStatus({required this.value});

  final String value;
}
