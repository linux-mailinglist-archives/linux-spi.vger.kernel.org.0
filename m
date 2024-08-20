Return-Path: <linux-spi+bounces-4259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 148F2958C8A
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32461F23F6F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD81B86F1;
	Tue, 20 Aug 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agZBc3/i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F61B8E8A;
	Tue, 20 Aug 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172255; cv=none; b=t17/0hOv1hDhwszOLSeMP3iF/OxzrlflxBjkQfaQa2aw2SxGNdySNWawiluS1DbMl4CQ/1Hc4PtU2CqjLaDShm91lCRBN+k367Cz3OTSu9UQjwR5xkyJ3rdny5G/xsgSH092PXHL4Uk53W/wwjJA/KHLDlEA7IEKCVSWW0GByaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172255; c=relaxed/simple;
	bh=/ojMcXENemaXH/FLKbr2BdneUV5CeKMxILaSi7pc4FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPnDl9vFUKaw++qI1hz31GJ2iKu4/DJiDMBRJA47yBHRWXqkjkugcgwhxdIBV6hGMe86i2o73o3AEXRSjOU4wTrjYxhqIXyXW3fONgccqk3NaUzGr4QPU7CN1RuvK87yLzOuXMI+F1ky+lwLcpab1Qm/u/v//KROtjLBLHXyrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agZBc3/i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724172254; x=1755708254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ojMcXENemaXH/FLKbr2BdneUV5CeKMxILaSi7pc4FQ=;
  b=agZBc3/iu2cB0gjAntM3QuXd8KlYwBpb0uMq0KrhGakQ41ZFpB53nm4T
   IPHcm2iYSeSidtvI73UUD7h+B7Yuy9ey8DTQRkvbsIJedV64bJN46F1w9
   AsNNJRa2cqaA10ef6k0/q8Xm3WdCwbuNrUjtHQpCbfzPSxh9HUEfs4nI7
   pLaGFaLpkdqQ/txK0CYbS9GDTsqje5HWomjtKC3TjbfGzDyR4NDs7UlvX
   T6H01dBptjzylra6wslvsMjcjEBZnS1A47OXs29CgyvTpKcOAAUcDkzsd
   CBO86Hvuvc7L0MgLghSC2AUHtslYcE2gu35wcb+3O6O8oJTjkApPT4/9g
   Q==;
X-CSE-ConnectionGUID: Mpq1d0fkTKqKVjE6QZFPkA==
X-CSE-MsgGUID: GPfAJ6ScTCCWol2z5d5U6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="25387874"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="25387874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:44:13 -0700
X-CSE-ConnectionGUID: lypA/BkVR1qzZNoA1ESHzw==
X-CSE-MsgGUID: ETO8seD5SKKJHYJbafRR+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="61095167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:44:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgRxp-0000000HN8W-2aOI;
	Tue, 20 Aug 2024 19:44:09 +0300
Date: Tue, 20 Aug 2024 19:44:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "spi: ppc4xx: handle
 irq_of_parse_and_map() errors"
Message-ID: <ZsTH2cTcWQG9ltub@smile.fi.intel.com>
References: <20240819195029.2388397-1-andriy.shevchenko@linux.intel.com>
 <f71823fb-4b9a-430a-92cc-0b9df446ce3f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71823fb-4b9a-430a-92cc-0b9df446ce3f@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 12:20:30PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 10:50:29PM +0300, Andy Shevchenko wrote:
> > This reverts commit f1011ba20b83da3ee70dcb4a6d9d282a718916fa.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

It has the human-readable text just below that line.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

This is a pure and clean revert, not sure if we need to hide that fact.

P.S.
You can just revert yourself the second commit if it makes it easier to
perform, I'm fine with either.

-- 
With Best Regards,
Andy Shevchenko



