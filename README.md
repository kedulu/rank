# Rank

A Dart package that helps to implement a string index.

## Installation

```yaml
dependencies:
  rank: ^0.0.1
```

## Overview
Before:
```dart
class Person {
  const Person(..., this.previousId, nextId);
  ...
  final String previousId;
  final String nextId;
}
```
Using `rank`
```dart
class Person {
  const Person(..., this.rank);
  ...
  final String rank;
}
```
then, you could perform this query in your database:

```sql
SELECT * FROM "_" ORDER BY "RANK";
```

## Usage

First, add the plugin `rank` to your `pubspec.yaml` file:
```yaml
dependencies:
  rank: ^0.0.1
```

To get a rank use `generate`

```dart
rank.generate(previous: previousRank, next:nextRank);
```
That's all, for now.

## Issues

Please file any issues, bugs or feature request as an issue on our GitHub page.

## Contributing

If you would like to contribute to the plugin (_e.g._ by improving the documentation, solving a bug or adding a cool new feature or you'd like an easier or better way to do something), consider opening a pull request. 


