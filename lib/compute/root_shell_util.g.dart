

import 'dart:core' as core$_;
import 'dart:core' show Object, String;

import 'package:jni/_internal.dart' as jni$_;
import 'package:jni/jni.dart' as jni$_;

const _$jniVersionCheck = jni$_.JniVersionCheck(1, 0);

extension type Pair<$F extends jni$_.JObject?, $S extends jni$_.JObject?>._(
  jni$_.JObject _$this
)
    implements jni$_.JObject {
  static final _class = jni$_.JClass.forName(r'androidx/core/util/Pair');

  static const jni$_.JType<Pair> type = $Pair$Type$();
  static final _id_new$ = _class.constructorId(
    r'(Ljava/lang/Object;Ljava/lang/Object;)V',
  );

  static final _new$ =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (jni$_.Pointer<jni$_.Void>, jni$_.Pointer<jni$_.Void>)
                >,
              )
            >
          >('globalEnv_NewObject')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  factory Pair($F? object, $S? object1) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    final _$object1 = object1?.reference ?? jni$_.jNullReference;
    return _new$(
      _class.reference.pointer,
      _id_new$.pointer,
      _$object.pointer,
      _$object1.pointer,
    ).object<Pair<$F, $S>>();
  }

  static final _id_create = _class.staticMethodId(
    r'create',
    r'(Ljava/lang/Object;Ljava/lang/Object;)Landroidx/core/util/Pair;',
  );

  static final _create =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (jni$_.Pointer<jni$_.Void>, jni$_.Pointer<jni$_.Void>)
                >,
              )
            >
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  static Pair<$A?, $B?>? create<
    $A extends jni$_.JObject?,
    $B extends jni$_.JObject?
  >($A? object, $B? object1) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    final _$object1 = object1?.reference ?? jni$_.jNullReference;
    return _create(
      _class.reference.pointer,
      _id_create.pointer,
      _$object.pointer,
      _$object1.pointer,
    ).object<Pair<$A?, $B?>?>();
  }
}

extension Pair$$Methods<$F extends jni$_.JObject?, $S extends jni$_.JObject?>
    on Pair<$F, $S> {
  static final _id_first = Pair._class.instanceFieldId(
    r'first',
    r'Ljava/lang/Object;',
  );

  $F? get first => _id_first.getNullable(this, jni$_.JObject.type) as $F?;

  static final _id_second = Pair._class.instanceFieldId(
    r'second',
    r'Ljava/lang/Object;',
  );

  $S? get second => _id_second.getNullable(this, jni$_.JObject.type) as $S?;

  static final _id_equals = Pair._class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  core$_.bool equals(jni$_.JObject? object) {
    final _$object = object?.reference ?? jni$_.jNullReference;
    return _equals(
      reference.pointer,
      _id_equals.pointer,
      _$object.pointer,
    ).boolean;
  }

  static final _id_hashCode$1 = Pair._class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallIntMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  core$_.int hashCode$1() {
    return _hashCode$1(reference.pointer, _id_hashCode$1.pointer).integer;
  }

  static final _id_toString$1 = Pair._class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString$1 =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  jni$_.JString? toString$1() {
    return _toString$1(
      reference.pointer,
      _id_toString$1.pointer,
    ).object<jni$_.JString?>();
  }
}

final class $Pair$Type$ extends jni$_.JType<Pair> {
  @jni$_.internal
  const $Pair$Type$();

  @jni$_.internal
  @core$_.override
  String get signature => r'Landroidx/core/util/Pair;';
}

extension type RootShellUtil._(jni$_.JObject _$this) implements jni$_.JObject {
  static final _class = jni$_.JClass.forName(
    r'com/otetswoo/app_manager/RootShellUtil',
  );

  static const jni$_.JType<RootShellUtil> type = $RootShellUtil$Type$();
  static final _id_get$isRooted = _class.staticMethodId(r'isRooted', r'()Z');

  static final _get$isRooted =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )
            >
          >('globalEnv_CallStaticBooleanMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
            )
          >();

  static core$_.bool get isRooted {
    return _get$isRooted(
      _class.reference.pointer,
      _id_get$isRooted.pointer,
    ).boolean;
  }

  static final _id_run = _class.staticMethodId(
    r'run',
    r'(Ljava/lang/String;)Landroidx/core/util/Pair;',
  );

  static final _run =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>,
              )
            >
          >('globalEnv_CallStaticObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
            )
          >();

  static Pair<jni$_.JInteger?, jni$_.JString?> run(jni$_.JString command) {
    final _$command = command.reference;
    return _run(
      _class.reference.pointer,
      _id_run.pointer,
      _$command.pointer,
    ).object<Pair<jni$_.JInteger?, jni$_.JString?>>();
  }
}

final class $RootShellUtil$Type$ extends jni$_.JType<RootShellUtil> {
  @jni$_.internal
  const $RootShellUtil$Type$();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lcom/otetswoo/app_manager/RootShellUtil;';
}
