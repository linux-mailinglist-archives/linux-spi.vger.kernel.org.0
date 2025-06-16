Return-Path: <linux-spi+bounces-8582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA38ADAFD7
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5521695E3
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CAD2E425B;
	Mon, 16 Jun 2025 12:08:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1892E4245;
	Mon, 16 Jun 2025 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075720; cv=none; b=rFinq6QyAfoE+Wm42mwUsyxH+mXxa7JLx1OGncW566k8ZdaYKkwMYK5Sb1jpZ7TR33UAGu8rADYyqSgQzi++uAN5yI8VHn/MvJWdvMqW3cIZqJlpraXM5WHavKNVFTKsNFIwpBMIG921C3MPL8AU5bp4jWsaevZgKYBJ3fGmi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075720; c=relaxed/simple;
	bh=vVxkfp5GoKo0CMkCNkuwA6XeVd0NMi0LyrUGKehdXcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B75vGCIVXAyC0wmF9Z+g2bWxX5zVuWu0o0qunYeEphwXHXihZeWsxuFKU4Wey6a5P0WQ/h5XO/zcQQrUZ31U7iTpq1Eair69uzphYSsoam6tzzpCRcZbLxCeS3MJxScljtI5WLZ4TtmQ5A1t8XuYn3YcCzZjZbaFWAxIqYbvbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C55F67373; Mon, 16 Jun 2025 14:08:33 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:08:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark Brown <broonie@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, James Clark <james.clark@linaro.org>,
	olteanv@gmail.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250616120832.GA24959@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 01:06:00PM +0100, Mark Brown wrote:
> On Mon, Jun 16, 2025 at 01:29:27PM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 16, 2025 at 12:17:49PM +0100, James Clark wrote:
> 
> > > The implementations are in mapping.c which requires HAS_DMA so stub them
> > > out if not present. This is required for some drivers to pass randconfig
> > > builds.
> 
> > No.  Just add the proper IS_ENABLED checks in the callers.  While these
> > kinds of stubs used to be popular they are really nasty in that the
> > calls unexpectedly just fail without the right depends.
> 
> The issue with HAS_DMA is that essentially all platforms have and rely
> on DMA.  This ends up just being painful noise from the buildbots when
> they do randconfigs rather than something useful.

In most case the driver really does depend on DMA to work, so just
depend on HAS_DMA.  If it can work without DMA, you can use IS_ENABLED.


