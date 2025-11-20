Return-Path: <linux-spi+bounces-11377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCFEC731BE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40BF54E0704
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F408F31354F;
	Thu, 20 Nov 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwJ6ZoT1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E66311C3D;
	Thu, 20 Nov 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630695; cv=none; b=ORW0axhmJx6rxPFQ8J/x1+Kj8sfErvRkGEw5X7C2QOj96Gr95eH7USX/WdxlLptMb9dJ6QU6fW+TxHjs+b1VDwXgjWQzj86ezXZ1ZBw8DxA0/YnR0gYtdcganZjW5N9tacVeGeZT/0DfEn1A6AE+C6Za+2o/tKj+oh5H18IiZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630695; c=relaxed/simple;
	bh=hBip2WThVzY9ZVddt1AB48ogRCRjAU01XxhHR3z75Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqX56JfxERPW3zy1zacKfyQTx5Pq38zs5nHhzcZihS8+Hbzf7PB+7pAtCoU8QkxnSkwDsf81PeHn41b4kp1v6qgrVpWy5j0YpN8E+NtoztFq9GBV6Q8JoFzyhR8gofIjyyT8RcGRvbnRMT9i8GfBeJquBhO+mImysZnNEaybtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwJ6ZoT1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763630694; x=1795166694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBip2WThVzY9ZVddt1AB48ogRCRjAU01XxhHR3z75Xk=;
  b=jwJ6ZoT10BzNtSWP1n/p+pdpxTyyD2QVn2sml4fjUnxUMsveoPq4oD5t
   cYE2UNOipIDPHx/eeSAUePDEGjo6d2MCbz/BYH1sZm1QaUB4vhShZvG64
   b2pwOmKcmUmrdw2LXWZ+UtgKWM/oWhjk7r8iYjPZxDlC9zirXC/dWcprA
   Y3+5QXjD9/Px2/fBB2htyLB/XZrzG/D/xB1wkTN1TfgBuJzfQatE8NFd0
   kyOIgE3n+z6mdGszQjdrxvIyhEYwtHRE4GkHqsLjjjYysJPigSkLU6mBD
   ErLktG7mPx7JsnhWBKqFP+zmtz9X2Gflyo2fvx1ZMvMlV/cALnNAxFx2V
   Q==;
X-CSE-ConnectionGUID: U377B5+OT7yF1AnAwk1VMQ==
X-CSE-MsgGUID: 5O8gOO2VT8O0k5hvAWh48g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572019"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65572019"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:24:51 -0800
X-CSE-ConnectionGUID: fv8DjrxqRvyVtIOryl+vkg==
X-CSE-MsgGUID: eqfMzdkyS3+2nnT05TLHHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="221957866"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2025 01:24:49 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM0uD-0003oH-2u;
	Thu, 20 Nov 2025 09:24:45 +0000
