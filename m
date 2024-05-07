Return-Path: <linux-spi+bounces-2760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CE8BE4A0
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A039B23A35
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7D15F418;
	Tue,  7 May 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWbB6yXZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0C15DBCE;
	Tue,  7 May 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088079; cv=none; b=GXEhzRzgr7m+hxy73Xu77mRlMlwt9hvUmAfisIm9ZXzBIiBOUX+ig8Q3r8WkvJeA/VQbAZtbNbzNKm8LdSM1vrF4saMYk31tOPoSWnbKbV19Cs4jZNVN6mopXbSrRDgJ9mwJB/MzFsgdX6DFmDdwzS7ynSe24RWNCOyZX9GWwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088079; c=relaxed/simple;
	bh=EmCiyPVChUhVOax3y0D7tFpfQz/xrZKt8YiTOJ9BE94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHWGGlWTHJv6YOp9xA01VwuQ0hSkJxoIn9Zffb5PJPe9ur9F3Jm8CJsuJdLzfD7xSoulldgGVpTTSxiS0pRHSZqKN9Aq4krCCkPlAjk9IMSBJBhVmrZg+mcj4xU7liWyKXaZuM5Tw2A4Cb6p3ltwn/KF7+Bj3Ik7KxcIjDLPRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWbB6yXZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715088079; x=1746624079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmCiyPVChUhVOax3y0D7tFpfQz/xrZKt8YiTOJ9BE94=;
  b=KWbB6yXZ3cN6vzZ8Spr7B9KDPoiFqyam7bgOgOj0fwbTiNSytNZiERvf
   vJeEhUM3pfv/azymphCRL1qNJ6YhOZWXA3GVm4bO8XXoTeUXW0Tl3rywh
   ZWWU5fB//z/CU6ZwSKbx3ANDlWKTwXD126lya1rFFnoq0wgvnwoqWNFPv
   w4La4iO0tR/WVe+MyvMoxae5vSainIG1XITOZ17uV1hrQ1ZZ6xlCFG3/A
   tRd/WaVVDnRRF4xnvEkNGXyJtDPZopG4pNc5v8u+XXAeXgfsANJKGrCu0
   E1jqJUeY1+GxoW1pN+/vz3XoVMERYLk1EugADC1cma5Jwj9yqpCGlFs2+
   A==;
X-CSE-ConnectionGUID: +FukTVpFS9SmbDTH+pKFpw==
X-CSE-MsgGUID: PcHjFMUEQ5Cn7JiOzLanfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21436381"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21436381"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:21:18 -0700
X-CSE-ConnectionGUID: goWWd2jHRriPlda1mPZZPw==
X-CSE-MsgGUID: 62fInBOER8KnNk6EiF+Qkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33196154"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:21:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4Kks-000000052pK-0eUB;
	Tue, 07 May 2024 16:21:14 +0300
Date: Tue, 7 May 2024 16:21:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Drop the stale entry in
 documentation TOC
Message-ID: <Zjoqyc8RVOPVSPnO@smile.fi.intel.com>
References: <20240507132002.71938-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507132002.71938-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 07, 2024 at 04:20:02PM +0300, Andy Shevchenko wrote:
> The documentation had been removed, so should TOC entry.

Closes: https://lore.kernel.org/r/20240507163131.183813ee@canb.auug.org.au

> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2d069c11e822 ("spi: pxa2xx: Remove outdated documentation")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/spi/index.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
> index 06c34ea11bcf..824ce42ed4f0 100644
> --- a/Documentation/spi/index.rst
> +++ b/Documentation/spi/index.rst
> @@ -10,7 +10,6 @@ Serial Peripheral Interface (SPI)
>     spi-summary
>     spidev
>     butterfly
> -   pxa2xx
>     spi-lm70llp
>     spi-sc18is602

-- 
With Best Regards,
Andy Shevchenko



