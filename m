Return-Path: <linux-spi+bounces-11604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F4C8AF77
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D5344492
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34D328620;
	Wed, 26 Nov 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUQcKDY5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692C328B50;
	Wed, 26 Nov 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174441; cv=none; b=T7r3vUbOP6hbKu0bJbH52tInj6EZN/rza5e8GweQwvEl2qoccs5B19USIJxS/KGV9MxTud3QYWzJMML6Pp5PWJXol6dtSkYdm8ui4U6Zcnmfrc+OMYXMmW0AiVlMk+2Tfpy4aB+3bVarSKwKwBweyqmF4z+u2F2uJmvhZoAbhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174441; c=relaxed/simple;
	bh=Zrm4cIS/gFCy7A/6+Fxi5FH8VZ4BCyx7g+suc0m4fZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enMEphniSk34ivHhS9UAH3+FPoDT1AGeeWg543eLkQUzb755R8rjDQciqB0DfdPKNH19ClC28UPKeHRlDcjKqFrtLEynVhJvbuel73i07eVf5cMB3PXVGnOVqRn7Ty0LHAlsc6AsxY2l3+ts9on18Bh5rNGJvhk62ryg6ZyEXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUQcKDY5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764174439; x=1795710439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zrm4cIS/gFCy7A/6+Fxi5FH8VZ4BCyx7g+suc0m4fZ4=;
  b=mUQcKDY5JYp89YcMzbfxDcPeQUReUrjiVHeeiI+9T6mess0DjFYgbHRb
   G3V4noVlk1VJyRmtgzLWwfbWxvtwJ6tx1Vfe47jxxS0a1VJZYg+DrEKXN
   bCswnWc1I8Snw8hybsvb/4ElFZrB1mo8ZuVRro1rtsDFOwH5GohqrEjE/
   H2eGb5SUkEyXnCM8HiFpqHxi387S+J/M+2FrIy0YVWC5sTepMThNCjy95
   gVaL+48oRc44r33JV6MGqm0tTZwyZ5X7BeEsA5YZxTnpdAQm19tRIfpU1
   lbMCJfAForV/MtoJarv4UO1A1I7IygNMTZJXN2FuebI3AQr5AMfAhursD
   g==;
X-CSE-ConnectionGUID: pjQgCdDyRWyFwc9/MwHVFA==
X-CSE-MsgGUID: pCqXOP86SDGgFdnNTJjcCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66293722"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66293722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 08:27:19 -0800
X-CSE-ConnectionGUID: qkkUpyMdTxKNpJudDuBdPA==
X-CSE-MsgGUID: h31odMugTReGV83TFLHliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193416504"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 08:27:18 -0800
Date: Wed, 26 Nov 2025 18:27:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <aScqY4s5EFgvw_5g@smile.fi.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
 <aSafnlEbZt-yFzbv@smile.fi.intel.com>
 <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 12:03:40PM +0000, Mark Brown wrote:
> On Wed, Nov 26, 2025 at 08:35:10AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 25, 2025 at 11:19:22PM +0000, Mark Brown wrote:
> 
> > > I really don't think it's a good idea to just do it as a thoughtless
> > > default given that there are cases where we actively want a different
> > > interface on ACPI or don't want to see a device used at all.
> 
> > Okay,I think the commit message is a bit misleading. There are two ideas behind
> > this change, one is to have agnostic APIs in use, second one to make code
> > shorter and cleaner. Assuming we are targeting the second one as a main point,
> > does this make sense?

> I'm still a bit dubious TBH, I didn't spot anything super obvious in the
> patch and there's the whole should you actually use anything other than
> DT question still.

The only helpful API which has no par on DT side is matching strings.
Otherwise it's only about shorten lines and less LoCs.

> It'd seem better to make the OF APIs better if
> there's some big win there.

I dropped it in v2. Can that be applied instead?

-- 
With Best Regards,
Andy Shevchenko



