Return-Path: <linux-spi+bounces-4005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105093C852
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769A21C20CAA
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7270026286;
	Thu, 25 Jul 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUXqEgnP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA97210F8;
	Thu, 25 Jul 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931986; cv=none; b=mB9hNRvdDoGUdMQUI+T8gd27Gus+qc+ntBLNxPhGtU8ZSssm7prrI+jmL3x4WmfMJVqvKppJN9S4bmTOrq4i0F97kxxbDvo8s38Sk0g9+JRFp1qLEHSiA03QtIHBZJN4GDkRj/vXyO5WndV/evknbyYAfTgQCI35JsevV1iU2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931986; c=relaxed/simple;
	bh=An+rYruUwkzkNoE8qdnOXJoiP4El3xe1TpM1w2+ehXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAo/vdxsL8ve+OedISduXnFH8MBKq46cpB4axdJC7/hlw8xpAvUf3eek1lyQypluE2mv6eFQFIwUJlr7mqii6kvX4F6kviTJh5IQZw5O+FcdQ91C8+C6aFDybaLhYxinAab72VPCZh9OXaqXijpLGOE3mLPAL6UI7drB7xbi7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUXqEgnP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721931984; x=1753467984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=An+rYruUwkzkNoE8qdnOXJoiP4El3xe1TpM1w2+ehXI=;
  b=WUXqEgnPJj2Y9hcBwrA35j84nO1dqGk9oe/DVqhLnK4jebfhLWhxzL9Z
   OOQlf5YW6StGSkD/dSSV0Wu/U0DDWO2d0+bI6DWhEYpCA2cGExeRZiLAT
   Fbw6lM98GHmnibILxLNTefrM+5RrlgaX6IzL7O7I2ceGvNit8WCj3zE7j
   xrBAnRZ8YHNrpUzRzld+/iQVkctUO9GirNGkqPGBeYr92dnb5MJJqL0kv
   faimxjOtXVtK5kivt+V4KVXjuw6rpGj+beQR+6X1JawZMstwR8WzLf/E4
   w9RpEDy0uUTwumbynTeJ+jCAAK0tYSS6/DHjiVKXkxEcRTrcxwn1ZnPnR
   A==;
X-CSE-ConnectionGUID: vUdnbC/8RBuDKmbAF8ZxQw==
X-CSE-MsgGUID: xCd5/RaqRkKTNGJxC6Gnzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30316478"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="30316478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 11:26:23 -0700
X-CSE-ConnectionGUID: yty4kyOcSgqUIUw3LryJ9Q==
X-CSE-MsgGUID: acAkU7E5R9257G8OsJ9i8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57596254"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jul 2024 11:26:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX3AO-000oM0-1f;
	Thu, 25 Jul 2024 18:26:16 +0000
