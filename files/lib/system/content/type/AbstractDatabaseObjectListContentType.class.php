<?php

namespace cms\system\content\type;

use cms\data\content\Content;
use wcf\data\DatabaseObjectList;
use wcf\system\WCF;

abstract class AbstractDatabaseObjectListContentType extends AbstractContentType {
	/**
	 * @see	\cms\system\content\type\AbstractContentType::$icon
	 */
	protected $icon = 'icon-list';

	/**
	 * classname of the object list
	 * @var string
	 */
	protected $objectListClassName = '';

	/**
	 * @var null|DatabaseObjectList
	 */
	protected $objectList = null;

	/**
	 * application abbreviation the template belongs to
	 * @var string
	 */
	protected $templateNameApplication = 'wcf';

	/**
	 * additional fields for the template
	 * @var array
	 */
	protected $additionalFields = array();

	/**
	 * template with additional fields for the content add
	 * form
	 * @var string
	 */
	protected $additionalFormTemplate = '';

	/**
	 * @see \cms\system\content\type\IContentType::getFormTemplate()
	 */
	public function getFormTemplate() {
		WCF::getTPL()->assign(array(
			'additionalTemplate' => $this->additionalFormTemplate
		));
	}

	/**
	 * @see	\cms\system\content\type\IContentType::getOutput()
	 */
	public function getOutput(Content $content) {
		$this->objectList = new $this->objectListClassName();
		$this->objectList->sqlLimit = $content->maxItems;
		$this->initObjectList($content);
		$this->objectList->readObjects();

		return WCF::getTPL()->fetch($this->templateName, $this->templateNameApplication, array_merge(array(
			'items' => iterator_count($this->objectList),
			'objects' => $this->objectList,
			'content' => $content
		), $this->additionalFields));
	}

	/**
	 * special operations to avoid overriding getOutput
	 * directly before readObjects()
	 */
	public function initObjectList(Content $content) {
		// does nothing
	}
}
