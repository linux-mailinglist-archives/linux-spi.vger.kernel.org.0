Return-Path: <linux-spi+bounces-2430-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1698A9931
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B9D284D18
	for <lists+linux-spi@lfdr.de>; Thu, 18 Apr 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A815E7F1;
	Thu, 18 Apr 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWQaCZl7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA715E814;
	Thu, 18 Apr 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441478; cv=none; b=cfglEGm8EeR9JazLxjRNKKqcZUZZ4chVQFwiQScak7NuRRrCJbZoonngVVH4wRSl+Msy1WtRrw1+o2zP3L4R3PxJRnizIYsT2PajU/qZUzB5J5pSseEeP/Rd4Pfcfu9XWfNGmvuiGP4HwPjNAlv+weyP9EuVO0IVQ+rfS2jAVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441478; c=relaxed/simple;
	bh=EJ+eUdeeBCXzftAQJU57/zkUCCLUBsA/k3v4mshrZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9CimmH74Lufgn9byze31TpxJWBsGbLXY8nIfQBD/tqHNvguxyBrEVCSJAuSd2zUkldRZscK3ipxrYAWJR0N6pOfbfD4HlybrBVr+nFk2er+gRdP2HAfkRIsI9bWYeIMPzXsFUQXHNlqoi3BsFKs8BmJX6zLW1PgjJaMdCeztjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWQaCZl7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713441476; x=1744977476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJ+eUdeeBCXzftAQJU57/zkUCCLUBsA/k3v4mshrZgA=;
  b=lWQaCZl7iycAWX5vCf4g9mXIMsQTdBwlcGin9oD5BlrUf5Wud1J+P0BR
   70sj8ajQxoO2p/0c9vbAJ8ExKwESMiU3ut/nXa/8DQ3SjzZ4JYm8uGA7A
   adfi7JPU5WLK1E0T81TnP3YcFfEVv7IWptPcGHe5CcQcp6s3lENIbGto4
   fsEgqF66vv2DndFcceHyMDKRXyKj5DqREOnTBUGybTE6xbX/oSz/l+8tP
   7BfIkWLIavL+xB7f81Hp2Gzf0tW5syY5I5Li481W0Yuzu59nDk3j0n7dT
   LfDurFJ0JCZcDZCtArIxY4icrgGMYKAM4VtotLtfsgD8q0UigHPGJ0Fe/
   A==;
X-CSE-ConnectionGUID: s3DpWTKgSDmIb2JsEnKfVA==
X-CSE-MsgGUID: 7TT2d7j7T7SJ2A4obqFeQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12767279"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12767279"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:57:52 -0700
X-CSE-ConnectionGUID: gOdMdSlySyqCFwAcsFuv1w==
X-CSE-MsgGUID: DntNxO6tSPCCloBUxJgvLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27774216"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 18 Apr 2024 04:57:47 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxQOf-0007Zx-0T;
	Thu, 18 Apr 2024 11:57:45 +0000
