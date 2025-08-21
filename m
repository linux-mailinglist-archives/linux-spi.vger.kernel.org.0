Return-Path: <linux-spi+bounces-9569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A8B2EB26
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 04:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A61C287BC
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB023E334;
	Thu, 21 Aug 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRzMV5FV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF623BD0F;
	Thu, 21 Aug 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755742966; cv=none; b=Gx0CA1EagEm//VS7L6AGryXBt+Zq15FJQTI2I7iEiWD2KTEAmKAqgxzuRP9Uc44lgnrqQGXN2pRdp9AWPYtm2Qcj7ZKST5CCxA1mvJL9gXM00IiJgaUEx02y8p9BP18qlrrMz+xgCy4ItaYKnZm97Kbll4vbnHrr7XnfFRcLLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755742966; c=relaxed/simple;
	bh=uy3s5KuQl2CRGkvYWxUUIoDsD3XKo8NzwvJ3oGQXudo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMnxlneUJgmj3YgLcfSCWAmv2qgHA1OtiDwF6HoElC8lFLTkW9vutb1LDjpshxj9lqtTMcpHq5hlC3wW1LTQ9wCqPbSZGj9M6n7OQ/QhtcP/salv8rWBKR8V7GprFucWjY5LGy6w8Mnz/smMAGsZ+U+AwRNOpjbr+gOKHLqjd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRzMV5FV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755742965; x=1787278965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uy3s5KuQl2CRGkvYWxUUIoDsD3XKo8NzwvJ3oGQXudo=;
  b=aRzMV5FVHZFq54OpTGsCbyufL91/qRTjjtHaZ80VQH+wH02Kxdw/39My
   fq/UvzWD4eblVchVlH8hbufXfIRK3XbZRagDIx3/5Uoqz26RTU2lF+Es/
   /c+Ewbl1IymTii8mHcpMTKm0dF39rXD+aEJY1JJm2nytR0YgZuIAxtGGA
   tAFrGO4F5dBZQy2k3fIDgtF9HCna7pc2yrTNi7WnD4NYr2aQpFj1CkP8D
   7j4flSlgJeusxePmjk1SYBuqWiZrvVdH3wMi8SQ2eEMwl8/PoSr6qGhHT
   rsXVaBbgbzuN3cmdxHDEMcY9mWqEje2iF3ISsPqL1LavoMWaNAlM9oODR
   w==;
X-CSE-ConnectionGUID: IrKqjMLrT+SjBc6nOeCoxg==
X-CSE-MsgGUID: syorwwsSTwOhy1cq9ISYDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60649577"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60649577"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 19:22:44 -0700
X-CSE-ConnectionGUID: UW+oQu99SU6U/fvB/Xz6mw==
X-CSE-MsgGUID: +4lHtu5+RB+tu5lWBtAVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172706776"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2025 19:22:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uouwb-000Jqx-1Q;
	Thu, 21 Aug 2025 02:22:30 +0000
Date: Thu, 21 Aug 2025 10:22:13 +0800
From: kernel test robot <lkp@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, andriy.shevchenko@intel.com,
	harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 3/3] SPI: Add virtio SPI driver
Message-ID: <202508211051.cuOjaH00-lkp@intel.com>
References: <20250820084944.84505-4-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820084944.84505-4-quic_haixcui@quicinc.com>

Hi Haixu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.17-rc2 next-20250820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haixu-Cui/virtio-Add-ID-for-virtio-SPI/20250820-165441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250820084944.84505-4-quic_haixcui%40quicinc.com
patch subject: [PATCH v4 3/3] SPI: Add virtio SPI driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250821/202508211051.cuOjaH00-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508211051.cuOjaH00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508211051.cuOjaH00-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-virtio.c:373:45: warning: cast from 'void (*)(struct virtio_device *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
     373 |         err = devm_add_action_or_reset(&vdev->dev, (void (*)(void *))virtio_spi_del_vq, vdev);
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/devres.h:166:34: note: expanded from macro 'devm_add_action_or_reset'
     166 |         __devm_add_action_or_reset(dev, action, data, #action)
         |                                         ^~~~~~
   1 warning generated.


vim +373 drivers/spi/spi-virtio.c

   333	
   334	static int virtio_spi_probe(struct virtio_device *vdev)
   335	{
   336		struct virtio_spi_priv *priv;
   337		struct spi_controller *ctrl;
   338		int err;
   339		u32 bus_num;
   340	
   341		ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
   342		if (!ctrl)
   343			return -ENOMEM;
   344	
   345		priv = spi_controller_get_devdata(ctrl);
   346		priv->vdev = vdev;
   347		vdev->priv = priv;
   348	
   349		device_set_node(&ctrl->dev, dev_fwnode(&vdev->dev));
   350	
   351		/* Setup ACPI node for controlled devices which will be probed through ACPI. */
   352		ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
   353	
   354		dev_set_drvdata(&vdev->dev, ctrl);
   355	
   356		err = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);
   357		if (!err && bus_num <= S16_MAX)
   358			ctrl->bus_num = bus_num;
   359		else
   360			ctrl->bus_num = -1;
   361	
   362		virtio_spi_read_config(vdev);
   363	
   364		ctrl->transfer_one = virtio_spi_transfer_one;
   365	
   366		err = virtio_spi_find_vqs(priv);
   367		if (err) {
   368			dev_err_probe(&vdev->dev, err, "Cannot setup virtqueues\n");
   369			return err;
   370		}
   371	
   372		/* Register cleanup for virtqueues using devm */
 > 373		err = devm_add_action_or_reset(&vdev->dev, (void (*)(void *))virtio_spi_del_vq, vdev);
   374		if (err) {
   375			dev_err_probe(&vdev->dev, err, "Cannot register virtqueue cleanup\n");
   376			return err;
   377		}
   378	
   379		/* Use devm version to register controller */
   380		err = devm_spi_register_controller(&vdev->dev, ctrl);
   381		if (err) {
   382			dev_err_probe(&vdev->dev, err, "Cannot register controller\n");
   383			return err;
   384		}
   385	
   386		return 0;
   387	}
   388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

