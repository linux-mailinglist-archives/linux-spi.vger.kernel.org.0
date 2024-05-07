Return-Path: <linux-spi+bounces-2763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560318BE8CA
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A11C23B60
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D916ABFA;
	Tue,  7 May 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDa28c5e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39116ABE8;
	Tue,  7 May 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099092; cv=none; b=CAljEbOoVbNCdao2GzIzsV7r6Gl/uvjrSr0ARQ/HQ/hGmSBfKAmRuPo8M/JxpX8ulllz88iANLhfvN6tcyzWOnM0acLKjNWu00eq4POPoHMlHOBod4yOY+REwYKWjFYl00nYxGYxQEc0TOv7nYv3bsxC2FyxPC/VKCpBl0WqsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099092; c=relaxed/simple;
	bh=xjqnat7biDHsSjLjF1RDSmbAHh5gsv1jZ8a8jPor4zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vbq/dqLGuQ5V+EbS+vlG0Ne/tod/pbNGDScXZFDVazqlOI6TJJwpqJ7HoFs2c8bCyvuqvZkY+/kiuaz6XZ22HWQI+3kPnx0H4tVPKNukUQViyOj9mMHLD3Z6qq89XX0eIubUiKEVjUJhuXzZGOYVMC45xBTPADKqIlBRh0gb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDa28c5e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715099090; x=1746635090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjqnat7biDHsSjLjF1RDSmbAHh5gsv1jZ8a8jPor4zE=;
  b=QDa28c5eIjDb0mlWxE12HHQ08Xk99KGl8fqTjRbeKx+E7BNGNhfx7RfQ
   7c9Yn94wX50E3/D8fdjooEas5e6TxUhiS7jEX8VxtKwEmUvM1zJ2enA2R
   mc0G+hXVSTFJRJdZvRGTZArB+UMJem7tBpu8V1gJvRptRPhLlO61Vaspn
   /MExJ0Tt6wcD2DEpav3iR5MHQLI7qjcY+asNNRavVifmg1N60nALiQx0A
   av/5A6g9YImucqNC0VQI3sDW3h6iXOfMkATXK1Jri62tOkBrbGQdNjpLo
   ROs09AkieI/rgh+JFWCGTGAiqL3zuOaaGiQFuXQL5+z4G66NFsVuxwCjs
   g==;
X-CSE-ConnectionGUID: Z3x2xIBhS+qybM/Yt52p0g==
X-CSE-MsgGUID: R0MNQZIFRcSmHvTyBWzxkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21577457"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="21577457"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:24:50 -0700
X-CSE-ConnectionGUID: enH0uxdLSHmnEPpAFEeujw==
X-CSE-MsgGUID: GjkPmm1BTeW4Dlv3J8Crfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="28553500"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 09:24:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s4NcU-000000056c9-0xMI;
	Tue, 07 May 2024 19:24:46 +0300
Date: Tue, 7 May 2024 19:24:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 REBASED] spi: Add capability to perform some transfer
 with chipselect off
Message-ID: <ZjpVzexVvyih2vGG@smile.fi.intel.com>
References: <20220907141344.oDJgraej0r_TWCpXPzNZwflzEvN3hBXTvsBehJGtLSY@z>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907141344.oDJgraej0r_TWCpXPzNZwflzEvN3hBXTvsBehJGtLSY@z>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 07, 2022 at 04:13:44PM +0200, Christophe Leroy wrote:
> Some components require a few clock cycles with chipselect off before
> or/and after the data transfer done with CS on.
> 
> Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
> should have one cycle before CS goes low, and two cycles after
> CS goes high".
> 
> The cycles "before" are implicitely provided by all previous activity
> on the SPI bus. But the cycles "after" must be provided in order to
> terminate the SPI transfer.
> 
> In order to use that kind of component, add a cs_off flag to
> spi_transfer struct. When this flag is set, the transfer is performed
> with chipselect off. This allows consummer to add a dummy transfer
> at the end of the transfer list which is performed with chipselect
> OFF, providing the required additional clock cycles.

Interesting. Wondering if this helps to improve mmc-spi.c case, which
abuses SPI protocol on the initialisation phase.

P.S> just noticed this change in the Git history of spi.c changes :-)

-- 
With Best Regards,
Andy Shevchenko



