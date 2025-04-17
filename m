Return-Path: <linux-spi+bounces-7638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4CA9215C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EA88A2B7C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B225393C;
	Thu, 17 Apr 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkN1axgs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F433253B6D;
	Thu, 17 Apr 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903343; cv=none; b=STe80W0LZKZekaHlvNmnpZXEmabTcftIBedRZlBjeAnZHeu3nfuoWEeaACFkOptcYNUNhlvs7+doij+Q++Cp89RmG9XOwnGqcl7eKpPsSf5mjTSnWNfLMEGLPNbTNmDy6sfGqTxuHJMRG7L3giBYzCuFV8zORYb61o9zVO6Oq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903343; c=relaxed/simple;
	bh=+d5Tt/mnxSSxnKX+ZWT69Gg5ImQItqXJ1kvJcCqc0I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS8Cnchqso+GI1ABFiVLbRxHFhTzRBTdS/zSbfztDUku5IH1Yil4SzLCqNM1kYcoIH3IY/EXlqdvz9WA+OwJ8GPOC7jerch6NFyH9ixE37WToxSWkriCgriX3qQ0jsuMzb7dA+/WVMM1TVz3kW93lUSrMEHFbJKVgLmMBdOK52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkN1axgs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903341; x=1776439341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+d5Tt/mnxSSxnKX+ZWT69Gg5ImQItqXJ1kvJcCqc0I0=;
  b=fkN1axgsZZ2QO4fR2Bl/QyG+1UlqPUBbuZNywZCx4vEe0YfCjkYFp4vT
   VCXx3RGPR9JdrR0h475lDO8Lmf4l6H3RuTE+UsJM++NgkINvh716UYlp2
   WjvESL/CTGDZxhwb+fEbYtsFg12erVzQfpFFBNwlO0gZ2PZYf/U5YEd/4
   GAi2YJRpW8umxbM3nA5PMrZRamOL2SZsQMUX1+hqiCON4dtwQ3GljvInU
   FdL7/g/KmXoZnzugks5polL+GiYHumLYTrIHE542P90hoojfQKd9Yqhka
   vaI4VvsHyDbIqaXO1duHR5ZcmMKHXTjmg1j3pE7P91J4Vq9IRkupJUs3A
   A==;
X-CSE-ConnectionGUID: a31pUV2FRqGpIw6usicMpw==
X-CSE-MsgGUID: Ls6T/qi6R+KslCefQRdadw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57491489"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57491489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:22:21 -0700
X-CSE-ConnectionGUID: LQ4kZetMRt+j6Pjvc2NiTA==
X-CSE-MsgGUID: xH8gX4lDTE6PH7+z8SfxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="135684999"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:22:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u5R4D-0000000DEdd-073w;
	Thu, 17 Apr 2025 18:22:17 +0300
Date: Thu, 17 Apr 2025 18:22:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Message-ID: <aAEcqC9R6GDOr5L4@smile.fi.intel.com>
References: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
 <20250417151958.490174-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417151958.490174-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 06:17:52PM +0300, Andy Shevchenko wrote:
> This helper converts the given bits per word to bytes. The result
> will always be power-of-two, e.g.,
> 
>     ===============    =================
>     Input (in bits)    Output (in bytes)
>     ===============    =================
>             0                   0
>             5                   1
>             9                   2

>             2                   4
>             3                   8

My gosh, it lost the couple of characters here, should be 21 and 37 respectively...
I'll fix this in v3.

>     ===============    =================

...

> + * This function converts the given @bpw to bytes. The result is always
> + * power-of-two, e.g.,
> + *
> + *  ===============    =================
> + *  Input (in bits)    Output (in bytes)
> + *  ===============    =================
> + *          0                   0
> + *          5                   1
> + *          9                   2

> + *          2                   4
> + *          3                   8

As per above,

> + *  ===============    =================

-- 
With Best Regards,
Andy Shevchenko



