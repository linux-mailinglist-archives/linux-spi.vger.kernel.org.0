Return-Path: <linux-spi+bounces-2949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19318C96BD
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC501F21038
	for <lists+linux-spi@lfdr.de>; Sun, 19 May 2024 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DF6E602;
	Sun, 19 May 2024 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G761Mc+9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46747A60;
	Sun, 19 May 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153496; cv=none; b=WFksDbhHRhSzzc98Fqh34g2RfPjl9ckEgCp6lQDdv33XbnVV6g5W6/Gl/EN6y+BbYrgFXb6+68duRDI/157d/2SO10E8dCmO1414lSWyaCe/pHWWN9sI8jd2OdUcRR0KvUXHW/2ZMyxdSW3KEy1FCi5PqvkU/mTskxhH9Re4fOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153496; c=relaxed/simple;
	bh=nRNvrAUDokkFb+DAB7wQjB6l6bkHSaKn/msMtWmOAfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7KeYpXYtDQNL855hzWY32cn/NYJlUsXb+1M4L1pR+cTRLN1xo60E2Q4ho8cJZzoGiAv0kY2RhocjZTZ/dXBDpufgNfAaC6aSjXB1cuzU96NDnQ2lVDkwDRE8yNTTxyYHR7+p2jUzfbHuUuCDp91ZCtQwrMj0JUe8EKW9POS9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G761Mc+9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716153495; x=1747689495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nRNvrAUDokkFb+DAB7wQjB6l6bkHSaKn/msMtWmOAfw=;
  b=G761Mc+9s/FZ2k4/B34fXdA42ANSvdM2pCRh6OGaHFN9CkchpaCsMkNR
   AObPncZxcfATg46GZk8+vTeWWOSGItx3hqa4BzValvJBR+2C+kLLBx+k9
   f2Tw/boUJ1zpmWSAWJ/n0aVpcdZyLon7nhqW6eWvI8MPMnivpkmiErvj2
   8xS+yKeESe++Tsjc35qcTeEtAZ/RXo1LCMnsP9JApy+L/XS996wQ8EoGq
   8Rzgik4QxskSQLF7aMf8fYENXW0GjN0+7RzUEPWli5GTpul0UCSdK9Dc2
   p7Q0IOibXnezMm0AqRrurGCMQ7NPfshvCms9YdvCY8hHpur5LbeA3vAXr
   w==;
X-CSE-ConnectionGUID: dYouk8QFSJuNWfgpZnhA9g==
X-CSE-MsgGUID: aWHl9PpKTXSiZUdEnGhFPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12391407"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="12391407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 14:18:14 -0700
X-CSE-ConnectionGUID: Rd3jNdoHR+SCh4DnKDKHtg==
X-CSE-MsgGUID: lLMNmTPWQF2iBWCW8ZK2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="32355541"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2024 14:18:12 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8nuz-0004BS-2V;
	Sun, 19 May 2024 21:18:09 +0000
Date: Mon, 20 May 2024 05:18:00 +0800
From: kernel test robot <lkp@intel.com>
To: egyszeregy@freemail.hu, broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Benjamin =?utf-8?B?U3rFkWtl?= <egyszeregy@freemail.hu>
Subject: Re: [PATCH] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <202405200442.ydsaBrDZ-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240520/202405200442.ydsaBrDZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200442.ydsaBrDZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200442.ydsaBrDZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spidev.c: In function 'spidev_probe':
>> drivers/spi/spidev.c:812:45: error: incompatible type for argument 1 of 'device_create'
     812 |                         dev = device_create(spidev_class, &spi->dev, spidev->devt,
         |                                             ^~~~~~~~~~~~
         |                                             |
         |                                             struct class
   In file included from drivers/spi/spidev.c:13:
   include/linux/device.h:1175:35: note: expected 'const struct class *' but argument is of type 'struct class'
    1175 | device_create(const struct class *cls, struct device *parent, dev_t devt,
         |               ~~~~~~~~~~~~~~~~~~~~^~~
   drivers/spi/spidev.c:816:45: error: incompatible type for argument 1 of 'device_create'
     816 |                         dev = device_create(spidev_class, &spi->dev, spidev->devt,
         |                                             ^~~~~~~~~~~~
         |                                             |
         |                                             struct class
   include/linux/device.h:1175:35: note: expected 'const struct class *' but argument is of type 'struct class'
    1175 | device_create(const struct class *cls, struct device *parent, dev_t devt,
         |               ~~~~~~~~~~~~~~~~~~~~^~~


vim +/device_create +812 drivers/spi/spidev.c

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

