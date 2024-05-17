Return-Path: <linux-spi+bounces-2941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFA8C8D4D
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B032F2865C7
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5714F61;
	Fri, 17 May 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhmDhd5T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B071FC8;
	Fri, 17 May 2024 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978184; cv=none; b=Yv+1VMMoi714uEvBOVXNtOPBvMr8PUQAy5GUhZxZ2a0KcyKiS1lpYzhtHuoVFN+9qt+7es6w55a1BJEjYFO7d6SPDVN9aRpYY07rPn4cs0JpeKeR9MQj75PsNyVdxN5XxFyaJxdAKVXpwTU1ZbqNfMI/4yTHJ/jzY2Lr/ZxIDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978184; c=relaxed/simple;
	bh=7GCMgjFdqpTN0OvC1V9p7UqDrw/d07Z0ZCZ93oglGmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7RLrPq98AbQiRzv49Q66Gm/V/ArJjE7FbAZQc6MUXfGwjZ4lhgFPZn4BqXV2/q9AMnx8/epwD9EGN/sOL46a/nK6FC9d0zUXjVMo6x7K+TvefagIKoQAS3WD/lpX+3rgf5d/wqsAT8vAemNEkpAyIUbvbm4MfckgZAkBdeExMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhmDhd5T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715978183; x=1747514183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7GCMgjFdqpTN0OvC1V9p7UqDrw/d07Z0ZCZ93oglGmI=;
  b=EhmDhd5T1UiAqDOtYm8E+jkae8D8zjEr6bE1fctnlMW/qYdXWlPM0iWR
   Ghs5OsV5M0i7HlQrFk8D1M/YOBZJuVNwQDxBBr54TgZs5I4aKTwU5p208
   3kEDk1m3c3syxLixu6++bw4EydbmG1CoAPte0rNM3KbHwW4vkbdvhFlZ7
   n3mcOZTcFG3wzVxc7gCuv1dJxfBapfG5Dp31Y/wJ3RC87LT91HzjXL4NE
   tGyvclWlWMonnB00YzeU94yqv1A34tYbJZGwfuLKzQtBcXIs16MZN+3Jf
   BxAFjTupcQ/upJdJRM9Xs8BsakcHOMjEmxj20qWvMfKukbZH0CGLLM64Z
   w==;
X-CSE-ConnectionGUID: yJq/gI+vSZa9dhYiH/mKow==
X-CSE-MsgGUID: bgH1NEn4RV6t7Joqbr87Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11979049"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="11979049"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 13:36:22 -0700
X-CSE-ConnectionGUID: RRlG68s1RM66FEo1A8tLfA==
X-CSE-MsgGUID: HVfsa1nuTXSTgYtWbOTPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32465677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 13:36:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s84JN-00000008caS-0ATr;
	Fri, 17 May 2024 23:36:17 +0300
Date: Fri, 17 May 2024 23:36:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 09/10] spi: pxa2xx: Move platform driver to a separate
 file
Message-ID: <Zke_wCyt-Dks5314@smile.fi.intel.com>
References: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
 <20240517195344.813032-10-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517195344.813032-10-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 10:47:43PM +0300, Andy Shevchenko wrote:
> The spi-pxa2xx.c is bloated with a platform driver code while
> pretending to provide a core functionality. Make it real core
> library by splitting out the platform driver to a separate file.

...

> @@ -1597,8 +1485,9 @@ static int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp)

>  	pxa_ssp_free(ssp);

Looking at this leftover, namely this patch should remove the above line,
I realised that there is a problem with the original code as well as it may
drop a reference count in pxa/ssp.c before cleaning up other things which
might have unexpected behaviour.

>  	return status;
>  }
> +EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_probe, SPI_PXA2xx);

I will rework this one along with providing a fix for the above mentioned
issue. Meanwhile I will wait for other comments for the rest of the series.

-- 
With Best Regards,
Andy Shevchenko



