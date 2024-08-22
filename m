Return-Path: <linux-spi+bounces-4263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ADC95B046
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543A31F265D5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED217B50E;
	Thu, 22 Aug 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL/C0LhF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14917DFF2;
	Thu, 22 Aug 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315165; cv=none; b=bzRL3DSA2oAvyhoYHTnfUW2qc1gfianJCg5f7Cqmo+nyTq+ojrJEHDqo0/r2gl/IEbaNqt8LRBL26ni3BoGPA8o9S5KgQB2yyTIVRDhtzNPZgRhijH+JY+xRAM+857rxyCQ9oZxzVi/dxKejrCknVodPWt9id17YW+B6B7+4fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315165; c=relaxed/simple;
	bh=dB2KYzLu/Tv5zD99j9Lz99BYHd0f0NKIEZ0d6sfyKKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r42I67XNagix/qthRynwK37/uq4uWiHbV2jrPR8zB0Ma4UFhu7WdL/69GKMyuPBMfOup1wZRpwcE038OlFAsXr4yV4lS21r3LAGQKRfPrckLKvrMAOfxbxm5NLbfdPiwLMFU7b5Bhj8POuH/tbEhVqiqVgmSUTWh2Vhsv9mIRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL/C0LhF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724315163; x=1755851163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dB2KYzLu/Tv5zD99j9Lz99BYHd0f0NKIEZ0d6sfyKKk=;
  b=EL/C0LhFFzTxDpVXJDcDuNIbvHogNppEjvx5Ryf7VFrBtrzFn2i2Tag5
   jXAjJ4ijUnIfbdgXNVP4T9MbUCHAwuzrPYCOkv3sugQ4SOmALqxYY8uRF
   hd2jzKEiTjFnhepjJtzZUFe+GB9ShurM6ettlP5UY/DqBz8J7N4o9i6p+
   fPWiy6reEHhuNGoH1+nHyJxbwSE8mi+ozbLI1oUmk5NnYBuHJRKl87Syn
   LuRdbOVLdqc3MfVwTrZ/cyAnIC8rscCpL7nP1aoyiqVFqAuFeAlrZVXRf
   8/7Tb4RbONUkEKWAUmgLziaiULxJiY7z/MZJlU6g1/80UFFHSO4kldcJC
   Q==;
X-CSE-ConnectionGUID: haY3+HVTR2Ojn07Bl4hwLg==
X-CSE-MsgGUID: +fEeyYAKR6C2o3NbgZ6F4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13148902"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="13148902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:26:02 -0700
X-CSE-ConnectionGUID: uYXY8uX2SiujYrUUtbnVlQ==
X-CSE-MsgGUID: lBnQwlbcQ2yPb6NGTjducQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66310543"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 01:25:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh38l-000CZn-1X;
	Thu, 22 Aug 2024 08:25:55 +0000
