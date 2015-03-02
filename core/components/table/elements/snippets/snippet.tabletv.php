<?php
if (!isset($tv)){
   return;
}

$tv = (int)$tv;
$classname = isset($classname) ? $classname : 'pricelist';
$did =isset($id) ? $id : $modx->resource->id;

if ($tvObject = $modx->getObject('modTemplateVarResource', array('tmplvarid' => $tv, 'contentid' => $did ))){
    $tvv = $tvObject->get('value');
}

if (!$tvv || $tvv=='[["",""],["",""]]') return;
$tvtArr=json_decode($tvv);

$output='<table class="'.$classname.'">'."\n";
$output .='<tr>'."\n";
for($i=0; $i<count($tvtArr[0]); $i++) $output .='<th'.($i ? '' : ' class="first"').'>'.$tvtArr[0][$i].'</th>'."\n";
$output.='</tr>'."\n";
for($row=2; $row<count($tvtArr); $row++) {
	$output .='<tr'.(($row%2) ? '' : ' class="altrow"').'>'."\n";
	for($i=0; $i<count($tvtArr[$row]); $i++) $output .='<td width="'.$tvtArr[1][$i].'"'.($i ? '' : ' class="first"').'>'.$tvtArr[$row][$i].'</td>'."\n";
	$output.='</tr>'."\n";
}
$output.='</table>';
return $output;