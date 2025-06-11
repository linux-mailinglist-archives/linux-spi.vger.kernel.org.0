Return-Path: <linux-spi+bounces-8442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1885AD4E97
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 10:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50643A7F5D
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64580242927;
	Wed, 11 Jun 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyCmOX+9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912502405F6;
	Wed, 11 Jun 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631058; cv=none; b=Pp4rzjBXoO57IJUz9+CIRgkhnW8iPmw7eJ3+22kgLLpqR4pqIueGkeJVwphton3riTqwBFO8cUHgwgUT2v4a4vnMAeYDUlNc1Wrt0Zfq1ppj0DPHqDlyCQcIpiyNubEpAZISEEmz111lM40NlalAIOp3u9DzQIYtKshzX9qVxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631058; c=relaxed/simple;
	bh=2kinzhlmz4ZC51GgMVeRamrxVg5pzwaLxW8qfc0MaDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukHxikAlwHAT81oV/wE3WnT58oQBEg0tZReBgZ+pDhCGfCnVnv8nzlP9pFBTuS8fSUc8wAh+5zkPI+gLntSErLE5ej1UBw4jXHq638hq/OvzxrrK7pYfY/FJghp08oUNEuJ1ZcbB1L00DXSw0mE8IbYLKXGPSSEXeH/KB9GV+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyCmOX+9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749631057; x=1781167057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2kinzhlmz4ZC51GgMVeRamrxVg5pzwaLxW8qfc0MaDM=;
  b=PyCmOX+93ixbM+3PqMUpdRv9AneK0Ra9AM5zNbNFi+Ty38dHYBuqDX+T
   l2AKU+N2HbHv+6hRlhY97nKEkj4hfDQ45A3aaKCGPPOSsWJHVr7ut/LGt
   tBRV3TzQjBbG8ACq/gFirW3CkcwIurL6OKHyqSXe61TLDQKhuakujARye
   V3c1P0tyjC2wBAQydJFT0asDzudhJ2/UHYgogYKBqv04KgeCgIwUcLUQ8
   996YnUquvifoiTqNMjB6kR/R24+PBDdaOpnR3fBncxkDZioEjK5HTzqgA
   /eLiU7rLsCQ/33Vvc0JsYfdLQRXd3T0UB4s7ge9it4NZu1J1rHc9hgtxy
   A==;
X-CSE-ConnectionGUID: BgGCNocrTdy6rMB3cxnBDw==
X-CSE-MsgGUID: 5+WG0UHXRsCaLc2T8SYH4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62418520"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62418520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:37:36 -0700
X-CSE-ConnectionGUID: WUkEGOYpTlWF1DvX0mYXGA==
X-CSE-MsgGUID: FopgQGVwQVO8ZzHiCd1LqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="184332570"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:33:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPGtX-00000005aOn-1tE9;
	Wed, 11 Jun 2025 11:33:15 +0300
Date: Wed, 11 Jun 2025 11:33:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/3] spi: spi-nxp-fspi: check return value of
 devm_mutex_init()
Message-ID: <aEk_Sx2qht6WK6yQ@smile.fi.intel.com>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
 <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
 <7afc214a-affd-4a99-8528-c58c31fbcc59@sirena.org.uk>
 <aEgBkROmEV2df4rA@smile.fi.intel.com>
 <d8d1ee94-ee95-461f-a5d8-040bb2a1cfee@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d1ee94-ee95-461f-a5d8-040bb2a1cfee@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 12:46:12PM +0100, Mark Brown wrote:
> On Tue, Jun 10, 2025 at 12:57:37PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 09, 2025 at 09:59:46PM +0100, Mark Brown wrote:
> 
> > > I don't understand the comment about leaking here?  We might end up with
> > > an unitialised mutex but how would we leak anything?
> 
> > In case if the mutex_init() allocates something that needs to be freed
> > (in the future).
> 
> I don't see how checking the return value impacts that?  The management
> via devm is still there either way.

I see now what you mean. Yes, this is more likely applicable to non-devm case.
Thomas, can you adjust the commit message(s), please, for v7?

-- 
With Best Regards,
Andy Shevchenko



