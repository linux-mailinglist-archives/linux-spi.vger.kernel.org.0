Return-Path: <linux-spi+bounces-5540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 763729B5BE8
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A062B1C20B65
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74D1D1309;
	Wed, 30 Oct 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDDg2PS8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2761D0E27;
	Wed, 30 Oct 2024 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270645; cv=none; b=QVMnzMCMhb+ilX4jp516V0EU3gHPxjWPY7bK9XzcmTEZrorBuvbbx5VpW1leIFr4DaX7LHtP6N4wIkYkAjCiJJzc30BIa49OH/dBuprcPUzSUpBJDeGMZhqxslwN2rnQ2ISMCx3MzwFvJaiRpSot8BDGYmjgwcPt5auYEsCfMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270645; c=relaxed/simple;
	bh=0T+E7OV6n+a0eK67ylsHRGryyoU3pd01WCTFw4Kmrz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udc7o4HAoNZuEWe8g8aDp4UK/SNtI88NUybipFvV2djH3ah3lrsehdheuodmuPzekPR9647jQoHDMlABAb3fDdHdq30j51kS9xn/+Rv0WlIY7y9JiYVDioan/T9PBtZIFrwp2eXeUAvKdR9DAso953d1x0111fuRe8y1M0UxEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDDg2PS8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730270640; x=1761806640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0T+E7OV6n+a0eK67ylsHRGryyoU3pd01WCTFw4Kmrz4=;
  b=IDDg2PS8ZoOavwk/M89fmIwqqESvRrzTCiLcB78CIm2vWTybyO3Bao49
   0+hcCPi5CRfMqIvynrJW1XbGrKcJkSBwaZSvJa68XYJNWiZxAbXTQsRct
   RLhcBNG3GxQsFOyJuWR1RBoQ4M03tQsHwmvhSj+OnNM2b1rW6BufzL5XC
   iMRwjPT3Gjz5QMxRizQyN540F+m+yFo00P7by2ABO9XDi5PlnSysV4MR+
   242od0LQ94Agnm+XXWHIaLErzb4bRpPOQcorEFrhmeUpk89x7cIf5Bk8f
   vMfP2wEG9NlPjRILyFCPUqRlQzyMRqSjpa085sK4HmDs3ldpxrkAiV3Yl
   g==;
X-CSE-ConnectionGUID: gw1idrFPSdKdSP5jgtyXyw==
X-CSE-MsgGUID: ClZNH7i/REueB+emmvGfmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40532736"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="40532736"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:43:59 -0700
X-CSE-ConnectionGUID: Z1UfAt+GTX+2holsnhEt0Q==
X-CSE-MsgGUID: lyQQ4C04RD6jJ07K55ldXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82298268"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Oct 2024 23:43:57 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t62Qs-000eb2-1u;
	Wed, 30 Oct 2024 06:43:54 +0000
Date: Wed, 30 Oct 2024 14:42:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, broonie@kernel.org,
	miquel.raynal@bootlin.com
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
Message-ID: <202410301452.7koB3V8S-lkp@intel.com>
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
[also build test WARNING on next-20241029]
[cannot apply to linus/master v6.12-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/spi-spi-mem-rtl-snand-Correctly-handle-DMA-transfers/20241030-055313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241029215159.1975844-1-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241030/202410301452.7koB3V8S-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410301452.7koB3V8S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410301452.7koB3V8S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-realtek-rtl-snand.c: In function 'rtl_snand_dma_xfer':
>> drivers/spi/spi-realtek-rtl-snand.c:252:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     252 |                 buf = op->data.buf.out;
         |                     ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/const +252 drivers/spi/spi-realtek-rtl-snand.c

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

