Return-Path: <linux-spi+bounces-3989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BF93B9A1
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 01:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E5C1F2213A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C114830D;
	Wed, 24 Jul 2024 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwKlCQVH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07396146D79;
	Wed, 24 Jul 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864750; cv=none; b=lAj4FsQzlXhvSGqLtbmKZT/FFS7KiFOLvio33ePrZuxz+HSaVv4xxWpRgbu9Bsz6+xzrt9ipKOtIeHIIvI5ev9qUiPJoytmbs88CdvkCWQZYPr0nsAtwi1v6yxFpvAdCbyVKzYyHb4frwweEHA3vLKbxKDw0gqjAr6oOAL8mmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864750; c=relaxed/simple;
	bh=uggjNB8xiPHrZhFwDJSSjFZt6W4b7QSRrczNrx0Ht4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAa1nF3yuFTLu1akNptKjldkoX8Brmj6gWjdto8z+ezM70ROdjMc8jKmf5lXDJQtvRIh3MFEudDXVLD//DDxFI7ijNxQaZZ/h1DBTaz+2qIUb6ssOuOfg0JTdKNvzpw0tTz7X5DVabfkg+GJvtJMLjIx8mgR0URihoPgC1pc9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwKlCQVH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864748; x=1753400748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uggjNB8xiPHrZhFwDJSSjFZt6W4b7QSRrczNrx0Ht4c=;
  b=BwKlCQVHeQasdb49RetgXgVvtvXjxyJyg1Rd3ecS58wPj8d4IAnKIG7b
   dF+ZySNw7kgNVQksj+USflrD5dWHGK17Is5pupe8MijwUdjcqeOUubBNB
   H6dhSEfu8JXHQI9MN/qDZkeg+sKEiSbqjwOWU5PMnQ2v4HJcCcs9yw/OA
   3ie3VejE8FzItyFCMlPV6UzFDHBmw0rAYfgnioeYKlCL2ffmY5k94EVJ8
   aPn+ORTIcWhxeYqivfy+Ddy/jCTOZkW3qQiG0CDheGNcvZLqbCzADmM7x
   8Dxy87xbfeyFMVsQzGoFTVm9D+FQX6cSDp03Piz1S7DM9hqpCy74FD18A
   A==;
X-CSE-ConnectionGUID: 86kOIDdRSueVAAx7PUNV9w==
X-CSE-MsgGUID: R8SypdVLSDmFLbhLY39PVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="42104371"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="42104371"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:45:47 -0700
X-CSE-ConnectionGUID: Z9HAK5EPTrWrFl5pzvOZbw==
X-CSE-MsgGUID: vG8qsWSlRKeL3nq3Np+hlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52654643"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Jul 2024 16:45:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWlfv-000nYW-1I;
	Wed, 24 Jul 2024 23:45:39 +0000
Date: Thu, 25 Jul 2024 07:45:28 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_mdalam@quicinc.com,
	quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH v7 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
Message-ID: <202407250710.knYmJebL-lkp@intel.com>
References: <20240724114225.2176448-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724114225.2176448-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on broonie-spi/for-next robh/for-next linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240724-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240724114225.2176448-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v7 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240725/202407250710.knYmJebL-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250710.knYmJebL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250710.knYmJebL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-qpic-snand.c: In function 'qcom_spi_init':
>> drivers/spi/spi-qpic-snand.c:174:25: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     174 |         snand_cfg_val = FIELD_PREP(CLK_CNTR_INIT_VAL_VEC_MASK, CLK_CNTR_INIT_VAL_VEC) |
         |                         ^~~~~~~~~~
   drivers/spi/spi-qpic-snand.c: In function 'qcom_spi_ecc_init_ctx_pipelined':
>> drivers/spi/spi-qpic-snand.c:247:42: warning: variable 'steps' set but not used [-Wunused-but-set-variable]
     247 |         int step_size = 0, strength = 0, steps;
         |                                          ^~~~~
   drivers/spi/spi-qpic-snand.c: In function 'qcom_spi_write_page':
   drivers/spi/spi-qpic-snand.c:1261:30: warning: variable 's_op' set but not used [-Wunused-but-set-variable]
    1261 |         struct qpic_snand_op s_op = {};
         |                              ^~~~
   drivers/spi/spi-qpic-snand.c: At top level:
   drivers/spi/spi-qpic-snand.c:1632:19: error: initialization of 'int (*)(struct platform_device *)' from incompatible pointer type 'void (*)(struct platform_device *)' [-Wincompatible-pointer-types]
    1632 |         .remove = qcom_spi_remove,
         |                   ^~~~~~~~~~~~~~~
   drivers/spi/spi-qpic-snand.c:1632:19: note: (near initialization for 'qcom_spi_driver.remove')


