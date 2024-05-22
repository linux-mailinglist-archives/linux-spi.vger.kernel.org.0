Return-Path: <linux-spi+bounces-2998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493A8CC329
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34A11F21418
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29B1419B4;
	Wed, 22 May 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRguW/6C"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646913DBA4;
	Wed, 22 May 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387750; cv=none; b=HbkKNJATJQtLZobiAHYcvPr6990rTdB/o6uPg1fvglv3a9mhYy5DjUpEn2TsGsrkwV5Rp4EwkuIflV8lzeGBvlYSDdqd6IKwJ8XFHdoCf0PpbJWAvS0+Jj2OpfaP70FvP4ftHGiiFxNfz58HVJV7rfZ7Mq05tk+VkS8TomUntxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387750; c=relaxed/simple;
	bh=suVrlw0nFzc3lB2cYZbKfBlNaV+EXs/T5pbTxcvyUJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOpzxEeNcQ4dNSz8PlA1C6CxHX/Jfgg8UTfgjlWfA+u5u3ISq9IcSrSVk0HwqbINXKwcggtjoEGUe7aOmRbphwnu8RV/ub7Vovwz1Ye8KPWRru+qurx4m0mE5qTD0ukE8HdF5x0sPiVRETIdpU8YR9os289cdWOG/qMuXY4O4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRguW/6C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716387749; x=1747923749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suVrlw0nFzc3lB2cYZbKfBlNaV+EXs/T5pbTxcvyUJQ=;
  b=bRguW/6CffoK0NZVp50YNOgvwNg/vYY5zatUc0KDFOlZ7hsB5lS3iM4E
   GzKUmDIX+17eDft0+Fh/eIpCDYkKC60Ejz+GpTvuSPtSI4RHns2gedEl4
   bcefbdfROVDuklSAbHjh/1obC1DgZeOQ2QMtxOWPG6WjmeceeuJQvJ6Oq
   thySkvUpWU750D0xD0B0tKcj6By8YEPnksb7X/2GYtqhIqQi9BPP3BlmR
   aD3ZH8uDPDPoVpmKpkPdJAuEOHkc2kmG2gL3w03xCKjb9Rnlb/ZZvVeCJ
   l1A8hZflVhOCG6mpj2eWE+rlvVkIWN28PTZk7pVZPwXUk/fgGL6Ul3abl
   g==;
X-CSE-ConnectionGUID: wWHEUyfrQXK3MdQY1veTLA==
X-CSE-MsgGUID: 6U1VOcCRRJKY6rAsh3V6aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16473448"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16473448"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:22:08 -0700
X-CSE-ConnectionGUID: y1hX3QJjQ7i5UrmlX0ooBA==
X-CSE-MsgGUID: ZlqPq3bHRNqj9K1zaEWn8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33886167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:22:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9mqx-00000009zT4-2IdD;
	Wed, 22 May 2024 17:22:03 +0300
Date: Wed, 22 May 2024 17:22:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into
 schema
Message-ID: <Zk3_i6JabA-0j0eE@smile.fi.intel.com>
References: <20240522132859.3146335-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522132859.3146335-1-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 08:28:58AM -0500, Rob Herring (Arm) wrote:
> The Marvell PXA SSP block is the same or similiar to the MMP2 variant.
> The only difference in the binding is the PXA version supports DMA (and
> that's probably a binding difference rather than an actual h/w
> difference).
> 
> The old binding didn't belong under 'serial' as it is not a UART. The
> SSP block also supports audio devices, so 'spi' is not a perfect fit
> either. As the existing schema for MMP2 is there, just leave things
> as-is.
> 
> The examples in the old text binding were pretty out of sync with
> reality. 'clock-names' and 'ssp-id' aren't documented nor used.

Thank you! I believe this is correct implementation and
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(can't fully review it due to lack of DT knowledge).

-- 
With Best Regards,
Andy Shevchenko



