# Custom Functions

## `endRange`

### Purpose

Returns the end string of the search range.

### Why Use This Function?

This function is designed for querying a string field within a specific range.

### Example Use Case

Suppose you want to search for names that begin with "You". You can query like this:

```sql
name >= "You" && name < "You\uf8ff"
```

### Backend Query Example

Below is an example of a backend query in a ListView to perform a case-insensitive user search.

![image.png](/images/image (3).png)


## `dateTimeOf` Custom Function

The `dateTimeOf` custom function converts a number into a `DateTime` object. The parameter should be a timestamp in seconds or milliseconds.

### Returns

A `DateTime` object from a timestamp.

### Behavior

- **Seconds to Milliseconds**: If the timestamp is in seconds, it will be converted to milliseconds and returns into the DateTime of it.
- **Null Timestamp**: If the timestamp is null, it will return the current time.
- **Non-Integer Timestamp**: If the timestamp is not an integer, it will throw an exception.
- **Negative Timestamp**: If the timestamp is negative, it will throw an exception.
- **Zero Timestamp**: If the timestamp is zero, it will return the current time.

### Example of using the `dateTimeOf` custom function

See below to understand better on how to using it.

![image.png](./images/date_time_of.png)


