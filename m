Return-Path: <linux-spi+bounces-3124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38018D36AF
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 14:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118F71C20B1C
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD071FB2;
	Wed, 29 May 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUX5Vt7q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB061847;
	Wed, 29 May 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986892; cv=none; b=rmmHaK3FJypA3GN/ks+0JEDW9NgOF8SzeCwXD8XZCOgwC0SjWlIgPqLHcLmYhplA5wbMcABU07hpb2FefBwq+bL5fIr5eZ0dF/FuKc075PtrdzItmaLFm0ppyhmWfl1AlhYskLEZPJ8mgpdX5pzLcwRpnXPo6dV+ZnlReqMx+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986892; c=relaxed/simple;
	bh=9pJvNja2U7PLURXTO3eftWYh0qDuyaJBNkaVWjDGzR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp+1481i0fidfz8JRE3IGew/As/1Dnm8Ke7lrEB5kQFYM5OTPbJ5YHjPMDE9O6cTUk2Q5XUMqSM06noDNffl0kBVIMss5+GuXY6DZZbuNrLESnwyVZETy6EbcO7s9QNb7IlQaZJtdjrSrI+2K72ViCdRw51MErEpBeH6HzpRl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUX5Vt7q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716986891; x=1748522891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9pJvNja2U7PLURXTO3eftWYh0qDuyaJBNkaVWjDGzR0=;
  b=lUX5Vt7q8CMO4zlxOTOP+cbeYrBvT2qvqj4tXJ27CPvbhslDiTIhb7wy
   5+TbogQzUJ5E53CROknD8+3bgzuJRNmjoU9pZCjKUlU3r3Y+eaN682jdK
   QzfaePPQm8pPuWYrNo3Yj9adzOQemNjO+YIWzz0J4EGJPUpliiUTQ6vz8
   0eheIMiuiYPlC/2mhfmJH+/Yx7YwPbsJVEu31DOfnYHSeCS/CFESx9Qup
   jQPo9hLKeyb4FnCH7RV7Tm2PNcZ5ptPQBQ+x352zRggnyjjA+zxIL/eSW
   PzMQVjzQxc+eSEIucGS/YSq3CLYFWwJEq/rCuf3pFV/wIhH2l8zevJP7p
   g==;
X-CSE-ConnectionGUID: cE/5HA16Sc+jCcop+v+xcA==
X-CSE-MsgGUID: fBTP5M4rQmGoDfVEQpgC3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24040527"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24040527"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:48:10 -0700
X-CSE-ConnectionGUID: GbmwNwHdS9KpuWbz7QaFNQ==
X-CSE-MsgGUID: 8wwERgIWTI6RcqwHppxPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="72875655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:48:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sCIis-0000000BnNm-0vFs;
	Wed, 29 May 2024 15:48:06 +0300
Date: Wed, 29 May 2024 15:48:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] spi: Check if transfer is mapped before calling
 DMA sync APIs
Message-ID: <ZlckBe02dybokq94@smile.fi.intel.com>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
 <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
 <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
 <60691eb7-ca16-4547-8744-f9bfae919a3f@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60691eb7-ca16-4547-8744-f9bfae919a3f@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 08:35:26AM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, May 22, 2024 at 02:41:51PM -0400, Nícolas F. R. A. Prado wrote:
> > On Wed, May 22, 2024 at 08:09:50PM +0300, Andy Shevchenko wrote:

[..]

> I can send this patch to the list myself with your authorship, I just need
> your SoB.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. Sorry for the delay, I was and still is on a sick leave.


-- 
With Best Regards,
Andy Shevchenko



