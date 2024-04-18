Return-Path: <linux-spi+bounces-2432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C78A9C51
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE98281FD4
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2505165FCA;
	Thu, 18 Apr 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIc6TCg3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A261649DE;
	Thu, 18 Apr 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449458; cv=none; b=Y3Gu9YZUUtIwXL6hTyHpNbQ1yBlWJL3iCrr9FS+bUKGvDV/SdPOk+CGcVLOdGURIgEaKC+ehcbQ77sTnZnc7bGHUKfq/vKP2cYu5sFzC+EeZC0+AIvF/QW4PAptxBvX1haAUzj6vJOSyUREb8jKKkWFUTB2ixZdcGdHHhIec2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449458; c=relaxed/simple;
	bh=+T4Gbz0d0WDWqpCdnwHViVzIhKHhKRV2SeC9eULkFI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNG3rZovKhnaEF/Vly1fpmScMT7zt0qt18+lxkGv9fi+izaJEyZAZ03HCCc9ihWC2PPjrYsrcJl72iXzGwiyWWoSJOcMAY57n+xBks/86M7+zdakYAcICXxsddcgYf82J8jc9ZJG2gR7k7lKI/UsZvB8/sKsTWi09aO46/cQhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIc6TCg3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449455; x=1744985455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+T4Gbz0d0WDWqpCdnwHViVzIhKHhKRV2SeC9eULkFI8=;
  b=PIc6TCg3kjFDUeEIlpo5c6gF1M9HRWEwWvW2DcGrUECSHmcJTTeyJwXi
   t3ozW61b8IwvF5Wnv5RXbMGAlB01TzUefxbiWLl5F518b7EeBbTqxk1wy
   4B3+GQOHfajRI2plQksBnt6ryahthn+wxvfwayYkvfaT3nFjpKROgaD47
   e9mSFTMvofpTjvj3J3y4aiBuXFFsbD7EvHq7UCTpT4PTGQz6RAsK3qsPZ
   mxCsDLx7S7nBFhp/qu/HWWzXogL+jd0MxtJ5OMbn4w8kWDtNsdyrkYNg7
   419nx1R5rqSKuaWrftVm9fOI4cA5VBfdSPKvg72z+2qfJt8YvhPEnVlvQ
   w==;
X-CSE-ConnectionGUID: zjwjpYKvSly4O4dh+ZaEsw==
X-CSE-MsgGUID: p+4yzLcjSF69QfAU3RbhLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26456683"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="26456683"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:10:54 -0700
X-CSE-ConnectionGUID: zcIgliynSJW6Sz2cXS0D+w==
X-CSE-MsgGUID: jj4Bonx3Tnq9dPuBz/qaOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27441373"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Apr 2024 07:10:49 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxSTO-0007mK-2y;
	Thu, 18 Apr 2024 14:10:46 +0000
Date: Thu, 18 Apr 2024 22:10:35 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <202404182252.YtOmaTWG-lkp@intel.com>
References: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240416]
[cannot apply to broonie-spi/for-next robh/for-next arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.9-rc4 v6.9-rc3 v6.9-rc2 v6.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-spi-airoha-Add-YAML-schema-for-SNFI-controller/20240417-144847
base:   next-20240416
patch link:    https://lore.kernel.org/r/25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo%40kernel.org
patch subject: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240418/202404182252.YtOmaTWG-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404182252.YtOmaTWG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404182252.YtOmaTWG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-airoha-snfi.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2254:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/spi/spi-airoha-snfi.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/spi/spi-airoha-snfi.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/spi/spi-airoha-snfi.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/spi/spi-airoha-snfi.c:233:7: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     233 |                            FIELD_PREP(SPI_CTRL_OPFIFO_LEN, op_len) |
         |                            ^
   drivers/spi/spi-airoha-snfi.c:281:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     281 |                                    FIELD_PREP(SPI_CTRL_DFIFO_WDATA, data[i]));
         |                                    ^
>> drivers/spi/spi-airoha-snfi.c:320:12: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     320 |                 ptr[i] = FIELD_GET(SPI_CTRL_DFIFO_RDATA, val);
         |                          ^
   drivers/spi/spi-airoha-snfi.c:487:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     487 |                 val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
         |                       ^
   drivers/spi/spi-airoha-snfi.c:507:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     507 |                 val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
         |                       ^
   drivers/spi/spi-airoha-snfi.c:523:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     523 |         val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
         |               ^
   drivers/spi/spi-airoha-snfi.c:694:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     694 |         val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
         |               ^
   drivers/spi/spi-airoha-snfi.c:819:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     819 |         val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
         |               ^
   drivers/spi/spi-airoha-snfi.c:1034:12: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1034 |         sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
         |                   ^
   7 warnings and 9 errors generated.


