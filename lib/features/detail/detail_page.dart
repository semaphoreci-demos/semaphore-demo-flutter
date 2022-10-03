// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_viewmodel.dart';
import 'package:semaphoreci_flutter_demo/models/todo_item.dart';

enum DetailPageType {
  add,
  edit,
}

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.type,
    this.item,
  }) : super(key: key);

  final DetailPageType type;
  final TodoItem? item;

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  late DetailViewModel _detailViewModel;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController()
      ..addListener(() {
        _detailViewModel.enterTitle(_titleController.text);
      });

    _descriptionController = TextEditingController()
      ..addListener(() {
        _detailViewModel.enterDescription(_descriptionController.text);
      });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _detailViewModel = Provider.of<DetailViewModel>(
      context,
      listen: false,
    );
    _detailViewModel.setDetailType(widget.type);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (widget.type) {
        case DetailPageType.edit:
          _detailViewModel.setItemEditing(widget.item!);

          _titleController.text = widget.item!.title;
          _descriptionController.text = widget.item!.description;
          break;
        default:
        // Do nothing
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _detailViewModel
      ..title = ''
      ..description = '';
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveItem() {
    _detailViewModel.saveItem();
    Navigator.pop(context);
  }

  void _deleteItem() {
    _detailViewModel.deleteItemById(widget.item!.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                key: const ValueKey('input.title'),
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: TextField(
                  key: const ValueKey('input.description'),
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Selector<DetailViewModel, bool>(
                  selector: (_, vm) => vm.isSavingAllowed,
                  builder: (_, isSaving, __) => TextButton(
                    key: const ValueKey('button.save'),
                    child: Text(
                      _detailViewModel.saveLabel,
                    ),
                    onPressed: isSaving ? _saveItem : null,
                  ),
                ),
              ),
              widget.type == DetailPageType.edit
                  ? TextButton(
                      key: const ValueKey('button.delete'),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: _deleteItem,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
