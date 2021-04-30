import 'package:flutter_app/models/Products.dart';
import 'package:flutter_app/myStore.dart';
import 'package:test/test.dart';

List<Products> product = [Products(id: 1,title: "Office Code",price: 234,size: 1,description: dummyText,image: "assets/bag_1.png",)];

void main() {
  test('Products need to be setted products', () {
    final store = myStore();
    store.setProduct(product);


    expect(store.products, product);
  });

  test('active product neet to be setted active product', () {
    final store = myStore();
    store.setProduct(product);
    store.setActiveProduct(product[0]);

    expect(store.activeProduct, product[0]);
  });

  test('Total shopping card balance need to be total price', () {
    final store = myStore();
    store.setProduct(product);
    store.addOneItemBasket(product[0]);


    expect(store.getTotalCost(), product[0].price);
  });

  test('Total item number needs to be same with added', () {
    final store = myStore();
    store.setProduct(product);
    store.addOneItemBasket(product[0]);

    expect(store.getBasketQty(), 1);
  });

  test('Product need to be removed from basket', () {
    final store = myStore();
    store.setProduct(product);
    store.addOneItemBasket(product[0]);
    store.removeBasket(product[0]);

    expect(store.getBasketQty(), 0);
  });

  test('Get method need to retrieve the same products', () {
    final store = myStore();
    store.setProduct(product);
    store.addOneItemBasket(product[0]);


    expect(store.getProducts(), product);
  });

  test('Added items on shopping card need to retrieve from basket', () {
    final store = myStore();
    store.setProduct(product);
    store.addOneItemBasket(product[0]);


    expect(store.baskets, product);
  });
}