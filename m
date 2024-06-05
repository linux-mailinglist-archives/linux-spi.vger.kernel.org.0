Return-Path: <linux-spi+bounces-3263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505A8FD81A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B33F1C23C97
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B1B13A897;
	Wed,  5 Jun 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEODIqI+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CB4965B;
	Wed,  5 Jun 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621640; cv=none; b=MUz9v84Tt43ahtehS6c7LEz2ef4oyLlcktYlC++GvTNc2uKgCKas9rVmcxniLCD6e2u/wLdEAaxb2zhDmr5rmpRcKR4aaAEEuO0orTTUzQhDGeBaHhvXfSFAgd+iF1lBXdxp8FDj6Q+8o+3N30kBoqvVayG/MFvru1Vxw7LRTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621640; c=relaxed/simple;
	bh=NXt8cdPNKHaGsYk1Z6keF8MQbnEnJZNY+H2tZhyrkGc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtltHQRvNQ+td8qkB8P5Uf9I8dTInPUhiTEmQs1kMkuppTcmrR22ql6NXffpCM5CM6iGQb2slukXMiKdWbBTaOlOUpNsFq7vD2LrG7VF5BXCduUMV4Vojj8yBD+yK6/5BCRbPm25MYE5T7mhlWYGyipdOdQo0FtYw2URTxg7/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEODIqI+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717621638; x=1749157638;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=NXt8cdPNKHaGsYk1Z6keF8MQbnEnJZNY+H2tZhyrkGc=;
  b=JEODIqI+68pqcUNoaG1PX8G5ZHcGFofTYxU95jlvVyok3y5KrfjpYkoX
   q1lMuP6N4MIPDneaQyv8Bo38Ksy36UwDpOKhSCgI/Nh1G9JsopJDFndoN
   dbtI4LwdqLdrrE6Xb5YF1+1Lnmr4QX5tVxE6hfhlQ4P3IfLX8Vu0W2dRM
   3fAIDkfaRjOIYBzRZfbzUn8HyPAkTi54XzP9fogYLpXNBUg8wm/IwL3XE
   R7TqG9ROCTS52quEYQlDp1EL2ZSrgFD7FwuanXZ07Vc8JG9KTNAfqNWOD
   m01UcOsKbSY0tprxl33toULXsCPsu7zi+xeq0A7BcVBC/S/rdv8YxSylq
   w==;
X-CSE-ConnectionGUID: zaTVRI0GTc+jQ1JQVGhXYA==
X-CSE-MsgGUID: IIXRagmeQE6MTa4iZ8RfZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25662207"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25662207"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:07:18 -0700
X-CSE-ConnectionGUID: /AYv3XedRwaR5IHAHsYSnw==
X-CSE-MsgGUID: ruk6PRkwS1+m/jsquvNzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37735016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:07:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExqk-0000000Dy3n-2Cqk;
	Thu, 06 Jun 2024 00:07:14 +0300
Date: Thu, 6 Jun 2024 00:07:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] spi: bitbang: Clean up the driver
Message-ID: <ZmDTgtONF49f8cBr@smile.fi.intel.com>
References: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 17, 2024 at 10:40:19PM +0300, Andy Shevchenko wrote:
> A few cleanups to the driver. No functional change intended.
> 
> Andy Shevchenko (3):
>   spi: bitbang: Use typedef for txrx_*() callbacks
>   spi: bitbang: Convert unsigned to unsigned int
>   spi: bitbang: Replace hard coded number of SPI modes

Hmm... It's not the first time I noticed that the series
(despite even appearing in the CI, but then disappearing)
left abandoned without clear feedback,

Should I do something here?

-- 
With Best Regards,
Andy Shevchenko



