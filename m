Return-Path: <linux-spi+bounces-10990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DFC2FE04
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A30188F183
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9131280A;
	Tue,  4 Nov 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdM5Aw65"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE541311C3B;
	Tue,  4 Nov 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244409; cv=none; b=I8ES8gIy07OJyei1fGwWS4UYWyS5IThY8TPPbRWWeTup2Gtjo0s01wDIWLHRdOVoJ56pTfnZzMg0pXjyQ/45HyVWe3y0KiwzWKLYI88OrWeVXm6HYAMP89iWWUrA3SHUk+LgVEQSslJOon+dFWpfWyqAB/ZXHNZc7LsGdribyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244409; c=relaxed/simple;
	bh=DYM83bBbxx1y5vplV3YBcZ8Mx+qy4hDpBNYYrYsw0cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZZho3tEKGKiH34VbLbY/VpOQwEIObDgMYI2H0HpzSD3av1xV8N/dmZC+x5lTxRCqrpbJOczA9r2pOH599CS8FfpGimutq2fEs3IWwB6/WMLDOs1vQ7yCya3w893N22bnCVnYj6YxFVQx6cjp/zmJpIVEvb4hgtNoYK44nPa57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdM5Aw65; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762244408; x=1793780408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYM83bBbxx1y5vplV3YBcZ8Mx+qy4hDpBNYYrYsw0cM=;
  b=SdM5Aw65tmK+G2S4PFzXMKCMuzbpS1Ag6ScbQX7ZlIa7tX3DfEhqS+9x
   akhuWp3lbf1UszJ1junMO49l2c6O1WxdlOtVxm1zUM4fpZlPg40NebwGH
   gqfxUGwj2asQp1bbzUrbD7FZLNCgLIvNq0kxZxEkG9ijPrxDZz5tKrk+o
   g1U8UqcsL9iAPC47NGcBNO4Y82DfgBKL17Sh7BQzu7xuX7qfJKPZDe00N
   BR4TQQ+Uwaea+aq0JSa3im4i4OZInYm49ExT0Z4eD2m/RpXO0N8Z9l1Tv
   YzSnNSTQS54phaVwmUdnaRG5/4IjHn0djtZIE/4XFa3CrI05TEOFM/SJj
   g==;
X-CSE-ConnectionGUID: cOqcktI+QkOOG6EwXxHRFw==
X-CSE-MsgGUID: H3guNeFrTs6ki1GjXsaE/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74624458"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="74624458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:20:08 -0800
X-CSE-ConnectionGUID: 4TYUN/wIR3WHvf4xaU/oPw==
X-CSE-MsgGUID: y1bocoSQTwWw2NQg6pBoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191445462"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Nov 2025 00:20:04 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGCGn-000R7c-2T;
	Tue, 04 Nov 2025 08:20:01 +0000
Date: Tue, 4 Nov 2025 16:19:45 +0800
From: kernel test robot <lkp@intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <202511041624.BMMvzi6h-lkp@intel.com>
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
config: sparc64-randconfig-002-20251104 (https://download.01.org/0day-ci/archive/20251104/202511041624.BMMvzi6h-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041624.BMMvzi6h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041624.BMMvzi6h-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-microchip-core.c:163:23: warning: unused variable 'corespi' [-Wunused-variable]
     163 |         struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
         |                              ^~~~~~~
>> drivers/spi/spi-microchip-core.c:438:3: error: field designator 'remove_new' does not refer to any field in type 'struct platform_driver'
     438 |         .remove_new = mchp_corespi_remove,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


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

