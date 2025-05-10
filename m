Return-Path: <linux-spi+bounces-8060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D832BAB2596
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 00:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5306189C437
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9ED10F1;
	Sat, 10 May 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFR7Ovf+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B720C00C;
	Sat, 10 May 2025 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746915752; cv=none; b=hTbka3Oaat7kPAHTgAfeSIzg1/ry4vGd7Wsjnl1Oeirl6BwLXdtorpYaQZk6qitoTLqR6SCsaKyC5hH+ys7IPyyhw/R2FyWJwtWKOeijgmEQ/PLT29LWS0YdurBGCyZsxEA3x1qKMtvY7wMTaBfoCmSZecRan44AJkVynZ53eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746915752; c=relaxed/simple;
	bh=ukgB+evCgCwwEnYan1JRIC6vSU5Hcfx4UggVn9a88D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSFENEpM1o67EuxrcQULifcdRzePDwj1eJiaDhNwGcijnaD0LgZIzJd1FsBq7Re9zS1UsA2gi4Ne7CWVe4rl2LowtU9mzi4NESf3z3CiVJp0AO8F5jOurrOWtZ/TaOvNsZ1hL6afJkHnf76bDmygQERix3y+ZRjR6S9UY8FPJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFR7Ovf+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746915751; x=1778451751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ukgB+evCgCwwEnYan1JRIC6vSU5Hcfx4UggVn9a88D0=;
  b=ZFR7Ovf+sms3/8fK6wEMykK5n7B6hixmsyY7bfR5lefmdYOl+pIYuuYD
   SphuWTqP18qQpH0TVewMY85eozA2p6Lc1LgGf6dnblWHMReTl+jr8QtFu
   jHGmrsEdCtGTuaXxr0ooFETmYy5hr3nYCvBZ95l1P5wg0NvjI/vvNQXc1
   FYzBDiW8gf1yn5cYz7XxwwzvZUMOWh82/ddI7UicWy4SKWTyS/pqlLuPa
   zOVMxs4a2AO1ruH1TDZ9fAD2H9kEs3cd3SoOqDHtrgxPXwan0n8dFFMvx
   /ooF4aNaYRVY1HkueNAysMy9+2xfTgvs+0eCCUXl+l8lXk+Y7XuDoo6pl
   A==;
X-CSE-ConnectionGUID: gWKiolBZQq+BX8QFPdvUEQ==
X-CSE-MsgGUID: sp5S/5SsRoaIz9jD3V1sUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="60070995"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="60070995"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 15:22:31 -0700
X-CSE-ConnectionGUID: yDZ2mg0YT5CNxlYkKlF02Q==
X-CSE-MsgGUID: 24ULPRgJRqy7z5ibucgwkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142192608"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 May 2025 15:22:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDsaQ-000DR1-1n;
	Sat, 10 May 2025 22:22:26 +0000
Date: Sun, 11 May 2025 06:21:38 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: Re: [PATCH] spi: spi_amd: Add HIDDMA basic write support
Message-ID: <202505110641.zLT16Dv7-lkp@intel.com>
References: <20250509181737.997167-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509181737.997167-1-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.15-rc5]
[also build test WARNING on linus/master]
[cannot apply to broonie-spi/for-next next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
base:   v6.15-rc5
patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505110641.zLT16Dv7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-amd.c:594:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/spi/spi-amd.c:594:57: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/spi/spi-amd.c:594:57: sparse:     got void *

vim +594 drivers/spi/spi-amd.c

   566	
   567	static void amd_spi_mem_data_out(struct amd_spi *amd_spi,
   568					 const struct spi_mem_op *op)
   569	{
   570		int base_addr = AMD_SPI_FIFO_BASE + op->addr.nbytes;
   571		u64 *buf_64 = (u64 *)op->data.buf.out;
   572		u64 addr_val = op->addr.val;
   573		u32 nbytes = op->data.nbytes;
   574		u32 left_data = nbytes;
   575		u8 *buf;
   576		int i;
   577	
   578		/*
   579		 * Condition for using HID write mode. Only for writing complete page data, use HID write.
   580		 * Use index mode otherwise.
   581		 */
   582		if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_write_cmd(op->cmd.opcode)) {
   583			void *hid_base_addr = amd_spi->dma_virt_addr + op->addr.nbytes + op->cmd.nbytes;
   584	
   585			/* Write opcode and address in system memory */
   586			writeb(op->cmd.opcode, amd_spi->dma_virt_addr);
   587	
   588			for (i = 0; i < op->addr.nbytes; i++) {
   589				writeb(addr_val & GENMASK(7, 0), hid_base_addr - i - op->cmd.nbytes);
   590				addr_val >>= 8;
   591			}
   592	
   593			for (i = 0; left_data >= 8; i++, left_data -= 8)
 > 594				writeq(*buf_64++, hid_base_addr + (i * 8));
   595	
   596			buf = (u8 *)buf_64;
   597	
   598			for (i = 0; i < left_data; i++)
   599				writeb(buf[i], hid_base_addr + (nbytes - left_data + i));
   600	
   601			amd_spi_hiddma_write(amd_spi, op);
   602		} else {
   603			amd_spi_set_opcode(amd_spi, op->cmd.opcode);
   604			amd_spi_set_addr(amd_spi, op);
   605	
   606			for (i = 0; left_data >= 8; i++, left_data -= 8)
   607				amd_spi_writereg64(amd_spi, base_addr + op->dummy.nbytes + (i * 8),
   608						   *buf_64++);
   609	
   610			buf = (u8 *)buf_64;
   611			for (i = 0; i < left_data; i++) {
   612				amd_spi_writereg8(amd_spi,
   613						  base_addr + op->dummy.nbytes + nbytes + i - left_data,
   614						  buf[i]);
   615			}
   616	
   617			amd_spi_set_tx_count(amd_spi, op->addr.nbytes + op->data.nbytes);
   618			amd_spi_set_rx_count(amd_spi, 0);
   619			amd_spi_clear_fifo_ptr(amd_spi);
   620			amd_spi_execute_opcode(amd_spi);
   621		}
   622	}
   623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

