Return-Path: <linux-spi+bounces-4936-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B258697F0E0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 20:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAAD1C21865
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739619E99A;
	Mon, 23 Sep 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahItg/sL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA901FA5;
	Mon, 23 Sep 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117628; cv=none; b=s4xeaoVf7x8+sULEgzwFjtWIQnW6IrnZkFQZHWZQGUScy+7hMSBCuB1NyqLSGyVdRScHnL3VLvIgMswZBRa8DUCSvAcx9lqgqCslegoKqdcHL+UHjLv+DMZY205T0aIb7wn8maOsk/v7sILRBCHb4w9aKL8QUG3EmyytPZigHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117628; c=relaxed/simple;
	bh=wSTLsA5Ybe2xoc8o3MD/A/8FFyISsRuVdTmpWvRDFYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAbbkN3T17E/rmuA1QTqg1XI8tKasP7Wldba9/UXBl/Rg9xBok62plkvqUb7ennnAAM8sGeTmlDQjsQj1ROzL7Ps4sawfxPe5UzweFmHQiQrqf/eYNtVTafDo+rKj/beII8eOuNTfp/unhQqSiWDV9dnG7fCthREouIstDS1P1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahItg/sL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727117627; x=1758653627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSTLsA5Ybe2xoc8o3MD/A/8FFyISsRuVdTmpWvRDFYM=;
  b=ahItg/sLMxN385rsy35/ttrUQX5Fe8k5lgU0pqUpNhtMcBgeQ6+IjeIw
   VrM01rJ0Nwpiwa/94DSsWlowEboKtTeTyass0WEnSqUu+G/gPO6oUoAvk
   XNGG3qN+NCoFLexW/9qVdbL0QJcFWfWQeWROn0119QQpzJYVeHC98RiGe
   NdLFlFDXZ5TTfjfll0vKyVGUXzcrhnmRXts7e2N/UiUR89Rurk+jjQk3d
   kqU73s2I+nNKXuIAXZv9aeCLStD0/EUATWis/yy6/A3IoFSXxLVZsCjL6
   vIYPG3W0pvavhH9CUhtJWuyIs+nq0PnG92GbK4HhN4PT/Z7udid9mYe6k
   Q==;
X-CSE-ConnectionGUID: 4elRHYEnQ/+rli72X+rL3w==
X-CSE-MsgGUID: XbG0UGj5ShiXLp8z1IdK1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37448287"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37448287"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 11:53:46 -0700
X-CSE-ConnectionGUID: qfKhphN1R4KM0lwsB9zRjA==
X-CSE-MsgGUID: v/ZMOK7mTO6D5F7Mfz+4Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71155818"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Sep 2024 11:53:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssoBm-000HWI-2t;
	Mon, 23 Sep 2024 18:53:38 +0000
Date: Tue, 24 Sep 2024 02:52:43 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, vkoul@kernel.org,
	nikita.shubin@maquefel.me, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
	quic_varada@quicinc.com, quic_mdalam@quicinc.com
Subject: Re: [PATCH v10 6/8] spi: spi-qpic: add driver for QCOM SPI NAND
 flash Interface
Message-ID: <202409240205.8sGdi5dZ-lkp@intel.com>
References: <20240922113351.2390195-7-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922113351.2390195-7-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on broonie-spi/for-next robh/for-next linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240922-193748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240922113351.2390195-7-quic_mdalam%40quicinc.com
patch subject: [PATCH v10 6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240924/202409240205.8sGdi5dZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240205.8sGdi5dZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240205.8sGdi5dZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_remove':
   spi-qpic-snand.c:(.text+0x19e): undefined reference to `qcom_nandc_unalloc'
   m68k-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_probe':
   spi-qpic-snand.c:(.text+0x5da): undefined reference to `qcom_nandc_alloc'
>> m68k-linux-ld: spi-qpic-snand.c:(.text+0x638): undefined reference to `qcom_write_reg_dma'
>> m68k-linux-ld: spi-qpic-snand.c:(.text+0x69a): undefined reference to `qcom_submit_descs'
>> m68k-linux-ld: spi-qpic-snand.c:(.text+0x6ba): undefined reference to `qcom_nandc_unalloc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

