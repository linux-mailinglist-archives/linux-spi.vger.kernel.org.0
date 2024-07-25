Return-Path: <linux-spi+bounces-4006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9B93C8D9
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 21:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12B21C21985
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FF558BB;
	Thu, 25 Jul 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvEmZo/0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E04446D2;
	Thu, 25 Jul 2024 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936489; cv=none; b=jb07hjYBLqitliHa9CdGkY+Rm6Hl20gyNcYRqSbXW80DcM3nLFPu7/qJOSI0ClkU1pBP46YKkjN/oS8tRgGWDZDKTQLdKhzz7nOeOj2SvNRmTfAorhAOEoa6W0DbZTzVZK+uvhg3JyLaQf85CgTTvJt+c+h7T2Ig+dW4LTRzr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936489; c=relaxed/simple;
	bh=KFT8A9cyJFd3Llr7DWfNsA64oWybLNnXui5gHgwBViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu/sSKLok1TjlmTK+rqJXL5n6H1Tk3P2qgzStC/IduABabpsJN7OjXK36dc+1yoFKlEuANNwgGF5Man9lCbY50eaenCXl8/ISHQmkthEBuWZiR49Nk0mdAsHL4al1pK4KU5XsmpdgymBBNZp175YXJC+t3gXyG2HeWhG+Jy8rBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvEmZo/0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721936486; x=1753472486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KFT8A9cyJFd3Llr7DWfNsA64oWybLNnXui5gHgwBViU=;
  b=AvEmZo/0EIqMn8qP7PTvj+RvjDuB4r8qNlFuy/LDgdvs8fh8NOU7VhSS
   amJet7Z0vGs37/cibiveybFCdxUeEy2MbjF2Wkn5a2/coMrin8EWGQVso
   h9sBP4NJRb1bGcu/fN7ixvrbeZWt+vHhxuL8cTGeeGSvNmgdQ8Kr1o+YE
   Fuz0dc6Ob731udGNhnGEBYcpiuqM5FDtXNGyUyy8rhgF/VMNW7yqhARIQ
   ddbsODhIyVOmX17yVdISPOc1g9IFdq0Oc4f0GpktaeKv2RutNcen4PIqS
   MEuUyD+yZDR5HoivriYfHs+WxREDaiEsAb9afIH5i0VGwtrpu9qmk+ZXr
   g==;
X-CSE-ConnectionGUID: w7ZeHAGyTPqgOzb18DXD3g==
X-CSE-MsgGUID: F2CVd00JSHSAnCjL7Fz/YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23559772"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="23559772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 12:41:26 -0700
X-CSE-ConnectionGUID: Kq2VXbNZSDGKPfSjRs3pqA==
X-CSE-MsgGUID: 9L5R5dL/TqK8cuM2he9j9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57849925"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Jul 2024 12:41:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX4L0-000oP6-1M;
	Thu, 25 Jul 2024 19:41:18 +0000
