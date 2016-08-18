geodns Cookbook
===============
This cookbook Get info about a list of domains using geoiplookup command

Requirements
------------
This cookbook is ready to work on Unix/Linux systems, tested on ubuntu and centos7

Attributes
----------

#### geodns::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['geodns']['domains']</tt></td>
    <td>Boolean</td>
    <td>List domains to get info</td>
    <td><tt>["www.google.es"]</tt></td>
  </tr>
</table>

Usage
-----
#### geodns::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `geodns` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[geodns]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Enrique Jimenez <serialsito@gmail.com>
