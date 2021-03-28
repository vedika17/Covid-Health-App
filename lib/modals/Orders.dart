class Orders {
  String email,
      product,
      qty,
      name,
      number,
      addressLine1,
      addressLine2,
      landmark,
      pinCode,
      city,
      state,
      deliveryType,
      price,
      paymentID,
      paymentMode;

  Orders(
      {this.email,
        this.product,
        this.qty,
        this.name,
        this.number,
        this.addressLine1,
        this.addressLine2,
        this.landmark,
        this.pinCode,
        this.city,
        this.state,
        this.deliveryType,
        this.price,
      this.paymentID,
      this.paymentMode});
}
