Return-Path: <linux-spi+bounces-4261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4F9591EA
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2024 02:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8674B21ECC
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2024 00:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D81803E;
	Wed, 21 Aug 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGlDkb5i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF6134B6;
	Wed, 21 Aug 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200565; cv=none; b=NTD4NMG91JYhNvguIwj8miB6U8kas36ylbReEn6W0/RKOttYuj1eroobHaSbqD4XzjOFZmI1W+Z+BLeieWkdoo4bFUuQiyuJzhmS6pxp4nAfOmG+LPBAINqKvZGMasGwRPHIk8jznyMxNTYbQEh5e4eorGB8lWaH0PXu+AH8jOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200565; c=relaxed/simple;
	bh=pbIWRKgD32GPjpxjthB6v7/UP7vr1HstzDWmojM99FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUP6KaCemBNTywmORBYvXVbzujq55X3qt687/oxljths+vTki8fizpBfV4xb/vxhqNotKIqcRr0RiaqFfDieqqn5t0JhS1s+VO6jRCyVDQ+N4mz9IHxjqBix2tttFdc85Fd0VV6mVdlqbybYG0aV+y1yNoryWZh+1gazdktqe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGlDkb5i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724200564; x=1755736564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pbIWRKgD32GPjpxjthB6v7/UP7vr1HstzDWmojM99FQ=;
  b=nGlDkb5iELh46onzgOJO1/7mtfPgN5W2iL3MDWH2CDykAWozkdstz1O7
   HURYeP1d+oCu57DMQ3cxOJsi/7g9/NouRoVNXdh3Ap8OYdNsgsKpVkRun
   du3aW8vnL50QloKJs7DBkeWXT/6zHFLEPyZfovuMYZYJCKzmLbdPTd1ec
   CKNn6H4JbIu56YFNLAxLOqObmAjok5xvXQkJ6ruJ7mv74AfbnHuPDOmKz
   Vj8woZ5o6I5giEqacWFUbKQtPXPYZCU2eoeEDTEHgSQOYU8dLgJY+b17I
   sGQg0VKwv+5XqJPfjIz3iz6XdRRZEorrC3GXKKZtsT4CqYP0Q2Q5WWwux
   w==;
X-CSE-ConnectionGUID: Qx+ggEuiSt2DCg4ULR7doQ==
X-CSE-MsgGUID: t190mGhxQkCnTtaAe7+Lxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22723122"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="22723122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 17:36:03 -0700
X-CSE-ConnectionGUID: RldnoCA6S+GftaEj7UdkJg==
X-CSE-MsgGUID: G9i5SaDPQHGlcAeOUX3bGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60880900"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Aug 2024 17:35:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgZKO-000AjS-1U;
	Wed, 21 Aug 2024 00:35:56 +0000
Date: Wed, 21 Aug 2024 08:35:29 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v8 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
Message-ID: <202408210853.PGPCGquw-lkp@intel.com>
References: <20240820104239.1774600-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820104239.1774600-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.11-rc4 next-20240820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240820-184732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240820104239.1774600-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v8 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240821/202408210853.PGPCGquw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210853.PGPCGquw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210853.PGPCGquw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-qpic-snand.c: In function 'qcom_spi_ecc_init_ctx_pipelined':
>> drivers/spi/spi-qpic-snand.c:248:28: warning: variable 'strength' set but not used [-Wunused-but-set-variable]
     248 |         int step_size = 0, strength = 0;
         |                            ^~~~~~~~
>> drivers/spi/spi-qpic-snand.c:248:13: warning: variable 'step_size' set but not used [-Wunused-but-set-variable]
     248 |         int step_size = 0, strength = 0;
         |             ^~~~~~~~~
   drivers/spi/spi-qpic-snand.c: In function 'qcom_spi_write_page':
   drivers/spi/spi-qpic-snand.c:1259:30: warning: variable 's_op' set but not used [-Wunused-but-set-variable]
    1259 |         struct qpic_snand_op s_op = {};
         |                              ^~~~
   drivers/spi/spi-qpic-snand.c: At top level:
   drivers/spi/spi-qpic-snand.c:1630:19: error: initialization of 'int (*)(struct platform_device *)' from incompatible pointer type 'void (*)(struct platform_device *)' [-Wincompatible-pointer-types]
    1630 |         .remove = qcom_spi_remove,
         |                   ^~~~~~~~~~~~~~~
   drivers/spi/spi-qpic-snand.c:1630:19: note: (near initialization for 'qcom_spi_driver.remove')


