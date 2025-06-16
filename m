Return-Path: <linux-spi+bounces-8574-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA7ADAE7C
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8F1701DF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B442C08B4;
	Mon, 16 Jun 2025 11:29:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA42BF3C3;
	Mon, 16 Jun 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073378; cv=none; b=eCAd5CStDtT3sIB4lzTI7QI/lq4vNptuLlbuiwDIw9THuDv8IoRLMRZxUT592P20Z2Cf/RDwMJKP/XcXhGTLRRaVIjHdiNFd5l72cp0ljZq1G7SkTh1397kcHmIFP7sSvktTXO/AXc4TzgK0eQ/V2conygc/PYXbBFYUEd7t83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073378; c=relaxed/simple;
	bh=VNpzq5XMajWseNHkJUpa4CQhSfFYhQigCVye/D7VuVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Pg/t5/LqkwfHlqYQn54vrYFs5TGF9oHiFRIqOkSDtk9UQ0sm5UsS3ckPXG73+BbiiRQ2Mf99EhWGX4vlQ011HGvKKgerEKQZxZHzePeTzhYybs8Tp6GW6xYchnP4EQdc/wtyTrnD04O6F6m8nRE2fhCG8WNLc8cSdumGjEqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EDF168D07; Mon, 16 Jun 2025 13:29:28 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:29:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Clark <james.clark@linaro.org>
Cc: hch@lst.de, olteanv@gmail.com, broonie@kernel.org,
	oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250616112927.GA21689@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616111749.316413-1-james.clark@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 12:17:49PM +0100, James Clark wrote:
> The implementations are in mapping.c which requires HAS_DMA so stub them
> out if not present. This is required for some drivers to pass randconfig
> builds.

No.  Just add the proper IS_ENABLED checks in the callers.  While these
kinds of stubs used to be popular they are really nasty in that the
calls unexpectedly just fail without the right depends.


