Return-Path: <linux-spi+bounces-4485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E496695E
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 21:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212271F23CDE
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE061BE249;
	Fri, 30 Aug 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPcjBKGG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD411BE230;
	Fri, 30 Aug 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045130; cv=none; b=q8lEFVxiOBcydDDyU9PMA5LlTH2hIj+aSx2T1BdyLWYsT/jTqNm/9P0AsPih4HZKLJT2pmQIeyFfsB5nCfhOpg+NuW59FmcPHOHjsE+yIdADJikGRs1IWSupQEDjTdZprCtB3znmK/cQcxaO3lQKiDwy5E55tffTaJf4S+2cYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045130; c=relaxed/simple;
	bh=dzWh+GQLUAty+8IfUKGWuOCoAVmfzi1JX5RFpods71E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIYjC6GND3w0rk80AQRhKw/FHNVj1VcCwYwubTl8mW8iscH8zqw7InNHlMy+fpOu9jo79X7E6emmkisEO63dy1jvTZ2YdadRZ4h1+/vMaM0U04JDyinsONmhRj25gfjEv6LI6sjDgerb5Iv5zjbFvAV2oXp5rBfVQ5Xe7+trPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPcjBKGG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725045129; x=1756581129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dzWh+GQLUAty+8IfUKGWuOCoAVmfzi1JX5RFpods71E=;
  b=WPcjBKGGlEIJTyiA9m6CNxX2X3EF4UBGPBoWk7bRY7o7cwtd1v29LKmP
   HlzqjuqdjiM2UOBMR24e2AXIliRyvAPe1tI8MK2+8zsWTjWAb4Uqb84g7
   BpZqkj5/s8OqkyWrb0aVZKefudlPMKTaqIL+YuiJ60d+2m6q1FmkTguYo
   xlQ+4uKowRZkS1hRkk9IFNhe2tABoY/g7E5kGlC8Iu20VXvnSP3c4ulBQ
   yU3CaBk7m5TeJ4ta+DBCHqkqFZLJTDkmIMqbiH/nKDpNrwJEZTogwUIGk
   cQD0m5IDb+xdu1jZZ5RpPNayWPh/VtATriEQgcxV046LS6rLQd4n9vtpT
   A==;
X-CSE-ConnectionGUID: b/s+UkqtTbm2lgkgSfQDuw==
X-CSE-MsgGUID: yTPlu+jdTzmiFbC4A5TZ4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26599432"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="26599432"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:12:08 -0700
X-CSE-ConnectionGUID: xNbOcizQSWGEFqMOtuOdlA==
X-CSE-MsgGUID: vQ6n6zePSSONSDhO+5BYLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63682533"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:12:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sk72R-00000003SLA-19tq;
	Fri, 30 Aug 2024 22:12:03 +0300
Date: Fri, 30 Aug 2024 22:12:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yang Ruibin <11162571@vivo.com>, Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <ZtIZg4Jy31GON1zw@smile.fi.intel.com>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 30, 2024 at 10:55:06AM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 29, 2024 at 5:35 AM Yang Ruibin <11162571@vivo.com> wrote:
> > Increase the reference count by calling pci_get_slot(), and remember to
> > decrement the reference count by calling pci_dev_put().
> >
> > Signed-off-by: Yang Ruibin <11162571@vivo.com>
> 
> Thanks for your patch, which is now commit 8a0ec8c2d736961f ("spi:
> Insert the missing pci_dev_put()before return") in spi/for-next.

Which should be reverted.
Who is going to send one?

I also have one revert for double applied spi-ppc44x commit.

But Mark haven't replied if I need to send a v2 of that as it has Subject and
first line of the commit message generated by `git revert` without editing.

-- 
With Best Regards,
Andy Shevchenko



