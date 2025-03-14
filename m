Return-Path: <linux-spi+bounces-7151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62FA61603
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03951188AF2E
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBE2202C4A;
	Fri, 14 Mar 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhhhCSoM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F21F4288;
	Fri, 14 Mar 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968847; cv=none; b=H94Pg1qBT9sYqBBNnnDH8g3OMB9JFPqn4LUtY34zcW0dMxjv0hogjNB8pkrwFT0hnsljz4lVo5Km5WW2b8VRMXYw7GlNwbxmSuSu/8HDD6+6GV74hgKmkoLy0r8hSWgemS8YbzsS3SRjkng3Nr2Oq3iDJ6Vo/12to4XDdhQcbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968847; c=relaxed/simple;
	bh=DSWlAonZUkJocGNIA1FECdwmFFKVX0h5+Q91z8P8J9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oWSslWDDg7CIFXaSA7HtZTwJh4mF1juYy4GMdW3GYfEmkHG/8fs9uB/aTUqZihHpcGyEihuKvMornV2Le+wWGx0lqGbNn3wr/G+SSdOxSxKlbxYfkO/VHPkkXQGnUsvEiVHkSxEHhAj+KZYIDYU8HneO6CTF00yIQXEHWqaO8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhhhCSoM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741968844; x=1773504844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DSWlAonZUkJocGNIA1FECdwmFFKVX0h5+Q91z8P8J9k=;
  b=PhhhCSoMmO5Bquf3NouIfySZHhfDOfWHLj8VoSmqUDFOZ8caIj22d4N5
   +dnDOL2zrXBB5BWAB2T43kLx+IHqtlBmyPyWEo/Zp6wCiZ2UtzGeMPzCC
   H/ycMuKzOULTZCL7Eb2bzjdCkb+l/Bxmkvvw7fmBuRehiB9PM0cMKhMBN
   lWPILnYz8rRyEw6sD7uAUZElw5Nw2GY6PTxTDWFi3E5moNFCFgwXn+Mjt
   u9NY52peYBvLRsYnJuPQYKv8xbfOJXbj8wn5X+JnkB2WxqJ5itk1DPV43
   mjXdJDSMevmfFpt9gWUEw/1f9B9Lg4kxhfzCT1t5B1ljzaDottK8U1USZ
   A==;
X-CSE-ConnectionGUID: 5EDMr9LfQlKriJsepBjgNw==
X-CSE-MsgGUID: DT3hiSkLTGywgJewNXFK6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="65588897"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="65588897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 09:14:04 -0700
X-CSE-ConnectionGUID: 5RQ/wGPITeGv9lKQcjgGqQ==
X-CSE-MsgGUID: R3OTRyZuTLiPyz8qWFn4yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126384836"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 14 Mar 2025 09:14:02 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt7fc-000AdU-0y;
	Fri, 14 Mar 2025 16:14:00 +0000
Date: Sat, 15 Mar 2025 00:13:37 +0800
From: kernel test robot <lkp@intel.com>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org
Subject: [broonie-spi:for-6.15 19/22] htmldocs: Warning: MAINTAINERS
 references a file that doesn't exist:
 Documentation/connector/gocontroll,moduline-module-slot.yaml
Message-ID: <202503150030.PgDfN7Jx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.15
head:   336a41c90c86b883aa06ed19f138eee19ddf9958
commit: 8f1cc5242544052e4be037861abc8bc2b89cabda [19/22] MAINTAINERS: add maintainer for the GOcontroll Moduline module slot
reproduce: (https://download.01.org/0day-ci/archive/20250315/202503150030.PgDfN7Jx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503150030.PgDfN7Jx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/connector/gocontroll,moduline-module-slot.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

