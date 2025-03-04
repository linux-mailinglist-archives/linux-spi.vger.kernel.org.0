Return-Path: <linux-spi+bounces-7030-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A7A4E3BA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B730D17A700
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45724C08B;
	Tue,  4 Mar 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvrcpjjs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D624C070;
	Tue,  4 Mar 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101552; cv=none; b=q89KvCt8S3I9HeNlKLsQeDxHDGEC++F6gjMwy+igaR0MyhuRpp/D7fZ3CZO1u/SDX1Mv4K3aMPg2sfFMUwBoP8iAo5BkwgpXgfWGtsjJyteOjW1I+yKYGjlQRQr3D3to8IorMnKcoRMwGSPkopItcOqTXLK1P8uFVrxRb1f/g58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101552; c=relaxed/simple;
	bh=TzxuSWykCCc/zxAzz6e9wDWVq4eBwpwInfgT/Rd5cVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9levfJpwAKINJDGedEej3DbUYXpRjgb3bVr55cLlO/5lWzXrLj2NXbK623GG0+ldYE/TObBFRHviNssZe9eBE86PX23URa8ROiRMIqONXO4O1CVINIAA4DvACClZ4OdbX2mzBauB4K6JAtVoK9LFaxynbd9cujuMey1jFP0iKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvrcpjjs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101551; x=1772637551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TzxuSWykCCc/zxAzz6e9wDWVq4eBwpwInfgT/Rd5cVA=;
  b=mvrcpjjswNQanF0R68jvuiQoExwt68ElFTL5coqK+BbXbo68gE7Xeo10
   jCr3zzG9J3sGXkpFm+4us7rGoQDUo7GdN2NcJUxv29ljeh4YjEcwcA98L
   VQ2sd4bp/nknw9rz3Oixzwc6kEcDUSDoZ3KRe18iiqQ3n+3ny+k6kV9Cy
   cGaXTCLP+n1tqk2uJR5tP6AoKv6X/0xwH6l8FKmGq0ZfihnQ6aseUTP/6
   HSr4XPSG36RoqLXeyzRj5itD6fdFeUlUYD7SEMyLmW6PUX8nea3nPELz3
   L0lJiO8fxKhyEluzPMjpvmySm13MZCCV5CqTLxT/iBKftj8pAyYo7YDsT
   g==;
X-CSE-ConnectionGUID: isLqEi6KQumqg12eFDivdg==
X-CSE-MsgGUID: HN7Qq3COSoqu0Hi1FIq/PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41934152"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41934152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:19:10 -0800
X-CSE-ConnectionGUID: DjwoaqNfT3a2wvxB52yuLg==
X-CSE-MsgGUID: G9CiivFQRg2FKPKgQ48YfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="149188835"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 04 Mar 2025 07:19:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0AA4118F; Tue, 04 Mar 2025 17:19:06 +0200 (EET)
Date: Tue, 4 Mar 2025 17:19:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] spi: dw: Add ACPI ID for the Sophgo SG2044 SoC SPI
Message-ID: <Z8cZ6jXFBnFRK7SE@black.fi.intel.com>
References: <20250304070212.350155-2-inochiama@gmail.com>
 <nvym76w7ezhsugmno65m6jnt54ts5at7jcnn3jfrhlorayjlya@jyl536p2435u>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvym76w7ezhsugmno65m6jnt54ts5at7jcnn3jfrhlorayjlya@jyl536p2435u>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 07:48:42PM +0800, Inochi Amaoto wrote:
> On Tue, Mar 04, 2025 at 03:02:10PM +0800, Inochi Amaoto wrote:
> > The Sophgo SG2044 SoC can enumerated its SPI device via ACPI.
> > Add ACPI ID for it.

...

> >  static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
> >  	{"HISI0173", (kernel_ulong_t)dw_spi_pssi_init},
> > +	{"SOPHO004", (kernel_ulong_t)dw_spi_pssi_init},
> >  	{},
> >  };

> Drop this patch for now as the ACPI id is not registed.

Right, more details are in another thread:
https://lore.kernel.org/r/20250304070212.350155-3-inochiama@gmail.com

And here is a formal NAK from me.

Thanks, Inochi, to take this into account!

-- 
With Best Regards,
Andy Shevchenko



