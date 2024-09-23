Return-Path: <linux-spi+bounces-4937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B69839F3
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFFF1F23A91
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F085656;
	Mon, 23 Sep 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRyBsoyU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386213B58E;
	Mon, 23 Sep 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132577; cv=none; b=BCSHATh6fgy7aGO7FkU8wWa6iLcq5MvWF5HUDCugo0z+3NjrMZOjETA0mII1/MUamkhJP4J1jAe2ZFbTMhmxyNIT/GQ5KHHGuUUuKPEnyfnp6Vd/ogBzPVepnOWw6Vb4wAEh/eSwIyVMuZskv0rxh1Or0zMQXYM4sDb30Z4XwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132577; c=relaxed/simple;
	bh=sT2ERJf1IiiQr2+SWze8EkX9mc+I3GG3PKU3JCCVBjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsoWCptb1Ubt1eSeJtFrz8HOda5leZ0PLe1i39keZ0yXvt0+lEUlGdAuXSxN5v4JJniql98GnTgZnKEkgkUB9uspM8KoccLtKbLoBgI7cCn+HY5npX3IAqRwduRQMHUNWJ1fWYSN7j6bQvQxQFT2AKjFr8wMj+RCscr//Qyb0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRyBsoyU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727132575; x=1758668575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT2ERJf1IiiQr2+SWze8EkX9mc+I3GG3PKU3JCCVBjY=;
  b=GRyBsoyUFAcS+ndUalrjfDTzXXJgVFluape6Smk8QoLIM/+tmTD8BrJJ
   4Z1aIVqYqegfXVyiEytNYnuiiye/ml5BqE4q3k9RS2a1PVuBbLHX5eC75
   wHqQRnLkk0hGiENl4wz+XTssE8HyMjZRsAsYJNjQUWyyVMHWHOJdtDOvT
   aeUnJWI5hu+TOxbxjh4tfnZCzWn4ZLUwrt9ekav6RUVVnfdbb3aFMbdn9
   HLjS/jTCq53/efcq4Zpa41wKwlmpEsB9hn3lmKfbmb63HWhMyNoFcar2b
   6aL501x+Gwuamaz9U0449U0DYah404Zmi9zfsQEEu2nJBtCUHIRZTqK3U
   g==;
X-CSE-ConnectionGUID: SZyQggyfRXGDWqdq8P+iAw==
X-CSE-MsgGUID: 3QjBCGZRQ3eXNIG6vHfjsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43619919"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="43619919"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 16:02:54 -0700
X-CSE-ConnectionGUID: j7WMgWH0REWhb6PcC1xKjw==
X-CSE-MsgGUID: pjBFfilMSHiuQui1WsfUtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="76138059"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Sep 2024 16:02:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sss4s-000Hfb-0R;
	Mon, 23 Sep 2024 23:02:46 +0000
Date: Tue, 24 Sep 2024 07:02:45 +0800
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
Message-ID: <202409240634.CH4E22kp-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240924/202409240634.CH4E22kp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240634.CH4E22kp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240634.CH4E22kp-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_remove':
>> spi-qpic-snand.c:(.text+0x3e8): undefined reference to `qcom_nandc_unalloc'
   loongarch64-linux-ld: drivers/spi/spi-qpic-snand.o: in function `qcom_spi_probe':
>> spi-qpic-snand.c:(.text+0xb48): undefined reference to `qcom_nandc_alloc'
>> loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xbe4): undefined reference to `qcom_write_reg_dma'
   loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xc08): undefined reference to `qcom_write_reg_dma'
   loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xc24): undefined reference to `qcom_write_reg_dma'
   loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xc40): undefined reference to `qcom_write_reg_dma'
>> loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xc48): undefined reference to `qcom_submit_descs'
>> loongarch64-linux-ld: spi-qpic-snand.c:(.text+0xc7c): undefined reference to `qcom_nandc_unalloc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