Date: Thu, 20 Nov 2025 17:23:56 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
	brgl@bgdev.pl, linus.walleij@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org, p.zabel@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <202511201700.S7ieteHi-lkp@intel.com>
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Keepax/spi-cs42l43-Use-actual-ACPI-firmware-node-for-chip-selects/20251120-005808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20251119164017.1115791-1-ckeepax%40opensource.cirrus.com
patch subject: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip selects
config: sparc-randconfig-6002-20251120 (https://download.01.org/0day-ci/archive/20251120/202511201700.S7ieteHi-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201700.S7ieteHi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201700.S7ieteHi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-cs42l43.c: In function 'cs42l43_spi_probe':
>> drivers/spi/spi-cs42l43.c:410:25: error: 'struct software_node_ref_args' has no member named 'fwnode'; did you mean 'node'?
     410 |                 args[0].fwnode = fwnode;
         |                         ^~~~~~
         |                         node


vim +410 drivers/spi/spi-cs42l43.c

   322	
   323	static int cs42l43_spi_probe(struct platform_device *pdev)
   324	{
   325		struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
   326		struct cs42l43_spi *priv;
   327		struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
   328		struct fwnode_handle *xu_fwnode __free(fwnode_handle) = cs42l43_find_xu_node(fwnode);
   329		int nsidecars = 0;
   330		int spkid = -EINVAL;
   331		int ret;
   332	
   333		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
   334		if (!priv)
   335			return -ENOMEM;
   336	
   337		priv->ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*priv->ctlr));
   338		if (!priv->ctlr)
   339			return -ENOMEM;
   340	
   341		spi_controller_set_devdata(priv->ctlr, priv);
   342	
   343		priv->dev = &pdev->dev;
   344		priv->regmap = cs42l43->regmap;
   345	
   346		priv->ctlr->prepare_message = cs42l43_prepare_message;
   347		priv->ctlr->prepare_transfer_hardware = cs42l43_prepare_transfer_hardware;
   348		priv->ctlr->unprepare_transfer_hardware = cs42l43_unprepare_transfer_hardware;
   349		priv->ctlr->transfer_one = cs42l43_transfer_one;
   350		priv->ctlr->set_cs = cs42l43_set_cs;
   351		priv->ctlr->max_transfer_size = cs42l43_spi_max_length;
   352		priv->ctlr->mode_bits = SPI_3WIRE | SPI_MODE_X_MASK;
   353		priv->ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
   354		priv->ctlr->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
   355						 SPI_BPW_MASK(32);
   356		priv->ctlr->min_speed_hz = CS42L43_SPI_ROOT_HZ /
   357					   cs42l43_clock_divs[ARRAY_SIZE(cs42l43_clock_divs) - 1];
   358		priv->ctlr->max_speed_hz = CS42L43_SPI_ROOT_HZ / cs42l43_clock_divs[0];
   359		priv->ctlr->use_gpio_descriptors = true;
   360		priv->ctlr->auto_runtime_pm = true;
   361	
   362		ret = devm_pm_runtime_enable(priv->dev);
   363		if (ret)
   364			return ret;
   365	
   366		pm_runtime_idle(priv->dev);
   367	
   368		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
   369		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG7, CS42L43_FIFO_SIZE - 1);
   370	
   371		// Disable Watchdog timer and enable stall
   372		regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
   373		regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
   374	
   375		if (is_of_node(fwnode)) {
   376			fwnode = fwnode_get_named_child_node(fwnode, "spi");
   377			ret = devm_add_action_or_reset(priv->dev, cs42l43_release_of_node, fwnode);
   378			if (ret)
   379				return ret;
   380		}
   381	
   382		fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
   383	
   384		if (nsidecars) {
   385			struct software_node_ref_args *args;
   386			struct property_entry *props;
   387	
   388			ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
   389			if (!ret) {
   390				dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
   391			} else if (ret != -EINVAL) {
   392				return dev_err_probe(priv->dev, ret, "Failed to get spk-id-val\n");
   393			} else {
   394				ret = cs42l43_get_speaker_id_gpios(priv, &spkid);
   395				if (ret < 0)
   396					return dev_err_probe(priv->dev, ret,
   397							     "Failed to get spk-id-gpios\n");
   398			}
   399	
   400			props = devm_kmemdup(priv->dev, cs42l43_cs_props, sizeof(cs42l43_cs_props),
   401					     GFP_KERNEL);
   402			if (!props)
   403				return -ENOMEM;
   404	
   405			args = devm_kmemdup(priv->dev, cs42l43_cs_refs, sizeof(cs42l43_cs_refs),
   406					    GFP_KERNEL);
   407			if (!args)
   408				return -ENOMEM;
   409	
 > 410			args[0].fwnode = fwnode;
   411			props->pointer = args;
   412	
   413			ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
   414			if (ret)
   415				return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
   416		} else {
   417			device_set_node(&priv->ctlr->dev, fwnode);
   418		}
   419	
   420		ret = devm_spi_register_controller(priv->dev, priv->ctlr);
   421		if (ret)
   422			return dev_err_probe(priv->dev, ret,
   423					     "Failed to register SPI controller\n");
   424	
   425		if (nsidecars) {
   426			struct spi_board_info *ampl_info;
   427			struct spi_board_info *ampr_info;
   428	
   429			ampl_info = cs42l43_create_bridge_amp(priv, "cs35l56-left", 0, spkid);
   430			if (!ampl_info)
   431				return -ENOMEM;
   432	
   433			ampr_info = cs42l43_create_bridge_amp(priv, "cs35l56-right", 1, spkid);
   434			if (!ampr_info)
   435				return -ENOMEM;
   436	
   437			if (!spi_new_device(priv->ctlr, ampl_info))
   438				return dev_err_probe(priv->dev, -ENODEV,
   439						     "Failed to create left amp slave\n");
   440	
   441			if (!spi_new_device(priv->ctlr, ampr_info))
   442				return dev_err_probe(priv->dev, -ENODEV,
   443						     "Failed to create right amp slave\n");
   444		}
   445	
   446		return 0;
   447	}
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

