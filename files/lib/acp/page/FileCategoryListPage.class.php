<?php
namespace cms\acp\page;

use wcf\acp\page\AbstractCategoryListPage;

/**
 * Shows the file category list.
 * 
 * @author	Florian Frantzen
 * @copyright	2013 - 2015 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class FileCategoryListPage extends AbstractCategoryListPage {
	/**
	 * @see	\wcf\page\AbstractPage::$activeMenuItem
	 */
	public $activeMenuItem = 'fireball.acp.menu.link.fireball.file.category.list';
	
	/**
	 * @see	\wcf\acp\page\AbstractCategoryListPage::$activeMenuItem
	 */
	public $objectTypeName = 'de.codequake.cms.file';
}
