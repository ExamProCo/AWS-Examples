
## Create our bucket
```sh
aws s3 mb s3://prefixes-fun-ab-5235
```

## Create our folder

```sh
aws s3api put-object --bucket="prefixes-fun-ab-5235" --key="hello/"
```

## Create many folders
```sh
aws s3api put-object --bucket="prefixes-fun-ab-5235" --key="Lorem/ipsum/dolor/sit/amet/consectetur/adipiscing/elit/Nunc/id/facilisis/dolor/Donec/laoreet/odio/ac/bibendum/eleifend/Ut/nunc/massa/finibus/vitae/hendrerit/ac/aliquam/in/ligula/Vestibulum/eu/nibh/eget/nisl/aliquet/elementum/id/non/massa/Praesent/sed/dolor/facilisis/imperdiet/justo/ut/varius/urna/Cras/lacinia/lacinia/diam/sed/convallis/nisi/vehicula/sit/amet/Mauris/lacinia/rutrum/justo/a/consectetur/dolor/maximus/et/Duis/condimentum/dignissim/ligula/et/sollicitudin/Mauris/non/convallis/nisi/eget/vestibulum/est/Aliquam/faucibus/vestibulum/lacus/vitae/sagittis/nulla/blandit/quis/Vivamus/vel/justo/a/nisi/bibendum/varius/ac/vitae/urna/Nullam/et/lorem/metus/Praesent/lorem/mi/laoreet/eget/tincidunt/et/vestibulum/eget/erat/Aenean/nisl/ante/lobortis/vel/orci/sit/amet/commodo/viverra/mauris/Fusce/at/ipsum/at/ex/facilisis/ultrices/et/vel/augue/Etiam/vitae/nulla/sit/amet/risus/sagittis/pharetra/ullamcorper/vitae/mi/Nullam/eget/mollis/urna/non/malesuada/dui/Morbi/porta/nunc/et/ipsum/libero/wra/dsf/dfs/gf/dhg/gfh/jgidngi/"
```

### Try and break the 1024 limit

```sh
aws s3api put-object --bucket="prefixes-fun-ab-5235" --key="Lorem/ipsum/dolor/sit/amet/consectetur/adipiscing/elit/Nunc/id/facilisis/dolor/Donec/laoreet/odio/ac/bibendum/eleifend/Ut/nunc/massa/finibus/vitae/hendrerit/ac/aliquam/in/ligula/Vestibulum/eu/nibh/eget/nisl/aliquet/elementum/id/non/massa/Praesent/sed/dolor/facilisis/imperdiet/justo/ut/varius/urna/Cras/lacinia/lacinia/diam/sed/convallis/nisi/vehicula/sit/amet/Mauris/lacinia/rutrum/justo/a/consectetur/dolor/maximus/et/Duis/condimentum/dignissim/ligula/et/sollicitudin/Mauris/non/convallis/nisi/eget/vestibulum/est/Aliquam/faucibus/vestibulum/lacus/vitae/sagittis/nulla/blandit/quis/Vivamus/vel/justo/a/nisi/bibendum/varius/ac/vitae/urna/Nullam/et/lorem/metus/Praesent/lorem/mi/laoreet/eget/tincidunt/et/vestibulum/eget/erat/Aenean/nisl/ante/lobortis/vel/orci/sit/amet/commodo/viverra/mauris/Fusce/at/ipsum/at/ex/facilisis/ultrices/et/vel/augue/Etiam/vitae/nulla/sit/amet/risus/sagittis/pharetra/ullamcorper/vitae/mi/Nullam/eget/mollis/urna/non/malesuada/dui/Morbi/porta/nunc/et/ipsum/libero/wra/dsf/dfs/gf/dhg/gfh/jgidngi/hello.txt" --body="hello.txt"
```