Return-Path: <linux-spi+bounces-267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B97811C0E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D61F216BC
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE25952E;
	Wed, 13 Dec 2023 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufcx+MCR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22BE10A;
	Wed, 13 Dec 2023 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702491199; x=1734027199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQqZxdSjZUZKu7qV4uLKuuB6S1Lf0FGUnVaJd+r0FGI=;
  b=Ufcx+MCRtsW0DVBuunBNRFKxdbuKIz36FUM5f21IOvzMcu5lo2NSc4XO
   lpu9TyYHduPnbhLFyWNhZTT97ocwIsmO2JfgSkQK+FxwdbAfRdgvq7KbQ
   1Ed8bqgejGk8QVhgf7Z/thy0APR9AiqHsE0yGOv6ynzaKyAGC6VEqQASs
   m1FeLI7G9xJBkeNAYyQB51Jawf2zjnOdMpD65RCGvvHifh9Gh103WhPZo
   eKdy87805mnV5uGhmOF6On4uz/8tJobkS35ClmBYvZsbPcj3/ln78eWb1
   VBN6h7OtGTn9WUoAYmqHbz8jUUWT3HniYHi54Kpn6w/I25IqMTIEm0EHN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1861079"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1861079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947264609"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="947264609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:13:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rDTjN-00000005bbW-2HDO;
	Wed, 13 Dec 2023 20:13:13 +0200
Date: Wed, 13 Dec 2023 20:13:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 16/40] spi: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZXn0OTsoHcVTly3g@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-16-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-16-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:33AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - add device tree DMA request, so we can probe defer, in case DMA is not
>   ready yet
> - drop DMA platform code

...

> +	espi->dma_rx = dma_request_chan(dev, "rx");
> +	if (IS_ERR(espi->dma_rx)) {
> +		ret = PTR_ERR(espi->dma_rx);
> +		dev_err_probe(dev, ret, "rx DMA setup failed");

		ret = dev_err_probe(...);

>  		goto fail_free_page;
>  	}

...

> +	espi->dma_tx = dma_request_chan(dev, "tx");
> +	if (IS_ERR(espi->dma_tx)) {
> +		ret = PTR_ERR(espi->dma_tx);
> +		dev_err_probe(dev, ret, "tx DMA setup failed");

Ditto.

>  		goto fail_release_rx;
>  	}

...

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko



