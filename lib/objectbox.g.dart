// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/models.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3389953934019898521),
      name: 'Category',
      lastPropertyId: const IdUid(3, 7449564492769467393),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6720106487545263529),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6669964458856660193),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7449564492769467393),
            name: 'description',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5916528756675404941),
      name: 'Product',
      lastPropertyId: const IdUid(22, 894791615439657838),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4847058556747779327),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7168324975933487101),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8619592148642196098),
            name: 'brand',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4644655405258632590),
            name: 'quantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 337368092018618444),
            name: 'categoryId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7257987729244978022),
            relationTarget: 'Category'),
        ModelProperty(
            id: const IdUid(6, 6089202715720497885),
            name: 'isfav',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8711267619752182687),
            name: 'price',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2484437788730319385),
            name: 'cost',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5633723744561896590),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3764661793015678899),
            name: 'dosage',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7099846800526256090),
            name: 'ailments',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 1684797180665408713),
            name: 'pallets',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 4148393620562037404),
            name: 'cartons',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 6510762856418130411),
            name: 'boxes',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2613642135343424419),
            name: 'units',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 4689375506273634743),
            name: 'tabs',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 3475274375364894290),
            name: 'alternatives',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 5011916010446311817),
            name: 'prodDate',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 894791615439657838),
            name: 'expDate',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'lines', srcEntity: 'Line', srcField: 'product')
      ]),
  ModelEntity(
      id: const IdUid(3, 5091889213843295403),
      name: 'Line',
      lastPropertyId: const IdUid(7, 5672145181803073020),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1837361562378597035),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2014910968930305501),
            name: 'quantity',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8195368306125399981),
            name: 'price',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4828359398882560386),
            name: 'total',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 719270908652112168),
            name: 'saleId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 3360469566322698672),
            relationTarget: 'Sale'),
        ModelProperty(
            id: const IdUid(7, 5672145181803073020),
            name: 'productId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 149175100905935558),
            relationTarget: 'Product')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 5704473422754214832),
      name: 'Sale',
      lastPropertyId: const IdUid(3, 620077910016436467),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5589633602412642790),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4041094267035858695),
            name: 'price',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 620077910016436467),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'lines', srcEntity: 'Line', srcField: 'sale')
      ])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 5704473422754214832),
      lastIndexId: const IdUid(4, 149175100905935558),
      lastRelationId: const IdUid(1, 371433417526591386),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [8189442990560589881],
      retiredPropertyUids: const [
        5317687405017344953,
        2323582628500759881,
        2632241725238188460,
        4624677381553813485
      ],
      retiredRelationUids: const [371433417526591386],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Category: EntityDefinition<Category>(
        model: _entities[0],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {},
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Category(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    Product: EntityDefinition<Product>(
        model: _entities[1],
        toOneRelations: (Product object) => [object.category],
        toManyRelations: (Product object) => {
              RelInfo<Line>.toOneBacklink(
                      7, object.id, (Line srcObject) => srcObject.product):
                  object.lines
            },
        getId: (Product object) => object.id,
        setId: (Product object, int id) {
          object.id = id;
        },
        objectToFB: (Product object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final brandOffset = fbb.writeString(object.brand);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final dosageOffset =
              object.dosage == null ? null : fbb.writeString(object.dosage!);
          final ailmentsOffset = object.ailments == null
              ? null
              : fbb.writeString(object.ailments!);
          final alternativesOffset = object.alternatives == null
              ? null
              : fbb.writeString(object.alternatives!);
          fbb.startTable(23);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, brandOffset);
          fbb.addInt64(3, object.quantity);
          fbb.addInt64(4, object.category.targetId);
          fbb.addBool(5, object.isfav);
          fbb.addInt64(6, object.price);
          fbb.addInt64(7, object.cost);
          fbb.addOffset(8, descriptionOffset);
          fbb.addOffset(9, dosageOffset);
          fbb.addOffset(10, ailmentsOffset);
          fbb.addInt64(12, object.pallets);
          fbb.addInt64(13, object.cartons);
          fbb.addInt64(14, object.boxes);
          fbb.addInt64(15, object.units);
          fbb.addInt64(16, object.tabs);
          fbb.addOffset(19, alternativesOffset);
          fbb.addInt64(20, object.prodDate?.millisecondsSinceEpoch);
          fbb.addInt64(21, object.expDate?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final prodDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 44);
          final expDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 46);
          final object = Product(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              isfav: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 14, false),
              cost: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20),
              dosage: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22),
              ailments: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 24),
              alternatives: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 42),
              pallets: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 28),
              cartons: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 30),
              boxes: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 32),
              units: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 34),
              tabs: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 36),
              prodDate: prodDateValue == null ? null : DateTime.fromMillisecondsSinceEpoch(prodDateValue),
              expDate: expDateValue == null ? null : DateTime.fromMillisecondsSinceEpoch(expDateValue));
          object.category.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.category.attach(store);
          InternalToManyAccess.setRelInfo(
              object.lines,
              store,
              RelInfo<Line>.toOneBacklink(
                  7, object.id, (Line srcObject) => srcObject.product),
              store.box<Product>());
          return object;
        }),
    Line: EntityDefinition<Line>(
        model: _entities[2],
        toOneRelations: (Line object) => [object.sale, object.product],
        toManyRelations: (Line object) => {},
        getId: (Line object) => object.id,
        setId: (Line object, int id) {
          object.id = id;
        },
        objectToFB: (Line object, fb.Builder fbb) {
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.quantity);
          fbb.addInt64(2, object.price);
          fbb.addInt64(3, object.total);
          fbb.addInt64(4, object.sale.targetId);
          fbb.addInt64(6, object.product.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Line(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.sale.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.sale.attach(store);
          object.product.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.product.attach(store);
          return object;
        }),
    Sale: EntityDefinition<Sale>(
        model: _entities[3],
        toOneRelations: (Sale object) => [],
        toManyRelations: (Sale object) => {
              RelInfo<Line>.toOneBacklink(
                      5, object.id, (Line srcObject) => srcObject.sale):
                  object.lines
            },
        getId: (Sale object) => object.id,
        setId: (Sale object, int id) {
          object.id = id;
        },
        objectToFB: (Sale object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.price);
          fbb.addInt64(2, object.date.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Sale(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(
              object.lines,
              store,
              RelInfo<Line>.toOneBacklink(
                  5, object.id, (Line srcObject) => srcObject.sale),
              store.box<Sale>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// see [Category.id]
  static final id = QueryIntegerProperty<Category>(_entities[0].properties[0]);

  /// see [Category.name]
  static final name = QueryStringProperty<Category>(_entities[0].properties[1]);

  /// see [Category.description]
  static final description =
      QueryStringProperty<Category>(_entities[0].properties[2]);
}

/// [Product] entity fields to define ObjectBox queries.
class Product_ {
  /// see [Product.id]
  static final id = QueryIntegerProperty<Product>(_entities[1].properties[0]);

  /// see [Product.name]
  static final name = QueryStringProperty<Product>(_entities[1].properties[1]);

  /// see [Product.brand]
  static final brand = QueryStringProperty<Product>(_entities[1].properties[2]);

  /// see [Product.quantity]
  static final quantity =
      QueryIntegerProperty<Product>(_entities[1].properties[3]);

  /// see [Product.category]
  static final category =
      QueryRelationToOne<Product, Category>(_entities[1].properties[4]);

  /// see [Product.isfav]
  static final isfav =
      QueryBooleanProperty<Product>(_entities[1].properties[5]);

  /// see [Product.price]
  static final price =
      QueryIntegerProperty<Product>(_entities[1].properties[6]);

  /// see [Product.cost]
  static final cost = QueryIntegerProperty<Product>(_entities[1].properties[7]);

  /// see [Product.description]
  static final description =
      QueryStringProperty<Product>(_entities[1].properties[8]);

  /// see [Product.dosage]
  static final dosage =
      QueryStringProperty<Product>(_entities[1].properties[9]);

  /// see [Product.ailments]
  static final ailments =
      QueryStringProperty<Product>(_entities[1].properties[10]);

  /// see [Product.pallets]
  static final pallets =
      QueryIntegerProperty<Product>(_entities[1].properties[11]);

  /// see [Product.cartons]
  static final cartons =
      QueryIntegerProperty<Product>(_entities[1].properties[12]);

  /// see [Product.boxes]
  static final boxes =
      QueryIntegerProperty<Product>(_entities[1].properties[13]);

  /// see [Product.units]
  static final units =
      QueryIntegerProperty<Product>(_entities[1].properties[14]);

  /// see [Product.tabs]
  static final tabs =
      QueryIntegerProperty<Product>(_entities[1].properties[15]);

  /// see [Product.alternatives]
  static final alternatives =
      QueryStringProperty<Product>(_entities[1].properties[16]);

  /// see [Product.prodDate]
  static final prodDate =
      QueryIntegerProperty<Product>(_entities[1].properties[17]);

  /// see [Product.expDate]
  static final expDate =
      QueryIntegerProperty<Product>(_entities[1].properties[18]);
}

/// [Line] entity fields to define ObjectBox queries.
class Line_ {
  /// see [Line.id]
  static final id = QueryIntegerProperty<Line>(_entities[2].properties[0]);

  /// see [Line.quantity]
  static final quantity =
      QueryIntegerProperty<Line>(_entities[2].properties[1]);

  /// see [Line.price]
  static final price = QueryIntegerProperty<Line>(_entities[2].properties[2]);

  /// see [Line.total]
  static final total = QueryIntegerProperty<Line>(_entities[2].properties[3]);

  /// see [Line.sale]
  static final sale =
      QueryRelationToOne<Line, Sale>(_entities[2].properties[4]);

  /// see [Line.product]
  static final product =
      QueryRelationToOne<Line, Product>(_entities[2].properties[5]);
}

/// [Sale] entity fields to define ObjectBox queries.
class Sale_ {
  /// see [Sale.id]
  static final id = QueryIntegerProperty<Sale>(_entities[3].properties[0]);

  /// see [Sale.price]
  static final price = QueryIntegerProperty<Sale>(_entities[3].properties[1]);

  /// see [Sale.date]
  static final date = QueryIntegerProperty<Sale>(_entities[3].properties[2]);
}
