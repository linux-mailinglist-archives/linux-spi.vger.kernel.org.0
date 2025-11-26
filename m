Return-Path: <linux-spi+bounces-11591-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA5C89B43
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64DD4E37E6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E750236437;
	Wed, 26 Nov 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OceDrqs7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA6EED8;
	Wed, 26 Nov 2025 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159207; cv=none; b=ihwr0kg7LXChnj6E76X2N13ESayV8zFKp4mIalrpra0EQ3CSKFJ1CC9pNPyrNJJPWZSxeko8rN/2ixyW4yo9OFT0Ou9EqJ5NNy99owYCP1RlsDjcoOsc02H3X4i7ArgK7vRqOh1qTpytb8LCJ7LWWvNYt2hfPfyyxE5PsGMzcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159207; c=relaxed/simple;
	bh=AHwGu5yv6arh+oRD6EUZJftmu8GZZMKiiz6MirBaWm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnEQk7ayXm1urUHKFnWuZLCtcr1DvI5ap0z6o56ht/MGmME3s603kb0oyXUSdgDYZ9t2X+5jazXc2jjOiwgemHzGIjHsNO11tjzfZELZZGHK3wKeINsTC7lNEZ+44EpbOPx+qyfoB/Ic3+ZUYTulXDJVMC5du2e5fpEerJAL+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OceDrqs7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764159206; x=1795695206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHwGu5yv6arh+oRD6EUZJftmu8GZZMKiiz6MirBaWm0=;
  b=OceDrqs7oX4boJnirsYrv5e1mS/Rb9tRE9Acld0DPU+SNKBLb8XFZsFk
   0TirjH86PEgQ0m2fLrl7GPhTVuL7HhWMFXJMMS4Htp61XcdqdqxHDy31+
   TuUdJ/YSbScFHptYFuAGcDkt8cF6xPtOIgPOvneMsnv3An2UjWP7UvJw5
   0ucVZDsHDu4v+Vf9rFZWLfL1wUsMNZOR/vZv3P2FhxBLbDMttGlDhrart
   VGDVjtnBdZhtubknTDqpOb3yxEA2VgJPOrdW2WtqmnfjTv0K0k8O12jiE
   0d67f4ZFCx1cRaoJVNCzx8Hq/RlHiRnyHJfjKa6ZF9MvGnOPHzfdre7Kk
   g==;
X-CSE-ConnectionGUID: /HT5O1/2RLe3dPE3Bhh99A==
X-CSE-MsgGUID: nHsBZeBeRlSA/gb+ohqK5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="53763148"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="53763148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:13:25 -0800
X-CSE-ConnectionGUID: GlTkXC9dSHetFrtQvuirHw==
X-CSE-MsgGUID: bCjry0EVRvC6UqRKtp5DWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197418821"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:13:22 -0800
Date: Wed, 26 Nov 2025 14:13:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: david laight <david.laight@runbox.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
> On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:

...

> > I'm not sure I don't prefer the version with one writeb() call.
> > How about:
> > 		writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> > 			spi->regs + MCHP_CORESPI_REG_TXDATA);
> 
> Please don't abuse the ternery operator like this, just write normal
> conditional statements.

FWIW, that's what my patch does already :-)

-- 
With Best Regards,
Andy Shevchenko