Date: Thu, 22 Aug 2024 16:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
Message-ID: <202408221634.2JY5J8DX-lkp@intel.com>
References: <20240820104239.1774600-6-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820104239.1774600-6-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240820-184732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240820104239.1774600-6-quic_mdalam%40quicinc.com
patch subject: [PATCH v8 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
config: s390-randconfig-r111-20240821 (https://download.01.org/0day-ci/archive/20240822/202408221634.2JY5J8DX-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240822/202408221634.2JY5J8DX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221634.2JY5J8DX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/qcom_nandc.c:168:55: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] val @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:168:55: sparse:     expected restricted __le32 [usertype] val
   drivers/mtd/nand/raw/qcom_nandc.c:168:55: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:198:55: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] val @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:198:55: sparse:     expected restricted __le32 [usertype] val
   drivers/mtd/nand/raw/qcom_nandc.c:198:55: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:241:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:241:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:241:28: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:242:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:242:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:242:28: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:261:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:261:29: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:261:29: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:263:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:263:29: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:263:29: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:265:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:265:21: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:265:21: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:269:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:269:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:269:22: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:269:22: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:275:29: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:275:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:275:22: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:275:22: sparse:     got unsigned int
>> drivers/mtd/nand/raw/qcom_nandc.c:279:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [assigned] [usertype] ecc_bch_cfg @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:279:29: sparse:     expected restricted __le32 [assigned] [usertype] ecc_bch_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:279:29: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:292:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:292:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:292:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:879:20: sparse: sparse: invalid assignment: &=
   drivers/mtd/nand/raw/qcom_nandc.c:879:20: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:879:20: sparse:    right side has type unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:880:20: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:880:20: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:880:20: sparse:    right side has type int
   drivers/mtd/nand/raw/qcom_nandc.c:883:27: sparse: sparse: invalid assignment: &=
   drivers/mtd/nand/raw/qcom_nandc.c:883:27: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:883:27: sparse:    right side has type unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:884:27: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:884:27: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:884:27: sparse:    right side has type int
   drivers/mtd/nand/raw/qcom_nandc.c:885:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:885:27: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:885:27: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:1490:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1490:20: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1490:20: sparse:     got unsigned long
>> drivers/mtd/nand/raw/qcom_nandc.c:1499:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1499:20: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:1499:20: sparse:     got unsigned long
>> drivers/mtd/nand/raw/qcom_nandc.c:1506:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0_raw @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1506:24: sparse:     expected restricted __le32 [usertype] cfg0_raw
   drivers/mtd/nand/raw/qcom_nandc.c:1506:24: sparse:     got unsigned long
>> drivers/mtd/nand/raw/qcom_nandc.c:1511:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1_raw @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1511:24: sparse:     expected restricted __le32 [usertype] cfg1_raw
   drivers/mtd/nand/raw/qcom_nandc.c:1511:24: sparse:     got unsigned long
>> drivers/mtd/nand/raw/qcom_nandc.c:1519:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_bch_cfg @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1519:27: sparse:     expected restricted __le32 [usertype] ecc_bch_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:1519:27: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1527:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1527:35: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:1527:35: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1529:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrflashstatus @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1529:30: sparse:     expected restricted __le32 [usertype] clrflashstatus
   drivers/mtd/nand/raw/qcom_nandc.c:1529:30: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1530:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrreadstatus @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1530:29: sparse:     expected restricted __le32 [usertype] clrreadstatus
   drivers/mtd/nand/raw/qcom_nandc.c:1530:29: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1613:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd_reg @@     got int [assigned] ret @@
   drivers/mtd/nand/raw/qcom_nandc.c:1613:39: sparse:     expected restricted __le32 [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1613:39: sparse:     got int [assigned] ret
   drivers/mtd/nand/raw/qcom_nandc.c:1623:49: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:1623:49: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:1623:49: sparse:    right side has type int
   drivers/mtd/nand/raw/qcom_nandc.c:1626:49: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:1626:49: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:1626:49: sparse:    right side has type unsigned char
   drivers/mtd/nand/raw/qcom_nandc.c:1711:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1711:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1711:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1770:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] chip_sel @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1770:31: sparse:     expected restricted __le32 [usertype] chip_sel
   drivers/mtd/nand/raw/qcom_nandc.c:1770:31: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1771:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1771:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1771:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1809:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:1810:30: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:1810:30: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:1810:30: sparse:    right side has type unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1813:41: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1816:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:1828:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1828:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1828:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1832:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/mtd/nand/raw/qcom_nandc.c:1866:22: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/qcom_nandc.c:1866:22: sparse:    left side has type restricted __le32
   drivers/mtd/nand/raw/qcom_nandc.c:1866:22: sparse:    right side has type unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1878:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1878:20: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1878:20: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1883:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1883:20: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:1883:20: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1892:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1892:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:1892:42: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1896:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] vld @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1896:34: sparse:     expected restricted __le32 [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c:1896:34: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1897:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd1 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1897:35: sparse:     expected restricted __le32 [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1897:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1901:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1901:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1901:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1904:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_cmd1 @@     got unsigned int [usertype] cmd1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:1904:40: sparse:     expected restricted __le32 [usertype] orig_cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1904:40: sparse:     got unsigned int [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1905:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_vld @@     got unsigned int [usertype] vld @@
   drivers/mtd/nand/raw/qcom_nandc.c:1905:39: sparse:     expected restricted __le32 [usertype] orig_vld
   drivers/mtd/nand/raw/qcom_nandc.c:1905:39: sparse:     got unsigned int [usertype] vld

vim +279 drivers/mtd/nand/raw/qcom_nandc.c

   244	
   245	/*
   246	 * update_rw_regs:	set up read/write register values, these will be
   247	 *			written to the NAND controller registers via DMA
   248	 *
   249	 * @num_cw:		number of steps for the read/write operation
   250	 * @read:		read or write operation
   251	 * @cw	:		which code word
   252	 */
   253	static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, int cw)
   254	{
   255		struct nand_chip *chip = &host->chip;
   256		__le32 cmd, cfg0, cfg1, ecc_bch_cfg;
   257		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   258	
   259		if (read) {
   260			if (host->use_ecc)
   261				cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
   262			else
   263				cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
   264		} else {
   265			cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
   266		}
   267	
   268		if (host->use_ecc) {
   269			cfg0 = (host->cfg0 & ~(7U << CW_PER_PAGE)) |
   270					(num_cw - 1) << CW_PER_PAGE;
   271	
   272			cfg1 = host->cfg1;
   273			ecc_bch_cfg = host->ecc_bch_cfg;
   274		} else {
   275			cfg0 = (host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
   276					(num_cw - 1) << CW_PER_PAGE;
   277	
   278			cfg1 = host->cfg1_raw;
 > 279			ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
   280		}
   281	
   282		nandc->regs->cmd = cmd;
   283		nandc->regs->cfg0 = cfg0;
   284		nandc->regs->cfg1 = cfg1;
   285		nandc->regs->ecc_bch_cfg = ecc_bch_cfg;
   286	
   287		if (!nandc->props->qpic_version2)
   288			nandc->regs->ecc_buf_cfg = host->ecc_buf_cfg;
   289	
   290		nandc->regs->clrflashstatus = host->clrflashstatus;
   291		nandc->regs->clrreadstatus = host->clrreadstatus;
   292		nandc->regs->exec = 1;
   293	
   294		if (read)
   295			nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
   296					   host->cw_data : host->cw_size, 1);
   297	}
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

