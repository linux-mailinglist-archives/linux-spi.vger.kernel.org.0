Return-Path: <linux-spi+bounces-4902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC797D6BC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 16:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE551C2346D
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D517BB33;
	Fri, 20 Sep 2024 14:17:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71A1E87B
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841845; cv=none; b=tGg/5ubxbBmf56FGevMES4hQclmmOPE1w6JnDYrlCA2ABQGWkzTeuUrRkHzVXAiDeWtjWzWvP9nAPnEAqXQ7aSfKYsTORNWUUKFnIc3TolOmrTjRPbuo4Jt8x3yb1DFU21r0lW74jt7lgNfAEagcmRbWB5lXlYnJAh0LuZk35eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841845; c=relaxed/simple;
	bh=JWqAcXEoj4GWY2LrKBI2yqFihhOPhQ8DlBKrH1z95bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnbGVSYSpR9XLNxF4T2XrIzylA/Py9JMDpzj9PZWEYwYpW5tWxe9FgtkrSj9vVZEbr0BFH9cWaaZQdgcQ5VtkjaRE9hZFkWhcZypgGt8ZcDsszMkC3gj8nOtcIsLVQ/djaJRiyMdYPoxu+cBSKKIELYWbCq4IxX5YzrrmtcXArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2sm7YoCTRw2LvSacoLYwxA==
X-CSE-MsgGUID: BjwyKvKdQgmRtU1RLhbFhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25368454"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25368454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:17:19 -0700
X-CSE-ConnectionGUID: am1L4D7QQGS9HGwNuge0wQ==
X-CSE-MsgGUID: +qZK57IRSg2Ssk8wNh3tNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75259572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:17:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sreRe-0000000Aw1E-2P6q;
	Fri, 20 Sep 2024 17:17:14 +0300
Date: Fri, 20 Sep 2024 17:17:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 2/2] spi: airoha: do not keep {tx,rx} dma buffer
 always mapped
Message-ID: <Zu2D6sS52DjVhWBq@smile.fi.intel.com>
References: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
 <20240919-airoha-spi-fixes-v2-2-cb0f0ed9920a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-airoha-spi-fixes-v2-2-cb0f0ed9920a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 19, 2024 at 06:57:17PM +0200, Lorenzo Bianconi wrote:
> DMA map txrx_buf on demand in airoha_snand_dirmap_read and
> airoha_snand_dirmap_write routines and do not keep it always mapped.
> This patch is not fixing any bug or introducing any functional change
> to the driver, it just simplifies the code and improve code readability
> without introducing any performance degradation according to the results
> obtained from the mtd_speedtest kernel module test.

...

> +	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
> +				  DMA_FROM_DEVICE);
> +	if (dma_mapping_error(as_ctrl->dev, dma_addr))
> +		return -ENOMEM;

Shouldn't this be

	err = dma_mapping_error(as_ctrl->dev, dma_addr);
	if (err)
		return err;

?

...

> +	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
> +				  DMA_TO_DEVICE);
> +	if (dma_mapping_error(as_ctrl->dev, dma_addr))
> +		return -ENOMEM;

Ditto.

-- 
With Best Regards,
Andy Shevchenko



