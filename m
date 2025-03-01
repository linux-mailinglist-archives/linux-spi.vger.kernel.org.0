Return-Path: <linux-spi+bounces-6978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C0A4A9CF
	for <lists+linux-spi@lfdr.de>; Sat,  1 Mar 2025 09:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20AA16F200
	for <lists+linux-spi@lfdr.de>; Sat,  1 Mar 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499781CBEB9;
	Sat,  1 Mar 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiD2yQP4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478D1C5F08;
	Sat,  1 Mar 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740818222; cv=none; b=qwWe5gqi83ZN0UxqgPRlUtQSWD4OtCw58Es77p9+nw8sUI496U6SUO/15Jq8iP5tr9Ff9Kos4O5LKIR9gB147yTVyEbWPj+ATcKuZQLx33GtYQ4pWoG1cyYFG6B8FP4WTdm79x9kRMMIBl6rsacQzeyrUvbkAg/+afWed0c+Kx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740818222; c=relaxed/simple;
	bh=ILiRyf+7LGFCo6GR2fvwMOED+UnCtYqI6Fm7BMRzSQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqkAgEVcYvWLfCIUKjt5vj5WOnWnv37btqVYw074/IC2XXW4nHLZOHyN84it1H5dry0w1qInfbXGw6hqxoqXbDBQ+FeCEBxXrLireuDtR/s96aanpdecnggICm1eg7Rskt+QjTZYSbc6kOqUMrGaXJy3uYygqmHUWWyBjxFtiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiD2yQP4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740818220; x=1772354220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILiRyf+7LGFCo6GR2fvwMOED+UnCtYqI6Fm7BMRzSQ0=;
  b=BiD2yQP4hUZTLZSFhAnB4j0vIdNtvMfDaF9jdejvt3eNnFVbqenp5a6T
   gxVabXNDXssVUZW0E7Ni8WCMKyWLBOWYhWVu/9uNgHCRl9hm9OGg+JiKD
   JiVXnVByRFP7fbMq4sAker7b46ldjXRNyw9L77bSuPCMzobHJlZB652Qc
   Fz0gr6voSGhJKLC751bmtrDUaV1zty054NkLfBrNpLl1ijNrnI5Wc8oSd
   gEQZzTmzcAprLKmyULp639C24b9nXzVX8b7qbAmIFuFw4BoJeqgURyDx4
   nwO4zoJJt3Xa0mgc9SMXFr2yZbkq9+L3ZQcoF1mekjcfmUuZoBVkTMGEw
   g==;
X-CSE-ConnectionGUID: NYGFvdvURTy/eXKvENeKXA==
X-CSE-MsgGUID: 3fSPUHUgQi6HpdYB+edPkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41632186"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="41632186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 00:36:59 -0800
X-CSE-ConnectionGUID: lW8G4db8QjWNavqxlTHDNg==
X-CSE-MsgGUID: 48i6mZFCSCmI1LJ6hl7Sqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148458821"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2025 00:36:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toIL8-000G3C-2o;
	Sat, 01 Mar 2025 08:36:54 +0000
Date: Sat, 1 Mar 2025 16:36:51 +0800
From: kernel test robot <lkp@intel.com>
To: Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Leilk Liu <leilk.liu@mediatek.com>
Subject: Re: [PATCH v1] spi: mt65xx: add PM QoS support
Message-ID: <202503011637.9HYajsft-lkp@intel.com>
References: <20250228062246.24186-1-leilk.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228062246.24186-1-leilk.liu@mediatek.com>

