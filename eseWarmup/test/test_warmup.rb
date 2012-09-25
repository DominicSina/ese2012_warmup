#Dominic Sina 11-111-507

require 'test/unit'
require '../app/Warmup/user'
require '../app/Warmup/item'

# syntax for inheritance
class TestWarmup < Test::Unit::TestCase

  def test_userInit
    john = Warmup::User.named('John')
    assert(john.credits==100 && john.name=='John' && john.items!=nil, 'User initialization failed')
  end

  def test_itemInit
    john = Warmup::User.named('John')
    item = Warmup::Item.create('Mobile', 200, john)
    assert(item.name=='Mobile' && item.price==200 && item.owner==john && item.status== 'inactive', 'Item initialization failed')
  end

  def test_Ownership
    john = Warmup::User.named('John')
    john.add_item('Mobile', 200)
    assert( john.items[0].owner==john , 'Should recognize as own item' )
  end

  def test_itemActivation
    john = Warmup::User.named('John')
    john.add_item('Mobile', 200)
    john.add_item('Car', 4000)

    john.activate_item('Mobile')
    assert( john.items[0].status=='active', 'Should now be active')
    assert( john.items[1].status=='inactive', 'Should remain inactive')
  end

  # Should work assuming that users start with 100 Credits
  def test_enoughMoney
    john = Warmup::User.named('John')
    tooMuch = Warmup::Item.create('Mobile', 200, john)
    ok = Warmup::Item.create('Watch', 50, john)
    assert( ok.enough_money?(john.credits), 'Should be affordable' )
    assert( !tooMuch.enough_money?(john.credits), 'Should not be affordable' )
  end

  def test_buying
    john = Warmup::User.named('John')
    jim = Warmup::User.named('Jim')
    john.add_item('Mobile', 50)
    john.activate_item('Mobile')
    jim.add_item('Television', 400)
    jim.activate_item('Television')
    jim.add_item('Watch', 50)

    john.buy_item('Watch',jim)
    assert(john.items.length==1 && jim.items.length==2 && john.credits==100 && jim.credits==100,
           'This buy partially or fully took place although item is inactive')

    john.buy_item('Television',jim)
    assert(john.items.length==1 && jim.items.length==2 && john.credits==100 && jim.credits==100,
           'This buy partially or fully took place although item costs to much')

    jim.buy_item('Mobile',john)
    assert(john.items.length==0 && jim.credits=50 && john.credits==150 && jim.items.length==3,
           'This buy did not fully take place' )
  end

  def test_listItems
    john = Warmup::User.named('John')
    john.add_item('Mobile', 200)
    john.add_item('Watch', 50)
    john.add_item('Car', 4000)
    john.add_item('Keyboard', 100)
    john.activate_item('Watch')
    john.activate_item('Keyboard')
    printf("\n"+john.list_active_items)
    assert(john.list_active_items=="Watch 50$\nKeyboard 100$\n", 'List of active Items may be wrong')

  end


end

