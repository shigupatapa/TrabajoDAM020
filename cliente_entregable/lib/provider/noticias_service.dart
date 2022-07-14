import 'package:cloud_firestore/cloud_firestore.dart';

// LISTAR TODAS LAS NOTICIAS
class FirestoreService {
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance
        .collection('noticias')
        .orderBy('fecha')
        .snapshots();
    // int limite = 5;
    // return FirebaseFirestore.instance.collection('productos').where('stock', isLessThan: limite).snapshots();
  }

  //agregar productos
  Future productosAgregar(String nombre, int stock, int precio) {
    return FirebaseFirestore.instance.collection('productos').doc().set({
      'nombre': nombre,
      'stock': stock,
      'precio': precio,
    });
  }

  //borrar producto
  Future noticiaBorrar(String idNoticia) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(idNoticia)
        .delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticia(
      String idNoticia) async {
    return await FirebaseFirestore.instance
        .collection('noticias')
        .doc(idNoticia)
        .get();
    // print(prod['nombre']);
  }

  Future noticiaEditar(
      String idNoticia, String titulo, String contenido, Timestamp fecha) {
    return FirebaseFirestore.instance
        .collection('productos')
        .doc(idNoticia)
        .update({});
  }
}
