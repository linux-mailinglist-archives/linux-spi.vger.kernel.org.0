Return-Path: <linux-spi+bounces-11809-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA999CAA14A
	for <lists+linux-spi@lfdr.de>; Sat, 06 Dec 2025 06:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C32EE305654B
	for <lists+linux-spi@lfdr.de>; Sat,  6 Dec 2025 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D9821E091;
	Sat,  6 Dec 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOnD4tXH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9C1D63F3;
	Sat,  6 Dec 2025 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764998444; cv=none; b=QRu+pNCCXDOH+GrM/V5oHakzIUJ8M/aP92C+zlDIXAYcrQPYR8YQl1sIJ//gRD20HGkHqmto+1iR1i8awyEaGm+Lf4OkP8pTD72gHrx1pvwypAaa9sILdBfc4hIQBA/aZ4kJx8MlIqvcY7J7+Ed2PczOGMlzHXpELxzXjxLZVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764998444; c=relaxed/simple;
	bh=ZFjNsLDmNldfG/5D2Bo1Qfl2RpXTUFrxrN62ffaxeME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q47dAAorG49EEvl8O10BeyVaITtNfSJXq5K6mzjP/ziy8hnJOd5PzDhpvi+9UPvo48O6owAbd5rVUnW2p0nFT0x0qzo/yHOWEE4WjSz6HMfbeSreXHSkh7MCMGHt2u0JxpyvT47Bk9Zg2pPiadKOJzuMdb5cRSWqc0zOeXxJBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOnD4tXH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764998443; x=1796534443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZFjNsLDmNldfG/5D2Bo1Qfl2RpXTUFrxrN62ffaxeME=;
  b=jOnD4tXHFYfea9bqretoSovZs3Zr/piVDcxDyjjUrM+HDm47u7wWemS9
   CQ+bEegNxuE/26SIZlMI3/z7a63x7ORfPmYI1NblOUQKL+h38cv07qaf4
   OrX1QMoLBwa1S3yYFcqRXjTdW/Y87xE3OLzkAq41FrglfsR8rQqBvDFVd
   fJJBnQfAWaNmjWzhVeBDuEd9YAk7M9/m2md1pgCnMIJhMWBG0DTo26zV+
   j+LDgwxipCn3NmYzA4oJGW/fHtQtu0mGE7Yg1HaV4oPkxbAin0Wzbmwih
   GmaYMA0DyamZHF7ivdXbPG24FgnSJT9HxEjmcfIU9MXYqdGIgLGCJJEPN
   Q==;
X-CSE-ConnectionGUID: QBLrcPI9RPyvUIWKJ6hR9A==
X-CSE-MsgGUID: Ug0cRECWSVqLuymHGyedMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="89684191"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="89684191"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 21:20:43 -0800
X-CSE-ConnectionGUID: M8sn2e1iS7WipgYPGUEVrg==
X-CSE-MsgGUID: FnNPjzW+SuyCFsShyfMMBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="200605245"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Dec 2025 21:20:40 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRkij-00000000Fsj-1Jo7;
	Sat, 06 Dec 2025 05:20:37 +0000
Date: Sat, 6 Dec 2025 13:19:46 +0800
From: kernel test robot <lkp@intel.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
Message-ID: <202512061327.9CDC4SNs-lkp@intel.com>
References: <20251205-upstream_qspi_ospi_updates-v1-3-7e6c8b9f5141@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-upstream_qspi_ospi_updates-v1-3-7e6c8b9f5141@foss.st.com>

Hi Patrice,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7d0a66e4bb9081d75c82ec4957c50034cb0ea449]

url:    https://github.com/intel-lab-lkp/linux/commits/Patrice-Chotard/spi-stm32-ospi-Set-DMA-maxburst-dynamically/20251205-174931
base:   7d0a66e4bb9081d75c82ec4957c50034cb0ea449
patch link:    https://lore.kernel.org/r/20251205-upstream_qspi_ospi_updates-v1-3-7e6c8b9f5141%40foss.st.com
patch subject: [PATCH 3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
config: sparc64-randconfig-002-20251206 (https://download.01.org/0day-ci/archive/20251206/202512061327.9CDC4SNs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512061327.9CDC4SNs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061327.9CDC4SNs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-stm32-ospi.c:16:
   drivers/spi/spi-stm32-ospi.c: In function 'stm32_ospi_wait_cmd':
>> drivers/spi/spi-stm32-ospi.c:246:48: error: 'struct stm32_ospi' has no member named 'io_base'; did you mean 'mm_base'?
     err = readl_relaxed_poll_timeout_atomic(ospi->io_base + OSPI_SR, sr,
                                                   ^~~~~~~
   include/linux/iopoll.h:102:3: note: in definition of macro 'poll_timeout_us_atomic'
      op; \
      ^~
   include/linux/iopoll.h:213:2: note: in expansion of macro 'read_poll_timeout_atomic'
     read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/iopoll.h:255:2: note: in expansion of macro 'readx_poll_timeout_atomic'
     readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-stm32-ospi.c:246:8: note: in expansion of macro 'readl_relaxed_poll_timeout_atomic'
     err = readl_relaxed_poll_timeout_atomic(ospi->io_base + OSPI_SR, sr,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +246 drivers/spi/spi-stm32-ospi.c

   236	
   237	static int stm32_ospi_wait_cmd(struct stm32_ospi *ospi)
   238	{
   239		void __iomem *regs_base = ospi->regs_base;
   240		u32 sr;
   241		int err = 0;
   242	
   243		if (ospi->fmode == CR_FMODE_APM)
   244			goto out;
   245	
 > 246		err = readl_relaxed_poll_timeout_atomic(ospi->io_base + OSPI_SR, sr,
   247							(sr & (SR_TEF | SR_TCF)), 1,
   248							STM32_WAIT_CMD_TIMEOUT_US);
   249	
   250		if (sr & SR_TCF)
   251			/* avoid false timeout */
   252			err = 0;
   253		if (sr & SR_TEF)
   254			err = -EIO;
   255	
   256	out:
   257		/* clear flags */
   258		writel_relaxed(FCR_CTCF | FCR_CTEF, regs_base + OSPI_FCR);
   259	
   260		if (!err)
   261			err = stm32_ospi_wait_nobusy(ospi);
   262	
   263		return err;
   264	}
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

