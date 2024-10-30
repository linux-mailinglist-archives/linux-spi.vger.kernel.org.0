Return-Path: <linux-spi+bounces-5538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8182F9B5906
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6EB1F23AA3
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120213774B;
	Wed, 30 Oct 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCzLcApt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DD42A8B;
	Wed, 30 Oct 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251246; cv=none; b=UpSKQHlIp0PWB1qxRQGDsw2cyn6AWuNMAcTRSEjEnkm5+J2LxvkwmKmV91E7CdmdM5H6yN+UZPa8Yqauf1FsBwhlQPkrXTveZShnrT7kPLZEhtREwBNIEewGQwv1HKVMrSOnNJM3VAMLH+D+JZzeu3VX16nw7bK0Xod4jfIlTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251246; c=relaxed/simple;
	bh=wZDiMAaOhKiJUYkYEtwy19sskMyJZD0MGmAeOQbFpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geYCLm0BPp6tyMsvmLrPzIhIx9wHIgtFZBuwou1KrS8jrTd2of7eO5epkSe+r6ORPX0325kJUNUhFRCfMSzHBvFs44mCmHCcN1Ivo/r33gbyJKBmY9B15ZSBXup7R9Po0PMJaTZpa4Syu8VeMVNOwQLp81DFwKVPceGPV8q8umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCzLcApt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730251244; x=1761787244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wZDiMAaOhKiJUYkYEtwy19sskMyJZD0MGmAeOQbFpJU=;
  b=CCzLcAptPu5YC1R+K8L1Bu30P0SJ9zIIanzeF930EH59gXRLVkzNUfAV
   Dk2cMiE/Y7KPlHwONBweXKsm/YMFDtJN+vHyNofp6et/sDhzAmKkP5KYn
   AdNMUOpc4NFOZem6Pyr9mRwVIY5PKxzuKsgeia/BeeGWKKOMDg7EtXV4J
   tSK+rB6IgMBFWppZw53vW2kThGAv4GboL+3IgnLfG7I8D4sbyfnTZHvvj
   pEVVnrPETBETKyKgkZ9XUtsNkXlXvhNBD3m+urxFgr4aQWqF6Jl91MbEN
   DqPV0+fR38NU4uuVEQbzl7DgmpJgdlVWHiPmv/BazsgLse8rXM9Zijqf3
   Q==;
X-CSE-ConnectionGUID: QOXhr11qR3qJmnNbq8y/lA==
X-CSE-MsgGUID: +Sx9e+K5TkqDM6MzdwjTpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="32776934"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="32776934"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 18:20:42 -0700
X-CSE-ConnectionGUID: 7w0w8aZDTJqMuAYRh5XFng==
X-CSE-MsgGUID: XTZgTvcVS7SeqeGzux2ZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82062035"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Oct 2024 18:20:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5xO0-000eMm-33;
	Wed, 30 Oct 2024 01:20:36 +0000
Date: Wed, 30 Oct 2024 09:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
Message-ID: <202410300915.VPL8EQQu-lkp@intel.com>
References: <20241029125843.2384307-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029125843.2384307-1-csokas.bence@prolan.hu>

Hi Bence,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on soc/for-next linus/master v6.12-rc5 next-20241029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cs-k-s-Bence/spi-atmel-quadspi-Create-atmel_qspi_ops-to-support-newer-SoC-families/20241029-210231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20241029125843.2384307-1-csokas.bence%40prolan.hu
patch subject: [PATCH] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241030/202410300915.VPL8EQQu-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410300915.VPL8EQQu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300915.VPL8EQQu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/atmel-quadspi.c: In function 'atmel_qspi_transfer':
>> drivers/spi/atmel-quadspi.c:446:68: error: 'struct spi_device' has no member named 'master'
     446 |         struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
         |                                                                    ^~


vim +446 drivers/spi/atmel-quadspi.c

   442	
   443	static int atmel_qspi_transfer(struct spi_mem *mem,
   444				       const struct spi_mem_op *op, u32 offset)
   445	{
 > 446		struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
   447	
   448		/* Skip to the final steps if there is no data */
   449		if (!op->data.nbytes)
   450			return atmel_qspi_wait_for_completion(aq,
   451							      QSPI_SR_CMD_COMPLETED);
   452	
   453		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
   454		(void)atmel_qspi_read(aq, QSPI_IFR);
   455	
   456		/* Send/Receive data */
   457		if (op->data.dir == SPI_MEM_DATA_IN)
   458			memcpy_fromio(op->data.buf.in, aq->mem + offset,
   459				      op->data.nbytes);
   460		else
   461			memcpy_toio(aq->mem + offset, op->data.buf.out,
   462				    op->data.nbytes);
   463	
   464		/* Release the chip-select */
   465		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
   466	
   467		return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
   468	}
   469	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

