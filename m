Return-Path: <linux-spi+bounces-11557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1BC884D2
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9D355F0F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8E3164A9;
	Wed, 26 Nov 2025 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wbp3R+yx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E73126D4;
	Wed, 26 Nov 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139388; cv=none; b=mJRZ+d5vnCo6a91/jw4zdMVg59Vsj1SOBxguqqK8Up7HUg9MzfX+GHK5ojwbVWchl92tAJLx8zUU3h3ma2GZRk8dxyMLLWYylDdpvUtvJZ+IU9WdSCgQRVvDqqMJbXIPxMVWlyMuBnTiCHaDmqv1Mcen457UmAopuWdZut+Swao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139388; c=relaxed/simple;
	bh=2znHTxS4daBYRDsAYpSnSAuZrV7wLye90qTadu9BUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZH4bHPR29GLcKaxo4C554DKZF+6DtKSJPklRb+A9xQ4Wj4o1HWp4TAUwAcC+Gfy/r2kU7T06UYpp8bZp8dOw7f7B2tjDfmnMMCiWk0DT1qU1mbWf0J8fux0wdJ9++OAS887P9puc/8e6CoBuyKelkNtiiGixF6Nb2tG48qLOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wbp3R+yx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764139386; x=1795675386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2znHTxS4daBYRDsAYpSnSAuZrV7wLye90qTadu9BUlE=;
  b=Wbp3R+yxi3AjPnsrV3PP46ZvKe/27/BJnftMKe7qhmdKgu6Vajidxh+Y
   RdS7XapXnSKIUC4es+pLv2DV2JH86XiD8W8jlwmA+ZXx9pvq5AcPS81rc
   MEgIx4n6ukLxQxN/bGz28a9vWBInjyhFCxYcIyGWEpwS/qm5t9/KCSlYj
   ZF6mGDv2Sn23WUrHHU/J/rDnLX0tFt/Fzi50uAoTmZ6nNL4y6tD9qvP8w
   uHbCY9tCplQ9U988/pPBv51qtkO2iL9VmpFRrominwdhkBZbWgAtXSP2i
   9qQHdQJmdPNztAiBafM3q6geguWwrtruAjqdVkc6wplvM/ROojfj5tx8i
   g==;
X-CSE-ConnectionGUID: AsI/Ha3tTzubK/QlfN2M0g==
X-CSE-MsgGUID: Xispw2FaQiyNZYraHaz6UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66123500"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66123500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:43:06 -0800
X-CSE-ConnectionGUID: JxB8SxMeQaCXk6tKc+8dGQ==
X-CSE-MsgGUID: CZB/0PaMQCms82nWNBfMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="193662369"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:43:04 -0800
Date: Wed, 26 Nov 2025 08:43:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: david laight <david.laight@runbox.com>, Frank Li <frank.li@nxp.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"rongqianfeng@vivo.com" <rongqianfeng@vivo.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <aSahdZm1KvT0_x8B@smile.fi.intel.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
 <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
 <20251122105716.24769251@pumpkin>
 <aSXHB_CWYZYnQ6ui@black.igk.intel.com>
 <VI2PR04MB111477CFB4C4253842C234FF9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI2PR04MB111477CFB4C4253842C234FF9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 02:10:25AM +0000, Carlos Song wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, November 25, 2025 11:11 PM
> > On Sat, Nov 22, 2025 at 10:57:16AM +0000, david laight wrote:
> > > On Fri, 21 Nov 2025 11:19:34 -0500
> > > Frank Li <Frank.li@nxp.com> wrote:
> > > > On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com wrote:

...

> > > > > + /*
> > > > > +  * t->len is 'unsigned' and txfifosize and watermrk is 'u8',
> > > > > + force
> > > > > +  * type cast is inevitable. When len > 255, len will be
> > > > > + truncated in min_t(),
> > > > > +  * it caused wrong watermark set. 'unsigned int' is as the
> > > > > + designated type
> > > > > +  * for min_t() to avoid truncation.
> > > > > +  */
> > > > > + fsl_lpspi->watermark = min_t(unsigned int,
> > > > >                                fsl_lpspi->txfifosize,
> > > > >                                t->len);
> > > >
> > > > There are thread discussion about min() and min_t()
> > > >
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> > > > re.kernel.org%2Fall%2F20251119224140.8616-1-david.laight.linux%40gma
> > > >
> > il.com%2F&data=05%7C02%7Ccarlos.song%40nxp.com%7C24c955c5ab414a26
> > 730
> > > >
> > a08de2c34dda3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389
> > 96802
> > > >
> > 735067934%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
> > iIwLj
> > > >
> > AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> > 7C
> > > > %7C&sdata=NEBirtRBR5RXz9cUXuqWVtHT6b3memVhsRe5mA7AIAQ%3D&
> > reserved=0
> > >
> > > The big comment even carefully explains that the two types are unsigned
> > ones.
> > > So a simple min() is absolutely fine (and the comment can go away).
> > >
> > > The old typecheck in min was just so stupid.
> > > In this case the 'u8' variable is promoted to 'int' (they always are)
> > > and then converted to 'unsigned int' to match the other type.
> > > Even though there is an implicit 'int' => 'unsigned int' cast it is
> > > impossible for a negative value to become a large positive on (which
> > > is the only justification for the type check).
> > >
> > > I'd check the file for other uses on min_t() as well.
> > 
> > Just came to this thread to echoing what David said. +1 to the above, please
> > convert to simple min(). The use cases for min_t() and max_t() should be rare
> > really.
> 
> Thank you for all ack about this patch.
> From my points, min() ot min_t(unsigned, x, x) both are ok.
> This patch has been picked, do I need to do a new patch to use min() instead this patch?

It's already applied, so send a followup that moves from min_t() to min().

-- 
With Best Regards,
Andy Shevchenko



