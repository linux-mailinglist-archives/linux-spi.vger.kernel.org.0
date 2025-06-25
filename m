Return-Path: <linux-spi+bounces-8756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBDAE7843
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8481B16631A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB21FF7C8;
	Wed, 25 Jun 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhuGw8JD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F19258CD8;
	Wed, 25 Jun 2025 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835470; cv=none; b=t0xDqCS36qMmAstglyrSfeOg+UHD+rK9O/FRtY5Qd/PwDqY2jFHvFphe9W0WasiAT+Oyn+7Hst0sjalgvHTIW1DLDJ/Nk+xHFLUJUMG5AWvDVlZHvEmqXTVInTaa4PcLNsKTIhnpYXgBcZuwA2X71Rp+07ZZr1q7z9EntXmZmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835470; c=relaxed/simple;
	bh=mNEMpUGa8rDYteMLi4xCtYy2E5bn8LSTBSKl/pLqk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSB7N7bmSU/+4mjQfU+76oXizW7yDqFQHXj4draMGmy6Tq7v+qxXmK0PICkM+J93t+1HWLAJTRayFN8c5LzTvRBjPcPj4bhLfpLZXnHgrLiSDWBQRdbEFZi9f6MUyjd6otA8PVjrfCPhyDlekWFL2LUOwuKlXP1Of0uyYLxul8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhuGw8JD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750835469; x=1782371469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mNEMpUGa8rDYteMLi4xCtYy2E5bn8LSTBSKl/pLqk/A=;
  b=IhuGw8JD/3sBT97lJEKrQEzEN8RX5wbJ9iMHjp5Ld0NrnXFUWU6AlH2M
   QzBratFOYTT4qzhFHaXu89FMYXkl4RGIgNpQdsBgj6K8fMdkTDHYfvJGA
   XwgrLp/oNcVWiUbkN78Mmwfng1asbG4rx0n3AXj5Cg3jO+rGnK6VPIVnc
   3a6NvsuddrkE06ILT2jVx+f2w7niLCBOPzMfKeEmvnEnZM4CCNlp0GpWl
   8Koi6lHgjVrIYR+cLW8MGxAR0ny3xVHeo5PO7aZu2rDZW/DBLNo0wlQjY
   bDQsRMvn4Xa++PTwHxhbuzL1LubJe7xCrRopktqo4Qj8JgHL9JtTtMhCv
   w==;
X-CSE-ConnectionGUID: DINXc1vbSIC/akpWBmQzNw==
X-CSE-MsgGUID: tIRtnvVCSPy3sihpZDZQtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52963776"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52963776"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:11:08 -0700
X-CSE-ConnectionGUID: RyTVzk0rRJKJJPJBWtsdfw==
X-CSE-MsgGUID: rrQIsZ9ES6u3CXPaY4+2vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152622908"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Jun 2025 00:11:05 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUKHe-000Spy-2S;
	Wed, 25 Jun 2025 07:11:02 +0000
Date: Wed, 25 Jun 2025 15:10:33 +0800
From: kernel test robot <lkp@intel.com>
To: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <202506251415.Cj026uIP-lkp@intel.com>
References: <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4f326fa6236787ca516ea6eab8e5e9dc5c236f03]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/spi-spi-fsl-dspi-Clear-completion-counter-before-initiating-transfer/20250624-183952
base:   4f326fa6236787ca516ea6eab8e5e9dc5c236f03
patch link:    https://lore.kernel.org/r/20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c%40linaro.org
patch subject: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250625/202506251415.Cj026uIP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506251415.Cj026uIP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506251415.Cj026uIP-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-fsl-dspi.c: In function 'dspi_dma_xfer':
   drivers/spi/spi-fsl-dspi.c:792:9: error: 'sdpi' undeclared (first use in this function); did you mean 'dspi'?
     792 |         sdpi->cur_msg->status = -EINVAL;
         |         ^~~~
         |         dspi
   drivers/spi/spi-fsl-dspi.c:792:9: note: each undeclared identifier is reported only once for each function it appears in
   drivers/spi/spi-fsl-dspi.c: In function 'dspi_poll':
>> drivers/spi/spi-fsl-dspi.c:1086:49: error: implicit declaration of function 'dspi_fifo_error'; did you mean 'dspi_fifo_write'? [-Wimplicit-function-declaration]
    1086 |                         dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
         |                                                 ^~~~~~~~~~~~~~~
         |                                                 dspi_fifo_write
   drivers/spi/spi-fsl-dspi.c: At top level:
   drivers/spi/spi-fsl-dspi.c:474:12: warning: 'dspi_pop_tx_pushr' defined but not used [-Wunused-function]
     474 | static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
         |            ^~~~~~~~~~~~~~~~~


vim +1086 drivers/spi/spi-fsl-dspi.c

  1072	
  1073	static void dspi_poll(struct fsl_dspi *dspi)
  1074	{
  1075		int tries = 1000;
  1076		u32 spi_sr;
  1077	
  1078		while (dspi->len) {
  1079			do {
  1080				regmap_read(dspi->regmap, SPI_SR, &spi_sr);
  1081				regmap_write(dspi->regmap, SPI_SR, spi_sr);
  1082	
  1083				if (spi_sr & SPI_SR_CMDTCF)
  1084					break;
  1085	
> 1086				dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
  1087				if (dspi->cur_msg->status)
  1088					return;
  1089			} while (--tries);
  1090	
  1091			if (!tries) {
  1092				dspi->cur_msg->status = -ETIMEDOUT;
  1093				return;
  1094			}
  1095	
  1096			dspi_rxtx(dspi);
  1097		}
  1098	
  1099		dspi->cur_msg->status = 0;
  1100	}
  1101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

