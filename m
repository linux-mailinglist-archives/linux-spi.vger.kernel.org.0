Return-Path: <linux-spi+bounces-5651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024B9C0F83
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A169B1F217C9
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09D2170D6;
	Thu,  7 Nov 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+/ICLsO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61D20F5D7;
	Thu,  7 Nov 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009770; cv=none; b=qNdC7DUKBXWuWj+qmF83z5FQ8SqJAFw4ezHZQJjh7d1gPajw7ftEJOtcjp9CnLLZzyNso/psVbcvRM0hWmMKqIHX4AeZTTiN+FWAqP5Ju0WVNvN0WzsjCEzSi9+NGIegHcaIpR7O8NLJDzVN/0ZDjtSmJx7J1ZPhR9aT8vyulxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009770; c=relaxed/simple;
	bh=IOhBT4+s9HKKZijqKV2MQyFUtiotLMC73AtMG4Y6HsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slTkb+yK/nveyaIVb1clQrMsK0Py6bZ7IfeuCrEQ8/A9htwh5h9N/fQZ8shSDtXxVSb128VFbPzeIqOa22egmcPAP6/S6dRDG5WLRs3WHAA0N2rlU4rTMNSARVqcqRJTyJGkt6WXxBIxEA/iAc6o9W/fOuzB36QvMW3AlOZVXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+/ICLsO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731009768; x=1762545768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOhBT4+s9HKKZijqKV2MQyFUtiotLMC73AtMG4Y6HsI=;
  b=B+/ICLsOHDBxNTJIHr98ST1Dal6D/hvlSvM5RuCcED8cPaOHfCufe8u1
   G/fdNpil1m5vT3237BBkusXSSoOT2cpkHoZz3bHgW2EYJAAXIMMG2jFSl
   UQ0o7ZeJeEqXVYagdySpkBwknAoS4XjOnDlXu//PqLacXmapsEQdM1k6q
   50vzCnBWNFqtA3Fjg4M7xZGI0wCi5GPz+IYf/hLSyW/VGNqI1rz0CQ/TR
   L4BC07GbeOFocFLDpzRwursyfEwC53TrHaPuwHCYk4t/fn9fsq/lO+UQj
   ajn6gm310s+3T/WiKIVRuy+mEQ31b4U9J9wnz0VNcfF0rVA/rMIcJvzFQ
   A==;
X-CSE-ConnectionGUID: 9eH0FDVESUSkagtlIH3F1A==
X-CSE-MsgGUID: OCRzhjlBSbOAeThemXwI/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="48389753"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="48389753"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:02:33 -0800
X-CSE-ConnectionGUID: ba7PxB6RT3iz2c17O0RJ7w==
X-CSE-MsgGUID: 29VcLRgfRSOszxnR9CtQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89860766"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2024 12:02:30 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t98i3-000qdG-2M;
	Thu, 07 Nov 2024 20:02:27 +0000
Date: Fri, 8 Nov 2024 04:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jonas Rebmann <jre@pengutronix.de>
Subject: Re: [PATCH 2/2] spi: imx: support word delay
Message-ID: <202411080315.8JXzpAnT-lkp@intel.com>
References: <20241107-imx-spi-word-delay-v1-2-2a969214d796@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-imx-spi-word-delay-v1-2-2a969214d796@pengutronix.de>

Hi Jonas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Rebmann/spi-imx-pass-struct-spi_transfer-to-prepare_transfer/20241107-233756
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241107-imx-spi-word-delay-v1-2-2a969214d796%40pengutronix.de
patch subject: [PATCH 2/2] spi: imx: support word delay
config: arc-randconfig-002-20241108 (https://download.01.org/0day-ci/archive/20241108/202411080315.8JXzpAnT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080315.8JXzpAnT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080315.8JXzpAnT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-imx.c: In function 'mx51_ecspi_prepare_transfer':
>> drivers/spi/spi-imx.c:739:14: error: implicit declaration of function 'FIELD_FIT' [-Werror=implicit-function-declaration]
     739 |         if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
         |              ^~~~~~~~~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/arc/include/uapi/asm/byteorder.h:16,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from include/linux/clk.h:13,
                    from drivers/spi/spi-imx.c:6:
>> drivers/spi/spi-imx.c:742:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     742 |         writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
         |                ^~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   arch/arc/include/asm/io.h:208:47: note: in expansion of macro 'writel_relaxed'
     208 | #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
         |                                               ^~~~~~~~~~~~~~
   drivers/spi/spi-imx.c:742:9: note: in expansion of macro 'writel'
     742 |         writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
         |         ^~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_FIT +739 drivers/spi/spi-imx.c

   665	
   666	static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
   667					       struct spi_device *spi, struct spi_transfer *t)
   668	{
   669		u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
   670		u64 word_delay_sck;
   671		u32 clk;
   672	
   673		/* Clear BL field and set the right value */
   674		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
   675		if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
   676			ctrl |= (spi_imx->target_burst * 8 - 1)
   677				<< MX51_ECSPI_CTRL_BL_OFFSET;
   678		else {
   679			ctrl |= (spi_imx->bits_per_word - 1)
   680				<< MX51_ECSPI_CTRL_BL_OFFSET;
   681		}
   682	
   683		/* set clock speed */
   684		ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
   685			  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
   686		ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
   687		spi_imx->spi_bus_clk = clk;
   688	
   689		mx51_configure_cpha(spi_imx, spi);
   690	
   691		/*
   692		 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
   693		 * before i.mx6ul.
   694		 */
   695		if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
   696			ctrl |= MX51_ECSPI_CTRL_SMC;
   697		else
   698			ctrl &= ~MX51_ECSPI_CTRL_SMC;
   699	
   700		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
   701	
   702		/* calculate word delay in SPI Clock (SCLK) cycles */
   703		if (t->word_delay.value == 0) {
   704			word_delay_sck = 0;
   705		} else if (t->word_delay.unit == SPI_DELAY_UNIT_SCK) {
   706			word_delay_sck = t->word_delay.value;
   707	
   708			if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK)
   709				word_delay_sck = 0;
   710			else if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1)
   711				word_delay_sck = 1;
   712			else
   713				word_delay_sck -= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1;
   714		} else {
   715			int word_delay_ns;
   716	
   717			word_delay_ns = spi_delay_to_ns(&t->word_delay, t);
   718			if (word_delay_ns < 0)
   719				return word_delay_ns;
   720	
   721			if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
   722							     MX51_ECSPI_PERIOD_MIN_DELAY_SCK,
   723							     spi_imx->spi_bus_clk)) {
   724				word_delay_sck = 0;
   725			} else if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
   726								    MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
   727								    spi_imx->spi_bus_clk)) {
   728				word_delay_sck = 1;
   729			} else {
   730				word_delay_ns -= mul_u64_u32_div(NSEC_PER_SEC,
   731								 MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
   732								 spi_imx->spi_bus_clk);
   733	
   734				word_delay_sck = DIV_U64_ROUND_UP((u64)word_delay_ns * spi_imx->spi_bus_clk,
   735								  NSEC_PER_SEC);
   736			}
   737		}
   738	
 > 739		if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
   740			return -EINVAL;
   741	
 > 742		writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
   743		       spi_imx->base + MX51_ECSPI_PERIOD);
   744	
   745		return 0;
   746	}
   747	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

