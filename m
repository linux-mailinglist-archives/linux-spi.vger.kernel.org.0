Return-Path: <linux-spi+bounces-5026-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790C9892A0
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 04:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA151C22354
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F717578;
	Sun, 29 Sep 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv9QM9CB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2014A91;
	Sun, 29 Sep 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576473; cv=none; b=KIYt5z16hmuRe8qWd0bRg5uyLdmBwWPkYOkiHn2V+8RBpMN3DKvcQpOo9fITUtKeMawmys5J01p/jOnWcgOkB7FkD2c6RRxpKqDHqhpl5xVjtZnX8dHYmHgqWKdhhJf1HjRn+gc40X5DaLXCPn8RXgjiIgoYn4enNzkErwA4KjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576473; c=relaxed/simple;
	bh=xSb9HBBKx6Kc+DXgPCklMJpn9wz9U4K4o0J0+cEpDS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+MiEWNNsjYiisWveRii+ZNxWIczjgWKkUI3QDG4JtGO9JUftvsKWV0PjzqRQ0MfbTbU3U5HvG0r9x6YfK4gSz3mAh56nm/5ZXYEpdqsqQaGJB9JSvio3lTbFITUJw/c64gStaAGgmTeRYj+bYChvXR7k0xdKAUB7jia2mipoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv9QM9CB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727576472; x=1759112472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSb9HBBKx6Kc+DXgPCklMJpn9wz9U4K4o0J0+cEpDS4=;
  b=Tv9QM9CBObbi94VEBQT0JWvvDIo2xX/epYCNDFQNCLGD35q9a/Hmzxej
   kWOMtsMN9FAVbVaFbmmmWZzuz3tpC3ICX32ZVn6BRVgWh6NuQAexAAfur
   hn/99M6/o3iuWYtIEFEcZ3rU/r4Be9oy7BQ0eRoIPsQqRmbktVbSSonxi
   jQA0RL4ztzbiMg6JZQtZdS2iRYQlpXZpcwmDD793gDtDwiCeObWesK8eY
   i71iyZI6oYqhLL4x2ilwsaX/CCfBH5xe3lrE4EqUKFJinWIR6lLBYHJRZ
   fPVVvIZ+5tiwMjr9tZnehADpqIhCg1oPfJ8lPJQJ98g1ezeuHERBCF2Mk
   g==;
X-CSE-ConnectionGUID: fnivp4Y/Q+OVqEdxBu9mUQ==
X-CSE-MsgGUID: WIzd0MaRQ2ul+QrKoe2czg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="14307809"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="14307809"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 19:21:12 -0700
X-CSE-ConnectionGUID: K8NP/KFTTzq87Al86HBMRg==
X-CSE-MsgGUID: wyXz8uifTDuMZiZeLrFkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="72499187"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Sep 2024 19:21:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sujYY-000Npf-23;
	Sun, 29 Sep 2024 02:21:06 +0000
Date: Sun, 29 Sep 2024 10:20:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dragan Simic <dsimic@manjaro.org>, linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, heiko@sntech.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, oss@helene.moe,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] driver core: Add device probe log helper
 dev_warn_probe()
Message-ID: <202409290910.55WdSCMH-lkp@intel.com>
References: <2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic@manjaro.org>

Hi Dragan,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on broonie-spi/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.11 next-20240927]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dragan-Simic/spi-rockchip-Perform-trivial-code-cleanups/20240928-121548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/2fd9a60e0efe906dc7a203cd652c8d0b7f932470.1727496560.git.dsimic%40manjaro.org
patch subject: [PATCH v2 4/5] driver core: Add device probe log helper dev_warn_probe()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20240929/202409290910.55WdSCMH-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290910.55WdSCMH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290910.55WdSCMH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/base/core.c: In function 'dev_probe_failed':
>> drivers/base/core.c:4988:16: error: assignment to '__va_list_tag (*)[1]' from incompatible pointer type '__va_list_tag **' [-Wincompatible-pointer-types]
    4988 |         vaf.va = &args;
         |                ^
   drivers/base/core.c: In function 'dev_err_probe':
   drivers/base/core.c:5055:1: warning: control reaches end of non-void function [-Wreturn-type]
    5055 | }
         | ^
   drivers/base/core.c: In function 'dev_warn_probe':
   drivers/base/core.c:5101:1: warning: control reaches end of non-void function [-Wreturn-type]
    5101 | }
         | ^


vim +4988 drivers/base/core.c

  4981	
  4982	static int dev_probe_failed(const struct device *dev, int err, bool fatal,
  4983				    const char *fmt, va_list args)
  4984	{
  4985		struct va_format vaf;
  4986	
  4987		vaf.fmt = fmt;
> 4988		vaf.va = &args;
  4989	
  4990		switch (err) {
  4991		case -EPROBE_DEFER:
  4992			device_set_deferred_probe_reason(dev, &vaf);
  4993			dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
  4994			break;
  4995	
  4996		case -ENOMEM:
  4997			/* Don't print anything on -ENOMEM, there's already enough output */
  4998			break;
  4999	
  5000		default:
  5001			/* Log fatal final failures as errors, otherwise produce warnings */
  5002			if (fatal)
  5003				dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
  5004			else
  5005				dev_warn(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
  5006			break;
  5007		}
  5008	
  5009		return err;
  5010	}
  5011	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

