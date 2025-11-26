Return-Path: <linux-spi+bounces-11556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442FC88488
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3104B354B83
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 06:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE03126D4;
	Wed, 26 Nov 2025 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzFEicHP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3B9463;
	Wed, 26 Nov 2025 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138916; cv=none; b=pTrmP9e/+RsbNUyAmWlnv4lCoPdZ4WVjr8mTbeaBx8Y+BMJfi9RI6WBLxnIWUmxKOmiq/E0WLiOZ0TQVY+BqVq47wC7BZyh8iTTrVfnDfZ/sKmsHQkFTWKILa5aLKbc0N4H+WN3VnW0RBV4Moi8sRf1HNumjLwImMxj7DY/Uccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138916; c=relaxed/simple;
	bh=xhW0E9TfyUHecCdx8QymwC/On9IUxVuYFUn6lSvKA+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2P0MJueNU3qdk1/CDhuAnzteLBPkGS5uV/ZGA0ENr8WHTuCY+1V3ISkhYWPh0OpNqX7lueaaFUu8LTcoHnTFbFcuj/K5oBSQW/OEsGw/TNo69rXu0UY2qJDkF0Ge+LrzHuhdq7bunoqm5MNloI6wQrHn25/80ufn/hofA4ym8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzFEicHP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764138914; x=1795674914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhW0E9TfyUHecCdx8QymwC/On9IUxVuYFUn6lSvKA+o=;
  b=QzFEicHP5Kk9a8TrZBetMQeNzzbaWJucyRjiXtmW6tW2vddJWLHAEzwe
   8nQXHkHOl580nUGJWx3R327v2NGlnPYFmKRUXOvo0fc+X/c1jdiJyUw8M
   ZvfUQAFCxvobs3uGLVpo9FKjuOI/93r48llJZ6wRQmen1KqkjKZFS4kp/
   7zzHVemANJQJyRxEXEGfKq5yr+mbOBKE3OBhw9ernfWF/P+x0jTOBIXgo
   K3+AKdXIBA2CQEqyNXXTLqlsxzt/viCTB0w0MDiSzVSb2EJEffp9vWYg8
   uBQKz86uoRLS9UqSYIvkTEtYFx2fb7te0ltBjUa2Gcoat8bXm3J1yjxPz
   g==;
X-CSE-ConnectionGUID: z/lrBCEeTrOipVI2P/BMfA==
X-CSE-MsgGUID: H1sXAXDAS/uiMTqq6TywlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="88815201"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="88815201"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:35:14 -0800
X-CSE-ConnectionGUID: fBws4BlaTkGFAQZm3eTuSw==
X-CSE-MsgGUID: Wmz6VJdLQSa1z2ocQ8HxTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="197335889"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:35:13 -0800
Date: Wed, 26 Nov 2025 08:35:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <aSafnlEbZt-yFzbv@smile.fi.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 11:19:22PM +0000, Mark Brown wrote:
> On Tue, Nov 25, 2025 at 11:00:48PM +0000, Conor Dooley wrote:
> > On Tue, Nov 25, 2025 at 10:42:12PM +0000, Mark Brown wrote:
> > > On Tue, Nov 25, 2025 at 09:15:32PM +0100, Andy Shevchenko wrote:
> > > > Convert the module to be property provider agnostic and allow
> > > > it to be used on non-OF platforms.
> 
> > > Are we sure that these properties are tasteful and sensible on an ACPI
> > > system?
> 
> > If you're on an ACPI platform, you're probably not using this IP.

OK.

> > It's
> > really old and in need of an update (like what the "hard" version of
> > it got), we just happened to have some customers that wanted more SPI
> > controllers on the FPGA. I dunno if using these provider agnostic APIs
> > is something we should be doing where possible as good practise, but if
> > it's to make the IP more broadly usable I'd say that that's mostly
> > wasted effort.

See below.

> I really don't think it's a good idea to just do it as a thoughtless
> default given that there are cases where we actively want a different
> interface on ACPI or don't want to see a device used at all.

Okay,I think the commit message is a bit misleading. There are two ideas behind
this change, one is to have agnostic APIs in use, second one to make code
shorter and cleaner. Assuming we are targeting the second one as a main point,
does this make sense?

-- 
With Best Regards,
Andy Shevchenko



