Return-Path: <linux-spi+bounces-11650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CAC92773
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6BFC4E2036
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140023370F;
	Fri, 28 Nov 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agCqebgt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25A72602;
	Fri, 28 Nov 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344379; cv=none; b=DQAJGBhGMmd4HxFkQBUuxQVSGvAm/0JsRS57UzdrSXau5y5SR5L1u7QIWzgak2ON2MqW6yWHlAVgx1qx4y3qz4WxHaJRQS+xYoEbHevRv2+l6v49Uz+5PlU5O1eyRdW+5lzpE/O8rrBFsFNq9MpPVAk+4KzvOHUG6WEiYKr3p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344379; c=relaxed/simple;
	bh=BirTztAm3J7EG9K2o/nrovxnsQunfCoXlgCi7jvpzsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg+nADWu9lpdInBe2EEbh4DZM/uCGYSJyD9O5/6tXHtc9vp86QpTfDGbSCwKzQo8/iqy8/67mXT6qOw5RvQ+66GZqbpLNNQxT8WSI2xGq7fdqQHryvpwAobwqwJ8c+vbyPn/8L1Rh6aNZC8eUWXVbYRzry1x2Ei8sQc0B3n4UeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agCqebgt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764344377; x=1795880377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BirTztAm3J7EG9K2o/nrovxnsQunfCoXlgCi7jvpzsM=;
  b=agCqebgtrdeymAohmb0JdnSakHvETTRJfqIkXJf083kp049Gn3mWfKC8
   RVvqSmxlHA981Iivcwo9+1RjdLkvtVRqhFeGzmwupbALxin1RI7+yPMhW
   EKsI9JqLeCg/FuhoJ7zSANK+qur0U7gMhnLeYCynjLfb1dzuuGuojpHz2
   3Q8eQNpfgcjRPbo62zu8avhmDxw2yTL3WeS0qTtsbh6gjz5SN4fMNxZlX
   swigP+PxQe+noZ2ZNas4yG4YqlpBo9CxO0wWlbT19BdVzoSuLvdORllYr
   r3ByGVXtMqVtx9JpnPbe2ijhc7CXC5SJiWjLHjtOKUZZkQR/JXJ5AKLbw
   w==;
X-CSE-ConnectionGUID: pSdzUDvoTxKJoWqHSelnIg==
X-CSE-MsgGUID: oRde8Kj5T2mruMzhWn4G8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77846353"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="77846353"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 07:39:37 -0800
X-CSE-ConnectionGUID: xihPRjW+SiOVNCZq3mtnIg==
X-CSE-MsgGUID: +9xeXULnRm+TtP3YR7jsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="224190759"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.17])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 07:39:35 -0800
Date: Fri, 28 Nov 2025 17:39:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna.Rajendrakumar@microchip.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSnCNVwEBKhbppvA@smile.fi.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
 <20251127190031.2998705-3-andriy.shevchenko@linux.intel.com>
 <CYYPR11MB8386F204FAE5BB6220944DDC90DCA@CYYPR11MB8386.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR11MB8386F204FAE5BB6220944DDC90DCA@CYYPR11MB8386.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 02:16:27PM +0000, Prajna.Rajendrakumar@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, November 27, 2025 6:59 PM

> > Make both handlers to be shorter and easier to understand.
> > While at it, unify their style.
> > 
> Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Thanks, I assume now it works? Since Mark applied all but this patch from v3,
I am going to submit it separately with your tag included.

-- 
With Best Regards,
Andy Shevchenko



