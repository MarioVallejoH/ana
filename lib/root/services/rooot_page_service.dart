import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';


class RootPageService {
  Future<int> customerOrdersCount(int customerId) async {
    final res = await DataProvider.postPetition(
        ordersCountEndP, {'customer_id': customerId});

    if (res['success'] ?? 'false') {
      return res['data'];
    }

    return 0;
  }

 

  
}
