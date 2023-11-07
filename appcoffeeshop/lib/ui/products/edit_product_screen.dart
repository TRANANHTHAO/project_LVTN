import 'package:appcoffeeshop/models/product_type.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../shared/dialog_utils.dart';
import 'products_manager.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        description: '',
        imageUrl: '',
        favoriteId: '',
        creatorId: '',
        commentId: '',
        type: '',
      );
    } else {
      this.product = product;
    }
  }

  late final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  String? _selectedValue;
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        //anh hop le
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      print(error);
      await showErrorDialog(context, "Something went wrong.");
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 85,
        leadingWidth: 50,
        title: const Text('Thêm Sản Phẩm'),
        actions: <Widget>[
          Ink(
            //padding: EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: const ShapeDecoration(
              color: Color.fromARGB(255, 239, 91, 46),
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ),
        ],
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      body: _isLoading
          ? const Center(
              // child: CircularProgressIndicator(
              //     //backgroundColor: Colors.white,
              //     //color: Colors.green,
              //     ),
              )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 253, 242, 225)),
                child: Form(
                  key: _editForm,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: <Widget>[
                      buildTitleField(),
                      const SizedBox(
                        height: 8,
                      ),
                      buildPriceFeild(),
                      const SizedBox(
                        height: 8,
                      ),
                      buildDescriptionField(),
                      const SizedBox(
                        height: 30,
                      ),
                      _selectedTypeOfProduct(),
                      const SizedBox(
                        height: 8,
                      ),
                      buildProductPreview(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(labelText: 'Tên Sản Phẩm'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên.";
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

  TextFormField buildPriceFeild() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: const InputDecoration(labelText: "Giá"),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập giá trị.";
        }
        if (double.tryParse(value) == null) {
          return "Vui lòng nhập số hợp lệ.";
        }
        if (double.parse(value) <= 0) {
          return "Vui lòng nhập số lớn hơn 0 (Không).";
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(labelText: "Mô Tả Sản Phẩm"),
      maxLines: 2,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập mô tả.";
        }
        if (value.length < 10) {
          return "Mô tả ít nhất 10 kí tự.";
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.only(top: 40, right: 10),
            decoration: BoxDecoration(
                border: Border.all(
              width: 2,
              color: const Color.fromARGB(255, 239, 91, 46),
            )),
            child: _imageUrlController.text.isEmpty
                ? const Text(
                    "Ảnh",
                    textAlign: TextAlign.center,
                  )
                : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  )),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Ảnh Sản Phẩm"),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập hình ảnh liên kết.";
        }
        if (!_isValidImageUrl(value)) {
          return "Hình ảnh liên kết không hợp lệ.";
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }

  Widget _selectedTypeOfProduct() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: Text(
        _editedProduct.id == null ? 'Chọn loại sản phẩm' : _editedProduct.type,
        style: const TextStyle(fontSize: 14),
      ),
      items: ProductType.values
          .map((item) => DropdownMenuItem<String>(
                value: item.name,
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        _editedProduct = _editedProduct.copyWith(type: value.toString());
      },
      onSaved: (value) {
        _selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
