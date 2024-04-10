Return-Path: <linux-spi+bounces-2267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B789EC84
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B0F284696
	for <lists+linux-spi@lfdr.de>; Wed, 10 Apr 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659AF13D28B;
	Wed, 10 Apr 2024 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etSk0y8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567913D26E;
	Wed, 10 Apr 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734967; cv=none; b=uZ7Uu9h0HRi4xyiHF4VKQSkzX1PvVusOWz3Vc4k+PqalXrMrRqJp+KcqMN+Qrwz2LzeKrACDlvEZ4SsIDWUy55uC/3YVtGr16tJlI97+sWpAGuSunff7ALPJRXsFTPPgm/PnFpu7iiAUtIB4WjFPjN30fzX+BW8zqqig4kbyCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734967; c=relaxed/simple;
	bh=wWmn+i8xN3FEdFuPGlH4Qym/IY9I8gIWH1H2pqqEuaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r22uI4vJOpPwI/xJ0tXcBSnswEvJ90lEP6sYkMd7UOf+yuJhsgqpCvPkrSUji9Zb8A2BP6VFYoEPQc8F6zvFWL3LW3LZTPtNP9411+YoWIIOC9tI5Ocb0o9vt7Sg6tIti3AY41lIDpiGSsCCdVx5s6xCR8D/6EtbTf6Eq5e3VZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etSk0y8Q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712734966; x=1744270966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWmn+i8xN3FEdFuPGlH4Qym/IY9I8gIWH1H2pqqEuaY=;
  b=etSk0y8QeZQW5RHRUvoQeLI/dCcy8YxHnx+cWQixUAKrepnA7UUslgFt
   PZSiX9By9IyPRZ5A5G4VTqQipynUz8bVpunqxFtC+tKx8WABdT9eApcEm
   fRhKuzEjXIgeFpKekBtsUU8Wlz+3i1IvFsUWiyTmZTesPKeKE8YQE2LaR
   ADG+0RF32lVv7U+LfbWw8tUTCuWCqpsRioxLg5pQl+oyXe4k81l+6XIp+
   fjBlc2l3+EMagFIblbAYIkHNP4AOSXPC9CYgn3Yc4813ozU2+RtGYw8Jq
   mfXb/VORcIWT730tjmdRhlbTToxE8uqgq+/dZYaAoQ+efd/py25MYMd/s
   g==;
X-CSE-ConnectionGUID: +y3WIG1zT4OhA1+lfyJuWQ==
X-CSE-MsgGUID: sQ2GUL/8Q66B85PGe4lQig==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11922723"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11922723"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 00:42:45 -0700
X-CSE-ConnectionGUID: zjXhJi3BT/ygfLrqIJYbgg==
X-CSE-MsgGUID: xXIPWxd0QlGL07ac8ZmQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20361982"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Apr 2024 00:42:43 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruSbQ-00074g-0g;
	Wed, 10 Apr 2024 07:42:40 +0000
Date: Wed, 10 Apr 2024 15:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl
Cc: oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <202404101443.tYCaeZAm-lkp@intel.com>
References: <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on brgl/gpio/for-next linus/master v6.9-rc3 next-20240410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Keepax/gpio-swnode-Add-ability-to-specify-native-chip-selects-for-SPI/20240409-212316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240409132126.1117916-4-ckeepax%40opensource.cirrus.com
patch subject: [PATCH v4 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240410/202404101443.tYCaeZAm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404101443.tYCaeZAm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404101443.tYCaeZAm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-cs42l43.c: In function 'cs42l43_has_sidecar':
>> drivers/spi/spi-cs42l43.c:262:50: error: invalid use of undefined type 'struct acpi_device'
     262 |                 ret = acpi_get_local_address(adev->handle, &function);
         |                                                  ^~


vim +262 drivers/spi/spi-cs42l43.c

   247	
   248	static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
   249	{
   250		static const u32 func_smart_amp = 0x1;
   251		struct fwnode_handle *child_fwnode, *ext_fwnode;
   252		unsigned int val;
   253		u32 function;
   254		int ret;
   255	
   256		fwnode_for_each_child_node(fwnode, child_fwnode) {
   257			struct acpi_device *adev = to_acpi_device_node(child_fwnode);
   258	
   259			if (!adev)
   260				continue;
   261	
 > 262			ret = acpi_get_local_address(adev->handle, &function);
   263			if (ret || function != func_smart_amp) {
   264				fwnode_handle_put(child_fwnode);
   265				continue;
   266			}
   267	
   268			ext_fwnode = fwnode_get_named_child_node(child_fwnode,
   269					"mipi-sdca-function-expansion-subproperties");
   270			if (!ext_fwnode) {
   271				fwnode_handle_put(child_fwnode);
   272				continue;
   273			}
   274	
   275			ret = fwnode_property_read_u32(ext_fwnode,
   276						       "01fa-cirrus-sidecar-instances",
   277						       &val);
   278	
   279			fwnode_handle_put(ext_fwnode);
   280			fwnode_handle_put(child_fwnode);
   281	
   282			if (!ret)
   283				return !!val;
   284		}
   285	
   286		return false;
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

