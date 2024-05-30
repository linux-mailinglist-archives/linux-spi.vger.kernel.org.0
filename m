Return-Path: <linux-spi+bounces-3162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C48D526A
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 21:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B6A1C239E8
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60915887B;
	Thu, 30 May 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK4W+vtX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0747158860;
	Thu, 30 May 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097979; cv=none; b=OhMSFGbDLfb8HPiymrC+4n0JzQpbjZwNmKB+/4A5D3PPsv1y+GJwACDQ7TEaVLeFVHYL06nLJjOYLNBB+isPllCVLPmK4sZhRBNXZTlc0+sFtGo/u3EOCOaYwdoqtF2cm/+ymdSSv+gGiCdCVUS2KlSX3ipgAZibxUXrpDyc2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097979; c=relaxed/simple;
	bh=/lktGtJSvAn4lh7mJGP1VwrQBcfaabMzyjbDYfqQoH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtyho7r8a+nUQUl7pwyUSL88PtJ4wEFISFUIdNmQ2rhZP5DtUomj4kOT5Fq9sCET1K8e88VDUxfvPooSagBnPPwZQKm/2VwhaAIIrqDC/uAX2N2Qt/hiDJbNlncaCulZqE77J/NlUFipWOoZA1uIsIFNjdRxOmqxtIVUPgMbz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK4W+vtX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717097978; x=1748633978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lktGtJSvAn4lh7mJGP1VwrQBcfaabMzyjbDYfqQoH4=;
  b=EK4W+vtXByrrOyFw/g/tphVt9KMBbx8Xuzq3Qw56O09WATOcx4kB/d5L
   wegQ+OFH8QERi8cn0RLjqUa390yLk+04IAr4xdwms5YFw9RohckZqOp67
   mZFt3qDhm3Z1Nv2guVKwATBF3CqLQIbr+JdNjwi2f9RfsYjlfRmnhcxw4
   XzjIK/jdwce8wwh+y4XFa30hrJY1NlYa1qK4B+7KuknAhBLWPi79VlV1u
   bXq5P/z6xEkBJtblf1HRqZ8pWHV79UqYxhnxZG4wA1TCiXDbls6C2/u9C
   e6GaSkKtk1+fDWSfSadujUP9IVxw2SGQKRHjnOwwkap9bVZ1R50029Wx1
   A==;
X-CSE-ConnectionGUID: oB5aoEUmT3qI6hzq1B7Dnw==
X-CSE-MsgGUID: q88UenbTRLSgEb5EnKuuBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13809271"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13809271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:39:36 -0700
X-CSE-ConnectionGUID: RR6vibQ8SNWT6LNa4FbOmw==
X-CSE-MsgGUID: X2unkvyYR22oCdxtNCYCrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40985566"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 30 May 2024 12:39:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sClcX-000FuD-1Y;
	Thu, 30 May 2024 19:39:29 +0000
Date: Fri, 31 May 2024 03:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, pthombar@cadence.com,
	Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP overlay changes
Message-ID: <202405310322.RIyE2GGE-lkp@intel.com>
References: <20240529220026.1644986-3-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529220026.1644986-3-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-dt-bindings-cadence-Add-Marvell-overlay-bindings-documentation-for-Cadence-XSPI/20240530-060250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240529220026.1644986-3-wsadowski%40marvell.com
patch subject: [PATCH v7 2/4] spi: cadence: Add Marvell xSPI IP overlay changes
config: arm-randconfig-004-20240531 (https://download.01.org/0day-ci/archive/20240531/202405310322.RIyE2GGE-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310322.RIyE2GGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310322.RIyE2GGE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-cadence-xspi.c:496:15: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           *buf64++ = readq(addr);
                                      ^
   drivers/spi/spi-cadence-xspi.c:499:10: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           tmp = readq(addr);
                                 ^
   drivers/spi/spi-cadence-xspi.c:505:9: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   tmp = readq(addr);
                         ^
>> drivers/spi/spi-cadence-xspi.c:520:4: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           writeq(*buf64++, addr);
                           ^
   drivers/spi/spi-cadence-xspi.c:524:4: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           writeq(tmp, addr);
                           ^
   drivers/spi/spi-cadence-xspi.c:530:3: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   writeq(tmp, addr);
                   ^
   6 errors generated.


vim +/readq +496 drivers/spi/spi-cadence-xspi.c

   485	
   486	static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len)
   487	{
   488		int i = 0;
   489		int rcount = len / 8;
   490		int rcount_nf = len % 8;
   491		uint64_t tmp;
   492		uint64_t *buf64 = (uint64_t *)buf;
   493	
   494		if (((uint64_t)buf % 8) == 0) {
   495			for (i = 0; i < rcount; i++)
 > 496				*buf64++ = readq(addr);
   497		} else {
   498			for (i = 0; i < rcount; i++) {
   499				tmp = readq(addr);
   500				memcpy(buf+(i*8), &tmp, 8);
   501			}
   502		}
   503	
   504		if (rcount_nf != 0) {
   505			tmp = readq(addr);
   506			memcpy(buf+(i*8), &tmp, rcount_nf);
   507		}
   508	}
   509	
   510	static void mrvl_iowriteq(void __iomem *addr, const void *buf, int len)
   511	{
   512		int i = 0;
   513		int rcount = len / 8;
   514		int rcount_nf = len % 8;
   515		uint64_t tmp;
   516		uint64_t *buf64 = (uint64_t *)buf;
   517	
   518		if (((uint64_t)buf % 8) == 0) {
   519			for (i = 0; i < rcount; i++)
 > 520				writeq(*buf64++, addr);
   521		} else {
   522			for (i = 0; i < rcount; i++) {
   523				memcpy(&tmp, buf+(i*8), 8);
   524				writeq(tmp, addr);
   525			}
   526		}
   527	
   528		if (rcount_nf != 0) {
   529			memcpy(&tmp, buf+(i*8), rcount_nf);
   530			writeq(tmp, addr);
   531		}
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

