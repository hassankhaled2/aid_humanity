import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';

import 'package:aid_humanity/core/entities/request_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _searchTerm = '';
  List<RequestEntity> _allRequests = [];
  List<RequestEntity> _filteredRequests = [];
  @override
  void initState() {
    super.initState();
        BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RequestEntity> _searchRequests(
      List<RequestEntity> allRequests, String searchTerm) {
    final searchTextLower = searchTerm.toLowerCase();
    return allRequests
        .where((request) =>
            request.address[0].toLowerCase().contains(searchTextLower) ||
            request.numberOfItems
                .toString()
                .toLowerCase()
                .contains(searchTextLower) ||
            request.time.toString().toLowerCase().contains(searchTextLower))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _searchTerm = value),
          decoration: const InputDecoration(
            hintText: 'Search requests...',
          ),
        ),
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    _filteredRequests = _searchRequests(_allRequests, _searchTerm);

    return ListView.builder(
      itemCount: _filteredRequests.length,
      key: const PageStorageKey<String>('CardDeliverWidget'),
      itemBuilder: (context, index) {
        return CardWidget(
          requestEntity: _filteredRequests[index],
        );
      },
    );
  }
}
