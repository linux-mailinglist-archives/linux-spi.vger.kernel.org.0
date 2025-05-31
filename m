Return-Path: <linux-spi+bounces-8346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91045AC9D1D
	for <lists+linux-spi@lfdr.de>; Sun,  1 Jun 2025 00:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA211790AF
	for <lists+linux-spi@lfdr.de>; Sat, 31 May 2025 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78C1C3C04;
	Sat, 31 May 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWW4WThU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1B18D63A;
	Sat, 31 May 2025 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748729395; cv=none; b=UlfUd04KMImV+5cg+zRkNc4XbIRWADzs7RdsWGBfNjOZrJ6Q/Sn6VJ03AEiRymU7SmPmGUK6bl900f6XVIPZZElYikeIj5Y3H1MjCuxHEgTbo18/kHmueh6BJQjQY6r9sTrE7MZdxrgqbk2h1FS3xp8lcNSwRgB7+qeg4+3fRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748729395; c=relaxed/simple;
	bh=qD9FC1vyMvm89EJTpfDitWPr5e5+DYZUgCl7MfyLMWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsLqKlmS+6G0h2+WfmQnBkx+7wDeV1Ui1J4FMnx7m6tvJ+7Bv0dIpnYzprWKLCcLRAafnSfGZONxBtvqRVwpZL7bfyUtvg5ceDAChfsG6P7G4p0eGHQZnvFyaQ5WchSZ6jcLM7xViKrn2pQ5Adl91cIQl5ALtsUwN+Ku+/2mNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWW4WThU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748729394; x=1780265394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qD9FC1vyMvm89EJTpfDitWPr5e5+DYZUgCl7MfyLMWU=;
  b=EWW4WThU2SxjUnbrlIRpZXbwrVYm7IgOxQuO3SlYTcIQQZFOLSNG8RZc
   ourq7WUj8Et6OdcvFMU54eeOn9v4ffwDALy8nTPA/PYZ/FJFzUPVPYqj7
   qXIjTtDf7ogEEWGZnNt6SVipx1hPIhvTYNiM15ea7wapRMyqxoGGkqkPT
   IW8WMfDs3Kk33KF9XSXWGxLomb1lvfzys5ESk1kQXh+jM+v8+E1OAHGj3
   NxKOoUhRYMjUYNB0QSrdMercbXrpDtB/hd0t8pVPkMpwEeNYn5K1Ho21C
   i319SYQ6m6AVTLl5Imt+iqVVSs4TZSgRKWWurGRht1iDI3UcdRDVjWIUa
   Q==;
X-CSE-ConnectionGUID: 1AtnRWTTT7yjTs5oZH46IQ==
X-CSE-MsgGUID: jm+e6CDJQKGjWc38Nc3uCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="62187627"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="62187627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 15:09:53 -0700
X-CSE-ConnectionGUID: DR2wqyAZQZGWq35UX2HHTQ==
X-CSE-MsgGUID: Kjbyv2bSSkWJOLFCgt4FuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="167378829"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 May 2025 15:09:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLUOi-000Yfg-2v;
	Sat, 31 May 2025 22:09:48 +0000
Date: Sun, 1 Jun 2025 06:09:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Lamparter <chunkeey@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] spi: push HAS_IOMEM dependency down to the drivers
Message-ID: <202506010509.Ln1e8D4u-lkp@intel.com>
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
config: s390-kismet-CONFIG_MDIO_MSCC_MIIM-CONFIG_NET_DSA_MSCC_OCELOT_EXT-0-0 (https://download.01.org/0day-ci/archive/20250601/202506010509.Ln1e8D4u-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250601/202506010509.Ln1e8D4u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506010509.Ln1e8D4u-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MDIO_MSCC_MIIM when selected by NET_DSA_MSCC_OCELOT_EXT
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

