Return-Path: <linux-spi+bounces-11629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6FC8F8D0
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6EC934998E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A0335062;
	Thu, 27 Nov 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPwoqCah"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA22D1931;
	Thu, 27 Nov 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262259; cv=none; b=ONqQWNY1gliE3cvXXK5Azcsrfu3XOzC3j4w5MWaTV1vNbSY5X/JiEuGwfKcy3P5yX3OePOTaae4M2K7+YZUN1f2Q7ie/jZDuLJUnQaqnF6cYZRjDBUpFwLkUwSOJcuCdsYMlI8540GZ6Oe2nLYhBn+KtUKsuYO2lN9iXKRvldNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262259; c=relaxed/simple;
	bh=JTo0q8/GvvqwlpOQ7Rn1Uy7e8RIy7xdZWP9DoGygm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPi6PpIvs09b8luBITO5ALAr+M0KFG3vWpOC6luFpHYdbH3PyCWl/L0cwrS7E6N+wSNxdsz4982LQnQ1OI3MNmN5h+yEITLbV91pADIL/5okX9JU6x864bKbTgdzuEe/HbySEtuYfsuRSZCobjR3YcoN2wUVWxd3UHmPpCy/8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPwoqCah; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764262259; x=1795798259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JTo0q8/GvvqwlpOQ7Rn1Uy7e8RIy7xdZWP9DoGygm1g=;
  b=WPwoqCahY0QbVvSCq/K6EFy6JMSA73FsnIKUjqq1oUAh2Im0+x3VxAN0
   q41ISElFhvlE7nG2n3c05S4/OrGEzU224I+U/VQKGf40CHrp2CJEJocLz
   ydpR5yQBBsa5bwgChid1p97+legkdI4YtrqXggsq2w7Wf4Fa4CvdVIRbq
   D5heBGpse16TcnPP2FBG7LvkdUnYIBamav8lh+j62/GC0K9yPssrC7B4c
   0QuAWTh4zIrqx1ZQo2M3KPV0lcNjhM7vaKAq6Ndq5MVqtIPIlRYhl70um
   rUMfeqLjSdOmJWtEPYovMSKopDffXi+lG4PyFT6OSyHMncUA4zJX5s2oO
   g==;
X-CSE-ConnectionGUID: qKL6xvw5SrabGb/xEeUQwA==
X-CSE-MsgGUID: qUSJGFujSN+rP+64JIkWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="69930799"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="69930799"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:50:58 -0800
X-CSE-ConnectionGUID: 5Vr/OswtTzKWtbGCcA2aDQ==
X-CSE-MsgGUID: iMI6WxLYQK+b8rQqokdNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192527776"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:50:56 -0800
Date: Thu, 27 Nov 2025 18:50:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, david laight <david.laight@runbox.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley - M52691 <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSiBbS4uboYehB-8@smile.fi.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
 <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
 <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
 <aSiBF9nStZzUNGLA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSiBF9nStZzUNGLA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 06:49:31PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 04:08:25PM +0000, Prajna Rajendra Kumar wrote:
> > On 26/11/2025 12:13, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
> > > > On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:

...

> > > > > I'm not sure I don't prefer the version with one writeb() call.
> > > > > How about:
> > > > >              writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> > > > >                      spi->regs + MCHP_CORESPI_REG_TXDATA);
> > > > Please don't abuse the ternery operator like this, just write normal
> > > > conditional statements.
> > > FWIW, that's what my patch does already :-)
> > 
> > Thanks for the series. However, this particular patch appears to
> > introduce a regression. The SPI controller reads an incorrect
> > Device ID from the peripheral.
> 
> Hmm... This is interesting. The only thing I see is missed dummy byte read in
> case of TX only transfers. Is this what you have?

So, the

	else
		readb(spi->regs + MCHP_CORESPI_REG_RXDATA);

should help if it's the case.

But the change can be updated to still have the "data" be always assigned as
in the original code.

> > I’m investigating the root cause and will follow up.
> 
> Okay, I will be glad to know the cause and help to fix that.
> 
> 
> Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



