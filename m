Return-Path: <linux-spi+bounces-8063-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABBAB27E4
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7293BB3E2
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCA1D5CEA;
	Sun, 11 May 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra9bLu/M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5B1891AB;
	Sun, 11 May 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746962019; cv=none; b=nWglPsW12BvGpqmSOUfF1O6+2AfbeAeVaw0lA2h1JtaHKbvTsnOxgGLLmrpbP+OlyJbR2B1+gVvuMaV4D/CzgwNQvWlgKPUrFia6VC57kkusdUe3BdgNK+5T+0miWY/2ZB0fKWlwhszo1SY4d4HrbDB49EKPbK35pOQ7os0bR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746962019; c=relaxed/simple;
	bh=1rAsgwZYIQE6e6R96BL5uR52KMCv8+3yF9wTwCO3IdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDYd1oFzkziW7+E3mHYUNllu1R8YrcNfYBeFx/cZj5MPy45aSaGxPQwR1uv8MqEtTPNTw1e8XUVmQJlRmcyjV4An98GGN4VOiSvG/thT+WzbGL/1tbw/t08xS/vxI8jnRrKWT42cskr+FH8eRALNHQL6ReDtxTm4BydsSABMz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra9bLu/M; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746962018; x=1778498018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rAsgwZYIQE6e6R96BL5uR52KMCv8+3yF9wTwCO3IdI=;
  b=Ra9bLu/MhareMqizcctI/oZ/m8L6tuhpNmt5t8cNCGeGNcA5AGOHvN6T
   TrHuu967t3WluBaKA1vjpTgBozBLE1Ha23op9T7JJ2v30vjdA2daf+0pu
   SOfK3JrN65KfjcOnB6Jfauh0QvaQ8Jx2+kzb9ee7A694YfsgfKTZvqKey
   zPbLTZynIyYbmot4h83P8spOokW5iqSnGACLNDz3A3m8kJe61BO9j1rRX
   WbAkL/t6kzlbGy1lNjc2hn810miGSO8AAIbbTqHu2zeNy2b5lkyhu0PCb
   Io03h/x0DVZLNrWlF928M7idE+dWbQT8ZVEsyn76RktXIvoLcJKObyWDb
   w==;
X-CSE-ConnectionGUID: R0sdyaZbT9OJUWfZp1/nHQ==
X-CSE-MsgGUID: eEnA/QB8TXuFH4n2adn8+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="47873550"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="47873550"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 04:13:37 -0700
X-CSE-ConnectionGUID: kXTEaESAQbGa6BLvEcG9BA==
X-CSE-MsgGUID: cG3jbXnLQ2qq1JMScR/teQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137603556"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 May 2025 04:13:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uE4cc-000Djb-1r;
	Sun, 11 May 2025 11:13:30 +0000
Date: Sun, 11 May 2025 19:13:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Charkov <alchark@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
Message-ID: <202505111905.tlinDurh-lkp@intel.com>
References: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>

Hi Alexey,

kernel test robot noticed the following build errors:

[auto build test ERROR on ed61cb3d78d585209ec775933078e268544fe9a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Charkov/dt-bindings-spi-Add-VIA-WonderMedia-serial-flash-controller/20250511-034459
base:   ed61cb3d78d585209ec775933078e268544fe9a4
patch link:    https://lore.kernel.org/r/20250510-wmt-sflash-v1-2-02a1ac6adf12%40gmail.com
patch subject: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia serial flash controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250511/202505111905.tlinDurh-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250511/202505111905.tlinDurh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505111905.tlinDurh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/controllers/wmt-sflash.c: In function 'wmt_sflash_pcmd_mode':
>> drivers/mtd/spi-nor/controllers/wmt-sflash.c:132:16: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     132 |         reg |= FIELD_PREP(SF_PROG_CMD_MOD, enable);
         |                ^~~~~~~~~~


vim +/FIELD_PREP +132 drivers/mtd/spi-nor/controllers/wmt-sflash.c

   126	
   127	static void wmt_sflash_pcmd_mode(struct wmt_sflash_host *host, bool enable)
   128	{
   129		u32 reg = readl(host->regbase + SF_SPI_INTF_CFG);
   130	
   131		reg &= ~SF_PROG_CMD_MOD;
 > 132		reg |= FIELD_PREP(SF_PROG_CMD_MOD, enable);
   133		writel(reg, host->regbase + SF_SPI_INTF_CFG);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

