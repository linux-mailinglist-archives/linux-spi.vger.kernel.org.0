Return-Path: <linux-spi+bounces-4007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FB93C9F6
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1423E1C21FA2
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9B13D503;
	Thu, 25 Jul 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LplQ4HkG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5E58222;
	Thu, 25 Jul 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940991; cv=none; b=uSkqIh1ahM/+LxnPj1abgkA62dYfZBGmaNcmZ50CvFk9AqIMSrdENduOjguE6HTtEmuUD+XOVSlkH182YNiICLMDhIoGUZPsz75G3esQnGB7nindHqUBA6McFfpyRmftfWEYUgzH2xmu0+WfgilbtS17CdiBnDPfrOKv3wmJ6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940991; c=relaxed/simple;
	bh=Md8zYIkrMQp4ajNMUkVKmw71LgOlOxo3vyoJD4FQQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6M4lvuPZZTsT/MryuDgrUlTwc9D1FoiDihlRzFTYdtKKQMtoMFs5teOj6akFiueTcHyETCEjDh9jtEWlja6BkvbUwJe8N2QcC9B3syyVlRHbG4MU/Nj2oNMwZQ2N2gbpgAv1uviyTuJ0EwG0tbCyEeq1Pfc37DS86ykjWtOsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LplQ4HkG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721940988; x=1753476988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Md8zYIkrMQp4ajNMUkVKmw71LgOlOxo3vyoJD4FQQjw=;
  b=LplQ4HkGcMJuNxViNXC9LYGLcRIaxK9Cshz1JHaRDGUcZUM1nqKl+AXg
   6B0lXZGhBKuAAqei3IVBe2yeomC5jAc9grmhs69mSppnDx8G287DBplXq
   Yu1OGQ9Z3dJWEDlJadpJhjDiKoKGmaALipm/dUCGDQZK6b4MZPS9YNsHx
   EHBvLwhU4ymmMzdYp9iRXZ0BWSwv7rrEXtSipLZC+4/hyh8oJeh0mcRHu
   bFsw0tfk2nbRtW8tz5ekwM7pC715Wegf+BLDCzF8QlDJTH48mJAhWyu7v
   +KQMrG2Bfej+g2NJWfLZxJRIzOiiOVQAaJW39vDVvIz+h8ZgsYw7DFymW
   g==;
X-CSE-ConnectionGUID: jbJ3wWtwTe6KkfO+Pru22g==
X-CSE-MsgGUID: 73+80x6URdSzs7uqDtqgtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19587921"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19587921"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 13:56:28 -0700
X-CSE-ConnectionGUID: 9k9hBbk0R5isvuddizYT2A==
X-CSE-MsgGUID: 5r0SnpW5RR+xsmPCfC+miA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53820029"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Jul 2024 13:56:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX5Vb-000oRo-2O;
	Thu, 25 Jul 2024 20:56:19 +0000
