<?php
namespace cms\system\content\type;

/**
 * @author	Jens Krumsieck
 * @copyright	2014 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class GroupContentType extends AbstractStructureContentType {
	public function getFormTemplate() {
		return 'groupContentType';
	}

	public function getCSSClasses() {
		return 'contentCollection';
	}
}
