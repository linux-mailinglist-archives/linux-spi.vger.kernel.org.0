Return-Path: <linux-spi+bounces-7116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938DA5F72C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 15:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9D519C239B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6770813;
	Thu, 13 Mar 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHyC3yRy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF347346D;
	Thu, 13 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874515; cv=none; b=O0zyULSPQD9zNNNmo/+VBCBaz/+UYB1zWBLQQig73dBuqpU+jb8XZ/7d706vTRLJfDcSCBr5JCcftuB6s2PRo2LjYslpYTguFiQhCCaqJiduGbc5I4qTrpOktEuRtKRMeVEoID9VOo9O4k++jW9lU9jWl5w6mbgU+BpYAEVJChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874515; c=relaxed/simple;
	bh=UQJd59E6gmYMorGBrKuxpH2LfzIAgPkg97I9q5PiEec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn0ZU63bpp+WNnQk46A6bjiKQjGnkSEQK16pp/8nplwhliok645NUPOs551NrvsigeJwg92ef1Ue2d95RDKzdz3BDHjAdU6eAlfobVIdxhnaI3VU9m98scIcHSMmWt/BA3AZjJMOKLO/koYW6MYNfwAWo59oxr5RyXsHt/PZB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHyC3yRy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741874515; x=1773410515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQJd59E6gmYMorGBrKuxpH2LfzIAgPkg97I9q5PiEec=;
  b=gHyC3yRyoRHrCoqEmSL1T5OcdzjbFth0JvRuCKkqRirynFXZ4FwaJlq3
   GvLM6XWfrCB2OVQLT0dCdM3CCvFpgmh2wohEgRD75/anBQ40oYSLKKCda
   yu4+pzXK2LMT+z7i1HdTzC5N/sjRmH/gfoKAGwF27745IkM/H29f/vzNO
   rd63Nu/bmtFI2xMR0x+/JsqYDQG74IqVnMay+HeHHojJMqh1kwr4MjC4C
   JYPClXFzOiPOioABgyRXSUW0Y90Ld3zMip/znQqwqWEenPRJig8semmL6
   71tLrbKg6uEkfRKUh0CXS7rZvz3I89TdHt/SO7PG+/8qIcXs/cExF8bc5
   A==;
X-CSE-ConnectionGUID: WtypmPDhQXGIs6h+T0TXmA==
X-CSE-MsgGUID: e8YgJr+HTQCMjJ4ZVEbxdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43093363"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43093363"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:01:54 -0700
X-CSE-ConnectionGUID: Wpao57hOS6mRoQigZrL1vw==
X-CSE-MsgGUID: UiAD3bjaS/GJXieHF//i5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120750166"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:01:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsj8A-00000002C55-00qX;
	Thu, 13 Mar 2025 16:01:50 +0200
Date: Thu, 13 Mar 2025 16:01:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Use inclusive language
Message-ID: <Z9LlTflb1HQMyEv2@smile.fi.intel.com>
References: <20250313111442.322850-1-andriy.shevchenko@linux.intel.com>
 <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c49edb2-2ffc-419e-be5e-7e15669a7839@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 12:47:32PM +0000, Mark Brown wrote:
> On Thu, Mar 13, 2025 at 01:14:42PM +0200, Andy Shevchenko wrote:
> > Replace "master" by "[host] controller" in the SPI core code and comments.
> > All the similar to the "slave" by "target [device]" changes.
> 
> This doesn't apply against current code, please check and resend.

Hmm... It's based on the spi/for-next. Should I use another branch?

-- 
With Best Regards,
Andy Shevchenko



