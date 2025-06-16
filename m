Return-Path: <linux-spi+bounces-8588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08EADB15E
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570E9163800
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333C2C3745;
	Mon, 16 Jun 2025 13:12:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF32E06D1;
	Mon, 16 Jun 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079564; cv=none; b=GQgIfgDZWslsxqtEAEBKSS3LFTHzlYlQmIQX9ybvnAo0fnpPqgUZiHkVJEYWa/VlXeFQPacKNkoaFece/xChvlSnCclsuF8J7mqRx9hzX9d8qmoMPHQMW9mY6+Xx5CJpIWa1HjPei5PQ7SXzaI2fCkH7ODwyC1q2eon9XUKuziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079564; c=relaxed/simple;
	bh=5UjB8tEny3uH/qA6z9qyG9Z1S6iZLjblZTXlnNsLfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJHzqmDxhb07roRwfLQUUMKI+AnrYeRlMYtm+pfySArvxJ4JenBxPAyZLJANBBC+cBdhUe6siztUCosmXcMuvDEQCSdizzXauqRIatPHmDReBfbD+t4WN2Dp+OQ0B06Jl7nwpnUO9ZpgIzeqGEMDxBcv3ZhwvPn8Mr69Gd49PPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 600DD67373; Mon, 16 Jun 2025 15:12:36 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:12:36 +0200
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
Message-ID: <20250616131236.GA29838@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk> <20250616121444.GA25443@lst.de> <e4aa4d6d-0e84-42a8-bf63-f8d132619432@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4aa4d6d-0e84-42a8-bf63-f8d132619432@sirena.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:05:22PM +0100, Mark Brown wrote:
> On Mon, Jun 16, 2025 at 02:14:44PM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 16, 2025 at 01:11:49PM +0100, Mark Brown wrote:
> > > already tied to a platform that needs DMA needing to add the dependency
> > > which nobody is going to notice without doing build testing for
> > > randconfigs or similar non-useful configs - it's not a productive use of
> > > time.
> 
> > Stop your unproductive whining and just fix your dependencies.
> 
> That is not a constructive way to talk to people, especially not when
> misdirected.

In case you didn't notice, I found your answer extremely unconstrutive
if not actively malicious to start with.

