<?php
/*
	Events: OnTVInputRenderList, OnTVInputPropertiesList
*/

$corePath = $modx->getOption('table.core_path', null, $modx->getOption('core_path') . 'components/table/');

switch ($modx->event->name) {
	case 'OnTVInputRenderList':
		$modx->event->output($corePath . 'elements/tv/input/');
		break;
	case 'OnTVInputPropertiesList':
		$modx->event->output($corePath . 'elements/tv/inputoptions/');
		break;
}