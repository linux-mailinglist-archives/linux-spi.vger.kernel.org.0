Return-Path: <linux-spi+bounces-10924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B760C22784
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 278A94EF5AF
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 21:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8933554D;
	Thu, 30 Oct 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NirNdlqB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72043329E4A;
	Thu, 30 Oct 2025 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861018; cv=none; b=K5ccAiZAIwkAjtGDt/r/ER2H0yGcKCmG0mqsQ4w2YWl+TSos9VhpaSPPSWPzBR3rwXLnk8LMlYqXEzMQ7qbQ+Q05ybmI6wJT4FjpQxocPPgMf1yga5o1RqMI+rjjPrTPd2YkGDXn3yMLvosbvf/gfSyd5fr0UplBcLa05ejqHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861018; c=relaxed/simple;
	bh=uhsBi6jPYk4r7zoS0KFwjGrcAihOvbPQ1OZl8wiwXVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PU4A1+dpMJeZKV9e3vCe3ABMOxItvjRpkrLXSPAuW+isULpJKHL2IRLqj7kXO3+vtVDScmx+s+cspRG/IhGt+utA8BGJt6Js7Rh7SPsMlx3lVi2jvfVkAU7TxMx6b2IMssAS8ZHC+J6zEbkUgKX5uKscB8xiEIfwe+Sp3YbmDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NirNdlqB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761861017; x=1793397017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhsBi6jPYk4r7zoS0KFwjGrcAihOvbPQ1OZl8wiwXVg=;
  b=NirNdlqBNGALsSY5tvWHP7ihPKPACmJLmbR+O5ZCxbHSuoxjWhK5b8wp
   dZOJp7sv0/sbzd+Vf78+Wty3cc407unGjlPcTt403EPIeRXaDV90/sWS2
   0jD+pcTZAroWTTXMUN/2g/uGr+L2cuyh5XwQqFeYPpMvpFs7/o3gIBf48
   UzhNqHcmZHfN2Ocy1lgbn9K4h5X3QuBxI+nXSuzfY6BBQig6rhOx4tW//
   mRTPhDljfIWf9VrYn/fRTt46kQ++bt3Ryz0etKdMIIeTzrmETeiUmgB1S
   nOlA2aJqPBAt2R2/vh7hywGXRRmEEQnReaheEhZYwF/cLhdTGqkVgsE+B
   Q==;
X-CSE-ConnectionGUID: ocCmyAlwTpaIpxDxqTN/AQ==
X-CSE-MsgGUID: gErP2+VxSfynECRDutQSMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81431809"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="81431809"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:50:15 -0700
X-CSE-ConnectionGUID: mqKL0/XMRAu6LM36rYEPAQ==
X-CSE-MsgGUID: UsRHOMzSR5SIqQrleSv+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186404807"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 30 Oct 2025 14:50:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEaX4-000MYi-28;
	Thu, 30 Oct 2025 21:50:10 +0000
Date: Fri, 31 Oct 2025 05:49:11 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, dlan@gentoo.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <202510310505.d7e7kzCk-lkp@intel.com>
References: <20251027125504.297033-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027125504.297033-3-elder@riscstar.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/dt-bindings-spi-add-SpacemiT-K1-SPI-support/20251027-211246
base:   8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
patch link:    https://lore.kernel.org/r/20251027125504.297033-3-elder%40riscstar.com
patch subject: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251031/202510310505.d7e7kzCk-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310505.d7e7kzCk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310505.d7e7kzCk-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__hexagon_udivdi3" [drivers/spi/spi-spacemit-k1.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DMA_CMA
   Depends on [n]: HAVE_DMA_CONTIGUOUS [=n] && CMA [=y]
   Selected by [m]:
   - SND_SOC_K1_I2S [=m] && SOUND [=m] && SND [=m] && SND_SOC [=m] && (COMPILE_TEST [=y] || ARCH_SPACEMIT) && HAVE_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

