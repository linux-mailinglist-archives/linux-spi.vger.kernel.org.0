Return-Path: <linux-spi+bounces-6323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A978A0A494
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A85D169E12
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B5149C69;
	Sat, 11 Jan 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwZuO9Hi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D33EC0
	for <linux-spi@vger.kernel.org>; Sat, 11 Jan 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736611777; cv=none; b=OZBqrTj9Tqv1uwgNi8CXuwN+Apj5Wce5XUcpxX0HAeUcIr5YzvfsOgozKAqVH6pjpCjaq9BCgU8hknjhUiyZhhUvIdKGe6BK9pNqP0LIxTa144OH93/QHABnOGTYmieheAheGYkHPe345vbraHNmX1zIbjKzfJA1KAXHVa9jT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736611777; c=relaxed/simple;
	bh=NtquL0H1tlaj8sg6C9RoGCOsvvzWQ2j8p8kSloTeyRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ENS+NWpKjUpTeTR0r+p42wRm2w6iqqBybgqJjAgQA6AJor5rYy5L7g8RykzfmeWwoJZsvuV1RYxRRWhqCAYinSAaaQZqUS7YZ34kHNXtXuYNF3DhQE+Dt/vTwDzebh+u2591C4jKDy8YifsrNbPMXRqDnMUb07LJk0F24vXSvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwZuO9Hi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736611776; x=1768147776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NtquL0H1tlaj8sg6C9RoGCOsvvzWQ2j8p8kSloTeyRw=;
  b=MwZuO9HiiMMo4JtLCvCEpElt3ai1LBcoSIsWaYR4BFT04Rvr/LW4+nwI
   h0Wke3FHbulvvhnADLJycVyzembhHhCkesG3eh2IvALt3h+BuMYYGkSwL
   N/2qL2QJ1+oi6nJP+6+YN6guf0EstnuVkRPoUFiWpqoUAcOqFLI2j54QT
   4iz7fcoj6QBuYePKfwHmBknsZATwQZZq7NMvHaOlfVolY62bjXabsg2NI
   euFvL1oUnXUMxe5vTEtDFyt/ZeEgRxCfumZimWaFtSjwr2dCmid/XsN9D
   NVj3/vY020Kad9Hz1LUKaW8sxbuGmnQHtHQKDQd9Eo+ldiSssozJ0oZWA
   g==;
X-CSE-ConnectionGUID: W9QjvGyETXyHx3f5WTS9Fw==
X-CSE-MsgGUID: LQqzRM3KQseo3tQuZdnBVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="47550630"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="47550630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 08:09:35 -0800
X-CSE-ConnectionGUID: fjaPA+9sQ4S8NJMwvbh0zg==
X-CSE-MsgGUID: JRDKHizWTimPSGxTu/gzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="103817800"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jan 2025 08:09:34 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWe3H-000Kvd-2m;
	Sat, 11 Jan 2025 16:09:31 +0000
Date: Sun, 12 Jan 2025 00:08:52 +0800
From: kernel test robot <lkp@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-next 4/22] drivers/spi/spi-amd.c:695:9: warning:
 variable 'ret' is uninitialized when used here
Message-ID: <202501112315.ugYQ7Ce7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
head:   fd85b6b7bc53409d0be82763419bdcdaa48f2c91
commit: e6204f39fe3a7b4538815a2d778b601bd543649e [4/22] spi: amd: Drop redundant check
config: i386-randconfig-005-20250111 (https://download.01.org/0day-ci/archive/20250111/202501112315.ugYQ7Ce7-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501112315.ugYQ7Ce7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501112315.ugYQ7Ce7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-amd.c:695:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     695 |         return ret;
         |                ^~~
   drivers/spi/spi-amd.c:673:9: note: initialize the variable 'ret' to silence this warning
     673 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m] && HAS_IOPORT [=y]


vim +/ret +695 drivers/spi/spi-amd.c

9674f1694e644a Raju Rangoju  2024-09-25  668  
6defadbe6cbc3a Raju Rangoju  2024-02-29  669  static int amd_spi_exec_mem_op(struct spi_mem *mem,
6defadbe6cbc3a Raju Rangoju  2024-02-29  670  			       const struct spi_mem_op *op)
6defadbe6cbc3a Raju Rangoju  2024-02-29  671  {
6defadbe6cbc3a Raju Rangoju  2024-02-29  672  	struct amd_spi *amd_spi;
6defadbe6cbc3a Raju Rangoju  2024-02-29  673  	int ret;
6defadbe6cbc3a Raju Rangoju  2024-02-29  674  
6defadbe6cbc3a Raju Rangoju  2024-02-29  675  	amd_spi = spi_controller_get_devdata(mem->spi->controller);
6defadbe6cbc3a Raju Rangoju  2024-02-29  676  
e6204f39fe3a7b Miquel Raynal 2024-12-24  677  	amd_set_spi_freq(amd_spi, op->max_freq);
6defadbe6cbc3a Raju Rangoju  2024-02-29  678  
9674f1694e644a Raju Rangoju  2024-09-25  679  	if (amd_spi->version == AMD_SPI_V2)
9674f1694e644a Raju Rangoju  2024-09-25  680  		amd_set_spi_addr_mode(amd_spi, op);
9674f1694e644a Raju Rangoju  2024-09-25  681  
6defadbe6cbc3a Raju Rangoju  2024-02-29  682  	switch (op->data.dir) {
6defadbe6cbc3a Raju Rangoju  2024-02-29  683  	case SPI_MEM_DATA_IN:
6defadbe6cbc3a Raju Rangoju  2024-02-29  684  		amd_spi_mem_data_in(amd_spi, op);
6defadbe6cbc3a Raju Rangoju  2024-02-29  685  		break;
6defadbe6cbc3a Raju Rangoju  2024-02-29  686  	case SPI_MEM_DATA_OUT:
6defadbe6cbc3a Raju Rangoju  2024-02-29  687  		fallthrough;
6defadbe6cbc3a Raju Rangoju  2024-02-29  688  	case SPI_MEM_NO_DATA:
6defadbe6cbc3a Raju Rangoju  2024-02-29  689  		amd_spi_mem_data_out(amd_spi, op);
6defadbe6cbc3a Raju Rangoju  2024-02-29  690  		break;
6defadbe6cbc3a Raju Rangoju  2024-02-29  691  	default:
6defadbe6cbc3a Raju Rangoju  2024-02-29  692  		ret = -EOPNOTSUPP;
6defadbe6cbc3a Raju Rangoju  2024-02-29  693  	}
6defadbe6cbc3a Raju Rangoju  2024-02-29  694  
6defadbe6cbc3a Raju Rangoju  2024-02-29 @695  	return ret;
6defadbe6cbc3a Raju Rangoju  2024-02-29  696  }
6defadbe6cbc3a Raju Rangoju  2024-02-29  697  

:::::: The code at line 695 was first introduced by commit
:::::: 6defadbe6cbc3a87dc39c119a6748d19bfba0544 spi: spi_amd: Add support for SPI MEM framework

:::::: TO: Raju Rangoju <Raju.Rangoju@amd.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

