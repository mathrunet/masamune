part of masamune_purchase_stripe;

class StripeCustomer extends ChangeNotifier {
  StripeCustomer();

  static Completer<void>? _completer;

  static const documentQuery = StripeUserModel.document;
  static const collectionQuery = StripeUserModel.collection;

  Future<void> create({
    required String userId,
    required void Function(
      Widget webView,
      VoidCallback onSuccess,
      VoidCallback onCancel,
    ) builder,
    VoidCallback? onClosed,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    if (_completer != null) {
      return _completer!.future;
    }
    _completer = Completer<void>();
    Completer<void>? internalCompleter = Completer<void>();
    try {
      if (userId.isEmpty) {
        throw Exception("You are not logged in. Please log in once.");
      }
      final modelQuery = documentQuery(userId).modelQuery;
      final userDocument = $StripeUserModelDocument(modelQuery);
      final functionsAdapter =
          StripePurchaseMasamuneAdapter.primary.functionsAdapter ??
              FunctionsAdapter.primary;
      final callbackHost = StripePurchaseMasamuneAdapter.primary.callbackHost
          .toString()
          .trimQuery()
          .trimString("/");

      final response = await functionsAdapter.stipe(
        action: StripeCreateCustomerAndPaymentAction(
          userId: userId,
          successUrl: Uri.parse("$callbackHost/create_payment/success"),
          cancelUrl: Uri.parse("$callbackHost/create_payment/cancel"),
        ),
      );

      if (response == null || response.customerId.isEmpty) {
        throw Exception("Response is invalid.");
      }
      onSuccess() {
        internalCompleter?.complete();
        internalCompleter = null;
      }

      onCancel() {
        internalCompleter?.completeError(StripeCancelException());
        internalCompleter = null;
      }

      final webView = _StripeWebview(
        response.endpoint,
        shouldOverrideUrlLoading: (controller, url) {
          final path = url.trimQuery().replaceAll(callbackHost, "");
          switch (path) {
            case "/create_payment/success":
              onClosed?.call();
              onSuccess.call();
              return NavigationActionPolicy.CANCEL;
            case "/create_payment/cancel":
              onClosed?.call();
              onCancel.call();
              return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
        onCloseWindow: (controller) {
          onCancel.call();
        },
      );
      builder.call(webView, onSuccess, onCancel);
      await internalCompleter!.future;
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        await userDocument.load();
        return userDocument.value?.customerId.isNotEmpty ?? false;
      }).timeout(timeout);
      _completer?.complete();
      _completer = null;
      internalCompleter?.complete();
      internalCompleter = null;
      notifyListeners();
    } catch (e) {
      _completer?.completeError(e);
      _completer = null;
      internalCompleter?.completeError(e);
      internalCompleter = null;
      rethrow;
    } finally {
      _completer?.complete();
      _completer = null;
      internalCompleter?.complete();
      internalCompleter = null;
    }
  }

  Future<void> delete({
    required StripeUserModel customer,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    if (_completer != null) {
      return _completer!.future;
    }
    _completer = Completer<void>();
    try {
      if (customer.customerId.isEmpty) {
        throw Exception(
          "Customer information is empty. Please run [create] method.",
        );
      }
      final modelQuery = documentQuery(customer.userId).modelQuery;
      final userDocument = $StripeUserModelDocument(modelQuery);
      final functionsAdapter =
          StripePurchaseMasamuneAdapter.primary.functionsAdapter ??
              FunctionsAdapter.primary;

      final response = await functionsAdapter.stipe(
        action: StripeDeleteCustomerAction(
          userId: customer.userId,
        ),
      );
      if (response == null) {
        throw Exception("Response is invalid.");
      }
      await Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        await userDocument.load();
        return !(userDocument.value?.customerId.isNotEmpty ?? false);
      }).timeout(timeout);
      _completer?.complete();
      _completer = null;
      notifyListeners();
    } catch (e) {
      _completer?.completeError(e);
      _completer = null;
      rethrow;
    } finally {
      _completer?.complete();
      _completer = null;
    }
  }
}
