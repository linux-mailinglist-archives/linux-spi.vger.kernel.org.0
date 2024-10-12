Return-Path: <linux-spi+bounces-5214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5299B688
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 20:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1661F22242
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ABA12C54D;
	Sat, 12 Oct 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gw6ghBew"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E5770F1;
	Sat, 12 Oct 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728756022; cv=none; b=aOFa7gxF4h8PXb8pLYDHg7BX+tMvfD/BcXwjzYV8b5zt05HoB8UOZJvYXrJRMsgLhxYQ8wqleQQ17QAccZy5mg4ibfLcUsFQlQffpgdtxw3JLAooDd2IRFcpC83F5nIhub/SA4CDFdm/ykLyOSyuEB/aVQhZ36D87NHzy7kM9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728756022; c=relaxed/simple;
	bh=QZbghKMG5mddRcnYL0oUUjDtFdAbMtMB+WmbxAp1KO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuT7QqkixvuM8ahuf8wleIbfFhnp0ivGLLcmyTg9Fh3+Fo1NO9kktuY/9Wzwj8YUqMXSzS+fk+Rs8gFMGTXg1HfmjwUFEOW8HAiAYsL/cysVn/EkiSgljmO+ZQfr7B2rk2Ql/gatdXX5IFPoi2AxE3SkJAWOgSRpjFycvZ9yxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gw6ghBew; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728756020; x=1760292020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QZbghKMG5mddRcnYL0oUUjDtFdAbMtMB+WmbxAp1KO4=;
  b=gw6ghBewjHzh+ut3aEyT0SIi1sunUOzQYFcWLfg0f6bVjzol78/nh8h5
   2RkGlIBHCucBn5jiOcKGdoa7IQcQKF/7HfFHg80H/Ic6Wn+Pfp/P8+oKZ
   TlTQIjohZaVwngcIePcwDhkMC4rExF7BT+rNBEWwkauULN2HwJ8elY+yo
   E6zjwkIPd+XApb3eFdV4qv8g8ZTCxquaEME4f/wbflKR9vytShXg6XrLe
   YnhkKOn7b8FwCOizS2+4e5ZcuSo1IQb/+igzsxYwae0O7j66xYRaj6oao
   P21mxCPxixaG+AZ7J/yG5/sde499/2ey65mSnw606T9mG/jajsq97x8+9
   g==;
X-CSE-ConnectionGUID: fv5Cc8DEQkaIQzB5+tM6lA==
X-CSE-MsgGUID: +trNSOIsR2m9o1MmF2ZKfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28315437"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28315437"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 11:00:18 -0700
X-CSE-ConnectionGUID: 2TXqMIK5QayDULncJRh8vA==
X-CSE-MsgGUID: 9KGUO9srSdGv0XhB8YEqRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="81974009"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Oct 2024 10:58:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szgNV-000DaJ-2b;
	Sat, 12 Oct 2024 17:58:09 +0000
Date: Sun, 13 Oct 2024 01:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, arnd@arndb.de, esben@geanix.com,
	nikita.shubin@maquefel.me, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH v11 4/8] mtd: nand: Add qpic_common API file
