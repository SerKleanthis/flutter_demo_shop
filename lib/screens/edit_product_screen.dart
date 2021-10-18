import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../packages.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit';
  Product? product;

  EditProductScreen(this.product);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String _editedTitle = '';
  double _editedPrice = 0;
  String _editedDescription = '';
  String _editedImageUrl = '';
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    if (widget.product != null) {
      _initValues = {
        'title': widget.product!.title,
        'price': widget.product!.price.toString(),
        'description': widget.product!.description,
      };
      _imageUrlController.text = widget.product!.imageUrl;
    }
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    final Product newProduct = Product(
      id: DateTime.now().toString(),
      title: _editedTitle.toString(),
      description: _editedDescription.toString(),
      price: _editedPrice,
      imageUrl: _editedImageUrl,
    );

    if (widget.product != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(widget.product!.id, newProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(newProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () => saveForm(),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title';
                  } else if (value.length <= 2) {
                    return 'The title should be more than two letters';
                  }
                  return null;
                },
                onSaved: (value) => _editedTitle = value!,
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _editedPrice = double.parse(value!),
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description';
                  } else if (value.length <= 10) {
                    return 'The description should be more than 10 letters';
                  }
                  return null;
                },
                onSaved: (value) => _editedDescription = value!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Icon(Icons.image)
                        : FittedBox(
                            child: Image.network(_imageUrlController.text)),
                  ),
                  Expanded(
                    child: TextFormField(
                      // initialValue: _imageUrlController.text,
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a description';
                        } else if (!value.startsWith('http')) {
                          return 'Url must start with \'http\' ';
                        }
                        return null;
                      },
                      onSaved: (value) => _editedImageUrl = value!,
                      // onFieldSubmitted: (_) => saveForm(),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
