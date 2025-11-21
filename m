Return-Path: <linux-spi+bounces-11448-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDAC779EC
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 07:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A30F4E84FD
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68066335070;
	Fri, 21 Nov 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBQBnlJK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC62F7455;
	Fri, 21 Nov 2025 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708080; cv=none; b=GZEWXp8TTpX1FzcjIl1cXUMZk9tMVUHqLfhUHoRHP9SX4myKMCRMpVPnrDSGEz1eKmuGrKqZG4QGXkYtWikCSzDt33zLod8533u3kFX9Pif8SrThQXVTP/KNWcMDP9g03TJqCD3m0bA3Darzb7HTyP5gm6svt+4ECZWX5PEv1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708080; c=relaxed/simple;
	bh=zhc2K7oRS/mO6PHXeWGztnbvM0S6v5GiniqITGbpgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc8u02iYGdQvmY7dGK6eYISNAUQTrBRGmhvfuhd3yLxFCZ4ZFI8Yepx7bQ88n2/Psdrvao6Xr96rEDnJUGUTGFuzg7HqRPliEFtAPwfJpCoWLC4BpHeTgufBiuFwW+qHFdJfnNNOJb998KgL6LGJEC7Ote8vQ/7R9xHjlTOw5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBQBnlJK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763708078; x=1795244078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zhc2K7oRS/mO6PHXeWGztnbvM0S6v5GiniqITGbpgT4=;
  b=iBQBnlJKg37CGzCBruk2goBOu27zhZS88sbclx0FyUv2E5wQubozHzZo
   e9/M1mogQ2x4NIKfeuOS6PUKh2nTdIrPVdXNOHmeUwMu/uQvJ01KKCx9l
   ogUHL7tFpb/hjyQySTj7LqSRjFKpCtLRVM7XRVt+4oq+g1ye2Igs51eyX
   Qk0SRtySKhPm42gfeSb9xxuMKgvJfLJpyn+yZc5D9G/eYrxcpq5Pew3yW
   zTPgyYvClyZLwLiINnTvjo18NuajkReMRhjwsA7Ph8gdYuBn4Xdu7Z51s
   cUeCM1f82wLqQpOwg9DaivKVI5LOdkleLod8Gt+vWJh1CFBDWSdcYhOma
   w==;
X-CSE-ConnectionGUID: IyzfxGCwTV+y33J8DExZtg==
X-CSE-MsgGUID: wwSLHTVYQ4qnp3ctL446xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65832332"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="65832332"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 22:54:25 -0800
X-CSE-ConnectionGUID: uBBO4Ia3TY+4zSKWO/WVFQ==
X-CSE-MsgGUID: ozDdD66JQBeGhBEkLkzyEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="228912738"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Nov 2025 22:54:21 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vML2B-00053f-0i;
	Fri, 21 Nov 2025 06:54:19 +0000
Date: Fri, 21 Nov 2025 14:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
	brgl@bgdev.pl, linus.walleij@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org, p.zabel@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <202511211445.OQ2X71Jh-lkp@intel.com>
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.18-rc6 next-20251120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Keepax/spi-cs42l43-Use-actual-ACPI-firmware-node-for-chip-selects/20251120-190613
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20251120105907.1373797-1-ckeepax%40opensource.cirrus.com
patch subject: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip selects
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251121/202511211445.OQ2X71Jh-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211445.OQ2X71Jh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511211445.OQ2X71Jh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/acpi.h:16,
                    from drivers/spi/spi-cs42l43.c:8:
   drivers/spi/spi-cs42l43.c: In function 'cs42l43_spi_probe':
>> drivers/spi/spi-cs42l43.c:376:49: error: initialization of 'const struct software_node *' from incompatible pointer type 'struct fwnode_handle *' [-Werror=incompatible-pointer-types]
     376 |                         SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
         |                                                 ^~~~~~
   include/linux/property.h:370:17: note: in definition of macro 'SOFTWARE_NODE_REFERENCE'
     370 |         .node = _ref_,                                          \
         |                 ^~~~~
   drivers/spi/spi-cs42l43.c:376:49: note: (near initialization for '(anonymous).node')
     376 |                         SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
         |                                                 ^~~~~~
   include/linux/property.h:370:17: note: in definition of macro 'SOFTWARE_NODE_REFERENCE'
     370 |         .node = _ref_,                                          \
         |                 ^~~~~
   cc1: some warnings being treated as errors