Date: Fri, 26 Jul 2024 02:26:03 +0800
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
Subject: Re: [PATCH v7 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
Message-ID: <202407260215.PNyGyFnW-lkp@intel.com>
References: <20240724114225.2176448-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724114225.2176448-3-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.10 next-20240725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240724-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240724114225.2176448-3-quic_mdalam%40quicinc.com
patch subject: [PATCH v7 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
config: microblaze-randconfig-r133-20240725 (https://download.01.org/0day-ci/archive/20240726/202407260215.PNyGyFnW-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240726/202407260215.PNyGyFnW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260215.PNyGyFnW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/qcom_nandc.c:689:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location0 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:689:45: sparse:     expected restricted __le32 [usertype] read_location0
   drivers/mtd/nand/raw/qcom_nandc.c:689:45: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:691:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location1 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:691:45: sparse:     expected restricted __le32 [usertype] read_location1
   drivers/mtd/nand/raw/qcom_nandc.c:691:45: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:693:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location2 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:693:45: sparse:     expected restricted __le32 [usertype] read_location2
   drivers/mtd/nand/raw/qcom_nandc.c:693:45: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:695:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location3 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:695:45: sparse:     expected restricted __le32 [usertype] read_location3
   drivers/mtd/nand/raw/qcom_nandc.c:695:45: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:718:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last0 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:718:50: sparse:     expected restricted __le32 [usertype] read_location_last0
   drivers/mtd/nand/raw/qcom_nandc.c:718:50: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:720:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last1 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:720:50: sparse:     expected restricted __le32 [usertype] read_location_last1
   drivers/mtd/nand/raw/qcom_nandc.c:720:50: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:722:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last2 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:722:50: sparse:     expected restricted __le32 [usertype] read_location_last2
   drivers/mtd/nand/raw/qcom_nandc.c:722:50: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:724:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] read_location_last3 @@     got int val @@
   drivers/mtd/nand/raw/qcom_nandc.c:724:50: sparse:     expected restricted __le32 [usertype] read_location_last3
   drivers/mtd/nand/raw/qcom_nandc.c:724:50: sparse:     got int val
>> drivers/mtd/nand/raw/qcom_nandc.c:757:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:757:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:757:28: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:758:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:758:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:758:28: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:798:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [assigned] [usertype] cmd @@
   drivers/mtd/nand/raw/qcom_nandc.c:798:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:798:26: sparse:     got unsigned int [assigned] [usertype] cmd
>> drivers/mtd/nand/raw/qcom_nandc.c:799:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int [assigned] [usertype] cfg0 @@
   drivers/mtd/nand/raw/qcom_nandc.c:799:27: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:799:27: sparse:     got unsigned int [assigned] [usertype] cfg0
>> drivers/mtd/nand/raw/qcom_nandc.c:800:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned int [assigned] [usertype] cfg1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:800:27: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:800:27: sparse:     got unsigned int [assigned] [usertype] cfg1
>> drivers/mtd/nand/raw/qcom_nandc.c:801:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_bch_cfg @@     got unsigned int [assigned] [usertype] ecc_bch_cfg @@
   drivers/mtd/nand/raw/qcom_nandc.c:801:34: sparse:     expected restricted __le32 [usertype] ecc_bch_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:801:34: sparse:     got unsigned int [assigned] [usertype] ecc_bch_cfg
>> drivers/mtd/nand/raw/qcom_nandc.c:804:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got unsigned int [usertype] ecc_buf_cfg @@
   drivers/mtd/nand/raw/qcom_nandc.c:804:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:804:42: sparse:     got unsigned int [usertype] ecc_buf_cfg
>> drivers/mtd/nand/raw/qcom_nandc.c:806:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrflashstatus @@     got unsigned int [usertype] clrflashstatus @@
   drivers/mtd/nand/raw/qcom_nandc.c:806:37: sparse:     expected restricted __le32 [usertype] clrflashstatus
   drivers/mtd/nand/raw/qcom_nandc.c:806:37: sparse:     got unsigned int [usertype] clrflashstatus
>> drivers/mtd/nand/raw/qcom_nandc.c:807:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] clrreadstatus @@     got unsigned int [usertype] clrreadstatus @@
   drivers/mtd/nand/raw/qcom_nandc.c:807:36: sparse:     expected restricted __le32 [usertype] clrreadstatus
   drivers/mtd/nand/raw/qcom_nandc.c:807:36: sparse:     got unsigned int [usertype] clrreadstatus
>> drivers/mtd/nand/raw/qcom_nandc.c:808:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:808:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:808:27: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:2656:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2656:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:2656:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:2657:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2657:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:2657:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:2713:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2713:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:2713:26: sparse:     got unsigned int [addressable] [usertype] cmd_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:2714:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2714:28: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:2714:28: sparse:     got unsigned int [addressable] [usertype] addr1_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:2715:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2715:28: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:2715:28: sparse:     got unsigned int [addressable] [usertype] addr2_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:2716:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] chip_sel @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:2716:31: sparse:     expected restricted __le32 [usertype] chip_sel
   drivers/mtd/nand/raw/qcom_nandc.c:2716:31: sparse:     got unsigned long
   drivers/mtd/nand/raw/qcom_nandc.c:2717:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2717:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:2717:27: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:2757:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr0 @@     got unsigned int [addressable] [assigned] [usertype] addr1_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2757:36: sparse:     expected restricted __le32 [usertype] addr0
   drivers/mtd/nand/raw/qcom_nandc.c:2757:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr1_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:2758:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] addr1 @@     got unsigned int [addressable] [assigned] [usertype] addr2_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2758:36: sparse:     expected restricted __le32 [usertype] addr1
   drivers/mtd/nand/raw/qcom_nandc.c:2758:36: sparse:     got unsigned int [addressable] [assigned] [usertype] addr2_reg
>> drivers/mtd/nand/raw/qcom_nandc.c:2759:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2759:35: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:2759:35: sparse:     got unsigned int
>> drivers/mtd/nand/raw/qcom_nandc.c:2760:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got unsigned int [usertype] cfg1_raw @@
   drivers/mtd/nand/raw/qcom_nandc.c:2760:35: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:2760:35: sparse:     got unsigned int [usertype] cfg1_raw
