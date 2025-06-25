Return-Path: <linux-spi+bounces-8769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E76AE817C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849936A03EB
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7602325C702;
	Wed, 25 Jun 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKcoe7zn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C801214209;
	Wed, 25 Jun 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851155; cv=none; b=D4J4ZbvPg248Ov9gVzJmbg5nVABWrchyykVWTn8HvPRptwzxeNu/XjLB1C1SHQd2i8Qi14tX++MVPeQgkOPyRiHcN1yKcupLb8pnlYyzGcwa3lOBRH8HBdyOMcLzGVOqgXmuzzOic8IHvyL+W1mVxRkg7H0aJSpiFSGzcopUcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851155; c=relaxed/simple;
	bh=b8HExZsm4GZZYkcq+Be3f1cAN7tYaXlR5706Bb4d3ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unBVaSSz92eegRPdkBOgg+DU2GzrWe8HvV/KW6ixj88lGN6moxkpJ0yYNVSLl3oVtuf0hfNvsO6whw4nF5AVWKcbSal342slma+3MnWf0zHr+bl3ZeEbxCSbUcHUN3LTDX1ANtMk1cmYMSBOhy5qOvrh63jv0F6ayRDVyguTBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKcoe7zn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750851154; x=1782387154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8HExZsm4GZZYkcq+Be3f1cAN7tYaXlR5706Bb4d3ZE=;
  b=aKcoe7zn2lgBZlyrxIjzb/6RI0aS6zQf0onLWPfW++uKtb5F4fdQfbeZ
   TPQde0CzVd/O/+JRd81VFB4r6syhfYFLF9VRglOaKyLpyMDJrigvarA1B
   ZX/nZccfG+jVz0PFC1VAOnGP08jALJld86zXrcEFxHAWvVj1VdP2N8aP3
   ZXQ9MZ6Wp+K0U4F/8uZ3EaPU2GrH9Dk9Qmstrys6OJVfigycGpTXsta+v
   3ApiHhz1RSmA443bDlsHzMm2/yy4HF3VFy/+eT2HdThIC/elSPUDS0/OH
   7MqCrDP0x8ABoiKUPzmdttqXkAvdFtRuQWk2opN6wOjF5fW7C5gObFjim
   w==;
X-CSE-ConnectionGUID: jon4LHGCTEWpuxEKPLKnwA==
X-CSE-MsgGUID: YRX4vHH9TCiORdLU8H2flg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52232756"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52232756"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:32:33 -0700
X-CSE-ConnectionGUID: Pe3OIX3TS0GODZpYIBAnfg==
X-CSE-MsgGUID: +AIkFjC4RvKbHxfHQa8CQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="157964784"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2025 04:32:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUOMd-000T3u-2f;
	Wed, 25 Jun 2025 11:32:27 +0000
Date: Wed, 25 Jun 2025 19:32:02 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Message-ID: <202506251915.mDWx8v2S-lkp@intel.com>
References: <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>

Hi Fabrizio,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on geert-renesas-drivers/renesas-clk arm64/for-next/core geert-renesas-devel/next robh/for-next linus/master v6.16-rc3 next-20250625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrizio-Castro/clk-renesas-r9a09g057-Add-entries-for-the-RSPIs/20250625-032714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250624192304.338979-4-fabrizio.castro.jz%40renesas.com
patch subject: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250625/202506251915.mDWx8v2S-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506251915.mDWx8v2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506251915.mDWx8v2S-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-rzv2h-rspi.c: In function 'rzv2h_rspi_prepare_message':
>> drivers/spi/spi-rzv2h-rspi.c:298:18: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     298 |         conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
         |                  ^~~~~~~~~~


vim +/FIELD_PREP +298 drivers/spi/spi-rzv2h-rspi.c

   268	
   269	static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
   270					      struct spi_message *message)
   271	{
   272		struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(ctlr);
   273		const struct spi_device *spi = message->spi;
   274		struct spi_transfer *xfer;
   275		u32 speed_hz = U32_MAX;
   276		u8 bits_per_word;
   277		u32 conf32;
   278		u16 conf16;
   279	
   280		/* Make sure SPCR.SPE is 0 before amending the configuration */
   281		rzv2h_rspi_spe_disable(rspi);
   282	
   283		/* Configure the device to work in "host" mode */
   284		conf32 = RSPI_SPCR_MSTR;
   285	
   286		/* Auto-stop function */
   287		conf32 |= RSPI_SPCR_SCKASE;
   288	
   289		/* SPI receive buffer full interrupt enable */
   290		conf32 |= RSPI_SPCR_SPRIE;
   291	
   292		writel(conf32, rspi->base + RSPI_SPCR);
   293	
   294		/* Use SPCMD0 only */
   295		writeb(0x0, rspi->base + RSPI_SPSCR);
   296	
   297		/* Setup mode */
 > 298		conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
   299		conf32 |= FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
   300		conf32 |= FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST));
   301		conf32 |= FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
   302		conf32 |= FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
   303		writel(conf32, rspi->base + RSPI_SPCMD);
   304		if (spi->mode & SPI_CS_HIGH)
   305			writeb(BIT(spi_get_chipselect(spi, 0)), rspi->base + RSPI_SSLP);
   306		else
   307			writeb(0, rspi->base + RSPI_SSLP);
   308	
   309		/* Setup FIFO thresholds */
   310		conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
   311		conf16 |= FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
   312		writew(conf16, rspi->base + RSPI_SPDCR2);
   313	
   314		rzv2h_rspi_clear_fifos(rspi);
   315	
   316		list_for_each_entry(xfer, &message->transfers, transfer_list) {
   317			if (!xfer->speed_hz)
   318				continue;
   319	
   320			speed_hz = min(xfer->speed_hz, speed_hz);
   321			bits_per_word = xfer->bits_per_word;
   322		}
   323	
   324		if (speed_hz == U32_MAX)
   325			return -EINVAL;
   326	
   327		rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
   328		rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word - 1);
   329	
   330		rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
   331		if (!rspi->freq)
   332			return -EINVAL;
   333	
   334		rzv2h_rspi_spe_enable(rspi);
   335	
   336		return 0;
   337	}
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

