Return-Path: <linux-spi+bounces-8348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB2AC9D73
	for <lists+linux-spi@lfdr.de>; Sun,  1 Jun 2025 02:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1304A179688
	for <lists+linux-spi@lfdr.de>; Sun,  1 Jun 2025 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15E184E;
	Sun,  1 Jun 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZcezEe1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD84A32;
	Sun,  1 Jun 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748738646; cv=none; b=Kkmq7OQrN9JPxIf0HiljEIbxbb3bHTzpPdZ8RJr3klfee368G+ltGOaHMnO+U2aztmBs5vEbF+QBrT6PvJE1eRLA9cJ+/D3ivH4jZGThAHl75/EPPKtx9gBg0OEw1x1Z0T2IeRTZWgMUoy8fKOb/C1sJtK0b97fRbmeeqEddhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748738646; c=relaxed/simple;
	bh=+XLbk0n0OfYAxcie9FwOpfe8nvjleRVKH+GsU+88GpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEkfcKNZwZeSFojZul3Vxse8vIonq0M4Yg2mqXnESNPE0WSljiNYYvZneRw25dNDmoeP2n+xHgiMuphWPJZZzDccUqFs0FXLKWuy7VbGSMXC4M2uYnBe2lHm5kKGK3zeoAZH3Li1RahawYpWGu/1hcc1JTlJjEW9v1yBq2gmBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZcezEe1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748738645; x=1780274645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XLbk0n0OfYAxcie9FwOpfe8nvjleRVKH+GsU+88GpA=;
  b=DZcezEe1oh0QZJy3dcZWXXu2N6C/6COijAGUBOo3VINdaWDd2FXerowZ
   nLnI0KiGGLF9Bqix4fQR5qEX8AogmeCJ/G0yCdpBJ5M5dXMJWcqGKYdb9
   dHJViRIOOtw/N0kOrDsgWS9T9pBNZ2T79TXkd51Gq68lUL7o7VFjIxO/q
   of8y9Xc03hAEgsbE7XfR7HV9G3OEMG16Y5t4sZUBtUscWJ0wxlQkp0GEk
   4ejKBUJ4F9whyxRUbkMbbCKuF9mfwDegJRD7VsbDDjoV2cJSk6gRhwIAU
   fAvZqXOMo8vddhJ3RkWzqghHPyIGWC8TO7V/Z+UrPR3svl3Y8h817c2io
   Q==;
X-CSE-ConnectionGUID: RyzBt1B8Qv6/ntCvLiAdsQ==
X-CSE-MsgGUID: 0BmuTVpVRGO3F5C95ffhWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="61462295"
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="61462295"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 17:44:04 -0700
X-CSE-ConnectionGUID: i2wdyA9nQrOl+Mo+fCeU0A==
X-CSE-MsgGUID: 4NM9+RmbTUiZtnjxSRYRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="148087216"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 May 2025 17:44:02 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLWnw-000Yie-0T;
	Sun, 01 Jun 2025 00:44:00 +0000
Date: Sun, 1 Jun 2025 08:43:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Lamparter <chunkeey@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] spi: push HAS_IOMEM dependency down to the drivers
Message-ID: <202506010837.XIuxozSA-lkp@intel.com>
References: <20250530234941.950431-1-chunkeey@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530234941.950431-1-chunkeey@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master next-20250530]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Lamparter/spi-push-HAS_IOMEM-dependency-down-to-the-drivers/20250531-075211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250530234941.950431-1-chunkeey%40gmail.com
patch subject: [PATCH v1] spi: push HAS_IOMEM dependency down to the drivers
config: s390-kismet-CONFIG_MFD_OCELOT-CONFIG_NET_DSA_MSCC_OCELOT_EXT-0-0 (https://download.01.org/0day-ci/archive/20250601/202506010837.XIuxozSA-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250601/202506010837.XIuxozSA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506010837.XIuxozSA-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_OCELOT when selected by NET_DSA_MSCC_OCELOT_EXT
   WARNING: unmet direct dependencies detected for MFD_OCELOT
     Depends on [n]: HAS_IOMEM [=n] && SPI_MASTER [=y]
     Selected by [y]:
     - NET_DSA_MSCC_OCELOT_EXT [=y] && NETDEVICES [=y] && NET_DSA [=y] && SPI [=y] && NET_VENDOR_MICROSEMI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
   
   WARNING: unmet direct dependencies detected for MDIO_MSCC_MIIM
     Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=y] && MDIO_BUS [=y] && HAS_IOMEM [=n] && REGMAP_MMIO [=y]
     Selected by [y]:
     - NET_DSA_MSCC_OCELOT_EXT [=y] && NETDEVICES [=y] && NET_DSA [=y] && SPI [=y] && NET_VENDOR_MICROSEMI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