vim +376 drivers/spi/spi-cs42l43.c

   312	
   313	static int cs42l43_spi_probe(struct platform_device *pdev)
   314	{
   315		struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
   316		struct cs42l43_spi *priv;
   317		struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
   318		struct fwnode_handle *xu_fwnode __free(fwnode_handle) = cs42l43_find_xu_node(fwnode);
   319		int nsidecars = 0;
   320		int spkid = -EINVAL;
   321		int ret;
   322	
   323		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
   324		if (!priv)
   325			return -ENOMEM;
   326	
   327		priv->ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*priv->ctlr));
   328		if (!priv->ctlr)
   329			return -ENOMEM;
   330	
   331		spi_controller_set_devdata(priv->ctlr, priv);
   332	
   333		priv->dev = &pdev->dev;
   334		priv->regmap = cs42l43->regmap;
   335	
   336		priv->ctlr->prepare_message = cs42l43_prepare_message;
   337		priv->ctlr->prepare_transfer_hardware = cs42l43_prepare_transfer_hardware;
   338		priv->ctlr->unprepare_transfer_hardware = cs42l43_unprepare_transfer_hardware;
   339		priv->ctlr->transfer_one = cs42l43_transfer_one;
   340		priv->ctlr->set_cs = cs42l43_set_cs;
   341		priv->ctlr->max_transfer_size = cs42l43_spi_max_length;
   342		priv->ctlr->mode_bits = SPI_3WIRE | SPI_MODE_X_MASK;
   343		priv->ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
   344		priv->ctlr->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
   345						 SPI_BPW_MASK(32);
   346		priv->ctlr->min_speed_hz = CS42L43_SPI_ROOT_HZ /
   347					   cs42l43_clock_divs[ARRAY_SIZE(cs42l43_clock_divs) - 1];
   348		priv->ctlr->max_speed_hz = CS42L43_SPI_ROOT_HZ / cs42l43_clock_divs[0];
   349		priv->ctlr->use_gpio_descriptors = true;
   350		priv->ctlr->auto_runtime_pm = true;
   351	
   352		ret = devm_pm_runtime_enable(priv->dev);
   353		if (ret)
   354			return ret;
   355	
   356		pm_runtime_idle(priv->dev);
   357	
   358		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
   359		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG7, CS42L43_FIFO_SIZE - 1);
   360	
   361		// Disable Watchdog timer and enable stall
   362		regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
   363		regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
   364	
   365		if (is_of_node(fwnode)) {
   366			fwnode = fwnode_get_named_child_node(fwnode, "spi");
   367			ret = devm_add_action_or_reset(priv->dev, cs42l43_release_of_node, fwnode);
   368			if (ret)
   369				return ret;
   370		}
   371	
   372		fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
   373	
   374		if (nsidecars) {
   375			struct software_node_ref_args args[] = {
 > 376				SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
   377				SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
   378			};
   379			struct property_entry props[] = {
   380				PROPERTY_ENTRY_REF_ARRAY_LEN("cs-gpios", args, ARRAY_SIZE(args)),
   381				{ }
   382			};
   383	
   384			ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
   385			if (!ret) {
   386				dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
   387			} else if (ret != -EINVAL) {
   388				return dev_err_probe(priv->dev, ret, "Failed to get spk-id-val\n");
   389			} else {
   390				ret = cs42l43_get_speaker_id_gpios(priv, &spkid);
   391				if (ret < 0)
   392					return dev_err_probe(priv->dev, ret,
   393							     "Failed to get spk-id-gpios\n");
   394			}
   395	
   396			ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
   397			if (ret)
   398				return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
   399		} else {
   400			device_set_node(&priv->ctlr->dev, fwnode);
   401		}
   402	
   403		ret = devm_spi_register_controller(priv->dev, priv->ctlr);
   404		if (ret)
   405			return dev_err_probe(priv->dev, ret,
   406					     "Failed to register SPI controller\n");
   407	
   408		if (nsidecars) {
   409			struct spi_board_info *ampl_info;
   410			struct spi_board_info *ampr_info;
   411	
   412			ampl_info = cs42l43_create_bridge_amp(priv, "cs35l56-left", 0, spkid);
   413			if (!ampl_info)
   414				return -ENOMEM;
   415	
   416			ampr_info = cs42l43_create_bridge_amp(priv, "cs35l56-right", 1, spkid);
   417			if (!ampr_info)
   418				return -ENOMEM;
   419	
   420			if (!spi_new_device(priv->ctlr, ampl_info))
   421				return dev_err_probe(priv->dev, -ENODEV,
   422						     "Failed to create left amp slave\n");
   423	
   424			if (!spi_new_device(priv->ctlr, ampr_info))
   425				return dev_err_probe(priv->dev, -ENODEV,
   426						     "Failed to create right amp slave\n");
   427		}
   428	
   429		return 0;
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