>> drivers/mtd/nand/raw/qcom_nandc.c:2773:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2773:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:2773:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:2774:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2774:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:2774:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:2819:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd @@     got unsigned int [addressable] [assigned] [usertype] cmd_reg @@
   drivers/mtd/nand/raw/qcom_nandc.c:2819:26: sparse:     expected restricted __le32 [usertype] cmd
   drivers/mtd/nand/raw/qcom_nandc.c:2819:26: sparse:     got unsigned int [addressable] [assigned] [usertype] cmd_reg
   drivers/mtd/nand/raw/qcom_nandc.c:2823:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg0 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2823:27: sparse:     expected restricted __le32 [usertype] cfg0
   drivers/mtd/nand/raw/qcom_nandc.c:2823:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:2828:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cfg1 @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2828:27: sparse:     expected restricted __le32 [usertype] cfg1
   drivers/mtd/nand/raw/qcom_nandc.c:2828:27: sparse:     got int
   drivers/mtd/nand/raw/qcom_nandc.c:2837:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] ecc_buf_cfg @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2837:42: sparse:     expected restricted __le32 [usertype] ecc_buf_cfg
   drivers/mtd/nand/raw/qcom_nandc.c:2837:42: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:2841:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] vld @@     got unsigned long @@
   drivers/mtd/nand/raw/qcom_nandc.c:2841:34: sparse:     expected restricted __le32 [usertype] vld
   drivers/mtd/nand/raw/qcom_nandc.c:2841:34: sparse:     got unsigned long
>> drivers/mtd/nand/raw/qcom_nandc.c:2842:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cmd1 @@     got unsigned int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2842:35: sparse:     expected restricted __le32 [usertype] cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:2842:35: sparse:     got unsigned int
   drivers/mtd/nand/raw/qcom_nandc.c:2846:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] exec @@     got int @@
   drivers/mtd/nand/raw/qcom_nandc.c:2846:27: sparse:     expected restricted __le32 [usertype] exec
   drivers/mtd/nand/raw/qcom_nandc.c:2846:27: sparse:     got int
>> drivers/mtd/nand/raw/qcom_nandc.c:2849:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_cmd1 @@     got unsigned int [usertype] cmd1 @@
   drivers/mtd/nand/raw/qcom_nandc.c:2849:40: sparse:     expected restricted __le32 [usertype] orig_cmd1
   drivers/mtd/nand/raw/qcom_nandc.c:2849:40: sparse:     got unsigned int [usertype] cmd1
>> drivers/mtd/nand/raw/qcom_nandc.c:2850:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] orig_vld @@     got unsigned int [usertype] vld @@
   drivers/mtd/nand/raw/qcom_nandc.c:2850:39: sparse:     expected restricted __le32 [usertype] orig_vld
   drivers/mtd/nand/raw/qcom_nandc.c:2850:39: sparse:     got unsigned int [usertype] vld

