import 'package:demo/models/product.dart';
import 'package:graphql/client.dart';

class CartRepository {
  final GraphQLClient client;

  CartRepository(this.client);

  Future<QueryResult> getCart(String cartId) async {
    final query = '''
      query {
        cart(id: "$cartId", currency: { code: CNY }) {
          ...CartWithItems
        }
      }

      fragment CartWithItems on Cart {
        ...CartInfo
        items {
          ...ItemInfo
        }
      }

      fragment CartInfo on Cart {
        id
        email
        isEmpty
        abandoned
        totalItems
        totalUniqueItems
        currency {
          code
          symbol
        }
        subTotal {
          amount
          formatted
        }
        shippingTotal {
          amount
          formatted
        }
        taxTotal {
          amount
          formatted
        }
        grandTotal {
          amount
          formatted
        }
        attributes {
          key
          value
        }
        notes
        createdAt
        updatedAt
      }

      fragment ItemInfo on CartItem {
        id
        name
        description
        images
        quantity
        attributes {
          key
          value
        }
        unitTotal {
          amount
          formatted
        }
        lineTotal {
          amount
          formatted
        }
        createdAt
        updatedAt
      }
    ''';

    return await client.query(QueryOptions(document: gql(query)));
  }

  Future<QueryResult> addItemToCart(
      {required String cartId,
      required Product product,
      int quantity = 1}) async {
    final query = product.toAddCartItem(cartId: cartId, quantity: quantity);

    return await client.mutate(MutationOptions(document: gql(query)));
  }
}