Hi Leilk,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leilk-Liu/spi-mt65xx-add-PM-QoS-support/20250228-142359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20250228062246.24186-1-leilk.liu%40mediatek.com
patch subject: [PATCH v1] spi: mt65xx: add PM QoS support
config: sh-randconfig-002-20250301 (https://download.01.org/0day-ci/archive/20250301/202503011637.9HYajsft-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503011637.9HYajsft-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503011637.9HYajsft-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mt65xx.c:177: warning: Function parameter or struct member 'qos_request' not described in 'mtk_spi'


vim +177 drivers/spi/spi-mt65xx.c

a568231f463225 Leilk Liu                  2015-08-07  132  
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  133  /**
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  134   * struct mtk_spi - SPI driver instance
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  135   * @base:		Start address of the SPI controller registers
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  136   * @state:		SPI controller state
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  137   * @pad_num:		Number of pad_sel entries
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  138   * @pad_sel:		Groups of pins to select
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  139   * @parent_clk:		Parent of sel_clk
cae1578847e60a Yang Yingliang             2023-08-23  140   * @sel_clk:		SPI host mux clock
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  141   * @spi_clk:		Peripheral clock
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  142   * @spi_hclk:		AHB bus clock
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  143   * @cur_transfer:	Currently processed SPI transfer
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  144   * @xfer_len:		Number of bytes to transfer
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  145   * @num_xfered:		Number of transferred bytes
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  146   * @tx_sgl:		TX transfer scatterlist
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  147   * @rx_sgl:		RX transfer scatterlist
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  148   * @tx_sgl_len:		Size of TX DMA transfer
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  149   * @rx_sgl_len:		Size of RX DMA transfer
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  150   * @dev_comp:		Device data structure
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  151   * @spi_clk_hz:		Current SPI clock in Hz
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  152   * @spimem_done:	SPI-MEM operation completion
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  153   * @use_spimem:		Enables SPI-MEM
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  154   * @dev:		Device pointer
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  155   * @tx_dma:		DMA start for SPI-MEM TX
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  156   * @rx_dma:		DMA start for SPI-MEM RX
3c5cd2e23fe4c8 AngeloGioacchino Del Regno 2022-04-07  157   */
a568231f463225 Leilk Liu                  2015-08-07  158  struct mtk_spi {
a568231f463225 Leilk Liu                  2015-08-07  159  	void __iomem *base;
a568231f463225 Leilk Liu                  2015-08-07  160  	u32 state;
37457607ecaffe Leilk Liu                  2015-10-26  161  	int pad_num;
37457607ecaffe Leilk Liu                  2015-10-26  162  	u32 *pad_sel;
a740f4e684c020 Leilk Liu                  2022-03-21  163  	struct clk *parent_clk, *sel_clk, *spi_clk, *spi_hclk;
a568231f463225 Leilk Liu                  2015-08-07  164  	struct spi_transfer *cur_transfer;
a568231f463225 Leilk Liu                  2015-08-07  165  	u32 xfer_len;
00bca73bfca4fb Peter Shih                 2018-09-10  166  	u32 num_xfered;
a568231f463225 Leilk Liu                  2015-08-07  167  	struct scatterlist *tx_sgl, *rx_sgl;
a568231f463225 Leilk Liu                  2015-08-07  168  	u32 tx_sgl_len, rx_sgl_len;
a568231f463225 Leilk Liu                  2015-08-07  169  	const struct mtk_spi_compatible *dev_comp;
b0677bc0b5f41e Leilk Liu                  2025-02-28  170  	struct pm_qos_request qos_request;
162a31effc4182 Mason Zhang                2021-06-29  171  	u32 spi_clk_hz;
9f763fd20da7d8 Leilk Liu                  2022-03-21  172  	struct completion spimem_done;
9f763fd20da7d8 Leilk Liu                  2022-03-21  173  	bool use_spimem;
9f763fd20da7d8 Leilk Liu                  2022-03-21  174  	struct device *dev;
9f763fd20da7d8 Leilk Liu                  2022-03-21  175  	dma_addr_t tx_dma;
9f763fd20da7d8 Leilk Liu                  2022-03-21  176  	dma_addr_t rx_dma;
a568231f463225 Leilk Liu                  2015-08-07 @177  };
a568231f463225 Leilk Liu                  2015-08-07  178  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

