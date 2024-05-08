import 'package:flutter/material.dart';

class ArticleViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Understanding Color Blindness'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Understanding Color Blindness'),
            SizedBox(height: 16.0),
            _buildArticleContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget _buildArticleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildArticleBox(
          context,
          'Color blindness, or color vision deficiency, is the inability to perceive colors accurately due to a deficiency in certain cone cells in the eyes.',
        ),
        SizedBox(height: 16.0),
        _buildArticleBox(
          context,
          'It often runs in families and affects more males than females.',
        ),
        SizedBox(height: 16.0),
        _buildArticleBox(
          context,
          'The most common type is red-green color blindness, followed by blue-yellow deficiency.',
        ),
        SizedBox(height: 16.0),
        _buildArticleBox(
          context,
          'This condition can make tasks like reading maps or identifying ripe fruit challenging.',
        ),
        SizedBox(height: 16.0),
        _buildArticleBox(
          context,
          'While there is no cure, tools like special glasses and apps can help manage it.',
        ),
        SizedBox(height: 16.0),
        _buildArticleBox(
          context,
          'Increased awareness can lead to more inclusive environments for those with color vision deficiency.',
        ),
      ],
    );
  }

  Widget _buildArticleBox(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blueAccent,
          width: 2.0,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, height: 1.5),
      ),
    );
  }
}
