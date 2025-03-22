import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:project_dom/dbUtils/db_helper.dart';
import 'package:project_dom/dbUtils/item.dart';
import 'package:project_dom/models/books.dart';
// import 'package:sqflite/sqflite.dart';

class FormExampleApp extends StatefulWidget {
  const FormExampleApp({super.key});

  @override
  State<FormExampleApp> createState() => _FormExampleAppState();
}

class _FormExampleAppState extends State<FormExampleApp> {
  List<String?> imageUrls = demoBooks.map((book) => book.imageUrl).toList();
  int count = 3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo Form",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: FormPage(title: "Product Add Form"),
      home: Scaffold(
          appBar: AppBar(
            title: Text("hell22o"),
            backgroundColor: Colors.amber,
          ),
          body: GridView.count(
            crossAxisCount: count,
            crossAxisSpacing: 30,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/330px-The_Great_Gatsby_Cover_1925_Retouched.jpg"),
                        fit: BoxFit.cover)),
                child: Text(MediaQuery.of(context).size.width.toString()),
              ),
              Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/330px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg"),
              Image.network(
                  "https://upload.wikimedia.org/wikipedia/en/5/51/1984_first_edition_cover.jpg"),
              Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg/330px-The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg"),
              Image.network(
                  "https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg"),
              ElevatedButton.icon(
                  onPressed: () {
                    // setState(() {
                    //   count++;
                    // });
                    displayToastMessage("Added");
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add")),
              ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (count > 2) count--;
                    });
                    displayToastMessage(
                      "Removed",
                    );
                  },
                  icon: Icon(Icons.remove),
                  label: Text("Remove")),
            ],
          )),
    );
  }
}

displayToastMessage(String message) {
  Fluttertoast.showToast(msg: message);
}

class FormPage extends StatefulWidget {
  final String title;
  const FormPage({required this.title, Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Item? selectedItem;
  int currentIndex = 0;
  Widget? page;

  // Future<List<Item>> items = DatabaseHelper2().getAllItems();
  List<Item> items = [];

  void updateItems() async {
    var items2 = await DatabaseHelper2().getAllItems();
    setState(() {
      items = items2;
    });
  }

  void editItem(int id) async {
    var item = await DatabaseHelper2().getItem(id);
    setState(() {
      selectedItem = item;
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentIndex) {
      case 0:
        page = ItemForm(item: selectedItem);
      // page = MyListView();
      case 1:
        page = ItemList(
            items: items, updateItems: updateItems, editItem: editItem);
      // updateItems();
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: page,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                  selectedItem = null;
                });
              },
              child: const Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
                updateItems();
              },
              child: const Text("List"),
            )
          ],
        ),
      ),
    );
  }
}

class ItemForm extends StatefulWidget {
  final Item? item;
  const ItemForm({this.item});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _inStock = false;
  DateTime _expirationDate = DateTime.now();
  String? _selectedCategory;

  final List<String> _categories = ['Electroics', 'Clothing', 'Groceries'];

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
      _quantityController.text = widget.item!.quantity.toString();
      _descriptionController.text = widget.item!.description;
      _inStock = widget.item!.inStock;
      _expirationDate = widget.item!.expirationDate;
      _selectedCategory = widget.item!.category;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _expirationDate)
      setState(() {
        _expirationDate = picked;
      });
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('MM-dd-yyyy').format(date);
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        id: widget.item?.id,
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        price: double.parse(_priceController.text),
        inStock: _inStock,
        expirationDate: _expirationDate,
        description: _descriptionController.text,
        category: _selectedCategory ??
            'Uncategorized', // Default to 'Uncategorized' if not selected
      );
      print(item.toString());

      if (widget.item == null) {
        int i = await DatabaseHelper2().insertItem(item);
        print("inserted" + i.toString());
      } else {
        await DatabaseHelper2().updateItem(item);
        print("updated");
      }

      // Navigator.pop(context, true); // Return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Item Name'),
            validator: (value) => value!.isEmpty ? 'Enter item name' : null,
          ),
          TextFormField(
            controller: _quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => value!.isEmpty ? 'Enter price' : null,
          ),
          CheckboxListTile(
            title: Text('In Stock'),
            value: _inStock,
            onChanged: (bool? value) {
              setState(() {
                _inStock = value ?? false;
              });
            },
          ),
          ListTile(
            title: Text(
              'Expiration Date : ${getFormattedDate(_expirationDate)}',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDate(context),
          ),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(labelText: 'Category'),
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            validator: (value) => value == null ? 'Select a category' : null,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveItem,
            child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList(
      {required this.items,
      required this.updateItems,
      required this.editItem,
      super.key});

  final Function editItem;

  final List<Item> items;
  final Function updateItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Item List'),
          for (var item in items)
            ListTile(
              leading: ElevatedButton(
                  onPressed: () {
                    editItem(item.id!);
                  },
                  child: Text(item.id.toString())),
              title: Text(item.name),
              subtitle: Text('Quantity: ${item.quantity}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await DatabaseHelper2().deleteItem(item.id!);
                  updateItems();
                  // Rebuild the widget tree to update the UI
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ItemListPage()),
                  // );
                },
              ),
            ),
        ],
      ),
    );
  }
}
