Return-Path: <linux-spi+bounces-8621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4185ADCCF9
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D517A8427
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2028BAB3;
	Tue, 17 Jun 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UObvRUkW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E472E7177;
	Tue, 17 Jun 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166557; cv=none; b=ul3yc5Oqv23I+seFj+ib/BbXnvvRKLlDGP/h312lELdMXRFfe6J8ApTnqKcJfikC2Zxyb4aBXzfUcOuc/5uz7kTvRA1magmKydNN0mXkeMlUxWsJl684+1ozrgCugEu4/0dPfkTW5b8HcX9c6oFdc1fWkdlh6Ls+WvcdSY90mJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166557; c=relaxed/simple;
	bh=iOPD9cZ13iOgVBjbX8yhidl9KIoVbx+QGRtLA2hgsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8gFPvSvE8qkrmm8uZ6DBP+Gbpc3gzS5o5jJdWnCNHtTk7EFYhSmC74YwylNPrKnYHTBsKIKEJv52gTmVTMqPjgH+Pr1fVJZVSKsJuVK3n1ls45rkbGdN3p1RtejPKwDr+F649UDkFZH794bcCYHBSp/HDQTjSMFaHLnyTEKoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UObvRUkW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750166556; x=1781702556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iOPD9cZ13iOgVBjbX8yhidl9KIoVbx+QGRtLA2hgsws=;
  b=UObvRUkWtFpB7HKChFQuo5Kmda3Hl3/xjdOkUZXJut3TEDCY6ub65DVz
   9H5PSNFqPv5I6/Kt/VqUBLHWyNKvIggOo23/niARUyX89J/d0OE8ZzaV3
   M0ixmyh9FHl+mgoAKX8zXy1QHhuEYAa1Gug//EF4nkbAtHs1lRdi2Z/1v
   CAxFhS7jl4DbqCp++6CFd7DTIiPIz2jcBApSSUpXaVUIa6KOrgHoxK7Ur
   PBXfgRUZvWKTvnpSQ1a5Z+swyUxbFh8EIiC2+9GIi37dbTo6z46QIR3+e
   zRi1Cjc/yc8kaHVZsJvsnHSB+vxP1tT75L4hA8oTr9whbVmqh64vkY0+q
   w==;
X-CSE-ConnectionGUID: +1jeerDOSqSaTZB6D7BRDw==
X-CSE-MsgGUID: 8Un4tvBvShSBIXyzbQou2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52258069"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52258069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 06:22:35 -0700
X-CSE-ConnectionGUID: iojkX/jNRQS7IU1Sla552Q==
X-CSE-MsgGUID: zPQwlA+0SdOUc3vBWhem9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149671819"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 06:22:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRWGk-000G0l-1V;
	Tue, 17 Jun 2025 13:22:30 +0000
Date: Tue, 17 Jun 2025 21:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Mark Brown <broonie@kernel.org>, Michal Simek <monstr@monstr.eu>,
	linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v2 5/9] spi: zynqmp-gqspi: Support multiple buses
Message-ID: <202506172150.MoosHW24-lkp@intel.com>
References: <20250616220054.3968946-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616220054.3968946-6-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.16-rc2 next-20250617]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-spi-Add-spi-buses-property/20250617-060356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250616220054.3968946-6-sean.anderson%40linux.dev
patch subject: [PATCH v2 5/9] spi: zynqmp-gqspi: Support multiple buses
config: sparc-randconfig-001-20250617 (https://download.01.org/0day-ci/archive/20250617/202506172150.MoosHW24-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506172150.MoosHW24-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506172150.MoosHW24-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-zynqmp-gqspi.c: In function 'zynqmp_qspi_chipselect':
>> drivers/spi/spi-zynqmp-gqspi.c:469:25: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     469 |                         FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, qspi->buses);
         |                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +469 drivers/spi/spi-zynqmp-gqspi.c

   453	
   454	/**
   455	 * zynqmp_qspi_chipselect - Select or deselect the chip select line
   456	 * @qspi:	Pointer to the spi_device structure
   457	 * @is_high:	Select(0) or deselect (1) the chip select line
   458	 */
   459	static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
   460	{
   461		struct zynqmp_qspi *xqspi = spi_controller_get_devdata(qspi->controller);
   462		ulong timeout;
   463		u32 genfifoentry = 0, statusreg;
   464	
   465		genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
   466	
   467		if (!is_high) {
   468			xqspi->genfifobus =
 > 469				FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, qspi->buses);
   470			if (!spi_get_chipselect(qspi, 0))
   471				xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
   472			else
   473				xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
   474	
   475			genfifoentry |= xqspi->genfifobus;
   476			genfifoentry |= xqspi->genfifocs;
   477			genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
   478		} else {
   479			genfifoentry |= GQSPI_GENFIFO_CS_HOLD;
   480		}
   481	
   482		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
   483	
   484		/* Manually start the generic FIFO command */
   485		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
   486				   zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
   487				   GQSPI_CFG_START_GEN_FIFO_MASK);
   488	
   489		timeout = jiffies + msecs_to_jiffies(1000);
   490	
   491		/* Wait until the generic FIFO command is empty */
   492		do {
   493			statusreg = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
   494	
   495			if ((statusreg & GQSPI_ISR_GENFIFOEMPTY_MASK) &&
   496			    (statusreg & GQSPI_ISR_TXEMPTY_MASK))
   497				break;
   498			cpu_relax();
   499		} while (!time_after_eq(jiffies, timeout));
   500	
   501		if (time_after_eq(jiffies, timeout))
   502			dev_err(xqspi->dev, "Chip select timed out\n");
   503	}
   504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