vim +/strength +248 drivers/spi/spi-qpic-snand.c

   240	
   241	static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
   242	{
   243		struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
   244		struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
   245		struct nand_ecc_props *reqs = &nand->ecc.requirements;
   246		struct nand_ecc_props *user = &nand->ecc.user_conf;
   247		struct mtd_info *mtd = nanddev_to_mtd(nand);
 > 248		int step_size = 0, strength = 0;
   249		int cwperpage, bad_block_byte;
   250		struct qpic_ecc *ecc_cfg;
   251	
   252		cwperpage = mtd->writesize / NANDC_STEP_SIZE;
   253		snandc->qspi->num_cw = cwperpage;
   254	
   255		ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
   256		if (!ecc_cfg)
   257			return -ENOMEM;
   258		snandc->qspi->oob_buf = kzalloc(mtd->writesize + mtd->oobsize,
   259						GFP_KERNEL);
   260		if (!snandc->qspi->oob_buf)
   261			return -ENOMEM;
   262	
   263		memset(snandc->qspi->oob_buf, 0xff, mtd->writesize + mtd->oobsize);
   264	
   265		nand->ecc.ctx.priv = ecc_cfg;
   266		snandc->qspi->mtd = mtd;
   267	
   268		if (user->step_size && user->strength) {
   269			step_size = user->step_size;
   270			strength = user->strength;
   271		} else if (reqs->step_size && reqs->strength) {
   272			step_size = reqs->step_size;
   273			strength = reqs->strength;
   274		}
   275	
   276		ecc_cfg->ecc_bytes_hw = 7;
   277		ecc_cfg->spare_bytes = 4;
   278		ecc_cfg->bbm_size = 1;
   279		ecc_cfg->bch_enabled = true;
   280		ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
   281	
   282		ecc_cfg->steps = 4;
   283		ecc_cfg->strength = 4;
   284		ecc_cfg->step_size = 512;
   285		ecc_cfg->cw_data = 516;
   286		ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
   287		bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
   288	
   289		mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
   290	
   291		ecc_cfg->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
   292				FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_data) |
   293				FIELD_PREP(DISABLE_STATUS_AFTER_WRITE, 1) |
   294				FIELD_PREP(NUM_ADDR_CYCLES_MASK, 3) |
   295				FIELD_PREP(ECC_PARITY_SIZE_BYTES_RS, ecc_cfg->ecc_bytes_hw) |
   296				FIELD_PREP(STATUS_BFR_READ, 0) |
   297				FIELD_PREP(SET_RD_MODE_AFTER_STATUS, 1) |
   298				FIELD_PREP(SPARE_SIZE_BYTES_MASK, ecc_cfg->spare_bytes);
   299	
   300		ecc_cfg->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 0) |
   301				FIELD_PREP(CS_ACTIVE_BSY, 0) |
   302				FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, bad_block_byte) |
   303				FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 0) |
   304				FIELD_PREP(WR_RD_BSY_GAP_MASK, 20) |
   305				FIELD_PREP(WIDE_FLASH, 0) |
   306				FIELD_PREP(ENABLE_BCH_ECC, ecc_cfg->bch_enabled);
   307	
   308		ecc_cfg->cfg0_raw = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
   309				    FIELD_PREP(NUM_ADDR_CYCLES_MASK, 3) |
   310				    FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_size) |
   311				    FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
   312	
   313		ecc_cfg->cfg1_raw = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 0) |
   314				    FIELD_PREP(CS_ACTIVE_BSY, 0) |
   315				    FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
   316				    FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
   317				    FIELD_PREP(WR_RD_BSY_GAP_MASK, 20) |
   318				    FIELD_PREP(WIDE_FLASH, 0) |
   319				    FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
   320	
   321		ecc_cfg->ecc_bch_cfg = FIELD_PREP(ECC_CFG_ECC_DISABLE, !ecc_cfg->bch_enabled) |
   322				       FIELD_PREP(ECC_SW_RESET, 0) |
   323				       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
   324				       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
   325				       FIELD_PREP(ECC_MODE_MASK, 0) |
   326				       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
   327	
   328		ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
   329		ecc_cfg->clrflashstatus = FS_READY_BSY_N;
   330		ecc_cfg->clrreadstatus = 0xc0;
   331	
   332		conf->step_size = ecc_cfg->step_size;
   333		conf->strength = ecc_cfg->strength;
   334	
   335		snandc->regs->erased_cw_detect_cfg_clr = cpu_to_le32(CLR_ERASED_PAGE_DET);
   336		snandc->regs->erased_cw_detect_cfg_set = cpu_to_le32(SET_ERASED_PAGE_DET);
   337	
   338		dev_dbg(snandc->dev, "ECC strength: %u bits per %u bytes\n",
   339			ecc_cfg->strength, ecc_cfg->step_size);
   340	
   341		return 0;
   342	}
   343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

