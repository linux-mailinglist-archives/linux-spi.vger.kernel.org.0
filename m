Return-Path: <linux-spi+bounces-7154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFBA62697
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 06:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE517DCEA
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C51339A4;
	Sat, 15 Mar 2025 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjwHRqqT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECEE84FAD
	for <linux-spi@vger.kernel.org>; Sat, 15 Mar 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742016766; cv=none; b=k4zsHEPein4+uClHVMCxLECkmsmKyvAk6zVZ7has6wrAivFSJMglc/cInjwdNj3CN0i3giktH+Iu2YRJFjUoPnOzvgGpTKnPQrmQRuHI5WuEMG5nUe1JrRhQtSmSYL3opI2ZsIfoh4GuxYKNv192yHPrzbLHKDGRFBJe6b+BG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742016766; c=relaxed/simple;
	bh=FGxFvMeTHIw8junSff82D7cDkB1dpopOHzs/N/YAUT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lXKpI62u/lcrnRc+sf+nWH/EbVqTqZ9rjxu54iQ/rkkNB89dd18n2gOK2OVl0j1pd6wjRyzmQZc+r9WTW7+/7Atj1LiFMKgLrglib5lee2wC0p0p5vztTzdfg1oR+IRuWB2mliKCZYhgSoRiAWuA0M8/ox+rRuX8rY1a+/qrSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjwHRqqT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742016765; x=1773552765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FGxFvMeTHIw8junSff82D7cDkB1dpopOHzs/N/YAUT8=;
  b=YjwHRqqT30W/WAf4Pz52EZ8SEC/Gpzcmm/Pnav1bToRQiurE0aI4QCji
   iA6swX3JffUrmZPgl59KSRv1dVd/Nw3JxZTH7VQ4CvcZIr3I0H1eYvQ+7
   Q4K8Emj9w+PmqMJpLi2kw7mL85ho7wJfIMd0t/tJqpv/jAEsbAvLAySAM
   f6BQ0+DgUOyShX2qZ8WJeTt4os4tRljWqQpahJCAgqZzBLaPUM3WigWM1
   T84q+UCYmTyItnDwnaAqsKLJjQGyT/TVkZ8p/nikpNaL0ZEfnK8zn6Nkr
   ZSmUIDwzALZVgLB8ITpQJ4n4F1qugstLmfxwVFLkXbZdrXLa7KmMgpOuR
   w==;
X-CSE-ConnectionGUID: EsDqhbzaSO+5UNiqVfwGLg==
X-CSE-MsgGUID: QKVuWq/GTLGK1ySuUhiLhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54560685"
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="54560685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 22:32:44 -0700
X-CSE-ConnectionGUID: S4i/w2y1QRWfOGgDL68HMg==
X-CSE-MsgGUID: 8QHKpKGKSN2bTErpdbW/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="121965600"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Mar 2025 22:32:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttK8W-000B59-1o;
	Sat, 15 Mar 2025 05:32:40 +0000
Date: Sat, 15 Mar 2025 13:32:07 +0800
From: kernel test robot <lkp@intel.com>
To: Longbin Li <looong.bin@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [broonie-spi:for-6.15 10/22] drivers/spi/spi-sg2044-nor.c:243
 sg2044_spifmc_write() warn: unsigned 'ret' is never less than zero.
Message-ID: <202503151344.DRTW7z9o-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.15
head:   336a41c90c86b883aa06ed19f138eee19ddf9958
commit: de16c322eefbe9026d4eabc8ae934bb778cffd1d [10/22] spi: sophgo: add SG2044 SPI NOR controller driver
config: openrisc-randconfig-r072-20250314 (https://download.01.org/0day-ci/archive/20250315/202503151344.DRTW7z9o-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503151344.DRTW7z9o-lkp@intel.com/

New smatch warnings:
drivers/spi/spi-sg2044-nor.c:243 sg2044_spifmc_write() warn: unsigned 'ret' is never less than zero.
drivers/spi/spi-sg2044-nor.c:450 sg2044_spifmc_probe() error: uninitialized symbol 'base'.

Old smatch warnings:
drivers/spi/spi-sg2044-nor.c:253 sg2044_spifmc_write() warn: unsigned 'ret' is never less than zero.
drivers/spi/spi-sg2044-nor.c:263 sg2044_spifmc_write() warn: unsigned 'ret' is never less than zero.

vim +/ret +243 drivers/spi/spi-sg2044-nor.c

   212	
   213	static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
   214					   const struct spi_mem_op *op)
   215	{
   216		size_t xfer_size;
   217		const u8 *dout = op->data.buf.out;
   218		int i, offset;
   219		size_t ret;
   220		u32 reg;
   221	
   222		reg = sg2044_spifmc_init_reg(spifmc);
   223		reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
   224		reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
   225		reg |= SPIFMC_TRAN_CSR_WITH_CMD;
   226		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
   227	
   228		writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
   229		writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
   230	
   231		for (i = op->addr.nbytes - 1; i >= 0; i--)
   232			writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
   233	
   234		for (i = 0; i < op->dummy.nbytes; i++)
   235			writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
   236	
   237		writel(0, spifmc->io_base + SPIFMC_INT_STS);
   238		writel(op->data.nbytes, spifmc->io_base + SPIFMC_TRAN_NUM);
   239		reg |= SPIFMC_TRAN_CSR_GO_BUSY;
   240		writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
   241	
   242		ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
 > 243		if (ret < 0)
   244			return ret;
   245	
   246		writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
   247	
   248		offset = 0;
   249		while (offset < op->data.nbytes) {
   250			xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, op->data.nbytes - offset);
   251	
   252			ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
   253			if (ret < 0)
   254				return ret;
   255	
   256			for (i = 0; i < xfer_size; i++)
   257				writeb(dout[i + offset], spifmc->io_base + SPIFMC_FIFO_PORT);
   258	
   259			offset += xfer_size;
   260		}
   261	
   262		ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
   263		if (ret < 0)
   264			return ret;
   265	
   266		writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
   267	
   268		return 0;
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

