Return-Path: <linux-spi+bounces-8347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B6AC9D5A
	for <lists+linux-spi@lfdr.de>; Sun,  1 Jun 2025 01:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F006A178F3C
	for <lists+linux-spi@lfdr.de>; Sat, 31 May 2025 23:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F61A4F12;
	Sat, 31 May 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaAyU7yD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AA18C91F;
	Sat, 31 May 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748734322; cv=none; b=vCFb5ZltCZGFp4+M/o9ByEBhF24GrqOdxscc/GTkRoF1qpYtsQh2jX3EigapNWWsFqgKs0GKzi4CFR5YyRPWQOMatK6WvZr51sAff4N1EIzdCRvRZzpxLY5Fm7kqlkldwOHwrIX5SmBGA277TAJhMNgaRMFToUoTqwW8fzs+1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748734322; c=relaxed/simple;
	bh=l/6JWtbuEjpEYr0d5Qx0p0ETOLprUagjTTOYMllVTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qagYOOoTj5uNtWjgSv+MoTJQAtRdJMVv43XkxDyfEitcaCDdy8GK9wE102BKrjkD3Be+Y8T7g5TCSn0GyWovT1sMz3GExa/mXmlUm1ydOg0MF60Fcy57DBBUH1OBXaNHT5HrQWymnJ/GCYmspP6VANOBuEmGIXeAhNNfDMUNHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaAyU7yD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748734320; x=1780270320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/6JWtbuEjpEYr0d5Qx0p0ETOLprUagjTTOYMllVTmM=;
  b=OaAyU7yDLs7lPlx6t5L5d1gqLEe2i3Wz9+vPhKfd3PN0tZQYEuqWLhE0
   k0m1GfMLOL4+sNdgIV26R41VkbCmBHSwwb94poxRO9yeQSEQ6stwNq7BQ
   UD8tfxsBIf5oH94A63Oi8Nh06qhyh9M286S6laYQmNEStYM/02q6KILfA
   yTAtcnn7FQQiunEIEHfle0S8Txy+N0BG63irOCwj2oVOgodsNG+rBec7q
   KSudWIbURKKAl485vGI2K/uWjeXkE5d7kPNx9Zm3b5J5Fx7nZnAMfnrFi
   4x1nTo6FSN8F9QW11V4Y6SiiW9skSD8audXLomxjEC1TFQImjZbQT6n8+
   Q==;
X-CSE-ConnectionGUID: nOgROSGeToiaOdPre/9+/g==
X-CSE-MsgGUID: 62fJM+7sRSu99jrJwq5ECw==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50711541"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="50711541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 16:31:59 -0700
X-CSE-ConnectionGUID: /h+kF7heR8C0mmFRf2NNvQ==
X-CSE-MsgGUID: i8uZgsDoT2aSoq8+NoX0WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="144224192"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 31 May 2025 16:31:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLVgA-000YhA-2z;
	Sat, 31 May 2025 23:31:54 +0000
Date: Sun, 1 Jun 2025 07:31:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Lamparter <chunkeey@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] spi: push HAS_IOMEM dependency down to the drivers
Message-ID: <202506010734.yl1PFBaA-lkp@intel.com>
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
config: s390-kismet-CONFIG_MFD_CORE-CONFIG_IIO_SSP_SENSORHUB-0-0 (https://download.01.org/0day-ci/archive/20250601/202506010734.yl1PFBaA-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250601/202506010734.yl1PFBaA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506010734.yl1PFBaA-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_CORE when selected by IIO_SSP_SENSORHUB
   WARNING: unmet direct dependencies detected for MFD_CORE
     Depends on [n]: HAS_IOMEM [=n]
     Selected by [y]:
     - IIO_SSP_SENSORHUB [=y] && IIO [=y] && SPI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

