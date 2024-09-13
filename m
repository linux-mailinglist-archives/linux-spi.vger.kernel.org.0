Return-Path: <linux-spi+bounces-4806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD93977C1F
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D34B22A59
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31991D6DD2;
	Fri, 13 Sep 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfawKEcS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0F1D5CC1;
	Fri, 13 Sep 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219433; cv=none; b=JpX/taST2wWyxh7GaKh1SqQTrZ08qu0OhlWLH0VCrX3VlMD+HitECptLb42BD2tjdP5ChluNRyGinMk3YUtz+K9NAfNDIg+xoWYa3as310bAjdxPAT6uUB4R/rDOwitshwkCVohi6JZKtaoZhmQ3MOJH+9jlpkKYSX2TvDOURco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219433; c=relaxed/simple;
	bh=BB2Qli8K7W5hKcfadq8joRx/Kr5Qk4bl0eg10xz/VGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNz7snJgnaeWZV9HviFXrVD1WRlxG3JF1xFV9/Q5Mv3jfFja94Zfbm2/s0uL15M0HL1csW4rci9OljvoGifg1OjECCPKVOCdHxjzIrxG6MdkNGeLGEMnpuYnyzeEVo3ZqeVqq6CalrIkIjD79DZqCZXIXDbuZDv4AS2h/8qFRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfawKEcS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726219432; x=1757755432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BB2Qli8K7W5hKcfadq8joRx/Kr5Qk4bl0eg10xz/VGQ=;
  b=SfawKEcSaBPXScZHzk48VLnhiiHXcTZvq5j+Tozl0UyNv5UMrQ9MzJ7a
   zZMBsY076l5JeJccqA2VuqUx2gIhWBgjUhqcNwMoeB3fthmGN+YHjb45U
   EKYoBYk1ms1yo5YdmPNE7c4K8nXHgQJT+nbKbF0jsOtHSVWoon79t3lHH
   EvWnajGbP5baBedU3bI184CGaGuUskMOWcbAU02guC6s+9c43oaFAvTQz
   Q9+pKvAFVaEhKebk0jYx77FrRiINGKlflD+F+9EQXW370kRs4DssAZADr
   RkR8w30ptCnqTDEeiqwzAHeOmroPyAeaZcyw50CPkLTepz3z6rZEPky2B
   A==;
X-CSE-ConnectionGUID: hxCq3m8BQCWisDD/gFLNtg==
X-CSE-MsgGUID: dF0J71WRRMitXTZWruAwKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="13509281"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="13509281"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:23:50 -0700
X-CSE-ConnectionGUID: DxnFPH8UQWS397PPeOpDAg==
X-CSE-MsgGUID: /Y7yQKqjRv2MDyRvxMazew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68498886"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Sep 2024 02:23:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp2Wk-0006IR-2o;
	Fri, 13 Sep 2024 09:23:42 +0000
Date: Fri, 13 Sep 2024 17:22:51 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_mdalam@quicinc.com, quic_varada@quicinc.com,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v9 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash
 Interface
