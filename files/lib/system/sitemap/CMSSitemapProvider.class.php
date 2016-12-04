<?php
namespace cms\system\sitemap;

use cms\data\page\AccessiblePageNodeTree;
use wcf\system\sitemap\ISitemapProvider;
use wcf\system\WCF;

/**
 * @author	Jens Krumsieck
 * @copyright	2013 - 2015 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class CMSSitemapProvider implements ISitemapProvider {
	/**
	 * @see	\wcf\system\sitemap\ISitemapProvider::getTemplate()
	 */
	public function getTemplate() {
		$nodeTree = new AccessiblePageNodeTree();
		$nodeList = $nodeTree->getIterator();

		// sitemap only supports up to child-child-pages
		$nodeList->setMaxDepth(1);

		WCF::getTPL()->assign(array(
			'pageList' => $nodeList
		));

		return WCF::getTPL()->fetch('cmsSitemap', 'cms');
	}
}
