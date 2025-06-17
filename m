Return-Path: <linux-spi+bounces-8616-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2EADC110
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 06:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A171714FA
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B323770A;
	Tue, 17 Jun 2025 04:48:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438C1EF39F;
	Tue, 17 Jun 2025 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135721; cv=none; b=kdsf5RW8UHgBLngCvPRekz31qtXMSnVP5D5gyCgD4CK4PnodLabzUjSkB54toplh6DTeByXRoMkW91CSK2efJQwT9BHPFN52jAgg9gNZuVJjhVRpo2prTwXdY0mjh/0cCGvE2rnYBtSeg2gUDv64HBCTXXCRY/JY0+/yKRE1Fns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135721; c=relaxed/simple;
	bh=HpbsjtUF8/0yEJq1r9APjd7aYWNq9AD83e/U0S1OeDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rypmKc/5ibYrR1hWWe44c1RHOr0iGRscJ1La4caxugOIU/DI5xNRDBxP7DEnMG+PDQiCo8InUPIdlHG/RWF3e2LiYyM8fIqqzalbVUHAfPTZLlUpJ0lUH4WvFmqp/xp1QvP2EjvmTj3NkGbvSenF7fMJ4Rb94DEc9CW1fMULUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B627868D0E; Tue, 17 Jun 2025 06:48:33 +0200 (CEST)
Date: Tue, 17 Jun 2025 06:48:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, Christoph Hellwig <hch@lst.de>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, oe-kbuild-all@lists.linux.dev,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250617044833.GE1824@lst.de>
References: <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk> <20250616121444.GA25443@lst.de> <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org> <20250616131346.GB29838@lst.de> <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org> <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org> <20250616131944.GA30260@lst.de> <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org> <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 03:48:50PM +0200, Arnd Bergmann wrote:
> As far as I can tell, the difference here is that the
> dma_alloc_coherent()/dma_free_coherent() calls all get stubbed
> out, so the 827 drivers using those can all build cleanly on
> mk68knommu, shnommu and UML, while dma_alloc_noncoherent()/
> dma_free_noncoherent() are only used on 15 files that are all
> guarded by some other Kconfig dependency at the moment and won't
> build on the those platforms.

Yes, dma_alloc_coherent is from a time where stubbing out was
still very common.

> I agree that it would be best to treat the coherent/noncoherent
> cases the same, and I also think the existing stubs are a bit
> silly, but just removing them would likely require fixing
> hundreds of drivers with added Kconfig or IS_ENABLED() checks.

I doubt it's that many, as most drivers and even subsystems simply
depend on DMA.  There's probably at most a few dozen drivers
supporting DMA but not requiring it.

> Maybe we can actually remove CONFIG_NO_DMA/CONFIG_HAS_DMA
> entirely and remove all the checks for CONFIG_HAS_DMA? 
> My guess is that this would only lead to a small code size
> increase on the affected targets, but since they are not
> actually trying to do DMA, and they all have a very limited
> set of drivers they actually use, it won't break existing
> code.

Except for uml, the CONFIG_NO_DMA configs are usually very resource
constraint, so I don't think that's a good idea.


