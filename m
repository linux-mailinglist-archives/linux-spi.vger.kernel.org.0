Return-Path: <linux-spi+bounces-11082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C91C3B24C
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A794503479
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1130F932;
	Thu,  6 Nov 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSi1hsmS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF75328629;
	Thu,  6 Nov 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434557; cv=none; b=HA9lQ2fPOCoZfu6NaX3DqbTRIHylHng54dybQDleArHZQYSiO/r2Skih3nTMZkt8/wkvwm/h/2GbXT42qOMCzNr7Mq0l18HLKdWV3KNHYg9EhvnK5tEIwL/PTKc3jsfWU8HwdhnGpIImgQbeE/UIJFpppyjuVUBNr3nYgNKb/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434557; c=relaxed/simple;
	bh=nPjR0g11ycxjlGJ3jFNRI/IfJdx8z68Y2k3KkGmy1tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOK47sS72l95pFvS4KVthvzKZsNXhBe0x4Jo0wclkCFGQ4wlRvgbXFvYrQCOuKwpYvHdQAQKm0c7oiDCBd4NoCJT+Nzp0iG9qTz4lJTMk+2tSxxWnd8yhnAEaerkLN0skHzzsYbQNkMAroHDJUT7dYW6CPwqGOu3Y+DXPSp7e/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSi1hsmS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762434556; x=1793970556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPjR0g11ycxjlGJ3jFNRI/IfJdx8z68Y2k3KkGmy1tU=;
  b=kSi1hsmS/suA70FKXEG6Z1a0spyuo8WjnbblaavZ+aY51TLToVBw9KvS
   JiB7acfxe0VexkHnQrI/uHKi3+r+XDaJHRFY86sR4DBPK55izlgJpOiKm
   kPV4mQyC4HBP6zO32aU/ZkdQ5J7gCsPhtAeIWc1wQ6QOlB0O7AKF3HPpB
   ix1JuvMwFho+/OY54hAYSI2InqYalB8Y/Na/+qnE5SQKlHP6e5bNBZSLi
   +u0uDRiSEog9tP84hCMJ01Or3mpB24zE2Vuzpv2Esdg2ECmj7iuNW3BAo
   +xjnu60J0XIpi1BO6C24QTr7Ec2gpkfXvYRR0L+f/wQTL2k7yNJTtPF2j
   w==;
X-CSE-ConnectionGUID: gEP/20r/Q0+KZkrnaBrpxg==
X-CSE-MsgGUID: OtbpbnhvS6qU9YnQhq/p+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64607598"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64607598"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:09:16 -0800
X-CSE-ConnectionGUID: MCsQxvIRTuik0TQvgCTIkw==
X-CSE-MsgGUID: SJPA9Z51Sk+whnHZJ4VArA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192109543"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:09:14 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGzji-0000000661w-2ix6;
	Thu, 06 Nov 2025 15:09:10 +0200
Date: Thu, 6 Nov 2025 15:09:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQyd9SOGs5Cot8Y-@smile.fi.intel.com>
References: <20251102190921.30068-1-hansg@kernel.org>
 <176242886085.2357454.1138821772017853306.b4-ty@kernel.org>
 <935e8578-1c25-4015-bd6e-a41cd0f07c81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935e8578-1c25-4015-bd6e-a41cd0f07c81@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 01:23:21PM +0100, Hans de Goede wrote:
> On 6-Nov-25 12:34 PM, Mark Brown wrote:
> > On Sun, 02 Nov 2025 20:09:21 +0100, Hans de Goede wrote:

[...]

> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> > 
> > Thanks!
> > 
> > [1/1] spi: Try to get ACPI GPIO IRQ earlier
> >       commit: 3cd2018e15b3d66d2187d92867e265f45ad79e6f
> 
> Thank you.
> 
> I believe that Andy's Reviewed-by was intended for a v2 with extending
> the comment with an extra paragraph with something like:
> 
> "TODO: ideally the setup of the GPIO should be handled in a generic manner
> in the ACPI/gpiolib core code".

Yes.

> Since you've already merged this now l'll prepare a follow-up patch
> to extend the comment with that info.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