vim +/FIELD_PREP +174 drivers/spi/spi-qpic-snand.c

   168	
   169	static int qcom_spi_init(struct qcom_nand_controller *snandc)
   170	{
   171		u32 snand_cfg_val = 0x0;
   172		int ret;
   173	
 > 174		snand_cfg_val = FIELD_PREP(CLK_CNTR_INIT_VAL_VEC_MASK, CLK_CNTR_INIT_VAL_VEC) |
   175				FIELD_PREP(LOAD_CLK_CNTR_INIT_EN, 0) |
   176				FIELD_PREP(FEA_STATUS_DEV_ADDR_MASK, FEA_STATUS_DEV_ADDR) |
   177				FIELD_PREP(SPI_CFG, 0);
   178	
   179		snandc->regs->spi_cfg = snand_cfg_val;
   180		snandc->regs->num_addr_cycle = SPI_NUM_ADDR;
   181		snandc->regs->busy_wait_cnt = SPI_WAIT_CNT;
   182	
   183		qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
   184	
   185		snand_cfg_val &= ~LOAD_CLK_CNTR_INIT_EN;
   186		snandc->regs->spi_cfg = snand_cfg_val;
   187	
   188		qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
   189	
   190		qcom_write_reg_dma(snandc, &snandc->regs->num_addr_cycle, NAND_NUM_ADDR_CYCLES, 1, 0);
   191		qcom_write_reg_dma(snandc, &snandc->regs->busy_wait_cnt, NAND_BUSY_CHECK_WAIT_CNT, 1,
   192				   NAND_BAM_NEXT_SGL);
   193	
   194		ret = qcom_submit_descs(snandc);
   195		if (ret) {
   196			dev_err(snandc->dev, "failure in submitting spi init descriptor\n");
   197			return ret;
   198		}
   199	
   200		return ret;
   201	}
   202	
   203	static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
   204					  struct mtd_oob_region *oobregion)
   205	{
   206		struct nand_device *nand = mtd_to_nanddev(mtd);
   207		struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
   208		struct qpic_ecc *qecc = snandc->qspi->ecc;
   209	
   210		if (section > 1)
   211			return -ERANGE;
   212	
   213		oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
   214		oobregion->offset = mtd->oobsize - oobregion->length;
   215	
   216		return 0;
   217	}
   218	
   219	static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
   220					   struct mtd_oob_region *oobregion)
   221	{
   222		struct nand_device *nand = mtd_to_nanddev(mtd);
   223		struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
   224		struct qpic_ecc *qecc = snandc->qspi->ecc;
   225	
   226		if (section)
   227			return -ERANGE;
   228	
   229		oobregion->length = qecc->steps * 4;
   230		oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
   231	
   232		return 0;
   233	}
   234	
   235	static const struct mtd_ooblayout_ops qcom_spi_ooblayout = {
   236		.ecc = qcom_spi_ooblayout_ecc,
   237		.free = qcom_spi_ooblayout_free,
   238	};
   239	
   240	static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
   241	{
   242		struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
   243		struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
   244		struct nand_ecc_props *reqs = &nand->ecc.requirements;
   245		struct nand_ecc_props *user = &nand->ecc.user_conf;
   246		struct mtd_info *mtd = nanddev_to_mtd(nand);
 > 247		int step_size = 0, strength = 0, steps;
   248		int cwperpage, bad_block_byte;
   249		struct qpic_ecc *ecc_cfg;
   250	
   251		cwperpage = mtd->writesize / NANDC_STEP_SIZE;
   252		snandc->qspi->num_cw = cwperpage;
   253	
   254		ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
   255		if (!ecc_cfg)
   256			return -ENOMEM;
   257		snandc->qspi->oob_buf = kzalloc(mtd->writesize + mtd->oobsize,
   258						GFP_KERNEL);
   259		if (!snandc->qspi->oob_buf)
   260			return -ENOMEM;
   261	
   262		memset(snandc->qspi->oob_buf, 0xff, mtd->writesize + mtd->oobsize);
   263	
   264		nand->ecc.ctx.priv = ecc_cfg;
   265		snandc->qspi->mtd = mtd;
   266	
   267		if (user->step_size && user->strength) {
   268			step_size = user->step_size;
   269			strength = user->strength;
   270		} else if (reqs->step_size && reqs->strength) {
   271			step_size = reqs->step_size;
   272			strength = reqs->strength;
   273		}
   274	
   275		if (step_size && strength)
   276			steps = mtd->writesize / step_size;
   277	
   278		ecc_cfg->ecc_bytes_hw = 7;
   279		ecc_cfg->spare_bytes = 4;
   280		ecc_cfg->bbm_size = 1;
   281		ecc_cfg->bch_enabled = true;
   282		ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
   283	
   284		ecc_cfg->steps = 4;
   285		ecc_cfg->strength = 4;
   286		ecc_cfg->step_size = 512;
   287		ecc_cfg->cw_data = 516;
   288		ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
   289		bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
   290	
   291		mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
   292	
   293		ecc_cfg->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
   294				FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_data) |
   295				FIELD_PREP(DISABLE_STATUS_AFTER_WRITE, 1) |
   296				FIELD_PREP(NUM_ADDR_CYCLES_MASK, 3) |
   297				FIELD_PREP(ECC_PARITY_SIZE_BYTES_RS, ecc_cfg->ecc_bytes_hw) |
   298				FIELD_PREP(STATUS_BFR_READ, 0) |
   299				FIELD_PREP(SET_RD_MODE_AFTER_STATUS, 1) |
   300				FIELD_PREP(SPARE_SIZE_BYTES_MASK, ecc_cfg->spare_bytes);
   301	
   302		ecc_cfg->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 0) |
   303				FIELD_PREP(CS_ACTIVE_BSY, 0) |
   304				FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, bad_block_byte) |
   305				FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 0) |
   306				FIELD_PREP(WR_RD_BSY_GAP_MASK, 20) |
   307				FIELD_PREP(WIDE_FLASH, 0) |
   308				FIELD_PREP(ENABLE_BCH_ECC, ecc_cfg->bch_enabled);
   309	
   310		ecc_cfg->cfg0_raw = FIELD_PREP(CW_PER_PAGE_MASK, (cwperpage - 1)) |
   311				    FIELD_PREP(NUM_ADDR_CYCLES_MASK, 3) |
   312				    FIELD_PREP(UD_SIZE_BYTES_MASK, ecc_cfg->cw_size) |
   313				    FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
   314	
   315		ecc_cfg->cfg1_raw = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 0) |
   316				    FIELD_PREP(CS_ACTIVE_BSY, 0) |
   317				    FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
   318				    FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
   319				    FIELD_PREP(WR_RD_BSY_GAP_MASK, 20) |
   320				    FIELD_PREP(WIDE_FLASH, 0) |
   321				    FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
   322	
   323		ecc_cfg->ecc_bch_cfg = FIELD_PREP(ECC_CFG_ECC_DISABLE, !ecc_cfg->bch_enabled) |
   324				       FIELD_PREP(ECC_SW_RESET, 0) |
   325				       FIELD_PREP(ECC_NUM_DATA_BYTES_MASK, ecc_cfg->cw_data) |
   326				       FIELD_PREP(ECC_FORCE_CLK_OPEN, 1) |
   327				       FIELD_PREP(ECC_MODE_MASK, 0) |
   328				       FIELD_PREP(ECC_PARITY_SIZE_BYTES_BCH_MASK, ecc_cfg->ecc_bytes_hw);
   329	
   330		ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
   331		ecc_cfg->clrflashstatus = FS_READY_BSY_N;
   332		ecc_cfg->clrreadstatus = 0xc0;
   333	
   334		conf->step_size = ecc_cfg->step_size;
   335		conf->strength = ecc_cfg->strength;
   336	
   337		snandc->regs->erased_cw_detect_cfg_clr = cpu_to_le32(CLR_ERASED_PAGE_DET);
   338		snandc->regs->erased_cw_detect_cfg_set = cpu_to_le32(SET_ERASED_PAGE_DET);
   339	
   340		dev_dbg(snandc->dev, "ECC strength: %u bits per %u bytes\n",
   341			ecc_cfg->strength, ecc_cfg->step_size);
   342	
   343		return 0;
   344	}
   345	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

