(module
	(func $call (import "" "call"))
	(func (export "callfunc") (call $call))
	(func $sum (param $x i32) (param $y i32) (result i32)
		local.get $x
		local.get $y
		i32.add)
	(export "sum" (func $sum))
)