Message-ID: <202409131702.oP75WEmL-lkp@intel.com>
References: <20240912061503.3468147-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912061503.3468147-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.11-rc7 next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240912-141925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240912061503.3468147-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v9 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240913/202409131702.oP75WEmL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131702.oP75WEmL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131702.oP75WEmL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/spi/spi-qpic-snand.c:14:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/spi/spi-qpic-snand.c:14:
   In file included from include/linux/dmaengine.h:12:
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
   In file included from drivers/spi/spi-qpic-snand.c:14:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/spi/spi-qpic-snand.c:14:
   In file included from include/linux/dmaengine.h:12:
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
>> drivers/spi/spi-qpic-snand.c:1018:10: warning: equality comparison with extraneous parentheses [-Wparentheses-equality]
    1018 |                 if ((i == (num_cw - 1))) {
         |                      ~~^~~~~~~~~~~~~~~
   drivers/spi/spi-qpic-snand.c:1018:10: note: remove extraneous parentheses around the comparison to silence this warning
    1018 |                 if ((i == (num_cw - 1))) {
         |                     ~  ^              ~
   drivers/spi/spi-qpic-snand.c:1018:10: note: use '=' to turn this equality comparison into an assignment
    1018 |                 if ((i == (num_cw - 1))) {
         |                        ^~
         |                        =
   8 warnings generated.


vim +1018 drivers/spi/spi-qpic-snand.c

   973	
   974	static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
   975					const struct spi_mem_op *op)
   976	{
   977		struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
   978		struct mtd_info *mtd = snandc->qspi->mtd;
   979		u8 *data_buf = NULL, *oob_buf = NULL;
   980		int i, ret;
   981		int num_cw = snandc->qspi->num_cw;
   982		u32 cfg0, cfg1, ecc_bch_cfg;
   983	
   984		cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
   985				(num_cw - 1) << CW_PER_PAGE;
   986		cfg1 = ecc_cfg->cfg1_raw;
   987		ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
   988	
   989		data_buf = snandc->qspi->data_buf;
   990	
   991		oob_buf = snandc->qspi->oob_buf;
   992		memset(oob_buf, 0xff, OOB_BUF_SIZE);
   993	
   994		snandc->buf_count = 0;
   995		snandc->buf_start = 0;
   996		qcom_clear_read_regs(snandc);
   997		qcom_clear_bam_transaction(snandc);
   998	
   999		snandc->regs->addr0 = snandc->qspi->addr1;
  1000		snandc->regs->addr1 = snandc->qspi->addr2;
  1001		snandc->regs->cmd = snandc->qspi->cmd;
  1002		snandc->regs->cfg0 = cpu_to_le32(cfg0);
  1003		snandc->regs->cfg1 = cpu_to_le32(cfg1);
  1004		snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
  1005		snandc->regs->clrflashstatus = cpu_to_le32(ecc_cfg->clrflashstatus);
  1006		snandc->regs->clrreadstatus = cpu_to_le32(ecc_cfg->clrreadstatus);
  1007		snandc->regs->exec = cpu_to_le32(1);
  1008	
  1009		qcom_spi_config_page_write(snandc);
  1010	
  1011		for (i = 0; i < num_cw; i++) {
  1012			int data_size1, data_size2, oob_size1, oob_size2;
  1013			int reg_off = FLASH_BUF_ACC;
  1014	
  1015			data_size1 = mtd->writesize - ecc_cfg->cw_size * (num_cw - 1);
  1016			oob_size1 = ecc_cfg->bbm_size;
  1017	
> 1018			if ((i == (num_cw - 1))) {
  1019				data_size2 = NANDC_STEP_SIZE - data_size1 -
  1020					     ((num_cw - 1) << 2);
  1021				oob_size2 = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
  1022					    ecc_cfg->spare_bytes;
  1023			} else {
  1024				data_size2 = ecc_cfg->cw_data - data_size1;
  1025				oob_size2 = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
  1026			}
  1027	
  1028			qcom_write_data_dma(snandc, reg_off, data_buf, data_size1,
  1029					    NAND_BAM_NO_EOT);
  1030			reg_off += data_size1;
  1031			data_buf += data_size1;
  1032	
  1033			qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size1,
  1034					    NAND_BAM_NO_EOT);
  1035			oob_buf += oob_size1;
  1036			reg_off += oob_size1;
  1037	
  1038			qcom_write_data_dma(snandc, reg_off, data_buf, data_size2,
  1039					    NAND_BAM_NO_EOT);
  1040			reg_off += data_size2;
  1041			data_buf += data_size2;
  1042	
  1043			qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size2, 0);
  1044			oob_buf += oob_size2;
  1045	
  1046			qcom_spi_config_cw_write(snandc);
  1047		}
  1048	
  1049		ret = qcom_submit_descs(snandc);
  1050		if (ret) {
  1051			dev_err(snandc->dev, "failure to write raw page\n");
  1052			return ret;
  1053		}
  1054	
  1055		return 0;
  1056	}
  1057	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

