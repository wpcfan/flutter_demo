import 'package:graphql/client.dart';

class CartRepository {
  final GraphQLClient client;

  CartRepository(this.client);

  Future<QueryResult> getCart() async {
    const query = r'''
      query {
        cart(id: "abcs23132", currency: { code: CNY }) {
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
}
