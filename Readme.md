# MagLev

## Install
    rvm install maglev-25633
This will pull down both MagLev & the Gemstone VM

## Run it
    rvm use maglev[-25633]
    maglev start
    irb
    maglev stop

or if you are using a .rvmrc file, MagLev should start automatically.

## Debug
* MAGLEV\_OPTS="-d -q"
* nil.pause & fr 5
* fr (move to a frame)
* copy the object id, inspect @object\_id
* up/down upr/downr
* wh (where in the Smalltalk)
* whr (where in the Ruby)
* whr some\_string like whr raise (search through stack)
* cont to continue

## Edit & Fix
* [@avdi's](http://twitter.com/avdi) [hammertime](https://github.com/avdi/hammertime)
* Coming to a Rubinius near you (If Evan man's up on the dare)

## Some debug output
    topaz 1> set class @176477441
    topaz 1> rubylook meth devise                                                                                                                                      
    method: virtualModels
      devise
        <bridge method, objId 157392897>
    method: virtualModels
        def devise(*modules)
          include Devise::Models::Authenticatable
          options = modules.extract_options!

    topaz 1> set class @176572929
    topaz 1> rubyhier
    virtualKernel
      virtualLoadable
        Object
          Behavior( superClass format instVarsInfo instVarNames constraints classVars methDicts poolDictionaries categorys primaryCopy)
            virtualModuleConstMissing
              Module( name classHistory transientMethDicts)
                Metaclass3( destClass)
                  Class( timeStamp userId extraDict classCategory subclasses)
                    Object class
                      virtualEnumerable
                        virtualClassMethods
                          virtualNaming
                            virtualClassMethods
                              virtualDescendantsTracker
                                virtualClassMethods
                                  virtualTranslation
                                    virtualHelperMethods
                                      User class

    topaz 1> set class @154830849
    topaz 1> display classoops
    topaz 1> rubyhier
    virtualKernel        127351297  format=16r6820 primaryCopy 19427841 pns=nil tns=176412673
      virtualLoadable    174309377  format=16r806820 primaryCopy 160595713 pns=nil tns=176412929
        Object           72193  format=16r2000 pns=127536897 tns=176413185
          Models         154830849  format=16r802020 pns=nil tns=176406529

## Persist it
    Maglev.persistable do
      require "my_models"
    end
Now we can truly persist

    class Pet
      include Tesla::Model

      attr_accessor :name
    end

    Maglev.abort_transaction
    my_cat = Pet.new
    my_cat.name = "Pierre"
    my_cat.save # Not actually persisted to the repository
    Maglev.commit_transaction
    # now it's up there & available to the other VMs

### Notes on Persistence
* You need to persist all the things your lib depends on
* You need to abort & commit transactions (Rack & the status code)
