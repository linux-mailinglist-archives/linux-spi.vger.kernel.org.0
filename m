Return-Path: <linux-spi+bounces-8556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219EFADA291
	for <lists+linux-spi@lfdr.de>; Sun, 15 Jun 2025 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB2116E705
	for <lists+linux-spi@lfdr.de>; Sun, 15 Jun 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73413D51E;
	Sun, 15 Jun 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+jWMPE8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCE1DA21;
	Sun, 15 Jun 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750005087; cv=none; b=qLaf/ZwvEp1RMUOwEI75aBozsfKnlvig3ZwaljI0AIaYB+mhyxWeF2BxsUQOW38MGgBTeXrKoWxPoNcAZqUkIKZ9HcCYM30MwegXW7JjngAR+caSSAlEWrXozR5h5PeL+hdrcFwoIcISb0vuqcL9+QS6eA3sWq8hBIpE/NrX8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750005087; c=relaxed/simple;
	bh=UKlMClGuNsXjKmfdW7rUH1K/XPOnrNGPMUMQ2rUIPKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH888s2LsW/DZFhOqCgy2rTrtgU8Eqf4Np66rFFZjTPz77IkTF137K4RuzM5il9IyhK3ClyQN6BhpnsVy05PM9g3x0/eJycXhb5HTaE7zn3qrYd8qxrItgcQDiRpNG4s4LAR+hnsy33HfL5poLKI8y1BftAiavMzuc3W+rHrjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+jWMPE8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750005085; x=1781541085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UKlMClGuNsXjKmfdW7rUH1K/XPOnrNGPMUMQ2rUIPKA=;
  b=L+jWMPE8wrSYaU/wYiZ6NfgYYc/2dtW+n+MtnXc57VuiuEY0kPtFTsfx
   ylGNznxFse/whFM0vmDVVy8E/W3Ut9J40wkVAIsMwkC+rbxrWV4JA+RD4
   aq5B25wRfCdzf0LoPrVG45CcG/nuPey4XmgjL8LwXN+6z1DTPWY0fe0R6
   BwCllGysGD1H4nUvJBF0baTu7bdxlMe4Lny41WZK0FuVHrHS5GE2wDIRd
   XKA8EIGGKWWNKNQWXwDjsVfquanh3HDhaFpA8tp1464RDQJ6fXv/tGxhZ
   LqTbV8PvkwSxftkt1Pald2u5bZTTxIEhMxQI6oHut9zbPVDgIwVuUws/z
   Q==;
X-CSE-ConnectionGUID: OTFO4QaZQrO9lJj+Iu3voA==
X-CSE-MsgGUID: fSC71PpjQv25SZH9p0lGbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62763346"
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="62763346"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 09:31:24 -0700
X-CSE-ConnectionGUID: 8Vm6Y6fWSTGRTRUSflE0lg==
X-CSE-MsgGUID: k8ugKqjsRUC/SWEJKWPE8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="171470314"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jun 2025 09:31:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQqGO-000EQa-0y;
	Sun, 15 Jun 2025 16:31:20 +0000
Date: Mon, 16 Jun 2025 00:31:10 +0800
From: kernel test robot <lkp@intel.com>
To: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <202506160036.t9VDxF6p-lkp@intel.com>
References: <20250613-james-nxp-spi-dma-v2-2-017eecf24aab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-james-nxp-spi-dma-v2-2-017eecf24aab@linaro.org>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3adf5ba9ad767e33db2d6aab01bbca396bcb614b]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/spi-spi-fsl-dspi-Clear-completion-counter-before-initiating-transfer/20250613-173429
base:   3adf5ba9ad767e33db2d6aab01bbca396bcb614b
patch link:    https://lore.kernel.org/r/20250613-james-nxp-spi-dma-v2-2-017eecf24aab%40linaro.org
patch subject: [PATCH v2 2/5] spi: spi-fsl-dspi: Use non-coherent memory for DMA
config: m68k-randconfig-r113-20250615 (https://download.01.org/0day-ci/archive/20250616/202506160036.t9VDxF6p-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250616/202506160036.t9VDxF6p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/spi/spi-fsl-dspi.o: in function `dspi_release_dma.isra.0':
>> spi-fsl-dspi.c:(.text+0x644): undefined reference to `dma_free_pages'
>> m68k-linux-ld: spi-fsl-dspi.c:(.text+0x67a): undefined reference to `dma_free_pages'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

