Return-Path: <linux-spi+bounces-7222-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165BA689DA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 11:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300803B8C42
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57C251785;
	Wed, 19 Mar 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceJJ6t/j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C20250C0C;
	Wed, 19 Mar 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381080; cv=none; b=h/03BICDUi05/eoDJvDGsaehVdCFPPkZAh4eACMmjsQCP1J38Fy1FvT1bzottUltXF6CKRN8THdX5UswqUENRd/wJtl8qnjcv59XegwlK0s8jATIgF8hOkfYeDvU26bRPduByZ93N5yd15Rifvz4Kyh6GfT5/rJt9R+2JFQwVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381080; c=relaxed/simple;
	bh=dRtAdHtvOent1p3ZluGctDPJPtWxKazJkrSnIh21/90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sedqW8gyjuPwxeV70UOF8LWNE5DyzvrXupvg9cvTMNpKGXvtf3Cu1xin3gUeU9/jEqixq8jKkDO4fw041J6tlbLDidJN1yK4dJboHprIYC4kFBlUvQzIr3BNz1chf4jd8U4ohKqSG8W/fIsl3jYBN8Yz8y7k2cg5fIsYLcl+h9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceJJ6t/j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381079; x=1773917079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRtAdHtvOent1p3ZluGctDPJPtWxKazJkrSnIh21/90=;
  b=ceJJ6t/jayh5p3Myjd8HUwq7+NgTQTt67Zr6U11BFRoaCDJ7nO7MqBoy
   h8dskM7JTi+KE0qZtwF+2FZOGdjYswS1WaQspnLjxgkfqQFVlnsOHxiTA
   X3lrTfSnauVnLIns3xLGtp/Y6EGaU6SiPM/KwW3sfDM+quOuqGkYKDHAf
   +2OFnr3WPXpbjtpQ4BvgRtEVMFevFBrZG5T7Gn8Nmf19oeTehbsJ9bPyg
   vVyU3N7cU+WT1P9Y5iw4Wqb+7ROsIw2izHhMZSDAyx4bZCQ4EkeOUK0NA
   EIg9P8TgkpAnfQfiahwnkg5anh4CFsPsmh2wEepoAda4OL4RqQpVTAzsE
   w==;
X-CSE-ConnectionGUID: Q7Rf6V2oT1K3gUID0L9rlg==
X-CSE-MsgGUID: Zx6b2O5NRUiKFLSibJZBCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="46319600"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="46319600"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:44:38 -0700
X-CSE-ConnectionGUID: kP4Yshx8TZWTkBh7HFeyqQ==
X-CSE-MsgGUID: UqCdRbaqT9W84mPMd9aGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153415866"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:44:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuquX-00000003tQn-0Yu7;
	Wed, 19 Mar 2025 12:44:33 +0200
Date: Wed, 19 Mar 2025 12:44:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
Message-ID: <Z9qgENjcGFF-rDJe@smile.fi.intel.com>
References: <20250319032305.70340-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319032305.70340-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 11:23:04AM +0800, Miaoqian Lin wrote:
> Fix a reference count leak in slave_show() by properly putting the device
> reference obtained from device_find_any_child().

...

>  	struct device *child;
> +	int ret;
>  
>  	child = device_find_any_child(&ctlr->dev);
> -	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> +	ret = sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> +	put_device(child);
> +
> +	return ret;

Can be written better in case of NULL:

	child = device_find_any_child(&ctlr->dev);
	if (child)
		return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias);

	put_device(child);
	return sysfs_emit(buf, "%s\n", NULL);

No variable needed.

-- 
With Best Regards,
Andy Shevchenko



