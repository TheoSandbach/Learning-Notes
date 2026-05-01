# Computing 101 - Software Introspection

---

### Lecture 1 - Data

- ASCII has evolved into UTF-8 which encodes almost all text on the web
  
  - The first 128 characters in UTF-8 are ASCII, with the leading bit signifying whether this is an ASCII character (`0x00` - `0x7f`) or an extended character (`0x80` onwards)
  
  - Extended UTF-8 characters can be huge, as UTF-8 characters are variable length and can be encoded in up to 4 bytes, allowin for over 2 million characters to be encoded
  
  - `0x00` through `0x1f` are *control characters* - things like newline, tab, etc

- There is no requirement for bytes to be 8 bits, and for some systems bytes can be anything from 6 or 7 bits to 31 or 36 bytes (again, not limits - can be higher or lower), the 8-bit byte is simply historical

- *Words* are groupings of 8-bit bytes
