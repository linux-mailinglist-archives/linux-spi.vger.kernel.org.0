Return-Path: <linux-spi+bounces-3006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FB8CC406
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F012A1C21ADF
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FFE55C3E;
	Wed, 22 May 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SI3Q5lar"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16902374C;
	Wed, 22 May 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391452; cv=none; b=pesAZMA1B8R2thYy7aJDmbalOPgtZD17QZ/z1nj5HjkiPRSkxnpkkSl0a8aDsI5bbpqXfUA/c+gBW83jKfn6IgfEvmmAmX/aHB9E9+bVQyluL6nhiVWWiy5cpHOi54Eo8J72qi3WBjnGPimeY94t94mIl3a66gwBq2WBzZwVt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391452; c=relaxed/simple;
	bh=EcHNphBQN7AgRqNSuk/f729uUDKbx7R6C4iLyw5fAgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCqh5HT1vQHApLQ7ON+YdoxHbrfBcm7HB4CORWNJBPq7gi2swQ0fAc6IgDf9ZRNXBMF06hJq2wWLvmwVkW+WMT0BC+gQDTu/d/8tJ1u6vPQzqdXLnxJO20Mc6jF1JLmXKUpCuWv6Rl3/NDuMXJFjf4atY5bedWEs5uY75w/XcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SI3Q5lar; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716391450; x=1747927450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EcHNphBQN7AgRqNSuk/f729uUDKbx7R6C4iLyw5fAgI=;
  b=SI3Q5larNUny5Vinnwm2V9DPXsWQUnHE3MZ+OTyuxJgAcvyOwx4ZZcWx
   vDEQpdBdLWsRltgTuclUZ9MyigY3tMltkBsUKiBpK6papFNcqPMglaq85
   B1JYoQ+k3NSAs46fHflJb3BrXXwT0aJ6momT08b6YxpBmo4sUU+0Sx7OW
   BUxj+QxTge7fe7xBpSjGUT21c1Jys6PpxS5rva3orekbR3BbXZvkvNZqm
   zap6abJxatw3umn8x8DRCjBnCRCHrOwDXI/tdZjtZVxiLs31hIDMhF9Ah
   jB0mKv9eppIG+OlIWtP6yee27GoouoIBr8fX+q3DEP3wpOyDPYrbc58uo
   Q==;
X-CSE-ConnectionGUID: A06KPX1rTs2/DzXMqFu/QA==
X-CSE-MsgGUID: f64xmwpcSziEaFWF5QpV7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12435018"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12435018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:24:09 -0700
X-CSE-ConnectionGUID: 52foslnIR4S4cOsErEBYDg==
X-CSE-MsgGUID: MXeyRuAhS1+JNzeXHSJ+Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33443002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:24:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9noy-0000000A13A-1uix;
	Wed, 22 May 2024 18:24:04 +0300
Date: Wed, 22 May 2024 18:24:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <Zk4OFI3WObm1C1SY@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
 <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
 <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
 <71e7b6f8-67f2-4c03-b83a-71d7e747ad04@linaro.org>
 <Zk4AKOoymq5OvlkA@smile.fi.intel.com>
 <76763ae4-557a-401e-9497-9295e7da3fd7@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76763ae4-557a-401e-9497-9295e7da3fd7@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 11:12:43AM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, May 22, 2024 at 05:24:40PM +0300, Andy Shevchenko wrote:
> > On Wed, May 22, 2024 at 03:18:18PM +0200, Neil Armstrong wrote:
> > > On 22/05/2024 13:53, Neil Armstrong wrote:
> > > > On 22/05/2024 13:33, Andy Shevchenko wrote:
> > > > > On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
> > > > > > On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
> > > > > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > > > > All the same applies to other DMA mapping API calls.
> > > > > > > > 
> > > > > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > > > > checks.
> > > > > > > > 
> > > > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > this commit caused a regression which I reported here:
> > > > > > > 
> > > > > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > > > > 
> > > > > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > > > > familiar with this code base at all and would really appreciate any feedback you
> > > > > > > may have.
> > > > > > 
> > > > > > I also see the same regression on the SM8550 and SM8650 platforms,
> > > > > > please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.
> > > > > 
> > > > > There is still no answer from IOMMU patch author. Do you have the same trace
> > > > > due to IOMMU calls? Anyway, I guess it would be nice to see it.
> [..]
> > > > > 
> > > > > Meanwhile, I have three changes I posted in the replies to the initial report,
> > > > > can you combine them all and test? This will be a plan B (? or A, depending on
> > > > > the culprit).
> > > > > 
> > > > 
> > > > I'll try to apply them and test.
> > > 
> > > I stacked the 3 changes, and it works:
> > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> > 
> > Thank you!
> > 
> > I will try to develop and submit a fix against IOMMU which I believe is the
> > correct place to address this. So, this one will be plan B in case the IOMMU
> > folks will refuse the other one.
> 
> Hi,
> 
> that change did not work for me. Stack trace follows at the end.
> 
> But adding the following on top did fix it:
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0851c5e1fd1f..5d3972d9d1da 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1253,8 +1253,13 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>                 /* The sync is done before each transfer. */
>                 unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
> 
> -               if (!ctlr->can_dma(ctlr, msg->spi, xfer))
> +               if (!ctlr->can_dma(ctlr, msg->spi, xfer)) {
> +                       memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
> +                       xfer->tx_sg.sgl = &dummy_sg;
> +                       memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
> +                       xfer->rx_sg.sgl = &dummy_sg;
>                         continue;
> +               }
> 
>                 if (xfer->tx_buf != NULL) {
>                         ret = spi_map_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
> 
> 
> The thing is that even with all the previous changes applied, if one of the
> transfers inside the message doesn't support DMA, the null pointer would still
> be passed to the DMA API.

Ah, indeed, the conditionals also can be translated to

	can_dma = can_dma();

	if (can_dma && _buf)
		...
	else
		...

but...


> Alternatively, I think a better way to achieve the same is (I have verified this
> also works):

I agree that this one is much better approach. I will clean it up and send
as a quick fix. IOMMU will still be on the table as I think it's wrong to
dereference SG when nents = 0.

> I'll let you decide what is the best fix for the issue (what has been posted so
> far in this thread or another fix in IOMMU). If you go with this, feel free to
> add my
> 
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



