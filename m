Return-Path: <linux-spi+bounces-2939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7E8C8D24
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC681C236CC
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD014037E;
	Fri, 17 May 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHFrBsjy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED545007;
	Fri, 17 May 2024 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975887; cv=none; b=QBnizXwoPvhs7ZSB7z4J0s67uOnqmD/WVEVAyDgjH9AHziF2OsWw7L7RMTx/ySCxqDndeUHZdkHnxHiwdi8Q1EYI1YbywzPcj50uMfa+v94pM8ZoCvZo3TMxymT97Ts6XDoXHiHfYuMj1GPiNi3dVs6F/rAcwSqHrRZ8kCJDa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975887; c=relaxed/simple;
	bh=9Ar2XINDoPbMag4DWT0GPQzhpsfd87f7xxKyprFXG3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHJa4gUJlxNFsftYInjEzN2wpuLwn4oloaRbOnC1D1HEhZ8KKIwK0sm6v8BcBAeL/447d5p/fq8khiOLWY8lmy3TTxhdj7acpj+XzOrAObh+XELuO7JdN+vaVRn6377Pxs9pc0RNtM1WGBNGKRt5yRAZAezez/Ss6V9VUBU2GnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHFrBsjy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975886; x=1747511886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ar2XINDoPbMag4DWT0GPQzhpsfd87f7xxKyprFXG3o=;
  b=VHFrBsjyiG3s3uSQc5JLM4MB3KpVMgCv0AhAZeUpxPTlqBYEvXtEl9t1
   6c2cvMpoN4ZqRBLVtKCnYBHqMhXm8RCpSmA0oXJojTXuk8+JBIjdW+9Si
   rT9pRH03096VVtMQiXWAyHVQ+6IAhINMV/u+Sfhk1VGcp4ypc28PqwgwZ
   bFkfBepNBJrT78SS6nCd/Zr+/iFmD0mCXPgO9pk2GbiZ9xaVyl3tcV7mY
   tmmGjLmkps9+EXiYtK+g0C4qdVhDu7jde6hsFCahqlSriOYfxDcl7OvQT
   A1EG+OohC7I+R9FVCqw3Exa3UpFXTSEWjs1Deg41ZWfc9DA+T62dTt7Y1
   g==;
X-CSE-ConnectionGUID: eX+WY19SRvKHY/EmZOyYPA==
X-CSE-MsgGUID: cSdfKAsgSZu/nztb2y+Gfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="23590269"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="23590269"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:58:05 -0700
X-CSE-ConnectionGUID: S+ehf2qBQCSW993GIRdWFw==
X-CSE-MsgGUID: uuFhaBxaRpO65a529+6E3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36704434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:58:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s83iK-00000008c2B-3SMs;
	Fri, 17 May 2024 22:58:00 +0300
Date: Fri, 17 May 2024 22:58:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct
 folder
Message-ID: <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
 <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 06:24:37PM +0100, Mark Brown wrote:
> On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:
> > SSP stands for Serial Synchronous Protocol and has nothing to do with
> > UART, also known as USART, where 'A' stands for Asynchronous.
> > 
> > Move the SSP bindings to where it belongs.
> 
> It's a serial device which is also used for other applications (the
> other one upstream being audio) so I can see where the current binding
> comes from and it's not super obvious that spi is especially better
> here.

Hmm... okay. Then it's question to DT people. Consider this as a report.
Because UART (aka serial) is definitely not the place for SPI/SSP bindings
either.

-- 
With Best Regards,
Andy Shevchenko



