Return-Path: <linux-spi+bounces-8592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A9ADB19A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE683A2D3F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A2292B2A;
	Mon, 16 Jun 2025 13:19:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FCC27E05A;
	Mon, 16 Jun 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079992; cv=none; b=JLsfcySr8jbGbyJ0BBV2XGx7Wz5308CX3pDkNx9wEF7sJh+lWvQJMFKcExsSiPYHyZxibijuVjSLH9wIcJqW/JWAiAiRmPdMIkOOMC25+RGWXBGJ4MnDMZmF9eupGMLPdH7XVuf4a38sShQo7zALqx7sswTVEtFbLuJqm3lpU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079992; c=relaxed/simple;
	bh=j83uEkut/IUacfVpKQoQfNEnac5UYtvjf4AmXzaWfRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sv0Rvl3l3NJGIDkfSHXQscNWlqbyU6H42V2aMGk1QJerk9auwKRW75z0hC5mKS4BxnD7BS5v/s2GowbffYMLvD7CeUBV24E7GRC0cl5qVMZP6yAJwtV2vKIXtNRo9HvIoeIA1oYx5U7ont5/Mhf/l6u9v0kEel+0fH18uQ5rSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8C2467373; Mon, 16 Jun 2025 15:19:44 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:19:44 +0200
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
Message-ID: <20250616131944.GA30260@lst.de>
References: <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk> <20250616121444.GA25443@lst.de> <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org> <20250616131346.GB29838@lst.de> <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org> <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:15:56PM +0100, James Clark wrote:
>> Yes it does, it has a few modes that don't require it. Presumably we can't 
>> just add a depends into the kconfig for all devices because they might not 
>> be using DMA.
>
> *for all the different variants of spi-fsl-dpsi devices I mean

This is drivers/spi/spi-fsl-dspi.c?

Yes, looks like it is one of those rare devices supporting a DMA and
non-DMA mode.  But everything seems nicely guarded off using
"dspi->devtype_data->trans_mode == DSPI_DMA_MODE" checks there.  So
wrap them into a little helper using IS_ENABLED(CONFIG_HAS_DMA) and
everything should be sorted out.