vim +/FIELD_PREP +233 drivers/spi/spi-airoha-snfi.c

   225	
   226	static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
   227					    u8 op_cmd, int op_len)
   228	{
   229		int err;
   230		u32 val;
   231	
   232		err = regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WDATA,
 > 233				   FIELD_PREP(SPI_CTRL_OPFIFO_LEN, op_len) |
   234				   FIELD_PREP(SPI_CTRL_OPFIFO_OP, op_cmd));
   235		if (err)
   236			return err;
   237	
   238		err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   239					       REG_SPI_CTRL_OPFIFO_FULL,
   240					       val, !(val & SPI_CTRL_OPFIFO_FULL),
   241					       0, 250 * USEC_PER_MSEC);
   242		if (err)
   243			return err;
   244	
   245		err = regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WR,
   246				   SPI_CTRL_OPFIFO_WR);
   247		if (err)
   248			return err;
   249	
   250		return regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   251						REG_SPI_CTRL_OPFIFO_EMPTY,
   252						val, (val & SPI_CTRL_OPFIFO_EMPTY),
   253						0, 250 * USEC_PER_MSEC);
   254	}
   255	
   256	static int airoha_snand_set_cs(struct airoha_snand_ctrl *as_ctrl, u8 cs)
   257	{
   258		return airoha_snand_set_fifo_op(as_ctrl, cs, sizeof(cs));
   259	}
   260	
   261	static int airoha_snand_write_data_to_fifo(struct airoha_snand_ctrl *as_ctrl,
   262						   const u8 *data, int len)
   263	{
   264		int i;
   265	
   266		for (i = 0; i < len; i++) {
   267			int err;
   268			u32 val;
   269	
   270			/* 1. Wait until dfifo is not full */
   271			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   272						       REG_SPI_CTRL_DFIFO_FULL, val,
   273						       !(val & SPI_CTRL_DFIFO_FULL),
   274						       0, 250 * USEC_PER_MSEC);
   275			if (err)
   276				return err;
   277	
   278			/* 2. Write data to register DFIFO_WDATA */
   279			err = regmap_write(as_ctrl->regmap_ctrl,
   280					   REG_SPI_CTRL_DFIFO_WDATA,
   281					   FIELD_PREP(SPI_CTRL_DFIFO_WDATA, data[i]));
   282			if (err)
   283				return err;
   284	
   285			/* 3. Wait until dfifo is not full */
   286			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   287						       REG_SPI_CTRL_DFIFO_FULL, val,
   288						       !(val & SPI_CTRL_DFIFO_FULL),
   289						       0, 250 * USEC_PER_MSEC);
   290			if (err)
   291				return err;
   292		}
   293	
   294		return 0;
   295	}
   296	
   297	static int airoha_snand_read_data_from_fifo(struct airoha_snand_ctrl *as_ctrl,
   298						    u8 *ptr, int len)
   299	{
   300		int i;
   301	
   302		for (i = 0; i < len; i++) {
   303			int err;
   304			u32 val;
   305	
   306			/* 1. wait until dfifo is not empty */
   307			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   308						       REG_SPI_CTRL_DFIFO_EMPTY, val,
   309						       !(val & SPI_CTRL_DFIFO_EMPTY),
   310						       0, 250 * USEC_PER_MSEC);
   311			if (err)
   312				return err;
   313	
   314			/* 2. read from dfifo to register DFIFO_RDATA */
   315			err = regmap_read(as_ctrl->regmap_ctrl,
   316					  REG_SPI_CTRL_DFIFO_RDATA, &val);
   317			if (err)
   318				return err;
   319	
 > 320			ptr[i] = FIELD_GET(SPI_CTRL_DFIFO_RDATA, val);
   321			/* 3. enable register DFIFO_RD to read next byte */
   322			err = regmap_write(as_ctrl->regmap_ctrl,
   323					   REG_SPI_CTRL_DFIFO_RD, SPI_CTRL_DFIFO_RD);
   324			if (err)
   325				return err;
   326		}
   327	
   328		return 0;
   329	}
   330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

