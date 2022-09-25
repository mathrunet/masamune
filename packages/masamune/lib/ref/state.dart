part of masamune;

@deprecated
extension WidgetRefValueNotifierExtensions on WidgetRef {
  @Deprecated(
    "It will not be available from the next version. Use [ValueNotifierProvider] instead.",
  )
  ValueNotifier<T> state<T>(
    T defaultValue, {
    String hookId = "",
  }) {
    return valueBuilder<ValueNotifier<T>, _ValueNotifierValue<T>>(
      key: "valueNotifier:$hookId",
      builder: () {
        return _ValueNotifierValue<T>(defaultValue);
      },
    );
  }
}

@deprecated
class _ValueNotifierValue<T> extends ScopedValue<ValueNotifier<T>> {
  const _ValueNotifierValue(this.initialValue);
  final T initialValue;
  @override
  ScopedValueState<ValueNotifier<T>, ScopedValue<ValueNotifier<T>>>
      createState() => _ValueNotifierValueState<T>();
}

@deprecated
class _ValueNotifierValueState<T>
    extends ScopedValueState<ValueNotifier<T>, _ValueNotifierValue<T>> {
  late ValueNotifier<T> _valueNotifier;

  @override
  void initValue() {
    super.initValue();
    _valueNotifier = ValueNotifier<T>(value.initialValue);
    _valueNotifier.addListener(_handledOnUpdate);
  }

  @override
  void didUpdateValue(_ValueNotifierValue<T> oldValue) {
    super.didUpdateValue(oldValue);
    if (value.initialValue != oldValue.initialValue) {
      _valueNotifier.value = value.initialValue;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _valueNotifier.removeListener(_handledOnUpdate);
    _valueNotifier.dispose();
  }

  @override
  ValueNotifier<T> build() => _valueNotifier;

  void _handledOnUpdate() {
    setState(() {});
  }
}