Date: Thu, 18 Apr 2024 19:57:35 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <202404181933.AfPnhmy7-lkp@intel.com>
References: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240416]
[cannot apply to broonie-spi/for-next robh/for-next arm/for-next arm/fixes arm64/for-next/core kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.9-rc4 v6.9-rc3 v6.9-rc2 v6.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-spi-airoha-Add-YAML-schema-for-SNFI-controller/20240417-144847
base:   next-20240416
patch link:    https://lore.kernel.org/r/25dd4334e3b37eaa628c20265841f251968c2b75.1713335916.git.lorenzo%40kernel.org
patch subject: [PATCH v2 3/3] spi: airoha: add SPI-NAND Flash controller driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240418/202404181933.AfPnhmy7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181933.AfPnhmy7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181933.AfPnhmy7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-airoha-snfi.c: In function 'airoha_snand_set_fifo_op':
>> drivers/spi/spi-airoha-snfi.c:233:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     233 |                            FIELD_PREP(SPI_CTRL_OPFIFO_LEN, op_len) |
         |                            ^~~~~~~~~~
   drivers/spi/spi-airoha-snfi.c: In function 'airoha_snand_read_data_from_fifo':
>> drivers/spi/spi-airoha-snfi.c:320:26: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     320 |                 ptr[i] = FIELD_GET(SPI_CTRL_DFIFO_RDATA, val);
         |                          ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +233 drivers/spi/spi-airoha-snfi.c

   225	
   226	static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
   227					    u8 op_cmd, int op_len)
   228	{
   229		int err;
   230		u32 val;
   231	
   232		err = regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WDATA,
 > 233				   FIELD_PREP(SPI_CTRL_OPFIFO_LEN, op_len) |
   234				   FIELD_PREP(SPI_CTRL_OPFIFO_OP, op_cmd));
   235		if (err)
   236			return err;
   237	
   238		err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   239					       REG_SPI_CTRL_OPFIFO_FULL,
   240					       val, !(val & SPI_CTRL_OPFIFO_FULL),
   241					       0, 250 * USEC_PER_MSEC);
   242		if (err)
   243			return err;
   244	
   245		err = regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_OPFIFO_WR,
   246				   SPI_CTRL_OPFIFO_WR);
   247		if (err)
   248			return err;
   249	
   250		return regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   251						REG_SPI_CTRL_OPFIFO_EMPTY,
   252						val, (val & SPI_CTRL_OPFIFO_EMPTY),
   253						0, 250 * USEC_PER_MSEC);
   254	}
   255	
   256	static int airoha_snand_set_cs(struct airoha_snand_ctrl *as_ctrl, u8 cs)
   257	{
   258		return airoha_snand_set_fifo_op(as_ctrl, cs, sizeof(cs));
   259	}
   260	
   261	static int airoha_snand_write_data_to_fifo(struct airoha_snand_ctrl *as_ctrl,
   262						   const u8 *data, int len)
   263	{
   264		int i;
   265	
   266		for (i = 0; i < len; i++) {
   267			int err;
   268			u32 val;
   269	
   270			/* 1. Wait until dfifo is not full */
   271			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   272						       REG_SPI_CTRL_DFIFO_FULL, val,
   273						       !(val & SPI_CTRL_DFIFO_FULL),
   274						       0, 250 * USEC_PER_MSEC);
   275			if (err)
   276				return err;
   277	
   278			/* 2. Write data to register DFIFO_WDATA */
   279			err = regmap_write(as_ctrl->regmap_ctrl,
   280					   REG_SPI_CTRL_DFIFO_WDATA,
   281					   FIELD_PREP(SPI_CTRL_DFIFO_WDATA, data[i]));
   282			if (err)
   283				return err;
   284	
   285			/* 3. Wait until dfifo is not full */
   286			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   287						       REG_SPI_CTRL_DFIFO_FULL, val,
   288						       !(val & SPI_CTRL_DFIFO_FULL),
   289						       0, 250 * USEC_PER_MSEC);
   290			if (err)
   291				return err;
   292		}
   293	
   294		return 0;
   295	}
   296	
   297	static int airoha_snand_read_data_from_fifo(struct airoha_snand_ctrl *as_ctrl,
   298						    u8 *ptr, int len)
   299	{
   300		int i;
   301	
   302		for (i = 0; i < len; i++) {
   303			int err;
   304			u32 val;
   305	
   306			/* 1. wait until dfifo is not empty */
   307			err = regmap_read_poll_timeout(as_ctrl->regmap_ctrl,
   308						       REG_SPI_CTRL_DFIFO_EMPTY, val,
   309						       !(val & SPI_CTRL_DFIFO_EMPTY),
   310						       0, 250 * USEC_PER_MSEC);
   311			if (err)
   312				return err;
   313	
   314			/* 2. read from dfifo to register DFIFO_RDATA */
   315			err = regmap_read(as_ctrl->regmap_ctrl,
   316					  REG_SPI_CTRL_DFIFO_RDATA, &val);
   317			if (err)
   318				return err;
   319	
 > 320			ptr[i] = FIELD_GET(SPI_CTRL_DFIFO_RDATA, val);
   321			/* 3. enable register DFIFO_RD to read next byte */
   322			err = regmap_write(as_ctrl->regmap_ctrl,
   323					   REG_SPI_CTRL_DFIFO_RD, SPI_CTRL_DFIFO_RD);
   324			if (err)
   325				return err;
   326		}
   327	
   328		return 0;
   329	}
   330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

