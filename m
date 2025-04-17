Return-Path: <linux-spi+bounces-7645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33190A92225
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E91B60E0A
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54A35973;
	Thu, 17 Apr 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnVKcOXK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E71B4257;
	Thu, 17 Apr 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905615; cv=none; b=HeIYC/ZAUnVff13eKNRRNVydLB5OwH7P4ZKLxm32zm42/A1trAPWsw3oyiz4xe+6VspfkYl0YcVfiXLGJxnWdslIHEdOF+xXZTIf2qQP5aLCSp9skaRIOw4B1N1VXUcNNfzFxkaqVW6pn+hPektAudtL2W+OMiYGiSaq1kmIBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905615; c=relaxed/simple;
	bh=ZS6x8bwMHLKxIJFgPFcle45gVqwHALfPYTkIqt51OIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgelFZ+9Xi7XXLOxfXHP86C2ptfW+rxhOub/CI37MBntew8Ao6Oo3kxWaA8aPcAo+Azcy34RoLN595An63WDTqhxXUDjH1CGDhWZc6t9YDTrL72hnGRVPXVZFSwbsloybxF9shHlf4DEXyn5IMjyPeKrsfPNRRBf8K995Y+rJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnVKcOXK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744905614; x=1776441614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZS6x8bwMHLKxIJFgPFcle45gVqwHALfPYTkIqt51OIg=;
  b=KnVKcOXK1dRtUbGYCaAFSYvwpoNJfOFE1/Sg87IhkXUC/fLnLPQJHZ8B
   0zik8tKKZMUtLTz0VC/cWew7AI+xFV6zPgqx4BX2CmSwowu622d2HwowH
   vEBDxwqOp1/ZUTD7R6AO7RtA9AIIWg/7Zu1RGnnTQ8sjC1grXtN2dn/Mh
   lfdM5pi53JzGfNqVmwrNUjDd4A721WGfFaRkCU2vQZyaknELHvxbLr9oh
   j+oiTiNV+pp9aLjKtAga0+64kNfzQ+wBvfYpXB8X0kFbCDQt3AlEJAIpi
   lTElFZS+iczLOyKSrc6IIx5ZWGxiF0xAZ8yztFE8A1HxiXzQ8CxHvSCl/
   g==;
X-CSE-ConnectionGUID: PjAiZrjlRdWa4Tc2kYDdjg==
X-CSE-MsgGUID: lnJdVi2xQUS4BTQS8tP0KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50323733"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="50323733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:00:13 -0700
X-CSE-ConnectionGUID: nrHJ4FFhSL6QwQxXjGyLEw==
X-CSE-MsgGUID: wf/ikSkJTQ2l4EvXayOsWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="168033914"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:00:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u5Req-0000000DFFp-3clD;
	Thu, 17 Apr 2025 19:00:08 +0300
Date: Thu, 17 Apr 2025 19:00:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] spi: Introduce and use spi_bpw_to_bytes()
Message-ID: <aAEliMw1YDjnfEjc@smile.fi.intel.com>
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
 <1e22baf9-303e-4e49-9e9a-0daa3cd4caec@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e22baf9-303e-4e49-9e9a-0daa3cd4caec@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 10:30:46AM -0500, David Lechner wrote:
> On 4/17/25 10:24 AM, Andy Shevchenko wrote:
> > Recently in the discussion with David the idea of having
> > a common helper popped up. The helper converts the given
> > bits per word to bytes. The result will always be power-of-two
> > (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> > More details are in the respective code comment.
> > 
> > This mini-series introduces it and replaces current users
> > under drivers/spi and we expect more (and possibly some
> > lurking in other subsystems).
> > 
> > Mark, if you okay with the idea, please, make this to be
> > an immutable branch or tag for others to pull.
> > 
> > In v3:
> > - fixed the typos in the examples
> > 
> > In v2:
> > - improved examples in the code comment and commit message (David)
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



