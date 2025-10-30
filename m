Return-Path: <linux-spi+bounces-10923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE89C22555
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 21:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF1384ECC91
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBC32E13E;
	Thu, 30 Oct 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GylLjDwr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE961329E78;
	Thu, 30 Oct 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857188; cv=none; b=WmogiTRNYeL7z/dH31F7RQ69bgdizVwuVpeq3Asm4AhxAElzhwk2TCxDWwEoSCLBmO26qVYslqsRBH6JSF666UNsB2t9b5tsirrFDRTLgHQhIRRRrVyTZP764WXJr3VWgke4OT5x2PHKkqa3/jyirNp4YSntJFmRGCU+uYy6tCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857188; c=relaxed/simple;
	bh=IzHEHcAJbzakFfy2ATpib9g8Ap3+ty+ERc7BngoXid4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA0lfXrZmYGJi+mpaB1DBAaf/ohUDGwgFGMyEfyQaLdDyeutFfHu8CrNJX4rqrQeltwSi9LSIGXe4215vCeDyuV6rNh0CEFvjYMOsH4pOc52Du6i2A4O6wk/ruNoq2NvflhD6+cFe86JeaoT2wYtBs13oJYHwJaZxIYcm261+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GylLjDwr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761857187; x=1793393187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IzHEHcAJbzakFfy2ATpib9g8Ap3+ty+ERc7BngoXid4=;
  b=GylLjDwrCN59J1N5m+1QNhCsyElH8F1hTbm3VWdx6MMWaItn7EYCULsM
   Go51+j029j//EXPsoB1GJaAb3ZMQDWgIgEtLAplqdLgLU9pSTamaH+4Pw
   BfwwWjWK8CFQNVVt/sz4wdzgar8RqFDG2p969vMznmlCEz3H1UGDz8Fx8
   TmmB7rXGW/wMlO5xZ6RWVedXTc3nUJBFg7NB/XTnGyVCAVQW3hPbvA1vA
   cSBJNliVvCYJ5nPEDTK4OEdDL2EgCg1SoMQD5W1xibIz90N4Ct+WH32Xs
   T9QK0j5zcOFRG2/FMfPdvk//8c1SWiDBaTLOv4hScQQgrdBLbOUhhVwVJ
   A==;
X-CSE-ConnectionGUID: iD5QL6kIQgeY9/P5fGxY9Q==
X-CSE-MsgGUID: QrqFLS/iRRCQGhjFlhKYlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74305151"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="74305151"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:46:27 -0700
X-CSE-ConnectionGUID: ZOSCdisEQn6yO+A1JXJA3Q==
X-CSE-MsgGUID: CcBCWZKSSniJ0nEvu4L6Yw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2025 13:46:24 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEZWs-000MVc-24;
	Thu, 30 Oct 2025 20:46:03 +0000
Date: Fri, 31 Oct 2025 04:45:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, dlan@gentoo.org
Cc: oe-kbuild-all@lists.linux.dev, p.zabel@pengutronix.de,
	linux-spi@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <202510310407.ooVqGn3P-lkp@intel.com>
References: <20251027125504.297033-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027125504.297033-3-elder@riscstar.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/dt-bindings-spi-add-SpacemiT-K1-SPI-support/20251027-211246
base:   8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
patch link:    https://lore.kernel.org/r/20251027125504.297033-3-elder%40riscstar.com
patch subject: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20251031/202510310407.ooVqGn3P-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310407.ooVqGn3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310407.ooVqGn3P-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/spi/spi-spacemit-k1.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

