Return-Path: <linux-spi+bounces-3267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1858FD828
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CE31F2709B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40213CFBD;
	Wed,  5 Jun 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKWTMt4v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DA4965B;
	Wed,  5 Jun 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621934; cv=none; b=s6xcuVDrhTnG6c+dSrGY6ree8k9HWXiNqqzqCGQC2eeoDkcptThqiEe2EWkfkkVutp2GzFDmJe0wMJucNoPdhM8El2CpLeMecirPPLoTXppdkmhbyyRyEX6kFjpOSCMHi7lH1k6vts9Uu3E+H8k+Y8SivrFb0cSY37LTAon935E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621934; c=relaxed/simple;
	bh=LyHLgJkRrurdDRgnBOzirT7zP/ucxLdsMEoWbv6XOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFkREGy8WLgG6GfqJLj/sHmBm4WddFQK327KJUUryvbpjPWp09IwsvkH/+EJNlhB8F4vpZvkXSCbl9FL2FKa1Ar7e02nygdqh1vyVzd4WzJWO/oEZcXa9oty5N+Rzen1nin+DTWV4tLwC+8pcd2ILX5ZVoS1WeYPWiD9JszDeXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKWTMt4v; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621933; x=1749157933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LyHLgJkRrurdDRgnBOzirT7zP/ucxLdsMEoWbv6XOwA=;
  b=NKWTMt4vj3JNdzmZPi0A6TPh8sxLZHVDlStMxuWoDFp63nwqHcV4Dg1r
   3xAD+eH1xfAoZWe/AJPBts5O+/kRAUeHirv6+V0Um/JyRW7BghvjPClmg
   M6Rky2+uzv2XkOmhQqik3W1oumIoK6wgxPpGHXpQ7ccHBsKBKZWSNSOlr
   ZgEtkGuhzQecm/LMA0sWQbFpEcuAk6ZAv1d0piVa5oCWDvZff3b6J0m72
   Wnug9ZDVY84mElRtLjVK7Nna6dj8a16GJ73zoTGG32hs3bNY5+xB6s2xn
   hLOp6AhT44RFM4Vo2SBYJ2JBDa/lQC6dBb7+SRdmjOA10dHqPxqGbiH/B
   A==;
X-CSE-ConnectionGUID: TKMCTLWqQhSG1eVwVIMXvQ==
X-CSE-MsgGUID: w+sE6wrARZefbPxDhBEL/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25662944"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25662944"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:12:12 -0700
X-CSE-ConnectionGUID: M+t6oNJWSXC5g247pdi2mg==
X-CSE-MsgGUID: TcMyoLmrRROziMe/wvpPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37735874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:12:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExvR-0000000Dy86-3xjO;
	Thu, 06 Jun 2024 00:12:05 +0300
Date: Thu, 6 Jun 2024 00:12:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 5/8] spi: pxa2xx: Use new spi_xfer_is_dma_mapped()
 helper
Message-ID: <ZmDUpfCfcFUWz9py@smile.fi.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <20240531194723.1761567-6-andriy.shevchenko@linux.intel.com>
 <Zl4XphMgxEwzPCKA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4XphMgxEwzPCKA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 03, 2024 at 10:21:11PM +0300, Andy Shevchenko wrote:
> On Fri, May 31, 2024 at 10:42:37PM +0300, Andy Shevchenko wrote:
> > Replace a few lines of code by calling a spi_xfer_is_dma_mapped() helper.
> 
> It appears that this patch is based on the cleanup series against the driver
> that had been sent earlier. Namely this:
> [v2] spi: pxa2xx: Get rid of an additional layer in PCI driver
> 
> https://lore.kernel.org/linux-spi/20240530151117.1130792-1-andriy.shevchenko@linux.intel.com/T/#t

Okay, now it should cleanly apply to spi/for-next (and indeed, it does, I just
checked locally).

> And as others already said, this series is pure cleanup, no need to be backported.

-- 
With Best Regards,
Andy Shevchenko



