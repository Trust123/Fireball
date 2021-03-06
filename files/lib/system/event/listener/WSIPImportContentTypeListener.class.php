<?php

namespace cms\system\event\listener;
use cms\data\content\ContentAction;
use wcf\data\object\type\ObjectTypeCache;
use wcf\system\event\listener\IParameterizedEventListener;
use wcf\system\WCF;

/**
 * Updates the content type from wsip import to text
 *
 * @author	Florian Gail
 * @copyright	2014 Florian Gail <http://www.mysterycode.de/>
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class WSIPImportContentTypeListener implements IParameterizedEventListener {
	/**
	 * @see \wcf\system\event\IEventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName, array &$parameters) {
		$checkObjectTypeID = ObjectTypeCache::getInstance()->getObjectTypeByName('de.codequake.cms.content.type', 'de.codequake.cms.content.type.wsipimport')->objectTypeID;
		
		if (!empty($eventObj->content) && $eventObj->content->contentTypeID == $checkObjectTypeID) {
			$contentTypeID = ObjectTypeCache::getInstance()->getObjectTypeByName('de.codequake.cms.content.type', 'de.codequake.cms.content.type.text')->objectTypeID;
			$contentAction = new ContentAction(array($eventObj->content), 'update', array('data' => array('contentTypeID' => $contentTypeID)));
			$contentAction->executeAction();
		}
	}
}