Message-ID: <202410130129.M8J7VJoG-lkp@intel.com>
References: <20241010070510.1504250-5-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010070510.1504250-5-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on broonie-spi/for-next robh/for-next linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20241010-161236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20241010070510.1504250-5-quic_mdalam%40quicinc.com
patch subject: [PATCH v11 4/8] mtd: nand: Add qpic_common API file
config: csky-randconfig-r123-20241012 (https://download.01.org/0day-ci/archive/20241013/202410130129.M8J7VJoG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241013/202410130129.M8J7VJoG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410130129.M8J7VJoG-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_remove':
>> drivers/mtd/nand/raw/qcom_nandc.c:2347:(.text+0x3ce): undefined reference to `nand_cleanup'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `config_nand_page_write':
   drivers/mtd/nand/raw/qcom_nandc.c:377:(.text+0x538): undefined reference to `nand_cleanup'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_parse_instructions':
>> drivers/mtd/nand/raw/qcom_nandc.c:1626:(.text+0x756): undefined reference to `nand_subop_get_addr_start_off'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1627:(.text+0x766): undefined reference to `nand_subop_get_num_addr_cyc'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_misc_cmd_type_exec':
   drivers/mtd/nand/raw/qcom_nandc.c:1823:(.text+0x8a8): undefined reference to `nand_subop_get_addr_start_off'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1823:(.text+0x8ac): undefined reference to `nand_subop_get_num_addr_cyc'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_param_page_type_exec':
>> drivers/mtd/nand/raw/qcom_nandc.c:1917:(.text+0xa3e): undefined reference to `nand_subop_get_data_len'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1951:(.text+0xb64): undefined reference to `nand_subop_get_data_len'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_read_status_exec':
   drivers/mtd/nand/raw/qcom_nandc.c:1747:(.text+0xcc6): undefined reference to `nand_subop_get_data_len'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1752:(.text+0xd14): undefined reference to `nand_subop_get_data_len'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_read_id_type_exec':
   drivers/mtd/nand/raw/qcom_nandc.c:1794:(.text+0xdee): undefined reference to `nand_subop_get_data_len'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nand_attach_chip':
>> drivers/mtd/nand/raw/qcom_nandc.c:1393:(.text+0xe4c): undefined reference to `nand_ecc_choose_conf'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1403:(.text+0xed8): undefined reference to `nand_subop_get_data_len'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1403:(.text+0xee8): undefined reference to `nand_ecc_choose_conf'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_write_page_raw':
>> drivers/mtd/nand/raw/qcom_nandc.c:1054:(.text+0x10cc): undefined reference to `nand_prog_page_begin_op'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1109:(.text+0x11fe): undefined reference to `nand_prog_page_end_op'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1110:(.text+0x1218): undefined reference to `nand_prog_page_begin_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1110:(.text+0x1238): undefined reference to `nand_prog_page_end_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_read_cw_raw':
>> drivers/mtd/nand/raw/qcom_nandc.c:482:(.text+0x1266): undefined reference to `nand_read_page_op'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:542:(.text+0x1468): undefined reference to `nand_read_page_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `check_for_erased_page':
>> drivers/mtd/nand/raw/qcom_nandc.c:600:(.text+0x15bc): undefined reference to `nand_check_erased_ecc_chunk'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:613:(.text+0x1618): undefined reference to `nand_check_erased_ecc_chunk'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `nand_scan':
>> include/linux/mtd/rawnand.h:1592:(.text+0x1af6): undefined reference to `nand_scan_with_ids'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nand_host_parse_boot_partitions':
>> drivers/mtd/nand/raw/qcom_nandc.c:2091:(.text+0x1bb0): undefined reference to `nand_scan_with_ids'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nand_host_init_and_register':
   drivers/mtd/nand/raw/qcom_nandc.c:2195:(.text+0x1c88): undefined reference to `nand_cleanup'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_check_op':
   drivers/mtd/nand/raw/qcom_nandc.c:2008:(.text+0x1d4c): undefined reference to `nand_cleanup'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nand_exec_op':
>> drivers/mtd/nand/raw/qcom_nandc.c:2017:(.text+0x1d60): undefined reference to `nand_op_parser_exec_op'
>> csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:2018:(.text+0x1d94): undefined reference to `nand_op_parser_exec_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_read_page':
   drivers/mtd/nand/raw/qcom_nandc.c:905:(.text+0x20fe): undefined reference to `nand_read_page_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:919:(.text+0x2198): undefined reference to `nand_read_page_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_block_markbad':
>> drivers/mtd/nand/raw/qcom_nandc.c:1234:(.text+0x228c): undefined reference to `nand_prog_page_end_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_write_oob':
   drivers/mtd/nand/raw/qcom_nandc.c:1158:(.text+0x239a): undefined reference to `nand_prog_page_end_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1159:(.text+0x23cc): undefined reference to `nand_prog_page_end_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_write_page':
   drivers/mtd/nand/raw/qcom_nandc.c:980:(.text+0x2410): undefined reference to `nand_prog_page_begin_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1036:(.text+0x2524): undefined reference to `nand_prog_page_end_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.o: in function `qcom_nandc_block_bad':
   drivers/mtd/nand/raw/qcom_nandc.c:1167:(.text+0x2648): undefined reference to `nand_prog_page_begin_op'
   csky-linux-ld: drivers/mtd/nand/raw/qcom_nandc.c:1167:(.text+0x2668): undefined reference to `nand_prog_page_end_op'


vim +2347 drivers/mtd/nand/raw/qcom_nandc.c

c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2334  
ec185b18c22323 drivers/mtd/nand/raw/qcom_nandc.c Uwe Kleine-König 2023-04-11  2335  static void qcom_nandc_remove(struct platform_device *pdev)
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2336  {
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2337  	struct qcom_nand_controller *nandc = platform_get_drvdata(pdev);
7330fc505af4af drivers/mtd/nand/raw/qcom_nandc.c Arnd Bergmann    2018-07-17  2338  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2339  	struct qcom_nand_host *host;
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2340  	struct nand_chip *chip;
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2341  	int ret;
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2342  
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2343  	list_for_each_entry(host, &nandc->host_list, node) {
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2344  		chip = &host->chip;
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2345  		ret = mtd_device_unregister(nand_to_mtd(chip));
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2346  		WARN_ON(ret);
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19 @2347  		nand_cleanup(chip);
0a2bc9919cf74e drivers/mtd/nand/raw/qcom_nandc.c Miquel Raynal    2020-05-19  2348  	}
7330fc505af4af drivers/mtd/nand/raw/qcom_nandc.c Arnd Bergmann    2018-07-17  2349  
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2350  	qcom_nandc_unalloc(nandc);
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2351  
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2352  	clk_disable_unprepare(nandc->aon_clk);
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2353  	clk_disable_unprepare(nandc->core_clk);
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2354  
7330fc505af4af drivers/mtd/nand/raw/qcom_nandc.c Arnd Bergmann    2018-07-17  2355  	dma_unmap_resource(&pdev->dev, nandc->base_dma, resource_size(res),
7330fc505af4af drivers/mtd/nand/raw/qcom_nandc.c Arnd Bergmann    2018-07-17  2356  			   DMA_BIDIRECTIONAL, 0);
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2357  }
c76b78d8ec05a2 drivers/mtd/nand/qcom_nandc.c     Archit Taneja    2016-02-03  2358  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

