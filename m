Return-Path: <linux-spi+bounces-8424-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBADAD32EC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E103B0DF1
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C128B7CC;
	Tue, 10 Jun 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKHygNYQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92B28C013;
	Tue, 10 Jun 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549468; cv=none; b=GBakR3LZnRgstDVDk2my5sTc3HmduVBjMPrSwtJ/UsOokRn8t3BpJbXDVUf9Vr2HvOtfPSGKYlksx71Kn5c/PnDJlw3Qi+lTlHHRtWzfQL6aa5XjklfoRuHhj3l2yHR5jFicqZJBtCGt+lmTprW+DJcZ8QT4IDmuwahaIsQh3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549468; c=relaxed/simple;
	bh=ImjjDdcR0PDR/B0hW6U6b9uAanK0m2+0ZrpHzZLv2xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPupk8Dp6ROHD+tbRZwDb5GQvLaxek2VUhhDaGw7q8Zycn8bfMxJXNrTgWY2HbHkj21YfEVDXhtfSnx3gZaPakmJwDA7+pxUCK65nnMBfrUXyMXIKa29TXBc7UC8Mv96EGV5/JsB8hCEseQZVNQaHKDPWyUH0Y2/sfA1nk/JIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKHygNYQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749549467; x=1781085467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ImjjDdcR0PDR/B0hW6U6b9uAanK0m2+0ZrpHzZLv2xM=;
  b=PKHygNYQdI9D4flMuzw7JPdbRKP0Zkw75AdmARP6p0LIroSZjc4uyyJI
   VNmfIQVOwqy1o2Q05S55tv36fQZUnd36QOSVMCf4ArXfoukWJxlqpppSa
   8cHrJ9ee7rAKTFP9J62Cdxoj7Xgv2PKNbYe7MfaW7DVqMtm/lO8+TWzsu
   tDsB2hMb2kUZBHoHZKP+mcoImdBQkzZdDruFj7EaasQE2ExJm+qxzr94+
   PpZLTHDLCq3QNmDlcITE+2bVotMyEUDck4HUKonw+8z7+8eAppo1xzTcT
   WfGrIClVmei8Qe+7UA9gThZsV/C8cwni8IYWuBiqcA4ZUiMCgsBImhjFp
   g==;
X-CSE-ConnectionGUID: PFfajYLTTS+59hOIqLhJ/A==
X-CSE-MsgGUID: NfZttT+aRY6DY4YPHL+3Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="74184743"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="74184743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 02:57:46 -0700
X-CSE-ConnectionGUID: 5j80a83bTXmxzQIG+3ulhA==
X-CSE-MsgGUID: 2r67tEUWSUKZ8gLPPEVWxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="177719736"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 02:57:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOvjd-00000005JZB-3lD4;
	Tue, 10 Jun 2025 12:57:37 +0300
Date: Tue, 10 Jun 2025 12:57:37 +0300
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
Message-ID: <aEgBkROmEV2df4rA@smile.fi.intel.com>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
 <20250609-must_check-devm_mutex_init-v6-1-9540d5df9704@weissschuh.net>
 <7afc214a-affd-4a99-8528-c58c31fbcc59@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7afc214a-affd-4a99-8528-c58c31fbcc59@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 09, 2025 at 09:59:46PM +0100, Mark Brown wrote:
> On Mon, Jun 09, 2025 at 10:38:37PM +0200, Thomas Weißschuh wrote:
> > Even if it's not critical, the avoidance of checking the error code
> > from devm_mutex_init() call today diminishes the point of using devm
> > variant of it. Tomorrow it may even leak something.
> 
> I don't understand the comment about leaking here?  We might end up with
> an unitialised mutex but how would we leak anything?

In case if the mutex_init() allocates something that needs to be freed
(in the future).

-- 
With Best Regards,
Andy Shevchenko