Date: Fri, 26 Jul 2024 04:55:38 +0800
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
Subject: Re: [PATCH v7 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
Message-ID: <202407260410.p2IXTwQb-lkp@intel.com>
References: <20240724114225.2176448-6-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724114225.2176448-6-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240724-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240724114225.2176448-6-quic_mdalam%40quicinc.com
patch subject: [PATCH v7 5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
config: microblaze-randconfig-r133-20240725 (https://download.01.org/0day-ci/archive/20240726/202407260410.p2IXTwQb-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240726/202407260410.p2IXTwQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260410.p2IXTwQb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/qcom_nandc.c:171:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location0 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:171:45: sparse:     expected restricted __le32 [usertype] read_location0
   drivers/mtd/nand/raw/qcom_nandc.c:171:45: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:173:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location1 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:173:45: sparse:     expected restricted __le32 [usertype] read_location1
   drivers/mtd/nand/raw/qcom_nandc.c:173:45: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:175:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location2 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:175:45: sparse:     expected restricted __le32 [usertype] read_location2
   drivers/mtd/nand/raw/qcom_nandc.c:175:45: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:177:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location3 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:177:45: sparse:     expected restricted __le32 [usertype] read_location3
   drivers/mtd/nand/raw/qcom_nandc.c:177:45: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:200:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last0 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:200:50: sparse:     expected restricted __le32 [usertype] read_location_last0
   drivers/mtd/nand/raw/qcom_nandc.c:200:50: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:202:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last1 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:202:50: sparse:     expected restricted __le32 [usertype] read_location_last1
   drivers/mtd/nand/raw/qcom_nandc.c:202:50: sparse:     got int val
   drivers/mtd/nand/raw/qcom_nandc.c:204:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last2 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:204:50: sparse:     expected restricted __le32 [usertype] read_location_last2
   drivers/mtd/nand/raw/qcom_nandc.c:204:50: sparse:     got int val
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
   drivers/mtd/nand/raw/qcom_nandc.c:1708:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1708:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1708:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1709:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1709:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1709:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1765:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1765:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1765:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1766:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1766:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:1766:28: sparse:     got unsigned int [addressable] [usertype] addr1_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:1767:28: sparse:     got unsigned int [addressable] [usertype] addr2_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1768:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] chip_sel @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1768:31: sparse:     expected restricted __le32 [usertype] chip_sel
   drivers/mtd/nand/raw/qcom_nandc.c:1768:31: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1769:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1769:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1769:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1809:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [assigned] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1809:36: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:1809:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr1_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [assigned] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:1810:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr2_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1811:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1811:35: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:1811:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned int [usertype] cfg1_raw @@
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:1812:35: sparse:     got unsigned int [usertype] cfg1_raw
   drivers/mtd/nand/raw/qcom_nandc.c:1825:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1825:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1825:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:1826:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1826:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1826:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1872:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:1872:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:1872:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:1890:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1890:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:1890:42: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1894:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] vld @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:1894:34: sparse:     expected restricted __le32 [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c:1894:34: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:1895:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd1 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1895:35: sparse:     expected restricted __le32 [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1895:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:1899:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:1899:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:1899:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:1902:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_cmd1 @@     got unsigned int [usertype] cmd1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:1902:40: sparse:     expected restricted __le32 [usertype] orig_cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1902:40: sparse:     got unsigned int [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:1903:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_vld @@     got unsigned int [usertype] vld @@
   drivers/mtd/nand/raw/qcom_nandc.c:1903:39: sparse:     expected restricted __le32 [usertype] orig_vld
   drivers/mtd/nand/raw/qcom_nandc.c:1903:39: sparse:     got unsigned int [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c: note: in included file:
   include/linux/mtd/nand-qpic-common.h:453:34: sparse: sparse: marked inline, but without a definition
   include/linux/mtd/nand-qpic-common.h:453:34: sparse: sparse: marked inline, but without a definition
   include/linux/mtd/nand-qpic-common.h:453:34: sparse: sparse: marked inline, but without a definition
   include/linux/mtd/nand-qpic-common.h:453:34: sparse: sparse: marked inline, but without a definition
   include/linux/mtd/nand-qpic-common.h:453:34: sparse: sparse: marked inline, but without a definition

vim +1890 drivers/mtd/nand/raw/qcom_nandc.c

  1849	
  1850	static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
  1851	{
  1852		struct qcom_nand_host *host = to_qcom_nand_host(chip);
  1853		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
  1854		struct qcom_op q_op = {};
  1855		const struct nand_op_instr *instr = NULL;
  1856		unsigned int op_id = 0;
  1857		unsigned int len = 0;
  1858		int ret;
  1859	
  1860		ret = qcom_parse_instructions(chip, subop, &q_op);
  1861		if (ret)
  1862			return ret;
  1863	
  1864		q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
  1865	
  1866		nandc->buf_count = 0;
  1867		nandc->buf_start = 0;
  1868		host->use_ecc = false;
  1869		qcom_clear_read_regs(nandc);
  1870		qcom_clear_bam_transaction(nandc);
  1871	
  1872		nandc->regs->cmd = q_op.cmd_reg;
  1873		nandc->regs->addr0 = 0;
  1874		nandc->regs->addr1 = 0;
  1875	
  1876		host->cfg0 = FIELD_PREP(CW_PER_PAGE_MASK, 0) |
  1877			     FIELD_PREP(UD_SIZE_BYTES_MASK, 512) |
  1878			     FIELD_PREP(NUM_ADDR_CYCLES_MASK, 5) |
  1879			     FIELD_PREP(SPARE_SIZE_BYTES_MASK, 0);
  1880	
  1881		host->cfg1 = FIELD_PREP(NAND_RECOVERY_CYCLES_MASK, 7) |
  1882			     FIELD_PREP(BAD_BLOCK_BYTE_NUM_MASK, 17) |
  1883			     FIELD_PREP(CS_ACTIVE_BSY, 0) |
  1884			     FIELD_PREP(BAD_BLOCK_IN_SPARE_AREA, 1) |
  1885			     FIELD_PREP(WR_RD_BSY_GAP_MASK, 2) |
  1886			     FIELD_PREP(WIDE_FLASH, 0) |
  1887			     FIELD_PREP(DEV0_CFG1_ECC_DISABLE, 1);
  1888	
  1889		if (!nandc->props->qpic_version2)
> 1890			nandc->regs->ecc_buf_cfg = ECC_CFG_ECC_DISABLE;
  1891	
  1892		/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
  1893		if (!nandc->props->qpic_version2) {
  1894			nandc->regs->vld = (nandc->vld & ~READ_START_VLD);
  1895			nandc->regs->cmd1 = (nandc->cmd1 & ~(0xFF << READ_ADDR))
  1896					    | NAND_CMD_PARAM << READ_ADDR;
  1897		}
  1898	
  1899		nandc->regs->exec = 1;
  1900	
  1901		if (!nandc->props->qpic_version2) {
  1902			nandc->regs->orig_cmd1 = nandc->cmd1;
  1903			nandc->regs->orig_vld = nandc->vld;
  1904		}
  1905	
  1906		instr = q_op.data_instr;
  1907		op_id = q_op.data_instr_idx;
  1908		len = nand_subop_get_data_len(subop, op_id);
  1909	
  1910		nandc_set_read_loc(chip, 0, 0, 0, len, 1);
  1911	
  1912		if (!nandc->props->qpic_version2) {
  1913			qcom_write_reg_dma(nandc, &nandc->regs->vld, NAND_DEV_CMD_VLD, 1, 0);
  1914			qcom_write_reg_dma(nandc, &nandc->regs->cmd1, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
  1915		}
  1916	
  1917		nandc->buf_count = len;
  1918		memset(nandc->data_buffer, 0xff, nandc->buf_count);
  1919	
  1920		config_nand_single_cw_page_read(chip, false, 0);
  1921	
  1922		qcom_read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, nandc->buf_count, 0);
  1923	
  1924		/* restore CMD1 and VLD regs */
  1925		if (!nandc->props->qpic_version2) {
  1926			qcom_write_reg_dma(nandc, &nandc->regs->orig_cmd1, NAND_DEV_CMD1_RESTORE, 1, 0);
  1927			qcom_write_reg_dma(nandc, &nandc->regs->orig_vld, NAND_DEV_CMD_VLD_RESTORE, 1,
  1928					   NAND_BAM_NEXT_SGL);
  1929		}
  1930	
  1931		ret = qcom_submit_descs(nandc);
  1932		if (ret) {
  1933			dev_err(nandc->dev, "failure in submitting param page descriptor\n");
  1934			goto err_out;
  1935		}
  1936	
  1937		ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
  1938		if (ret)
  1939			goto err_out;
  1940	
  1941		memcpy(instr->ctx.data.buf.in, nandc->data_buffer, len);
  1942	
  1943	err_out:
  1944		return ret;
  1945	}
  1946	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

