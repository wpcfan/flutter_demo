import 'package:demo/models/product.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final GraphQLClient client;
  final SharedPreferences prefs;
  CartRepository(this.client, this.prefs);

  Future<QueryResult> getCart() async {
    final cartId = prefs.getString('cartId') ?? '';
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

  Future<QueryResult> addItemToCart({
    required Product product,
    int quantity = 1,
  }) async {
    final cartId = prefs.getString('cartId') ?? '';
    final query = product.toAddItemCartQL(cartId: cartId, quantity: quantity);

    return await client.mutate(MutationOptions(document: gql(query)));
  }
}