vim +689 drivers/mtd/nand/raw/qcom_nandc.c

   669	
   670	/**
   671	 * nandc_set_read_loc_first() - to set read location first register
   672	 * @reg_base:		location register base
   673	 * @cw_offset:		code word offset
   674	 * @read_size:		code word read length
   675	 * @is_last_read_loc:	is this the last read location
   676	 *
   677	 * This function will set location register value
   678	 */
   679	static void nandc_set_read_loc_first(struct nand_chip *chip,
   680					     int reg_base, int cw_offset,
   681					     int read_size, int is_last_read_loc)
   682	{
   683		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   684		int val = (((cw_offset) << READ_LOCATION_OFFSET) |
   685			  ((read_size) << READ_LOCATION_SIZE) |
   686			  ((is_last_read_loc) << READ_LOCATION_LAST));
   687	
   688		if (reg_base == NAND_READ_LOCATION_0)
 > 689			nandc->regs->read_location0 = val;
   690		else if (reg_base == NAND_READ_LOCATION_1)
 > 691			nandc->regs->read_location1 = val;
   692		else if (reg_base == NAND_READ_LOCATION_2)
 > 693			nandc->regs->read_location2 = val;
   694		else if (reg_base == NAND_READ_LOCATION_3)
 > 695			nandc->regs->read_location3 = val;
   696	}
   697	
   698	/**
   699	 * nandc_set_read_loc_last - to set read location last register
   700	 * @reg_base:		location register base
   701	 * @cw_offset:		code word offset
   702	 * @read_size:		code word read length
   703	 * @is_last_read_loc:	is this the last read location
   704	 *
   705	 * This function will set location last register value
   706	 */
   707	static void nandc_set_read_loc_last(struct nand_chip *chip,
   708					    int reg_base, int cw_offset,
   709					    int read_size, int is_last_read_loc)
   710	{
   711		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   712	
   713		int val = (((cw_offset) << READ_LOCATION_OFFSET) |
   714			  ((read_size) << READ_LOCATION_SIZE) |
   715			  ((is_last_read_loc) << READ_LOCATION_LAST));
   716	
   717		if (reg_base == NAND_READ_LOCATION_LAST_CW_0)
 > 718			nandc->regs->read_location_last0 = val;
   719		else if (reg_base == NAND_READ_LOCATION_LAST_CW_1)
 > 720			nandc->regs->read_location_last1 = val;
   721		else if (reg_base == NAND_READ_LOCATION_LAST_CW_2)
 > 722			nandc->regs->read_location_last2 = val;
   723		else if (reg_base == NAND_READ_LOCATION_LAST_CW_3)
 > 724			nandc->regs->read_location_last3 = val;
   725	}
   726	
   727	/* helper to configure location register values */
   728	static void nandc_set_read_loc(struct nand_chip *chip, int cw, int reg,
   729				       int cw_offset, int read_size, int is_last_read_loc)
   730	{
   731		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   732		struct nand_ecc_ctrl *ecc = &chip->ecc;
   733		int reg_base = NAND_READ_LOCATION_0;
   734	
   735		if (nandc->props->qpic_version2 && qcom_nandc_is_last_cw(ecc, cw))
   736			reg_base = NAND_READ_LOCATION_LAST_CW_0;
   737	
   738		reg_base += reg * 4;
   739	
   740		if (nandc->props->qpic_version2 && qcom_nandc_is_last_cw(ecc, cw))
   741			return nandc_set_read_loc_last(chip, reg_base, cw_offset,
   742					read_size, is_last_read_loc);
   743		else
   744			return nandc_set_read_loc_first(chip, reg_base, cw_offset,
   745					read_size, is_last_read_loc);
   746	}
   747	
   748	/* helper to configure address register values */
   749	static void set_address(struct qcom_nand_host *host, u16 column, int page)
   750	{
   751		struct nand_chip *chip = &host->chip;
   752		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   753	
   754		if (chip->options & NAND_BUSWIDTH_16)
   755			column >>= 1;
   756	
 > 757		nandc->regs->addr0 = page << 16 | column;
 > 758		nandc->regs->addr1 = page >> 16 & 0xff;
   759	}
   760	
   761	/*
   762	 * update_rw_regs:	set up read/write register values, these will be
   763	 *			written to the NAND controller registers via DMA
   764	 *
   765	 * @num_cw:		number of steps for the read/write operation
   766	 * @read:		read or write operation
   767	 * @cw	:		which code word
   768	 */
   769	static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, int cw)
   770	{
   771		struct nand_chip *chip = &host->chip;
   772		u32 cmd, cfg0, cfg1, ecc_bch_cfg;
   773		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   774	
   775		if (read) {
   776			if (host->use_ecc)
   777				cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
   778			else
   779				cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
   780		} else {
   781			cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
   782		}
   783	
   784		if (host->use_ecc) {
   785			cfg0 = (host->cfg0 & ~(7U << CW_PER_PAGE)) |
   786					(num_cw - 1) << CW_PER_PAGE;
   787	
   788			cfg1 = host->cfg1;
   789			ecc_bch_cfg = host->ecc_bch_cfg;
   790		} else {
   791			cfg0 = (host->cfg0_raw & ~(7U << CW_PER_PAGE)) |
   792					(num_cw - 1) << CW_PER_PAGE;
   793	
   794			cfg1 = host->cfg1_raw;
   795			ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
   796		}
   797	
 > 798		nandc->regs->cmd = cmd;
 > 799		nandc->regs->cfg0 = cfg0;
 > 800		nandc->regs->cfg1 = cfg1;
 > 801		nandc->regs->ecc_bch_cfg = ecc_bch_cfg;
   802	
   803		if (!nandc->props->qpic_version2)
 > 804			nandc->regs->ecc_buf_cfg = host->ecc_buf_cfg;
   805	
 > 806		nandc->regs->clrflashstatus = host->clrflashstatus;
 > 807		nandc->regs->clrreadstatus = host->clrreadstatus;
 > 808		nandc->regs->exec = 1;
   809	
   810		if (read)
   811			nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
   812					   host->cw_data : host->cw_size, 1);
   813	}
   814	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

