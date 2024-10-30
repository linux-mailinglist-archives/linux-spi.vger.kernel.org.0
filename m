Return-Path: <linux-spi+bounces-5568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1FC9B6D22
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 20:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BAF282DC9
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780B1D0400;
	Wed, 30 Oct 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCcvWB4X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FB1C3F01;
	Wed, 30 Oct 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318017; cv=none; b=Ta5Vu2OG7ABP0cnD0JQc5PKV7FZ0R1r49Pb2DZ5g1X1cuHxg4bOWVOpQDvbCvUreDZeJWBhwojEW+HIo+7dFEsNYZg+Lv9aVkpW1Fxv0f4Pnqb4/G/UvIFscXaLp+ZKiBm0s1lJBrA3ADhKE+NlJuVGCi6ugKXFMWHE4TrxivW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318017; c=relaxed/simple;
	bh=wyt0dBMKgnMl5ZM1MfC4za/eAJFFeRWrQfZ8t4y/fYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfI3apxVcs9/bUo4DlSNtMZRl3szUTzmgu632h2acxlOnYt6c1sOZL+eiei24V/FayxHEWMDpxaRKDbJixT5aCIjGH0H4X8/JB+8eNOj1yjzrUgBWcTMet8Z5Pup5qDLdMnTEZfXEo37iEq5r9PFgmYyrOzz46we1dYvbOS+ZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCcvWB4X; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730318014; x=1761854014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyt0dBMKgnMl5ZM1MfC4za/eAJFFeRWrQfZ8t4y/fYM=;
  b=SCcvWB4XUSRxEwUrqgzbQDQ71Rb3PvuRQlNDZWTksqbQnOdJU63CY8o+
   /KLmYB1ihHi33B6t2C/570auLuEFZVVSLMUXw+NPIHInHMqnCRKlcqLWg
   gW7bwyMW0dhNrnCvxPwJhDyWYE+brAb40lJeuEQ90Pe/vATxgZx/506xa
   YrqzblJSq/KfAXpyLuTGNqwKVhu4vO4OEfbvYkfpuYwYHBhr2g7H76wcY
   gB3pqJ1h+XmSlVFSlmTnDxF7c/RedDaYN3JiH5PijwTN0Wcjl4B3E3qnn
   gYwzOi4c9XEHG3Omf+teRYuKOuZwBwJ0jSN2wPWzigNn6ZBdyc4RxjurY
   A==;
X-CSE-ConnectionGUID: li1hay2fTxakTgoILPl8qg==
X-CSE-MsgGUID: xA5njYveTjGMOM2MuV9IFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30232632"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30232632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 12:53:34 -0700
X-CSE-ConnectionGUID: vSzTMaDxR56N3mVuaCpRoA==
X-CSE-MsgGUID: I+tDLQUZRwSJNEDQJmbdSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86358492"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2024 12:53:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Ekz-000fFo-1b;
	Wed, 30 Oct 2024 19:53:29 +0000
Date: Thu, 31 Oct 2024 03:53:02 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, broonie@kernel.org,
	miquel.raynal@bootlin.com
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
Message-ID: <202410310358.GyKQwhxO-lkp@intel.com>
References: <20241029215159.1975844-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029215159.1975844-1-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on next-20241030]
[cannot apply to linus/master v6.12-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/spi-spi-mem-rtl-snand-Correctly-handle-DMA-transfers/20241030-055313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241029215159.1975844-1-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
config: nios2-randconfig-r131-20241030 (https://download.01.org/0day-ci/archive/20241031/202410310358.GyKQwhxO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241031/202410310358.GyKQwhxO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310358.GyKQwhxO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-realtek-rtl-snand.c:252:21: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected void *[assigned] buf @@     got void const *const out @@
   drivers/spi/spi-realtek-rtl-snand.c:252:21: sparse:     expected void *[assigned] buf
   drivers/spi/spi-realtek-rtl-snand.c:252:21: sparse:     got void const *const out

vim +252 drivers/spi/spi-realtek-rtl-snand.c

   231	
   232	static int rtl_snand_dma_xfer(struct rtl_snand *snand, int cs, const struct spi_mem_op *op)
   233	{
   234		unsigned int pos, nbytes;
   235		int ret;
   236		dma_addr_t buf_dma;
   237		enum dma_data_direction dir;
   238		u32 trig, len, maxlen;
   239		void *buf;
   240	
   241		ret = rtl_snand_xfer_head(snand, cs, op);
   242		if (ret)
   243			goto out_deselect;
   244	
   245		if (op->data.dir == SPI_MEM_DATA_IN) {
   246			maxlen = 2080;
   247			buf = op->data.buf.in;
   248			dir = DMA_FROM_DEVICE;
   249			trig = 0;
   250		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
   251			maxlen = 520;
 > 252			buf = op->data.buf.out;
   253			dir = DMA_TO_DEVICE;
   254			trig = 1;
   255		} else {
   256			ret = -EOPNOTSUPP;
   257			goto out_deselect;
   258		}
   259	
   260		buf_dma = dma_map_single(snand->dev, buf, op->data.nbytes, dir);
   261		ret = dma_mapping_error(snand->dev, buf_dma);
   262		if (ret)
   263			goto out_deselect;
   264	
   265		ret = regmap_write(snand->regmap, SNAFDIR, SNAFDIR_DMA_IP);
   266		if (ret)
   267			goto out_unmap;
   268	
   269		ret = regmap_update_bits(snand->regmap, SNAFCFR, SNAFCFR_DMA_IE, SNAFCFR_DMA_IE);
   270		if (ret)
   271			goto out_unmap;
   272	
   273		pos = 0;
   274		len = op->data.nbytes;
   275	
   276		while (pos < len) {
   277			nbytes = len - pos;
   278			if (nbytes > maxlen)
   279				nbytes = maxlen;
   280	
   281			reinit_completion(&snand->comp);
   282	
   283			ret = regmap_write(snand->regmap, SNAFDRSAR, buf_dma + pos);
   284			if (ret)
   285				goto out_disable_int;
   286	
   287			pos += nbytes;
   288	
   289			ret = regmap_write(snand->regmap, SNAFDLR,
   290					CMR_WID(op->data.buswidth) | nbytes);
   291			if (ret)
   292				goto out_disable_int;
   293	
   294			ret = regmap_write(snand->regmap, SNAFDTR, trig);
   295			if (ret)
   296				goto out_disable_int;
   297	
   298			if (!wait_for_completion_timeout(&snand->comp, usecs_to_jiffies(20000)))
   299				ret = -ETIMEDOUT;
   300	
   301			if (ret)
   302				goto out_disable_int;
   303		}
   304	
   305	out_disable_int:
   306		regmap_update_bits(snand->regmap, SNAFCFR, SNAFCFR_DMA_IE, 0);
   307	out_unmap:
   308		dma_unmap_single(snand->dev, buf_dma, op->data.nbytes, dir);
   309	out_deselect:
   310		rtl_snand_xfer_tail(snand, cs);
   311	
   312		if (ret)
   313			dev_err(snand->dev, "transfer failed %d\n", ret);
   314	
   315		return ret;
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