Date: Fri, 26 Jul 2024 03:40:50 +0800
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
Subject: Re: [PATCH v7 4/8] mtd: nand: Add qpic_common API file
Message-ID: <202407260302.arL8EqNQ-lkp@intel.com>
References: <20240724114225.2176448-5-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724114225.2176448-5-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240724-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240724114225.2176448-5-quic_mdalam%40quicinc.com
patch subject: [PATCH v7 4/8] mtd: nand: Add qpic_common API file
config: microblaze-randconfig-r133-20240725 (https://download.01.org/0day-ci/archive/20240726/202407260302.arL8EqNQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240726/202407260302.arL8EqNQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260302.arL8EqNQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/qcom_nandc.c:206:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last3 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:206:50: sparse:     expected restricted __le32 [usertype] read_location_last3
   drivers/mtd/nand/raw/qcom_nandc.c:206:50: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:239:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:239:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:239:28: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:240:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:240:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:240:28: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:280:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [assigned] [usertype] cmd @@
   drivers/mtd/nand/raw/qcom_nandc.c:280:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:280:26: sparse:     got unsigned int [assigned] [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:281:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int [assigned] [usertype] cfg0 @@
   drivers/mtd/nand/raw/qcom_nandc.c:281:27: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:281:27: sparse:     got unsigned int [assigned] [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:282:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned int [assigned] [usertype] cfg1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:282:27: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:282:27: sparse:     got unsigned int [assigned] [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:283:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_bch_cfg @@     got unsigned int [assigned] [usertype] ecc_bch_cfg @@
   drivers/mtd/nand/raw/qcom_nandc.c:283:34: sparse:     expected restricted __le32 [usertype] ecc_bch_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:283:34: sparse:     got unsigned int [assigned] [usertype] ecc_bch_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:286:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got unsigned int [usertype] ecc_buf_cfg @@
   drivers/mtd/nand/raw/qcom_nandc.c:286:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:286:42: sparse:     got unsigned int [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:288:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrflashstatus @@     got unsigned int [usertype] clrflashstatus @@
   drivers/mtd/nand/raw/qcom_nandc.c:288:37: sparse:     expected restricted __le32 [usertype] clrflashstatus
   drivers/mtd/nand/raw/qcom_nandc.c:288:37: sparse:     got unsigned int [usertype] clrflashstatus
   drivers/mtd/nand/raw/qcom_nandc.c:289:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrreadstatus @@     got unsigned int [usertype] clrreadstatus @@
   drivers/mtd/nand/raw/qcom_nandc.c:289:36: sparse:     expected restricted __le32 [usertype] clrreadstatus
   drivers/mtd/nand/raw/qcom_nandc.c:289:36: sparse:     got unsigned int [usertype] clrreadstatus
   drivers/mtd/nand/raw/qcom_nandc.c:290:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:290:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:290:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1709:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1709:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1709:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1710:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1710:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1710:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1766:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1766:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1766:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse:     got unsigned int [addressable] [usertype] addr1_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1768:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1768:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:1768:28: sparse:     got unsigned int [addressable] [usertype] addr2_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1769:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] chip_sel @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1769:31: sparse:     expected restricted __le32 [usertype] chip_sel
   drivers/mtd/nand/raw/qcom_nandc.c:1769:31: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1770:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1770:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1770:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [assigned] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr1_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1811:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [assigned] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1811:36: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:1811:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr2_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned int [usertype] cfg1_raw @@
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:1813:35: sparse:     got unsigned int [usertype] cfg1_raw
   drivers/mtd/nand/raw/qcom_nandc.c:1826:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1826:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1826:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1827:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1827:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1827:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1873:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1873:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1873:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1877:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1877:27: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1877:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1882:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1882:27: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:1882:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1891:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1891:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:1891:42: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1895:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] vld @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1895:34: sparse:     expected restricted __le32 [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c:1895:34: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1896:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd1 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1896:35: sparse:     expected restricted __le32 [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1896:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1900:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1900:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1900:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1903:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_cmd1 @@     got unsigned int [usertype] cmd1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:1903:40: sparse:     expected restricted __le32 [usertype] orig_cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1903:40: sparse:     got unsigned int [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1904:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_vld @@     got unsigned int [usertype] vld @@
   drivers/mtd/nand/raw/qcom_nandc.c:1904:39: sparse:     expected restricted __le32 [usertype] orig_vld
   drivers/mtd/nand/raw/qcom_nandc.c:1904:39: sparse:     got unsigned int [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c: note: in included file:
>> include/linux/mtd/nand-qpic-common.h:446:34: sparse: sparse: marked inline, but without a definition
>> include/linux/mtd/nand-qpic-common.h:446:34: sparse: sparse: marked inline, but without a definition
>> include/linux/mtd/nand-qpic-common.h:446:34: sparse: sparse: marked inline, but without a definition
>> include/linux/mtd/nand-qpic-common.h:446:34: sparse: sparse: marked inline, but without a definition
>> include/linux/mtd/nand-qpic-common.h:446:34: sparse: sparse: marked inline, but without a definition

vim +446 include/linux/mtd/nand-qpic-common.h

   441	
   442	void qcom_free_bam_transaction(struct qcom_nand_controller *nandc);
   443	struct bam_transaction *qcom_alloc_bam_transaction(struct qcom_nand_controller *nandc);
   444	void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc);
   445	void qcom_qpic_bam_dma_done(void *data);
 > 446	inline void qcom_nandc_dev_to_mem(struct qcom_nand_controller *nandc, bool is_cpu);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

