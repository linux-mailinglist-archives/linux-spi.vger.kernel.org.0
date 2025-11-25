Return-Path: <linux-spi+bounces-11514-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB1C85B1E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561953A86BC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6561324B17;
	Tue, 25 Nov 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsE4u/GS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2632549B;
	Tue, 25 Nov 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083468; cv=none; b=ClCXfEgrzp+ZRN4iHzAfDgtkCwed4hBRVakY37aj6iZ7pY+GcHO9ztPhehRgCh3SBNeMOu4SAKhlTD6j15DPmJgz15hd+NG1o40a2KJP7xa3/ovbj/vBxAsrf7bO4RiJRQUr9EuX3klFzRucIgyZhJnWqJGRLf9XGd/Fu0HQWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083468; c=relaxed/simple;
	bh=xFmhncD5KPPPCBO82QGQgHGNuWMbMq/rlGNaBlJOWF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc0kz1PNnNe1S8rmODrV+j77kbF1phx+7/8IV0T5dmsMAQd225b6SCx+Jx8aHXSST3G4sVXuDaFNq+UzW1jLV6YOwuym2f8QnIHqr7u+au8bRd8myoh0cmzKBPeUX8TwZpluRcF7WVRmMurh8To2KcGv5S+8zerW8rLmfuDb7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsE4u/GS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764083467; x=1795619467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFmhncD5KPPPCBO82QGQgHGNuWMbMq/rlGNaBlJOWF0=;
  b=TsE4u/GSW2T+JcAbiGpS76SbTbtBUsnYmmksoUurmXLFVbv9sxkF/v/5
   iSCdTkOmDLmsHmMmy+a+5OPVZo90lfpBb0u+HBIkiAzx2uakG+b6P7JTL
   VpMROIebHHKeYyqHilQLP+sHT0xPVhJPFTtIs2FQzNLt2pfq3II2oR/oR
   EQO1vGHBwQV9aD4B6iuSSqDSXxHfnFKkntQtBWYlPzV9E6OueXzF2xVxw
   Kjn1qJVN/i5Z1zMvMRTFnotBneamquAeNfijTcahiYFZWBdZRvy9g9Wdu
   12q+Eq+f33VYWNtdEKVagJHwfIXjS3iAJtmC0IviuiSGqh/5taaflgpYx
   g==;
X-CSE-ConnectionGUID: TeY0301xSECx/9XswekTFQ==
X-CSE-MsgGUID: 53aJv+mDRf+Wwn6PCUpBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76428984"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76428984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 07:11:06 -0800
X-CSE-ConnectionGUID: tZcLcIncRaO4xGX5piNyWw==
X-CSE-MsgGUID: TNtCbReaS4KHzW0U/39WAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="197139267"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2025 07:11:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 25448A0; Tue, 25 Nov 2025 16:11:03 +0100 (CET)
Date: Tue, 25 Nov 2025 16:11:03 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: david laight <david.laight@runbox.com>
Cc: Frank Li <Frank.li@nxp.com>, carlos.song@nxp.com, broonie@kernel.org,
	rongqianfeng@vivo.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <aSXHB_CWYZYnQ6ui@black.igk.intel.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
 <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
 <20251122105716.24769251@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122105716.24769251@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 22, 2025 at 10:57:16AM +0000, david laight wrote:
> On Fri, 21 Nov 2025 11:19:34 -0500
> Frank Li <Frank.li@nxp.com> wrote:
> > On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com wrote:

...

> > > +	/*
> > > +	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> > > +	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> > > +	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> > > +	 * for min_t() to avoid truncation.
> > > +	 */
> > > +	fsl_lpspi->watermark = min_t(unsigned int,
> > >  				     fsl_lpspi->txfifosize,
> > >  				     t->len);  
> > 
> > There are thread discussion about min() and min_t()
> > 
> > https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/
> 
> The big comment even carefully explains that the two types are unsigned ones.
> So a simple min() is absolutely fine (and the comment can go away).
> 
> The old typecheck in min was just so stupid.
> In this case the 'u8' variable is promoted to 'int' (they always are)
> and then converted to 'unsigned int' to match the other type.
> Even though there is an implicit 'int' => 'unsigned int' cast it is
> impossible for a negative value to become a large positive on
> (which is the only justification for the type check).
> 
> I'd check the file for other uses on min_t() as well.

Just came to this thread to echoing what David said. +1 to the above, please
convert to simple min(). The use cases for min_t() and max_t() should be rare
really.

-- 
With Best Regards,
Andy Shevchenko



