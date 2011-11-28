package zpartanlite
{


public class Pages//<T>
{
    
    
    private var index:      int ;
    private var lastIndex:  int ;
    private var len:        int ;
    private var order:      Array;//Array<T> ;
    private var history:    Array;//Array<Int> ;
    public var circle:      Boolean ;
    public var last:        *;//T ;
    public var curr:        *;//T ;
    public var pageChange:  DispatchTo ;
    public var hideNext:    DispatchTo ;
    public var hidePrev:    DispatchTo ;
    public var looped:      DispatchTo ;
    // not implemented in as3 only hx
    //public var dir:         Travel;   
    // -1 = back
    public var dir:         int;
    
    
    
    public function Pages( /*?*/arr_: Array/*<T>*/, /*?*/circle_: Boolean = false )
    {
        
        circle      = circle_ ;
        pageChange  = new DispatchTo() ;
        hideNext    = new DispatchTo() ;
        hidePrev    = new DispatchTo() ;
        looped      = new DispatchTo() ;
        reset( arr_ ) ;
        
    }
    
    
    public function kill()
    {   
        
        reset([]);
        pageChange.kill();
        hideNext.kill();
        hidePrev.kill();
        looped.kill();
        
        pageChange  = null ;
        hideNext    = null ;
        hidePrev    = null ;
        
    }
    
    
    public function reset( /*?*/arr_: Array/*<T>*/ ) : void
    {
        
        if( arr_ == null )
        {
            
            order   = new Array() ;
        }
        else
        {
            
            order  = arr_ ;
            
        }
        
        len = order.length;
        index = 0;
        history = new Array() ;
        
    }
    
    
    public function next() : * /*T*/
    {
       	
        lastIndex   = index ;
        last        = order[ index ];
        dir = 1;//Forward;
        
        index++ ;
        if( index == len )
        {
            if( circle )
            {
                index = 0 ;
                looped.dispatch();
            }
            else
            {
                index = len - 1 ;
            }
        }
        
        curr = order[ index ] ;
        if( lastIndex != index )
        {
            
            history.push( index ) ;
            
            if( !circle )
            {
                
                if( !hasNext() )
                {
                    
                    hideNext.dispatch();
                    
                }
                
            }
            pageChange.dispatch();
            
        }
        
        return curr;
        
    }
    
    
    public function previous(): * /* T */
    {
        
        lastIndex   = index ;
        last = order[ index ];
        dir = -1;//Back;
        
        index-- ;
        if( index == -1 )
        {
            
            if( circle )
            {
                
                index = len - 1 ;
                
            }
            else
            {
                
                index = 0 ;
            }
            
        }
        
        curr = order[ index ]; 
        if( lastIndex != index )
        {
            
            history.push( index ) ;
            
            if( !circle )
            {
                
                if( !hasPrevious() )
                {
                    
                    hidePrev.dispatch();
                    
                }
                
            }
            pageChange.dispatch();
        }
        
        
        return curr;
        
    }
    
    
    public function getCurrent(): */* T */
    {
        
        return order[ index ] ;
        
    }
    
    
    public function hasPrevious(): Boolean
    {
        
        if( circle )
        {
            
            return true ;
            
        }
        
        if( index == 0 )
        {
            
            return false ;
            
        }
        
        return true ;
        
    }
    
    
    public function hasNext() : Boolean
    {
        trace( 'has next ');
        if( circle )
        {
            
            return true ;
            
        }
        
        if( index == len )
        {
            
            return false ;
            
        }
        
        return true ;
        
    }
    
    
    public function goto( index_: int ): * /* T  */
    {
        
        lastIndex   = index ;
        last        = order[ index ] ;
        
        
        index = index_ ;
        
        curr = order[ index ];
        if( lastIndex != index )
        {
            
            history.push( index ) ;
            
            if( !circle )
            {
                
                if( !hasNext() )
                {
                    
                    hideNext.dispatch();
                    
                }
                if( !hasPrevious() )
                {
                    
                    hidePrev.dispatch();
                    
                }
            }
            
            pageChange.dispatch();
            
        }
        
        
        return curr;
        
    }
    
    
    public function back(): * /* T */
    {
        
        lastIndex = index ;
        last = order[ index ] ;
        
        index = history.pop() ;
        
        if( lastIndex != index )
        {
            if( !circle )
            {
                
                if( !hasNext() )
                {
                    
                    hideNext.dispatch() ;
                    
                }
                if( !hasPrevious() )
                {
                    
                    hidePrev.dispatch() ;
                    
                }
                
            }
            pageChange.dispatch() ;
            
        }
        
        curr = order[ index ] ;
        return curr;
        
    }
    
    
    public function isLast():Boolean
    {
        
        if( index == len - 1 ) return true;
        return false;
        
    }
    
    
    public function getIndex(): int
    {
        
        return index ;
        
    }
    
    public function getLastIndex(): int
    {
        
        return lastIndex;
        
    }
    
    
}
}