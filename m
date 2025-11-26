Return-Path: <linux-spi+bounces-11609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA66C8B5A5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 18:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927F73B3FDA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935CC278165;
	Wed, 26 Nov 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwenZlke"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F827145F;
	Wed, 26 Nov 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179145; cv=none; b=nw1oWamvOhCY2rbjJCwkrCAqsy+7xC1H6uHyli9sPf/YqGjwSlksI2CMSyCrE2tbS1Vj3SNz8GOyBeKsRA59gI1YtkK6CpJoleu1HN0I4dOIeqK3t2y7/1XO3a6lRBb8M1chYsqxg2Vl3Gd+mfAmtmaNOelWuU4zbsDo4iehTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179145; c=relaxed/simple;
	bh=bNjiJuRjldJ77SFq6uI+K5gNhZKwNvyQ2zvi6WdLxIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo0g9W29DTW8QzrWtpsOnn5+pWGK662yJ7VNdgxWczFVAzPoAv8I4yhHLhkTtigy8uMN29NlnOV9kqaVx52zrwi/dUy6iCcqQNtj9QBwqZgjYg3IGWC0sN3nwfY3MkjmBy3qRxNRXJDe3tJouU7yyjuwTUnjz++OlqFH9wRAbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwenZlke; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764179143; x=1795715143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNjiJuRjldJ77SFq6uI+K5gNhZKwNvyQ2zvi6WdLxIA=;
  b=NwenZlkeoHVq279qs5z6qjVeU3DVdI3rk3nB6emyxsVbjVFHSmglml1W
   tD/ciR6at/Mj9LZQbnf101D8fUFwYVpDEdz8qLAYUCqO+xiAahPjBzZu8
   Pntwk7MtelLy2FNC/n9KUNvjNwHXS/w7Rg9DQV0U4S8Cw+lQzzICFNi/l
   5rGQjR9eShor0yg2+xgK0gv8Sdct1E+8wLVTVSE3Ff5oEcNP5AKbvjKsU
   8AQ9iSn8S/KsY3ewLTbZq6F2HQtIqPTr1UFx7XHtrTiFtb8MlUgHn1vdy
   Bi4FWiAgXUM9/x4d1gS7PT4UYjltRMeSg14QzRffgiRLXRX56rrjL9vRc
   A==;
X-CSE-ConnectionGUID: IiD0FhaWTcWEwfTj1HK6/w==
X-CSE-MsgGUID: piH2HTE2QvO0P8m6J0HYdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66114111"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="66114111"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:45:43 -0800
X-CSE-ConnectionGUID: Hk2dz5I6TK22Ba5/hUQRhg==
X-CSE-MsgGUID: Wuca+whiSyapFi/qeoiJ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193440753"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:45:42 -0800
Date: Wed, 26 Nov 2025 19:45:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <aSc8w3sURlq3SPb2@smile.fi.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
 <aSafnlEbZt-yFzbv@smile.fi.intel.com>
 <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
 <aScqY4s5EFgvw_5g@smile.fi.intel.com>
 <31ef355a-9b72-4c78-aac2-b632f5e22c07@sirena.org.uk>
 <20251126-stagnate-uncut-6d01fdb2f9bf@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-stagnate-uncut-6d01fdb2f9bf@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 05:29:20PM +0000, Conor Dooley wrote:
> On Wed, Nov 26, 2025 at 05:24:49PM +0000, Mark Brown wrote:
> > On Wed, Nov 26, 2025 at 06:27:15PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 12:03:40PM +0000, Mark Brown wrote:
> > 
> > > > It'd seem better to make the OF APIs better if
> > > > there's some big win there.
> > 
> > > I dropped it in v2. Can that be applied instead?
> > 
> > The microchip people do usually review stuff.
> 
> I mentioned v1 to Prajna this morning, she was definitely intending
> providing review, so I'd expect that you hear from her on v2 soon
> enough.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



