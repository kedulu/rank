# Rank

A Dart package that helps to implement a string index.

## Overview
__Before:__
```dart
class Element {
  const Element(..., this.position);

  ...
  final int position;  // 4
}
```
With a order number based ranking system, re-ordering a element of a list may require updating all elements of the list, which is O(n).

| element   | position              |
|-----------|-----------------------|
| ...     | ...                 |
| apple     | 3                     |
| __from _ to here__          | Oh ho! <br> No room between 3 and 4. |
| pear      | 4                     |
| raspberry | 5                     |

Well, let's try adding zeros.

| element   | position              |
|-----------|-----------------------|
| ...     | ...                 |
| apple     | 300                     |
| __from _ to here__          | Now, you can add 99 elements <br> before changing anything. |
| pear      | 400                     |
| raspberry | 500                     |

What if we don't use numbers?

__Using__ `rank`
```dart
class Element {
  const Element(..., this.rank);
  ...
  final String rank; // kran
}
```
Using a string-based range, this is done with O(1). All you have to do is to update the rank field of the reordered element.

| element   | rank              |
|-----------|-----------------------|
| ...     | ...                 |
| apple     | kra                     |
| __a sweet fruit added__   | kran |
| pear      | krb                     |
| raspberry | krc                     |

Now, you can add any element anywhere.

Then, to get your sorted list you could perform this query in your database:

```sql
SELECT * FROM "_" ORDER BY "rank";
```

## Usage

First, add the plugin `rank` to your `pubspec.yaml` file:
```yaml
dependencies:
  rank: ^0.1.0
```

Import `rank` in files that it will be used:

```dart
import 'package:rank/rank.dart';
```

Next, you must initialize the plugin:

```dart
Rank rank = Rank();
```

To get a rank use `generate`

```dart
sweetFruitRank = rank.generate(previous: appleRank, next: pearRank);
```

## Issues

Please file any issues, bugs or feature request as an [issue](https://github.com/kedulu/rank/issues) on our GitHub page.

## Contributing

If you would like to contribute to the plugin (_e.g._ by improving the documentation, solving a bug or adding a cool new feature or you'd like an easier or better way to do something), consider opening a [pull request](https://github.com/kedulu/rank/pulls). 


