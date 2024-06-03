Return-Path: <linux-spi+bounces-3204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB68D89F6
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007A11C23766
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181772CCB4;
	Mon,  3 Jun 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMRhhhAX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5A23A0;
	Mon,  3 Jun 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442480; cv=none; b=a1s+pxQrgSR8QQCBgLl1oLnFvCTtFTmR0WXRCdn4+t+kzSiTqZl7YKGPUVoeemiToOj9fbZ5TBjPh2VnAU1BwIE14wk1DMsxjV2I/WmuJr0l/9GpSwQZ9aczXCp0mJNboLg/E8N7Ie1nAbDNsQy3QYXwaEcuGNf4gBhnjOAanQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442480; c=relaxed/simple;
	bh=KHFlsjY60/++eC7FyVbiA7jM9GUOj78cXYpH6S2IMw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3rGA8383GGXfyUfTPX027Cw9tmSkfxYEo201BaG0HkbJwJ72e7hyygoKoW1FJmmhzB42P9P85XWJfmdlb61PedtnWT/drTdSoc/7PNuh3OJZfWDKMvK0DmeP+y838qquRUIcAuSUIfNC/ufbpRo2oynZFgOwQIeOwfEYUlURkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMRhhhAX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717442479; x=1748978479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KHFlsjY60/++eC7FyVbiA7jM9GUOj78cXYpH6S2IMw0=;
  b=GMRhhhAXvEMn3u1FwVifChF0dPgj+ui0G41GnuwIC4BUvVsKh1bDq8oA
   M685bA5McBXWTkgroTBrFGyKwDtwm6E8t98g9qhgA2E7T5c0GQ1gkdXNo
   XbrOEeV5xAJ4VzkKarPcVUdVr2sjZeQScGLY29ETQH5Xfsc7fS/B/cGCK
   YDLuAe0j3ncZSHua6GaH5yGXMH2XY+s3vE4UfITdAc1qF6V+VSRBQnimU
   1n1uENXH0kWuRcSo4IEwEYB9aypxgH0PkumxhNIs+c9QaXzuVxxRV4WAz
   Seem5Ahq82aK14NgzUCyOG5YT+GLz0E/jBPaqFCtR7fFVrvQCIZIC59CA
   w==;
X-CSE-ConnectionGUID: UGwm/FBaSoqvJ2UlElHEsw==
X-CSE-MsgGUID: TMRz7PHwTuSAB4lVVdtgYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25354179"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25354179"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:21:18 -0700
X-CSE-ConnectionGUID: V5utEDVASUCecZ6Mtl1Prw==
X-CSE-MsgGUID: 7eD3kgCmQx6XUQlrxb+b5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37090878"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:21:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEDF1-0000000DMvb-01r8;
	Mon, 03 Jun 2024 22:21:11 +0300
Date: Mon, 3 Jun 2024 22:21:10 +0300
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
Message-ID: <Zl4XphMgxEwzPCKA@smile.fi.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <20240531194723.1761567-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531194723.1761567-6-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 10:42:37PM +0300, Andy Shevchenko wrote:
> Replace a few lines of code by calling a spi_xfer_is_dma_mapped() helper.

It appears that this patch is based on the cleanup series against the driver
that had been sent earlier. Namely this:
[v2] spi: pxa2xx: Get rid of an additional layer in PCI driver

https://lore.kernel.org/linux-spi/20240530151117.1130792-1-andriy.shevchenko@linux.intel.com/T/#t

And as others already said, this series is pure cleanup, no need to be backported.

-- 
With Best Regards,
Andy Shevchenko



