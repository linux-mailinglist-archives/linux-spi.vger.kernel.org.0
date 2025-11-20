Return-Path: <linux-spi+bounces-11437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A7C76385
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CE9E628F66
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB32FE594;
	Thu, 20 Nov 2025 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WED9arYD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC662FFF9D;
	Thu, 20 Nov 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671402; cv=none; b=noen2dbVouKtK/t53BoGpuhF+QAjWqyfdql1mN8+H7a4JcAbf7pbbdvo0PexfFf6INn3uteQ2gp6zBLTZewLixhQTCw8rMFzztscMha8KTUMYFkaKgFmiwDt3kj07qZobZ3vXZDZDNXM+4O32lj+9nIYSujo1zsDD+re4CiIjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671402; c=relaxed/simple;
	bh=UUn7JgKQmKikqCmbVJPQXE79ce57X7L+YEAlrs+V/qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m10siZg7QnPZ0gHvmTLXCSbmQCHvrT+aqayGWTxPB1KH6PQcGzU545wSVxqURr2pv0xBLTe0yyy9SHVwM5waPUrfMVmG+7ZGbS97aEPGC+/FHjW8/fxkIKg+Hc1/l2EycO9jAR+S8/CUEBFJ7Ghc7szJkEwkO1jzYWpsOKyzyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WED9arYD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763671401; x=1795207401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUn7JgKQmKikqCmbVJPQXE79ce57X7L+YEAlrs+V/qc=;
  b=WED9arYDYwkfzivM5PYru6Vxr7j2ZPaIIv0yUXUkE2lU05liZ2euDPCH
   8hNC9t0xzGKdOJOe7PMlBzzCJlMSaoUoEY5XRrZSEKu6f6zpF037xFY4c
   SNgiSTbbVwIz9Cyhrhp6b/hMPIfaQ2tanPhiXUdwMLjllsDTtyXii1vEW
   5yWVRzclvfNGh7hipJ2wljB78cNUpb5cQIvKi6r1IRCjENttD893Gq7r7
   7MnSYmtFQca01kz7zZT1PCjZOcJ2A0wCdTCUZXs3Y/T7eAAO59tyFu86Z
   BGpWiesa/QO0HbG36W+eOeXBrSLFsVt8nKD7WAufFc3mG7HRfIbqpR+Zo
   g==;
X-CSE-ConnectionGUID: ZRMpywHBTwKpmXFwHPHn/g==
X-CSE-MsgGUID: h0YGhaeDS56ZmUOgNkO3yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65634629"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65634629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:43:20 -0800
X-CSE-ConnectionGUID: xgYWqL62TWizbyA9t+DeRA==
X-CSE-MsgGUID: hEQyJtLyQR+bTh6H93KnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191732009"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Nov 2025 12:43:15 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMBUn-0004YJ-2e;
	Thu, 20 Nov 2025 20:43:13 +0000
Date: Fri, 21 Nov 2025 04:43:00 +0800
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
Message-ID: <202511210421.NAzUWBmi-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on fe4d0dea039f2befb93f27569593ec209843b0f5]

url:    https://github.com/intel-lab-lkp/linux/commits/Haibo-Chen/dt-bindings-spi-Document-imx94-xspi/20251119-185220
base:   fe4d0dea039f2befb93f27569593ec209843b0f5
patch link:    https://lore.kernel.org/r/20251119-xspi-v4-2-a451afbccf33%40nxp.com
patch subject: [PATCH v4 2/2] spi: add driver for NXP XSPI controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251121/202511210421.NAzUWBmi-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511210421.NAzUWBmi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511210421.NAzUWBmi-lkp@intel.com/

All errors (new ones prefixed by >>):

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
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
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
>> include/linux/compiler_types.h:602:45: error: call to '__compiletime_assert_346' declared with attribute error: FIELD_PREP: mask is zero
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
--
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
   spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
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
   spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from spi-nxp-xspi.c:34:
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   spi-nxp-xspi.c:114:41: note: in expansion of macro 'GENMASK'
     114 | #define XSPI_DLLCRA_DLLRES_MASK         GENMASK(32, 20)
         |                                         ^~~~~~~
   spi-nxp-xspi.c:661:26: note: in expansion of macro 'XSPI_DLLCRA_DLLRES_MASK'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   In function 'nxp_xspi_dll_auto',
       inlined from 'nxp_xspi_select_mem' at spi-nxp-xspi.c:771:3:
>> include/linux/compiler_types.h:602:45: error: call to '__compiletime_assert_346' declared with attribute error: FIELD_PREP: mask is zero
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
   spi-nxp-xspi.c:661:15: note: in expansion of macro 'FIELD_PREP'
     661 |               FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
         |               ^~~~~~~~~~


vim +/__compiletime_assert_346 +602 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  588  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  589  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  590  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  591  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  592  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  593   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  594   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  595   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  596   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  597   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  598   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  599   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  600   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  601  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @602  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  603  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

