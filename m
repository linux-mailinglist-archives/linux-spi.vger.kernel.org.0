Return-Path: <linux-spi+bounces-4500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD4968487
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5FF1C2192A
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB013D503;
	Mon,  2 Sep 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdwkrS7x"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949313B5A1;
	Mon,  2 Sep 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272483; cv=none; b=FY+kVvAdclSp9YQqsFFu/p8RlKpVVSN4bwVd+596cZoaDe6HsQmMKSjgjVO18+aSe/UMsolGOLh8HLLjM/WvpDc4nv6AAbLvgElM522k4ACnPi9RTlgBk6rAv6HbuAgYmdt0OHVXqzYc/T3+qs2/HIj8LeSVNAiNLt9aw9P2CN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272483; c=relaxed/simple;
	bh=iDVWuqKIOvItALZ7mRc0t6C0bzOiHxajyUuSHCIwwEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEVyvaTWkqucQjqf+XcBR5FurmA1/s5iTJT1zf6XzYf+X2ETYTQ3T0StVF9QE0OceoN1qvYF1tC1176vPruKDVupN2zVWMApbb1Ir4i73o1jSeaC9bOeOY51ydVnGX9JX0F7++ozD/+zwOPqwUA4NYelO6Vg/bODyAQazJKbIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdwkrS7x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272482; x=1756808482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDVWuqKIOvItALZ7mRc0t6C0bzOiHxajyUuSHCIwwEM=;
  b=GdwkrS7xtKZCSuG//AujkdkbZToaUUOI4uHH6pxl1yc7uO7uX0R8uvjw
   PV3bBe4xPOoPUAlYlwoev3BTSHUwDCwrn++gdG04mUtU/cQNynOG1sJ9d
   CcpgQzp7ctLTQLnuZFgb1bHrYjgPlsVLiiGTJ3Nw4s4YoMJp3wd2CqiO7
   fgZ19KM3UfdGKqwFC4BRv6z8cWxYPb5IHrCFZ0UqHXg/nAHcWNv6YzBRQ
   H/nyGsL3MWl/2HhbJlwlHpVpY3DgjKf0WZFtslbH+novcUh43MWDJI9aa
   +gMxOT2O9Tux3JtJ2enJwzMi5ESML7/+uE8NcBMUBULTYK+F99PfpRmZ7
   w==;
X-CSE-ConnectionGUID: XvxEKDt4QveM3p8fY7+fwA==
X-CSE-MsgGUID: KoZmetjeTbe76yHrk6s88w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27636013"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27636013"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:21:22 -0700
X-CSE-ConnectionGUID: inEaSgj8R5SL1kF8v/9OzQ==
X-CSE-MsgGUID: 4UEi2HJOTO2PnRXq7VH7dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64765983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:21:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl4BQ-00000004Jig-2lfp;
	Mon, 02 Sep 2024 13:21:16 +0300
Date: Mon, 2 Sep 2024 13:21:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Yang Ruibin <11162571@vivo.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <ZtWRnD7hh4NYL-zl@smile.fi.intel.com>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
 <ZtIZg4Jy31GON1zw@smile.fi.intel.com>
 <317926b7-65fe-4f60-b4f9-887cd1ad59da@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317926b7-65fe-4f60-b4f9-887cd1ad59da@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 30, 2024 at 08:56:56PM +0100, Mark Brown wrote:
> On Fri, Aug 30, 2024 at 10:12:03PM +0300, Andy Shevchenko wrote:
> 
> > But Mark haven't replied if I need to send a v2 of that as it has Subject and
> > first line of the commit message generated by `git revert` without editing.
> 
> Yes, you should resend.

Got it!

-- 
With Best Regards,
Andy Shevchenko



