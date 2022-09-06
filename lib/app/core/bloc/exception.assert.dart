
import 'constant/message_assert.constant.dart';
import 'models/default_validator_model.dart';

abstract class ExceptionAssert<T>  {
  Type  get type => T;
  void verficateDefaultValidators(DefaultValidators? validator){
    if(validator!=null){
      if(validator.min is int ){
        assert(type==int || type==double || type==num, MessageAssertConstant.msgAssertOnlyNums(validator.min!,'min'));
      }else if(validator.max is int ){
        assert(type==int || type==double || type==num, MessageAssertConstant.msgAssertOnlyNums(validator.max!,'max'));
      }else if(validator.validEmail == true){
        assert(type==String, MessageAssertConstant.msgAssertEmail());
      }
    }
  }
}