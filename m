Return-Path: <linux-spi+bounces-3135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB58D404E
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 23:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91C31C2173A
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358301C8FDA;
	Wed, 29 May 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wx0zmJ4E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9A1C68B0;
	Wed, 29 May 2024 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018103; cv=none; b=qGypwhNkbN7z8crNez6RpBiDva4sdwweA4dQd9b3YkQwHJCt40H+8d0ikRWZRAf+sLTtgG+xU4gTat2E/YF3W7elGhpaEdAq4GYXZOGNAZ2KcFL9sGtirWm7ZNPUXRTqAdHR7LBA2U6hbrzHsyP6Zy0UlhgU7CC6i85cU8t3xG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018103; c=relaxed/simple;
	bh=8zWDjDedFf/ICjSC0KUnEXjkIlsSCH86AQ05ywlbeis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awiACopFiVjPtriQdHPitSe3JkLnWBMy70ZCHWNMRN6Zh0Y9yxzb4DAQSoGUFExGyGI4gX3RSrdb0n3DMfV5NDAxxJlf65hqU+WwFTK90icqaaYvDO2bTMGq6Pt6AD0QrwhnzqHE6shdZpkY0Ar9kwDJ0OF1KhxKkpFb/GpyqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wx0zmJ4E; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717018100; x=1748554100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8zWDjDedFf/ICjSC0KUnEXjkIlsSCH86AQ05ywlbeis=;
  b=Wx0zmJ4EVS9fjXYTMYZZcc0rj6KYwNdZA5xJ8gIUzdfD3TQEVhJokHkm
   EgNEza1AKvWj7UpBs+FoeqTxfNJ6CtSUEg7GG6OnOS2iOuDexE0fwfv+A
   HiULH6Jcc1HO1x5jLLLn/mPoyH2aw/HXEpyYZeunDhiEsw6pS5Fg9ZW7g
   U6RG1tmhi8GPFkUfJ1r2BPTjmj12V+q90J56ov4XYHhRFtCOHzQmrqJDb
   MIqJBPMBiFY8zQTm2dAGOQSK+ZkhA4Bo/KhCyZgsU4yt2eLH/SgommAL9
   Aj0qVMceH1QwZMNR/s51Bp/G+VfpPhJNYptxsoHzxYQBMpgq/yL92H9M5
   Q==;
X-CSE-ConnectionGUID: zkj0yJFsSJm7eDtOJt0JHg==
X-CSE-MsgGUID: yP8QRJaAQcGlWpJ/BAeoFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="38841856"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="38841856"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 14:28:20 -0700
X-CSE-ConnectionGUID: CEsAyq0uRNOwBNGzYvlJbg==
X-CSE-MsgGUID: jN0JXMA+S2iNMyExX/slww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66779322"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 May 2024 14:28:17 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCQpA-000EEH-11;
	Wed, 29 May 2024 21:27:58 +0000
Date: Thu, 30 May 2024 05:26:35 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <202405300552.k5g5BIm0-lkp@intel.com>
References: <20240529193651.1029840-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529193651.1029840-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/spi-dt-bindings-fsl-dspi-Convert-to-yaml-format/20240530-033848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240529193651.1029840-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] spi: dt-bindings: fsl-dspi: Convert to yaml format
reproduce: (https://download.01.org/0day-ci/archive/20240530/202405300552.k5g5BIm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405300552.k5g5BIm0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
   Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

