Return-Path: <linux-spi+bounces-8584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5BADAFFD
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EC47A8468
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52552285CAB;
	Mon, 16 Jun 2025 12:14:52 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFB2E4264;
	Mon, 16 Jun 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076092; cv=none; b=qG4+PSWzqMHd2M1hC1v94kJvGKxfjmvYqnzspH1XzmtEw9h5zgBcUm1wfJ30dyGXwh1wGcYg2DAjRlWIFUUAlkcaGgxe21FlU6gvTzH8qQ/k5QW0cBqo0XcoRReV4liZcjFlEfX+oEkQcR3h+huUl2LxPfbToNWA+RZ3YE3NhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076092; c=relaxed/simple;
	bh=ObbMHiVu4WRzSoOOo12RQA89uLQ+gUKdW/UONw0MTqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSOZQXpwHFkkhPtU2fiWrhYZdGKtj9x9fPQoYZ6nUCL1r5QmQZD5DvqKArkK/5mw6MBMD77csyQFoJIuz/WB171cu1wAvDUlo0qKvyZx9H00sxcCnxG2gzz598Pel2Hz563Z8De/b9tbwoy06zXvsBuNm0BwBO+23+iFTHFZBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B042568D05; Mon, 16 Jun 2025 14:14:44 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:14:44 +0200
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
Message-ID: <20250616121444.GA25443@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 01:11:49PM +0100, Mark Brown wrote:
> already tied to a platform that needs DMA needing to add the dependency
> which nobody is going to notice without doing build testing for
> randconfigs or similar non-useful configs - it's not a productive use of
> time.

Stop your unproductive whining and just fix your dependencies.

