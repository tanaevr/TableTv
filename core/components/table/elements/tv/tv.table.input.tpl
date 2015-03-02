<input id="tv{$tv->id}" name="tv{$tv->id}" class="textfield" value="{$tv->get('value')|escape}" type = "text"/>
<div class="tvtEditor"></div>
<style>
    .tvtrow.header{
    background:#f0f0ee; 
    padding :5px 0; 
    white-space:nowrap;
    }
    .add, .del, .add_item, .del_item{
    margin-left: 5px;
    }
</style>


<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
    window.ie9=window.XDomainRequest && window.performance; window.ie=window.ie && !window.ie9; /* IE9 patch */
    var tvIds = [{$tv->id}];
    
    {literal}
    
    $(document).ready(function () {
        
        for (var i=0;i<tvIds.length;i++){
            var fid = 'tv'+ tvIds[i];
            if($(fid)!=null) {
                var modxTvTable=TvTable.initialize(fid);
            }
        }
        
        
         $('body').on('keyup', 'input[type="text"]', function(){

         TvTable.setEditor();
         //documentDirty=true;
             MODx.fireResourceFormChange();
         });
        
        // добавить удалить строку
        $('body').on('click', '.add_item', function(){
            TvTable.addItem(null,$(this).parent());
            TvTable.setEditor();
        });
        
        $('body').on('click', '.del_item', function(){
            $(this).parent().remove();
            TvTable.setEditor();
        });
        
        // добавить удалить столбик 
        
        $('body').on('click', '.del', function(){
            if ($(this).parent().find('input[type=text]').length>2){
                TvTable.cols--;
                $('.tvtEditor').find('div.tvtrow').each(function(item){
                    $(this).find('input[type=text]').last().remove();
                });
                TvTable.setEditor();
            }
        });
        
        $('body').on('click', '.add', function(){
        TvTable.cols++;
                $('.tvtEditor').find('div.tvtrow').each(function(item){
                    TvTable.build('').insertAfter($(this).find('input[type=text]').last());
                    });
                TvTable.setEditor();
        
        
        
           
        });
        
        
    });
    
    var TvTable = {
        initialize: function(fid){
            $fid = $('#'+fid);
            var tvtArr = ($fid.val()) ? $.parseJSON($fid.val()) : [null,null];
            $fid.hide();
            $box = $('.tvtEditor');
            this.addHeader(tvtArr[0]);
            this.addSetting(tvtArr[1]);
            for (var row=2;row < tvtArr.length;row++) this.addItem(tvtArr[row]);
        },
        build: function(val){
            return $('<input type="text" value="'+val+'" class="x-form-text x-form-field" /> ');
        },
        addHeader: function(values,elem){
            $rowDiv = $('<div class="tvtrow header"><span style="width: 100px; display: inline-block;">&nbsp;Заголовок:</span></div>');
            $box.append($rowDiv);
            if (!values) values=['',''];
            this.cols=values.length;
            for (var i=0;i<this.cols;i++) {
                $rowDiv.append(this.build(values[i]));
            }
            $del = $('<button type="button" class="del x-btn x-btn-small" title="удалить столбик"><<</button>');
            $add = $('<button type="button" class="add x-btn x-btn-small" title="добавить столбик">>></button>');
            $rowDiv.append($del);
            $rowDiv.append($add);
        },
        addSetting: function(values,elem){
            $rowDiv = $('<div class="tvtrow footer"><span style="width: 100px; display: inline-block;">&nbsp;Ширина</span></div>');
            $box.append($rowDiv);
            if (!values) values=['',''];
            this.cols=values.length;
            for (var i=0;i<this.cols;i++) {
                $rowDiv.append(this.build(values[i]));
            }
            $rowDiv.append('<button title="добавить строку" class="add_item x-btn x-btn-small"><i class="icon icon-plus-square"></i></button>');
        },
        addItem: function(values,elem){
            $rowDiv = $('<div class="tvtrow" style="white-space: nowrap; padding :5px 0; "><span style="width: 100px; display: inline-block;"></span></div>')
            if (elem){
                $rowDiv.insertAfter(elem);
                }else{
                $box.append($rowDiv);
            }
            
            console.log(this.cols);
            for (var i=0;i<this.cols;i++) {
                $rowDiv.append(this.build((values) ? values[i] : ''));
            }
            $rowDiv.append('<button title="добавить строку" class="add_item x-btn x-btn-small"><i class="icon icon-plus-square"></i></button>');
            if ($box.find('div.tvtrow').length > 2){
                $rowDiv.append('<button title="удалить строку" class="del_item x-btn x-btn-small"><i class="icon icon-minus-square"></i></button>');
            }
        },
        setEditor: function(){
            var tvtArr=new Array();
            $box.find('div.tvtrow').each(function(item){
                var itemsArr=new Array();
                $inputs=$(this).find('input[type=text]');
                $inputs.each(function(item){
                itemsArr.push($(this).val());}
                );
                tvtArr.push(itemsArr);
            });
            var vl = JSON.stringify(tvtArr);
            // console.log(vl);
            $fid.val(vl);
           
            MODx.fireResourceFormChange();
            
        }
    };
    
    
    
    {/literal}
    
</script>