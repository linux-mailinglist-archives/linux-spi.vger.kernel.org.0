Return-Path: <linux-spi+bounces-10991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A693C2FE0D
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 09:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0761920519
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9275312812;
	Tue,  4 Nov 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiRuXU9I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BB312802;
	Tue,  4 Nov 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244409; cv=none; b=Bp4QS8filwBVn6TWD/kcAZ2oyZv6pcVW4iBtUKD3i4Jnuo/x7iNS46burolY5uj3s7BpmPowAafcP2V1gk9uTTvNObvY6XExSHSOiv0Ev/ydTQstykBnRQujaWvJAGLccytRymfW8FRXD2h4J6sdSqBuqvBKy6eYf+snyKIDoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244409; c=relaxed/simple;
	bh=MtR/xZVvEaQczGlFwJlc3qeyM4jRQ5EHhZH0AQSey+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDedNGXSB4OMfVbqe5BaX9QMpDaQLGSzz9jB9ST9DjR8bU3+EW1QPJtRyIO4tXC7UJ8XC/bBGNJukawk4E3lUC2ukeS1jZ1C1+4cvfRk667GjV1twFr6ZAmcvpoLtbP0249FrnWPMHSLnq+vBtkyIo68lmFjd/z1zjizUIvmi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiRuXU9I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762244409; x=1793780409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtR/xZVvEaQczGlFwJlc3qeyM4jRQ5EHhZH0AQSey+E=;
  b=QiRuXU9IqSyuPk31yH5u3gj963mVKOb3ytZ2Ch2aiIZzE3GhZw3IoBtS
   XaC+Nez9YZ3inctZsVYKPZX5ymwWOygAxDs+eHpiZXUqYH0xtYg2ujT7Y
   1oG3m3X9MCjYXAXsXbq3honuFS3JlgKpMiqyH2oALJDeQeTg2uJh8OB+s
   Xya6A6wsEXBh+3pGQ3KBr3XKte7xOmcWmVKqkvObJHZwh+O8MHbPdDo5c
   FFeqnq6sBCtZ8Q7eufrrrNrommCPHax27oHWFkPrxl06bn1BVgrCCJzZB
   X2rmZL9+dBYDMBploChnIflG3mm3jXrV+p5l27udxccwBo8NT482U4ptS
   g==;
X-CSE-ConnectionGUID: rLiCRGwpTm24AerdsCt5Qg==
X-CSE-MsgGUID: mjMK9spDTDqV9TJiu0EoZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64364050"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="64364050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:20:08 -0800
X-CSE-ConnectionGUID: mHaQJxUGQH22XIprnhNFdg==
X-CSE-MsgGUID: JKYDb3pmST2DVUAvDZJyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191186728"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 04 Nov 2025 00:20:04 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGCGn-000R7e-2X;
	Tue, 04 Nov 2025 08:20:01 +0000
Date: Tue, 4 Nov 2025 16:19:46 +0800
From: kernel test robot <lkp@intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH v1 3/3] spi: add support for microchip "soft" spi
 controller
Message-ID: <202511041552.wtkxOpRz-lkp@intel.com>
References: <20251103160515.412706-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103160515.412706-4-prajna.rajendrakumar@microchip.com>

Hi Prajna,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prajna-Rajendra-Kumar/spi-microchip-rename-driver-file-and-internal-identifiers/20251104-001544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20251103160515.412706-4-prajna.rajendrakumar%40microchip.com
patch subject: [PATCH v1 3/3] spi: add support for microchip "soft" spi controller
config: sparc-randconfig-002-20251104 (https://download.01.org/0day-ci/archive/20251104/202511041552.wtkxOpRz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041552.wtkxOpRz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041552.wtkxOpRz-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-microchip-core.c: In function 'mchp_corespi_setup':
>> drivers/spi/spi-microchip-core.c:163:30: warning: unused variable 'corespi' [-Wunused-variable]
     163 |         struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
         |                              ^~~~~~~
   drivers/spi/spi-microchip-core.c: At top level:
>> drivers/spi/spi-microchip-core.c:438:10: error: 'struct platform_driver' has no member named 'remove_new'; did you mean 'remove'?
     438 |         .remove_new = mchp_corespi_remove,
         |          ^~~~~~~~~~
         |          remove
>> drivers/spi/spi-microchip-core.c:438:23: error: initialization of 'const struct platform_device_id *' from incompatible pointer type 'void (*)(struct platform_device *)' [-Werror=incompatible-pointer-types]
     438 |         .remove_new = mchp_corespi_remove,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-microchip-core.c:438:23: note: (near initialization for 'mchp_corespi_driver.id_table')
   cc1: some warnings being treated as errors


vim +438 drivers/spi/spi-microchip-core.c

   430	
   431	static struct platform_driver mchp_corespi_driver = {
   432		.probe = mchp_corespi_probe,
   433		.driver = {
   434			.name = "microchip-corespi",
   435			.pm = MICROCHIP_SPI_PM_OPS,
   436			.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
   437		},
 > 438		.remove_new = mchp_corespi_remove,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

