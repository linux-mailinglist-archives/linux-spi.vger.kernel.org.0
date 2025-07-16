Return-Path: <linux-spi+bounces-9107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A61B06D11
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524BD189B6C9
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C9274B42;
	Wed, 16 Jul 2025 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC+0/tDI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEF26A0E2;
	Wed, 16 Jul 2025 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642887; cv=none; b=Sd27o03OsYwa0bXRecBVL26W8MGItRsN1jJUlF95s06np3yLbKoMsHcUE8fHeD3ZAu1yFqg4+xi0nF1X6b1ihnSwuecOeG/aSN2W8yfEm46+CSYpyhawLP9dAm3Lzlrn5b9sGYu7tP2ajUrrbCQ95S0UY3LpQDso/sWfMwG0/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642887; c=relaxed/simple;
	bh=zaPIWiKkOjG4zU9eSUxzP+ONhIb3xwwH3H2x0zXworA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFOD65pCIaUDbA/S2xRIeISPwuTMr1spN5+ggmyZPkM/T6QxQYR0baw5kBhBrUkR+Zm/fXSEdo89uOoxQIODZzXCOxNegror3IlpKb8HiH6+rOE+b4rmbK9fbd0vkwbRxym/jKRpc1KEWF5uUD81Cs6U7coMaOfkUxzcuhhcT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC+0/tDI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752642882; x=1784178882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zaPIWiKkOjG4zU9eSUxzP+ONhIb3xwwH3H2x0zXworA=;
  b=aC+0/tDIfX3UhOtV16BZcPqPOzw0uRx5VZhC8hBKdlcIMGWfg00NJq37
   IKQQefbpTUm8xVfefBtrWCvamP8aheLmcy01qBoI6AKwDvf3DGXbH3++2
   ErCSJpnoLF0SnCpXAynZxtGig+aYDR7XEplmV8R87DNR8eAiVGP5f/9Gl
   PAxVuFFNoWqsfTMcvwIq/oE5uYREBOvGAoe4WibJrahvtLvSWuAc6Wgjq
   xeEbmSTjLlhEEcq61y2V2cBUjdZsCEAX3NF/KnBMutrjgB0Tw1Sdyfg96
   uBkfuUqTQuOVVqIWXtR++7UT+veYTSOkS0aj0atTkqR+nYTGsTHX+ZEEx
   w==;
X-CSE-ConnectionGUID: XGAiNanrRjuWnqM6Wc9mzA==
X-CSE-MsgGUID: HVM7E6CDQn+LZy3SDfXAzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="53986203"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="53986203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 22:14:26 -0700
X-CSE-ConnectionGUID: GsMZ5fi9QMGvABkN4sCtPw==
X-CSE-MsgGUID: EH8KzFxlSO6NXqi4RMIUlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="163045675"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Jul 2025 22:14:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubuTF-000BvP-21;
	Wed, 16 Jul 2025 05:14:21 +0000
Date: Wed, 16 Jul 2025 13:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Czapiga <czapiga@google.com>, Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Konrad Adamczyk <konrada@google.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Czapiga <czapiga@google.com>
Subject: Re: [PATCH] spi: intel: Allow writeable MTD partition with module
 param
Message-ID: <202507161228.D92rDToS-lkp@intel.com>
References: <20250715095007.896620-1-czapiga@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715095007.896620-1-czapiga@google.com>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on broonie-sound/for-next westeri-thunderbolt/next linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Czapiga/spi-intel-Allow-writeable-MTD-partition-with-module-param/20250715-175230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250715095007.896620-1-czapiga%40google.com
patch subject: [PATCH] spi: intel: Allow writeable MTD partition with module param
config: arc-randconfig-001-20250716 (https://download.01.org/0day-ci/archive/20250716/202507161228.D92rDToS-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507161228.D92rDToS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507161228.D92rDToS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-intel.c:195:34: error: expected ')' before string constant
     195 |         ignore_protection_status,
         |                                  ^
         |                                  )
     196 |         "Do not block SPI flash chip write access even if it is write-protected (default=0)");
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +195 drivers/spi/spi-intel.c

   188	
   189	static bool writeable;
   190	module_param(writeable, bool, 0);
   191	MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
   192	static bool ignore_protection_status;
   193	module_param(ignore_protection_status, bool, 0);
   194	MODULE_PARAM_DESC(
 > 195		ignore_protection_status,
   196		"Do not block SPI flash chip write access even if it is write-protected (default=0)");
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

