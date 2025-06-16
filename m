Return-Path: <linux-spi+bounces-8589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DBADB165
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA7D173B4B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC93298CDC;
	Mon, 16 Jun 2025 13:13:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C468292B2E;
	Mon, 16 Jun 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079632; cv=none; b=EZ9d8j+mnp+zFkMjyNZCjZ25oSRLOhJXCDmms4zOS4V7x4522Mw+oahmvaWQXk9RC8Id2YfhqvQb3Iccn0KbexdO5U9Qp7x1wBXJI1mqMdR1XlB93CMHCx6WuZ/pUxfnVZzvD9mnAJuM9eYLHU4JLHoH4tFnbCjzHWYfYLWrxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079632; c=relaxed/simple;
	bh=mp54NSMRdSJL90KDT/VTaJlJsxoe7g25q4DBqprk7Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEA3kHuv43jArOY+GfDjyFCaBe7qxw+aeDfIGUqUx9emKbHZfHPBC0i4Q61HC8WZg/RnSEPjsgYK+NI0ivueha8w0Z+VCcSjsZo2QKI+a6Qykh+L+II3FHFLmqJ7oOkJ0y2EoeKj1ypU41T10Glw/t/6PRYrqfiiH+VcQklvq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B7F868D05; Mon, 16 Jun 2025 15:13:47 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:13:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Clark <james.clark@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>,
	olteanv@gmail.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250616131346.GB29838@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk> <20250616121444.GA25443@lst.de> <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:10:40PM +0100, James Clark wrote:
> The change introduces consistency with the existing declarations in 
> dma-mapping.h. Surely there is value in consistency and it doesn't do any 
> harm to define new ones with stubs the same as the other ones. That way 
> when you change an existing device that has DMA stuff to use a new part of 
> the API you don't have to predict that it will behave differently to 
> another part of the API.

Well, redoing the rest would definitively be nice, but so far no one
has signed up to that.

> I suppose it is possible to #ifdef out the DMA stuff in this driver, but 
> IMO it would be quite messy, and I don't think randomly not stubbing out 
> some functions is the right way to move towards fixing all the dependencies 
> in all drivers. We should continue with the stubs for now and fix whole 
> drivers one by one as a proper effort.

Does the driver even work at all without DMA support?


