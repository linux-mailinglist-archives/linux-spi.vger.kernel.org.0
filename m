Return-Path: <linux-spi+bounces-2948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D181F8C969C
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 22:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A16280D6F
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2350241;
	Sun, 19 May 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnLdR+QN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F31804F;
	Sun, 19 May 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150971; cv=none; b=Ul0+1rwMKNcYHUq34Vlwz5epzpZBHKBMEyRpWgwXa/125L4Qdd+C0WFXVA6a8pb/H4IfEi0y2UDot5NmgclV56vbWhdEKBaNLXur2clsDGicE1nFYHDjFGEtiihvfWo5mjhEmQ7PkudnUZRNAtL32dvXTfqHpCJ7iox4wBku+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150971; c=relaxed/simple;
	bh=PvchwwyHop/XcvwdlyaD/GxovOSOTuEM6HwG18aSwr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYuMF2jvV9rQtI/YqPNUpY/88xhQ3GC1Y5WRiNU5ToGdx/HU5zGRBvQDbyzt0y3fNbTUTog/FlBRfMtH2SLzNCXZNysJjxROM2hrwA/5Qzp1zvLUgirjxLXVz2T+Reem2Ti/w2jDt1Vp8CvjAtEkPJUq8Mx/CdmcCe0QkZAvF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnLdR+QN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716150969; x=1747686969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PvchwwyHop/XcvwdlyaD/GxovOSOTuEM6HwG18aSwr4=;
  b=ZnLdR+QNpIzU0DSGwznHv8vy7I6bqey3jn3jGQYj/r3FLZgmoA9Bs0s6
   Y3o+jmEkwN7CkOAgyjfyAD8wv3kGJ4KmMcmgVZXs8weBz+KI908cKMJdA
   3KgiX864D6xrFYyQci8jSj0HA9yBtOvTATLer5VuYqMYzAIrKSy8yKImH
   X/QvYt6hQsxzT3Dm6nf62q08NdmwQYfjXTV1S/DV6ApKo7grTtDpLWRu3
   oHGBC2OWQwU8kDhAWjt2GRcQC4pCqVfFU/DO2sU8qaDn6t1ljJjC7FvA5
   XNpkpqz/tBQ3bowqI1QmtN+149vMAAdyJE/jkjN228S1pJ/70B2RJXCij
   w==;
X-CSE-ConnectionGUID: TTzI/6HpQGGDNZ/3z2nVBA==
X-CSE-MsgGUID: c0HcY28ASQmxIlzsGwg2AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23412065"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="23412065"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 13:36:09 -0700
X-CSE-ConnectionGUID: hAuS7mItQAGZRzMpvNwHeg==
X-CSE-MsgGUID: DNMCxiFmSyuh2hG4uII5KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="63150766"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 May 2024 13:36:07 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8nGG-0004Au-1Q;
	Sun, 19 May 2024 20:36:04 +0000
Date: Mon, 20 May 2024 04:35:49 +0800
From: kernel test robot <lkp@intel.com>
To: egyszeregy@freemail.hu, broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Benjamin =?utf-8?B?U3rFkWtl?= <egyszeregy@freemail.hu>
Subject: Re: [PATCH] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <202405200406.PHvbYk5Z-lkp@intel.com>
References: <20240519181039.23147-1-egyszeregy@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519181039.23147-1-egyszeregy@freemail.hu>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/egyszeregy-freemail-hu/spidev-Introduce-linux-spidev-name-property-for-device-tree-of-spidev/20240520-021957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240519181039.23147-1-egyszeregy%40freemail.hu
patch subject: [PATCH] spidev: Introduce "linux,spidev-name" property for device tree of spidev.
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240520/202405200406.PHvbYk5Z-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200406.PHvbYk5Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200406.PHvbYk5Z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spidev.c:812:24: error: passing 'const struct class' to parameter of incompatible type 'const struct class *'; take the address with &
                           dev = device_create(spidev_class, &spi->dev, spidev->devt,
                                               ^~~~~~~~~~~~
                                               &
   include/linux/device.h:1175:35: note: passing argument to parameter 'cls' here
   device_create(const struct class *cls, struct device *parent, dev_t devt,
                                     ^
   drivers/spi/spidev.c:816:24: error: passing 'const struct class' to parameter of incompatible type 'const struct class *'; take the address with &
                           dev = device_create(spidev_class, &spi->dev, spidev->devt,
                                               ^~~~~~~~~~~~
                                               &
   include/linux/device.h:1175:35: note: passing argument to parameter 'cls' here
   device_create(const struct class *cls, struct device *parent, dev_t devt,
                                     ^
   2 errors generated.


vim +812 drivers/spi/spidev.c

   767	
   768	static int spidev_probe(struct spi_device *spi)
   769	{
   770		int ret;
   771		const char *name;
   772		int (*match)(struct device *dev);
   773		struct spidev_data	*spidev;
   774		int			status;
   775		unsigned long		minor;
   776	
   777		match = device_get_match_data(&spi->dev);
   778		if (match) {
   779			status = match(&spi->dev);
   780			if (status)
   781				return status;
   782		}
   783	
   784		/* Allocate driver data */
   785		spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
   786		if (!spidev)
   787			return -ENOMEM;
   788	
   789		/* Initialize the driver data */
   790		spidev->spi = spi;
   791		mutex_init(&spidev->spi_lock);
   792		mutex_init(&spidev->buf_lock);
   793	
   794		INIT_LIST_HEAD(&spidev->device_entry);
   795	
   796		/* If we can allocate a minor number, hook up this device.
   797		 * Reusing minors is fine so long as udev or mdev is working.
   798		 */
   799		mutex_lock(&device_list_lock);
   800		minor = find_first_zero_bit(minors, N_SPI_MINORS);
   801		if (minor < N_SPI_MINORS) {
   802			struct device *dev;
   803	
   804			spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
   805	
   806			/*
   807			 * If "linux,spidev-name" is specified in device tree, use /dev/spidev-<name>
   808			 * in Linux userspace, otherwise use /dev/spidev<bus_num>.<cs_num>.
   809			 */
   810			ret = device_property_read_string(&spi->dev, "linux,spidev-name", &name);
   811			if (ret < 0)
 > 812				dev = device_create(spidev_class, &spi->dev, spidev->devt,
   813						    spidev, "spidev%d.%d",
   814						    spi->controller->bus_num, spi_get_chipselect(spi, 0));
   815			else
   816				dev = device_create(spidev_class, &spi->dev, spidev->devt,
   817						    spidev, "spidev-%s", name);
   818	
   819			status = PTR_ERR_OR_ZERO(dev);
   820		} else {
   821			dev_dbg(&spi->dev, "no minor number available!\n");
   822			status = -ENODEV;
   823		}
   824		if (status == 0) {
   825			set_bit(minor, minors);
   826			list_add(&spidev->device_entry, &device_list);
   827		}
   828		mutex_unlock(&device_list_lock);
   829	
   830		spidev->speed_hz = spi->max_speed_hz;
   831	
   832		if (status == 0)
   833			spi_set_drvdata(spi, spidev);
   834		else
   835			kfree(spidev);
   836	
   837		return status;
   838	}
   839	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

