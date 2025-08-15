Return-Path: <linux-spi+bounces-9464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE91B276D9
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 05:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2395E168B
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C341E7C34;
	Fri, 15 Aug 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3oEspCR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37178189BB0;
	Fri, 15 Aug 2025 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229085; cv=none; b=hSZbfMv4H67p7s4fmNpju/rmBICzPm6PkS47yrZBe7rhNUKnxgEAGcy6Am6kDH7TUDlNMMIQjHDUdxGuwuTrGi5IkvwhfknVirqBwTA5ah+snh089lXyxazIvPEA4MIelOjZgEvYaV4lZO9/izWjtSLXUrfwXdZ4Dv86LG8y/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229085; c=relaxed/simple;
	bh=h8lIgUKwTmS+ekZUNGUrFDR3LrVHggV9Oafs6V0kwNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAHeJn0ARKNweVUXdF7iew8P4Nt+C0PPTfDpkt5Y0sFfSQ44tzA2wKGkIuUwQq0zqO/Cv3f+EZ0VePHsfJZhlCwEVL7YzHlsDqamuc/5N4bHyNOrE12roOvGEq1mkNXUZnKvQA/XNq6O4oQPQdYMKm5eHHSazwiPvWgobBrgT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3oEspCR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755229084; x=1786765084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h8lIgUKwTmS+ekZUNGUrFDR3LrVHggV9Oafs6V0kwNs=;
  b=R3oEspCR+F+QMfGu6AZ0+LUnvrlvpc2OOPt0M0w8IyZwnOQ2hsGPt7Jg
   uTvwm1cXOvIJadDRnGPV/x5kmIcJnfWk4UV4bmAc2h5DfW0STsHBkEtbt
   LCAgcXrt3YaoegoGm1j+6XXV/ariscrlGwrdxfEXHr4ewORRS1vcBXFov
   U68L5miuLRMmtbHCiQrB79vje7i5BSiO1eF7AEmSjbLEeCSsmbO5/rjhg
   wxDWEj5cA6RfpNOEbalrZlVQ8isQ1/vCYSJ3hZhd8xgQ8NI4ba47BsFZ8
   maVVTV5UkEn82c0Li0uNTIoc0O1gcTePtX8uLPmt+jXM4ZvedoVMi+n7e
   w==;
X-CSE-ConnectionGUID: C97e30NpSUm527bk8e+Jow==
X-CSE-MsgGUID: wT2ABwhfRsCPzSW9hOWgUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61187451"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61187451"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:38:03 -0700
X-CSE-ConnectionGUID: 1CkzBkoBTUS0Q+uORQ+5Ug==
X-CSE-MsgGUID: UFC4QNirQheTFLpH8/EwaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167296446"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Aug 2025 20:37:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umlGG-000BW4-2a;
	Fri, 15 Aug 2025 03:37:52 +0000
Date: Fri, 15 Aug 2025 11:37:00 +0800
From: kernel test robot <lkp@intel.com>
To: James Clark <james.clark@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, James Clark <james.clark@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
Message-ID: <202508151101.7lDGTaxi-lkp@intel.com>
References: <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/spi-spi-fsl-lpspi-Fix-transmissions-when-using-CONT/20250815-001554
base:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
patch link:    https://lore.kernel.org/r/20250814-james-nxp-lpspi-v1-2-9586d7815d14%40linaro.org
patch subject: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select polarity bit
config: csky-randconfig-002-20250815 (https://download.01.org/0day-ci/archive/20250815/202508151101.7lDGTaxi-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151101.7lDGTaxi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151101.7lDGTaxi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-fsl-lpspi.c: In function 'fsl_lpspi_config':
>> drivers/spi/spi-fsl-lpspi.c:428:25: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     428 |                 temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
         |                         ^~~~~~~~~~


vim +/FIELD_PREP +428 drivers/spi/spi-fsl-lpspi.c

   409	
   410	static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
   411	{
   412		u32 temp;
   413		int ret;
   414	
   415		if (!fsl_lpspi->is_target) {
   416			ret = fsl_lpspi_set_bitrate(fsl_lpspi);
   417			if (ret)
   418				return ret;
   419		}
   420	
   421		fsl_lpspi_set_watermark(fsl_lpspi);
   422	
   423		if (!fsl_lpspi->is_target)
   424			temp = CFGR1_HOST;
   425		else
   426			temp = CFGR1_PINCFG;
   427		if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 > 428			temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
   429					   BIT(fsl_lpspi->config.chip_select));
   430	
   431		writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
   432	
   433		temp = readl(fsl_lpspi->base + IMX7ULP_CR);
   434		temp |= CR_RRF | CR_RTF | CR_MEN;
   435		writel(temp, fsl_lpspi->base + IMX7ULP_CR);
   436	
   437		temp = 0;
   438		if (fsl_lpspi->usedma)
   439			temp = DER_TDDE | DER_RDDE;
   440		writel(temp, fsl_lpspi->base + IMX7ULP_DER);
   441	
   442		return 0;
   443	}
   444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

