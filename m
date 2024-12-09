Return-Path: <linux-spi+bounces-5969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006D9E8A8E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 05:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1779F280E5E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2024 04:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8398192B94;
	Mon,  9 Dec 2024 04:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIjBKCFm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345218A6B2;
	Mon,  9 Dec 2024 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720207; cv=none; b=TBS3KJ7qClsXMjH65wS/OWiOF5bw1jTlhnALLe+NiGFhV5H21J+LNnaFvaXsB10pN8vub5jgSRBSL2V1z58cazL/YaDw0QUzZGy5JXg4CgkL5YqG+76PhrHJlXzvzrAKOw7VaI/pHMdWYF6gizfZ7V89lvVMPtUWJXqSJwnRN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720207; c=relaxed/simple;
	bh=smdcXM4XVtdVmpcZSTAjc1CdeXynkh1TZG7WKdPEg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGdJmsAwfxDWpPUPaf6IKS3Z/yXGDeBrFWApwygalThxv4qKQQPIJLt01caxt3oaoCuGVYXuQkDHgtgXB7mckbNSrQULYHWGjaygezx0D5JpPsb+RPd++YzlPDozA/+fnxx+5DciINzETVCo4C2cIGTZizSlj2FWOww+E+OZr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIjBKCFm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720206; x=1765256206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smdcXM4XVtdVmpcZSTAjc1CdeXynkh1TZG7WKdPEg8s=;
  b=HIjBKCFmx9lym2ZFWJR+RpWSKsEfSVrJwfWtZiSFVdkFsASyqcLwuFS0
   Moo0PgkMnczaElODSeF+CSM68bepf7Oxan8dJRxIimp98OPSjspb2vlvx
   RXSHk0mfcsIg7RZGOGk7Gs8ill+xdfxJX77VQKEDVzVq8uB4ujdiNjL4R
   M9B3TozSD4fTIfuahHUxGj1kpNa4nGPRSC7hU/nTmkF7AxIoI1YL7C//v
   k29YqJZofo+iImup9NrU7WJJIRPStwLPlizhjQeexqpsCBGqBBaSeob5W
   XCBpSW8ycwoBlvyFcoB7ijY6UqGRKVv4kLsYDxrIc1N62C/blANjAKP1w
   A==;
X-CSE-ConnectionGUID: E5aDLAJEQ7eLFsJcBUGgaw==
X-CSE-MsgGUID: q9UHex9bRsyyNEliKMqjsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="56484906"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="56484906"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:56:46 -0800
X-CSE-ConnectionGUID: xqrC+jWTR8WGbuYoi0Oumw==
X-CSE-MsgGUID: Qobg1aSASgK3QKz6Ym49nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100015159"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 20:56:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVp0-0003wb-0u;
	Mon, 09 Dec 2024 04:56:38 +0000
Date: Mon, 9 Dec 2024 12:55:43 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de
Cc: oe-kbuild-all@lists.linux.dev, dharma.b@microchip.com,
	mihai.sain@microchip.com, romain.sioen@microchip.com,
	varshini.rajendran@microchip.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 11/13] ARM: dts: microchip: add support for
 sama7d65_curiosity board
Message-ID: <202412090708.BNX0mUZi-lkp@intel.com>
References: <e47d8c8cdaec834ce080ef8c34b9976228223c8f.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e47d8c8cdaec834ce080ef8c34b9976228223c8f.1733505542.git.Ryan.Wanner@microchip.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Wanner-microchip-com/dt-bindings-ARM-at91-Document-Microchip-SAMA7D65-Curiosity/20241207-040527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/e47d8c8cdaec834ce080ef8c34b9976228223c8f.1733505542.git.Ryan.Wanner%40microchip.com
patch subject: [PATCH v3 11/13] ARM: dts: microchip: add support for sama7d65_curiosity board
config: arm-randconfig-051-20241207 (https://download.01.org/0day-ci/archive/20241209/202412090708.BNX0mUZi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
dtschema version: 2024.12.dev3+g93ee800
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090708.BNX0mUZi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090708.BNX0mUZi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts:50.1-6 Label or path pioA not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

