Return-Path: <linux-spi+bounces-9565-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF8B2DF29
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4649716A3E6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348D26F45A;
	Wed, 20 Aug 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2yK0oTj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9726E6E3;
	Wed, 20 Aug 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699755; cv=none; b=ksG3vtSyb/tf5D72x89lWWsl/+iOByDnJG17N9s+GMP9Z4f+mHaAtsEqvzmXPN5HVZOsi3E+b89oI6DgFDf+kxY70JrWAa3LN8ORKFa3hxE853SY2nH2oSpKXKK47LFnu2pLzQDJqTP+8ekPvCi+xL78cyvb8l/rgB05pn2/OoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699755; c=relaxed/simple;
	bh=QAJDNNcacklcnmE9//Drmqj4yQa/a/hxKW1vPWGJTDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWCrz/YuGB6QOYQhvLSdRtHfQdAD+MBtB1wabDaTgP0l8IMGThAO18JB883deX8LwmXFOmf0WsU/JO9g5jWG7cnXP2Yiks/CzbMdJcCetCPfXNPSFbzxs2p6xt/b3K31Yu7O6RRJsOsNO0awR7KxV5w3AesQyXDtB9zJPqDYi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2yK0oTj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755699754; x=1787235754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAJDNNcacklcnmE9//Drmqj4yQa/a/hxKW1vPWGJTDs=;
  b=J2yK0oTj9IcpGA1aXb54zohYC60Ls15KD3uLBUG/Lol/FWb9eiK9DKzb
   lU6n9ez7TAk3/zQhAaAm3fdRwwkxHbAc/Ipv1qMrQIbERJynNvTs3EQV2
   Pa7FIjsATERUsq+rMCZQ5XpMvKlUWNfOcD+qXVy01p2Bf2x6CwQF6lvaq
   izRP2TPYHhF46MySoUgfxlkpZeSeIif0FHkQxzLwzM+82tfWhTq+Kp0U0
   a/I9UNMmaAni+RbJvJLUheo+1BT438yCpaaa2aNVHHNNnbaCKTBIz0/V/
   eQ6qrN06T6hWVPWOHRKtbmSZwE+8ZhQimqQGaNhLySsqNI8D0AUNDinSb
   A==;
X-CSE-ConnectionGUID: WkeeuyvxQKSiv5N7chz17Q==
X-CSE-MsgGUID: psphQpjZQGm8dlRDUUCI9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56995350"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56995350"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:22:33 -0700
X-CSE-ConnectionGUID: jx42DkcQRPSYXNFDbbDNHA==
X-CSE-MsgGUID: Ftft4ESETIuOd42V2j0zsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172405159"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:22:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojhr-00000006xKN-3fNC;
	Wed, 20 Aug 2025 17:22:27 +0300
Date: Wed, 20 Aug 2025 17:22:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <aKXaI0SAAMaHMZM9@smile.fi.intel.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820084944.84505-3-quic_haixcui@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.

...

> +/**

This is kernel-doc comment...

> + * struct virtio_spi_config - All config fields are read-only for the
> + * Virtio SPI driver

> + */

...

> +/*
> + * @chip_select_id: chipselect index the SPI transfer used.
> + *

But this one (besides having tons of unneeded blank lines) is not. Why is this
inconsistency?

> + */

...

> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK	0
> +#define VIRTIO_SPI_PARAM_ERR	1
> +#define VIRTIO_SPI_TRANS_ERR	2
> +	__u8 result;
> +};

And this data type has no doc at all...


-- 
With Best Regards,
Andy Shevchenko



