<?php
namespace cms\system\content\type;

use cms\data\content\Content;

/**
 * Interface for searchable content types.
 * 
 * @author	Jens Krumsieck
 * @copyright	2013 - 2017 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
interface ISearchableContentType {
	/**
	 * Return data for the search index
	 * 
	 * @return	array
	 */
	public function getSearchableData(Content $content);
}
