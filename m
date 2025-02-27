Return-Path: <linux-spi+bounces-6971-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D944A4893C
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238FC188BC42
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC526E96E;
	Thu, 27 Feb 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPTUGS1B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B626B2C7;
	Thu, 27 Feb 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685896; cv=none; b=Bp4nMYp7mJTg3H/Odb4YcGfGFOjg2eEt6xOVQJSW0X3yvwQi1UcdH7IwEKdb/hZd2twWjb9+KWj2TnC63Mvs1tlDNDGz8V75yo9cM036Cl5Xn3m9xjJ++CihbsI8JzeqbB0mpUciF+mszboUYFsHSW4EiaL4NTAuCfRd/RU0G+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685896; c=relaxed/simple;
	bh=EIbSUrM/Ujz1F3JimGdI96usqoFo8t4yf/dEL8vd+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+w2P6DYabZBuEF5ICSQ6sIRpITK165JM7DhoxUIfb2uWM+RrYO5piyEU9GBbmRoX0A8IwoSSavc7rfqunQopM36b+0Gc63V3nekqMoeUp5viyeelOdChkLG0z2+d5i2VxQ89fRGiuhbo9QyKCrM541j6GulDOaTXh/e+ePrPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPTUGS1B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740685895; x=1772221895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EIbSUrM/Ujz1F3JimGdI96usqoFo8t4yf/dEL8vd+xk=;
  b=iPTUGS1BRdEspshs028jBNv5yv/YAsjmYUOi1L+x3ChB45MMVoUtsmRT
   TGoBXyF2wsBqLuxbiE4u9Os2B1EGSCgWkshzJWiANf8F4EB1m6f817fnw
   Ba7hk2o7iHMD/g3vMXRvt9MMHobB0p7B28yEXlGXtn/ndFBhrBkQ9m56r
   UlARyTBoOhWQnQlAm803ThQqMfDjcmMDBQ9Jek3grWcFFULH+pSGPbPg3
   0FDCuNp+9QreDn9W7dZjYmkKwzdA1Eungb8PafVECid/EVORCZqsilYAa
   EiyG7n84sUGxnapCLCeONSwiQhHeeQ86BnTye6p0NdxioOv8CcK3sSQM9
   Q==;
X-CSE-ConnectionGUID: LJ3zR2cBT2+RF6pdUw9r5w==
X-CSE-MsgGUID: vJiw3xNgRAy52TcUmRgmnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52584913"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52584913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:51:34 -0800
X-CSE-ConnectionGUID: Zrhe8OtdQKee0BQsxRg1pA==
X-CSE-MsgGUID: FIZQc2wET9uoV0D4HJo0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="147945234"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2025 11:51:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnjur-000Dxy-19;
	Thu, 27 Feb 2025 19:51:29 +0000
Date: Fri, 28 Feb 2025 03:50:53 +0800
From: kernel test robot <lkp@intel.com>
To: Rengarajan S <rengarajan.s@microchip.com>, unglinuxdriver@microchip.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rengarajan.s@microchip.com
Subject: Re: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy
 implementation for x64 and bcm2711 processors
Message-ID: <202502280356.AulpRaPU-lkp@intel.com>
References: <20250224125153.13728-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224125153.13728-1-rengarajan.s@microchip.com>

Hi Rengarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rengarajan-S/spi-mchp-pci1xxxx-Updated-memcpy-implementation-for-x64-and-bcm2711-processors/20250224-205745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250224125153.13728-1-rengarajan.s%40microchip.com
patch subject: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy implementation for x64 and bcm2711 processors
config: arm-randconfig-002-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280356.AulpRaPU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280356.AulpRaPU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280356.AulpRaPU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-pci1xxxx.c:417:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     417 |                         __raw_writeq(*(u64 *)from, to);
         |                         ^
>> drivers/spi/spi-pci1xxxx.c:448:17: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     448 |                         *(u64 *)to = __raw_readq(from);
         |                                      ^
   2 errors generated.


vim +/__raw_writeq +417 drivers/spi/spi-pci1xxxx.c

   410	
   411	static void pci1xxxx_spi_write_to_io(void __iomem *to, const void *from,
   412					     size_t count, size_t size)
   413	{
   414		while (count) {
   415			if (size == 8 && (IS_ALIGNED((unsigned long)to, 8)) &&
   416			    count >= 8) {
 > 417				__raw_writeq(*(u64 *)from, to);
   418				from += 8;
   419				to += 8;
   420				count -= 8;
   421			} else if (size >= 4 && (IS_ALIGNED((unsigned long)to, 4)) &&
   422				   count >= 4) {
   423				__raw_writel(*(u32 *)from, to);
   424				from += 4;
   425				to += 4;
   426				count -= 4;
   427			} else if (size >= 2 && (IS_ALIGNED((unsigned long)to, 2)) &&
   428				   count >= 2) {
   429				__raw_writew(*(u16 *)from, to);
   430				from += 2;
   431				to += 2;
   432				count -= 2;
   433			} else {
   434				__raw_writeb(*(u8 *)from, to);
   435				from += 1;
   436				to += 1;
   437				count -= 1;
   438			}
   439		}
   440	}
   441	
   442	static void pci1xxxx_spi_read_from_io(void *to, const void __iomem *from,
   443					      size_t count, size_t size)
   444	{
   445		while (count) {
   446			if (size == 8 && (IS_ALIGNED((unsigned long)from, 8)) &&
   447			    count >= 8) {
 > 448				*(u64 *)to = __raw_readq(from);
   449				from += 8;
   450				to += 8;
   451				count -= 8;
   452			} else if (size >= 4 && (IS_ALIGNED((unsigned long)from, 4)) &&
   453				   count >= 4) {
   454				*(u32 *)to = __raw_readl(from);
   455				from += 4;
   456				to += 4;
   457				count -= 4;
   458			} else if (size >= 2 && (IS_ALIGNED((unsigned long)from, 2)) &&
   459				   count >= 2) {
   460				*(u16 *)to = __raw_readw(from);
   461				from += 2;
   462				to += 2;
   463				count -= 2;
   464			} else {
   465				*(u8 *)to = __raw_readb(from);
   466				from += 1;
   467				to += 1;
   468				count -= 1;
   469			}
   470		}
   471	}
   472	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

