Return-Path: <linux-spi+bounces-7119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE0A5F7F5
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E06B7AE889
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F537267F52;
	Thu, 13 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nScF/ei3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C4267F45;
	Thu, 13 Mar 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875919; cv=none; b=DWJWjmjcYxCAbxiveqoEdutrt/c/IXzAONpuTQQ/hNoB5Wca8UCFIe37K4IEsoGXWRgii+bkEi1c5Wn+7LAsTarGhFiXH6tpt/N/YERf80dlqvmAoBBXwHe28aVuqGu+r9QHZyOwMrsFKnjfZl6piq8CRkb6FZNe0rNjigN/r3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875919; c=relaxed/simple;
	bh=KGmJrceDamjRYmfBqz65BHjaNIf+vVNxlgv1SUPYziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCQs+h526PpAJm2SZuuMxvNAwYX0G0MO9ezpH2RdCSVPMbmtop0MX1HTOFsn7/+T9mCHqIwuKqmZ/pyBfANUwoiIshI4ZAItAfoe463HuhTNCAkPs3x+9fw3imCGsfLMgSCJHVvnv4ftn9XAbBJpj1F/E63CHVTv5mjvgUog+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nScF/ei3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875918; x=1773411918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGmJrceDamjRYmfBqz65BHjaNIf+vVNxlgv1SUPYziw=;
  b=nScF/ei3BVzw8q1KQ96U3PyfgKia1Ruuoo7g37RjrKD8RhsNXMLYM0S4
   FJoU5rdOTGLcxnKb9dY1t60CISoMZt8rlafGnvnKv8mdnU/GchDGoYfyU
   TDSlsUUKdLQeJiOF9XjE0yAN6TtABfttYP4fD+FNk/sPJo2vXNNR54RkR
   aiGB6/A412TSDfr38jSybEGdn9Ou7y0IY03CudN6efy+smgC4J7EEi2RG
   XvBf+cyNLalI9cgy9GmsFAkMXbHpamjomhvhjV0b3AmaCeS5kT3UUGksq
   7YqqymUanfXG6zZucSXVAqLeRBHyiAk5T0Iev2WT5mcFJJSoTtR9e5GFd
   g==;
X-CSE-ConnectionGUID: 9TRemX/tSlWl53iByr9Vhw==
X-CSE-MsgGUID: 1/Mt6bV9R2K1OURd71dcHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173763"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:25:18 -0700
X-CSE-ConnectionGUID: KmOb6IzoQve4rBYyMtpT7Q==
X-CSE-MsgGUID: xwpBqq35QGqpHdkmv4DpIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121470355"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:25:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsjUn-00000002CZB-1ykw;
	Thu, 13 Mar 2025 16:25:13 +0200
Date: Thu, 13 Mar 2025 16:25:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <Z9LqyWr4GH4RX6Nj@smile.fi.intel.com>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
 <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
 <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e329812d-90a5-456e-9a00-abb5c2c8d25d@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 02:12:29PM +0000, Mark Brown wrote:
> On Thu, Mar 13, 2025 at 04:01:49PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 13, 2025 at 12:47:32PM +0000, Mark Brown wrote:
> 
> > > This doesn't apply against current code, please check and resend.
> 
> > Hmm... It's based on the spi/for-next. Should I use another branch?
> 
> I did try to apply it against that in case there were fixes that needed
> merging up, it didn't apply.  Are you sure you're using an up to date
> copy?  I have ebd50ac3cd97ecae231f92b2d64b68d3c66b3474.

87a228960033 spi: Use inclusive language
0d9a21198453 defconfig: enable SERIAL_MULTI_INSTANTIATE
90485ebfb4b3 defconfig: enable SPI_TOPCLIFF_PCH
6d91e1fce386 defconfig: enable EEPROM_AT24 and EEPROM_AT25
331ffc354c53 defconfig: enable GPIO_PCH
d519315d6bed Merge remote-tracking branch 'spi/for-next' into HEAD
ebd50ac3cd97 (spi/for-next) Merge remote-tracking branch 'spi/for-6.15' into spi-next

Yes, the base where it was merged to is eds-acpi branch of my public GH [1],
which has no SPI stuff in there.

[1]: https://github.com/andy-shev/linux/commits/eds-acpi/

-- 
With Best Regards,
Andy Shevchenko



