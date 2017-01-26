<?php
namespace cms\data\content;

use cms\data\content\ContentList;

/**
 * Represents a list of viewable content items.
 * 
 * @author	Jens Krumsieck
 * @copyright	2013 - 2015 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class ViewableContentList extends ContentList {

	public $decoratorClassName = ViewableContent::class;
}
