<?php
namespace cms\system\content\type;

use cms\data\content\Content;
use wcf\system\WCF;

/**
 * @author	Jens Krumsieck
 * @copyright	2014 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class HeadlineContentType extends AbstractSearchableContentType {
	/**
	 * @see	\cms\system\content\type\AbstractContentType::$icon
	 */
	protected $icon = 'icon-underline';

	public $multilingualFields = array(
		'text'
	);

	protected $searchableFields = array(
		'text'
	);

	public function getFormTemplate() {
		return 'headlineContentType';
	}

	public function getOutput(Content $content) {
		$data = $content->handleContentData();
		WCF::getTPL()->assign(array(
			'data' => $data
		));
		return WCF::getTPL()->fetch('headlineContentTypeOutput', 'cms');
	}
}
