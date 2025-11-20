Return-Path: <linux-spi+bounces-11436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CBC75EE8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 395CE34555C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C430215D;
	Thu, 20 Nov 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJzcXvGG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E325742F;
	Thu, 20 Nov 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663702; cv=none; b=fx7E8u53PWQup6oHfZvRII9B97DI1JXnZVjmXNMcIrRpWfLjpwEC+4KLY8OyKgJ1dYtqPxXyE6qC0co/nDtJ1KJ+8Zwg20H/rPy+for1sOFvX5mW6W470W++W4cBaTS7HtXVO9AkpXsc4yKhDcf1vmvQEdppz30MEEVDZY+2g0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663702; c=relaxed/simple;
	bh=3Fzb54fjaR7ZtV3dxZZrZoeaKP6uiRx5LZSX269IsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR4XVvymGMGxwbvtFEgR5LBcugiiV11yqDXZ1tjDDEObB6JYsgmkeFvPIRp2cVousIYOjGwGBpDeCRN5pH+WS3q5PUW4IXjQvLoQZtM/QTFxCGdb4DIxH/juKU+ph70XbMD666rRiblFxY+CzHbUDXKrzvE0F4qib3rhsAgyQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJzcXvGG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763663701; x=1795199701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Fzb54fjaR7ZtV3dxZZrZoeaKP6uiRx5LZSX269IsB4=;
  b=dJzcXvGGgCxl+S6plOjj2vCTP+Al2ofCS3maU8pP+9vsrWsRLlu7hsYU
   hnB01RI7VJYDVFioP+8bFhJx60PrGzHhYCbNdNWrHTIS3IznzKAtuJLC+
   hkPn/gi10kdsLu0X5LHIl+ULNw3fCPsyJQgke2M7JqGVqkh0nAhRf7Pla
   BcluDrdVYvfeyHAfA3VrWIdTqjbNV/xnskVucUfjnonSlh+F0fe4cUtgi
   wK2CFNAgPGgEG/dmZPBOOeX14iNSVtLcIyv+LA749zZJYviF7gZaAH4Rf
   89lc+F64o1YoBZi4UGqJfvG1fouoGBSTOaF1dMqFG9oi4QT9oGHKSiQBm
   g==;
X-CSE-ConnectionGUID: +LZOYpTZR1GgEhLca/Br8w==
X-CSE-MsgGUID: Zv7cyBQgR/yHIrLQFTsEMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69363455"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69363455"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 10:35:00 -0800
X-CSE-ConnectionGUID: hIDQcUWBSkeFKCnyrqXnCw==
X-CSE-MsgGUID: Mqkay6l/QeyEeHR1YEo0Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="190678365"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Nov 2025 10:34:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM9Ua-0004OR-1W;
	Thu, 20 Nov 2025 18:34:52 +0000
Date: Fri, 21 Nov 2025 02:34:28 +0800
From: kernel test robot <lkp@intel.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, frank.li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 2/2] spi: add driver for NXP XSPI controller
Message-ID: <202511210153.zssUJV9a-lkp@intel.com>
References: <20251119-xspi-v4-2-a451afbccf33@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-xspi-v4-2-a451afbccf33@nxp.com>

Hi Haibo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fe4d0dea039f2befb93f27569593ec209843b0f5]

url:    https://github.com/intel-lab-lkp/linux/commits/Haibo-Chen/dt-bindings-spi-Document-imx94-xspi/20251119-185220
base:   fe4d0dea039f2befb93f27569593ec209843b0f5
patch link:    https://lore.kernel.org/r/20251119-xspi-v4-2-a451afbccf33%40nxp.com
patch subject: [PATCH v4 2/2] spi: add driver for NXP XSPI controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251121/202511210153.zssUJV9a-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511210153.zssUJV9a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511210153.zssUJV9a-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/spi/spi-nxp-xspi.c: In function 'nxp_xspi_dll_auto':
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:69:47: note: in expansion of macro '__bf_shf'
      69 |                                  ~((_mask) >> __bf_shf(_mask)) &        \
         |                                               ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:582:23: note: in definition of macro '__compiletime_assert'
     582 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/spi/spi-nxp-xspi.c:34:
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   In function 'nxp_xspi_dll_auto',
       inlined from 'nxp_xspi_select_mem' at drivers/spi/spi-nxp-xspi.c:771:3:
   include/linux/compiler_types.h:602:45: error: call to '__compiletime_assert_346' declared with attribute error: FIELD_PREP: mask is zero
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:583:25: note: in definition of macro '__compiletime_assert'
     583 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:602:9: note: in expansion of macro '_compiletime_assert'
     602 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/spi/spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
..


vim +49 include/linux/bits.h

31299a5e0211241 Vincent Mailhol 2025-03-26  35  
19408200c094858 Vincent Mailhol 2025-03-26  36  /*
19408200c094858 Vincent Mailhol 2025-03-26  37   * Generate a mask for the specified type @t. Additional checks are made to
19408200c094858 Vincent Mailhol 2025-03-26  38   * guarantee the value returned fits in that type, relying on
19408200c094858 Vincent Mailhol 2025-03-26  39   * -Wshift-count-overflow compiler check to detect incompatible arguments.
19408200c094858 Vincent Mailhol 2025-03-26  40   * For example, all these create build errors or warnings:
19408200c094858 Vincent Mailhol 2025-03-26  41   *
19408200c094858 Vincent Mailhol 2025-03-26  42   * - GENMASK(15, 20): wrong argument order
19408200c094858 Vincent Mailhol 2025-03-26  43   * - GENMASK(72, 15): doesn't fit unsigned long
19408200c094858 Vincent Mailhol 2025-03-26  44   * - GENMASK_U32(33, 15): doesn't fit in a u32
19408200c094858 Vincent Mailhol 2025-03-26  45   */
19408200c094858 Vincent Mailhol 2025-03-26  46  #define GENMASK_TYPE(t, h, l)					\
19408200c094858 Vincent Mailhol 2025-03-26  47  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
19408200c094858 Vincent Mailhol 2025-03-26  48  	     (type_max(t) << (l) &				\
19408200c094858 Vincent Mailhol 2025-03-26 @49  	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
19408200c094858 Vincent Mailhol 2025-03-26  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

