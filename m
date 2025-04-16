Return-Path: <linux-spi+bounces-7609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35CA8B1B8
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE273B72D3
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDBB221FB8;
	Wed, 16 Apr 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfpAEuQJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DC1D8E10;
	Wed, 16 Apr 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787379; cv=none; b=TScOmFQ4Ov9BYWiEWSs0MUqAeyygC3NHdfIxqa3sP+0F9Qcr/rZJkwDvogvLPJuyFD+xaHxOuHoJVNVKVNAvZQ+eh3j2SacbWjjTSBvmO8wHIy3tIW4ymP/lfUMx/SdCo1DPzheMlIRC+jVhBApNqUXcxTqCxMitg1J2c659jLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787379; c=relaxed/simple;
	bh=mreBMLYe0CKLqCE1BsZv7kMlpxdCG883OuYrHI1cFh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av3BT66AuPJxI9TDcvWmFAC0i/0pGpOHT4Uyvbqm11nb8vdaQmvQIHXI08as78lBSp/sqUjFSJbMs7xTQpqCOMUldsUk7TudqOYs+Mhudx5Ze/33annVg2I7BxGttNT0FiFJ9dAOTaUfRDLQAjTkv5MUhDddbIgzgshFv0NFR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfpAEuQJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744787378; x=1776323378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mreBMLYe0CKLqCE1BsZv7kMlpxdCG883OuYrHI1cFh4=;
  b=NfpAEuQJgWuyMyXJGTtQVS6uX6RUUSudkTEslsj5ayNOQMMyjdEqqCgO
   9GVjzdeJRE5/1WrGD9Dgy8mbaX7hxRPPX7hf/FNj8PO5diJ+w4UCEw24+
   QL7VwTMzOliJHVhgI/L1ZRBJMIKFHQsYYSwIQNR9/k6IZHWp2yfZGXgNB
   8s+QA016PktE2OsqDXWu+iCy/cviigC8Z3gv/ytMTB+dU6ko7hqfy7/If
   U6N5ScsXUGBoP6+cy0RNjQTrQFgN7l55dxOTudXiH5k6szcN6yxO5TU91
   j1Vg14cibGXGb8JO+7rodIZMlRAAXApeaXs9jD02fCtn1IJiO7vvNhYh9
   g==;
X-CSE-ConnectionGUID: r3PZHjQhR2Crz8ectXUmKg==
X-CSE-MsgGUID: MGdbwVmITIq8GzjOAFDyoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63860334"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="63860334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:09:38 -0700
X-CSE-ConnectionGUID: 6fwnGrY9QsiRUgthTi8peQ==
X-CSE-MsgGUID: cuapS7feRGy6doKbTgPOKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135524565"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:09:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4wtp-0000000CmAs-2GEo;
	Wed, 16 Apr 2025 10:09:33 +0300
Date: Wed, 16 Apr 2025 10:09:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v1 1/2] spi: Add spi_bpw_to_bytes() helper and use it
Message-ID: <Z_9XrXweruMZ1LvE@smile.fi.intel.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
 <20250416062013.1826421-2-andriy.shevchenko@linux.intel.com>
 <db36c119-c6f6-42e9-b8a0-f09e9e5a2585@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db36c119-c6f6-42e9-b8a0-f09e9e5a2585@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 12:33:24PM +0530, Mukesh Kumar Savaliya wrote:
> On 4/16/2025 11:46 AM, Andy Shevchenko wrote:

Thanks for the prompt review, my answers below.

...

> > +/**
> > + * spi_bpw_to_bytes - Covert bits per word to bytes
> > + * @bpw: Bits per word
> > + *
> > + * This function converts the given @bpw to bytes. The result is always
> > + * power-of-two (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> Would it be good to say in 4 byte aligned /Multiples ?

It's not correct. The said wording describes the current behaviour.

> > + * Returns:
> > + * Bytes for the given @bpw.
> Returns: Bytes for the given @bpw.
> Good to keep in one line.

Aligned with the style of the other function in the same header, so I prefer to
leave the style the same.

> > + */> +static inline u32 spi_bpw_to_bytes(u32 bpw)
> u8 bpw ?

Nope. See below why.

> struct spi_device {
> u8 bits_per_word;
> }

> so arg should be u8.

It's aligned with the above bpw related function.
Also note, that this helper might be moved to the global header at some point
as some other subsystems may utilise it, so I don't want to limit this to u8.

-- 
With Best Regards,
Andy Shevchenko



