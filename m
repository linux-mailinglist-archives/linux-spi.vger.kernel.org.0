Return-Path: <linux-spi+bounces-2868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E48C7BAA
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BD62823E2
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA710158214;
	Thu, 16 May 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dmh04/mW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEB156F23;
	Thu, 16 May 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881589; cv=none; b=E8rUSYqJpQpZ6a4GlHh2wc4Ccp8u7UBQOW01NXA5SHTWRHOP/tP+O93lBAeaKCJEsydeLgcP3ub08ESnQOXF1ZztP82+RIIhM2Il6+rBUDSJFrbYM1Oj9EE0Jk+flpoWqjeLf+/KxzP17q9D0Eh+tRzrWzPS2FUjV1SATMg9EXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881589; c=relaxed/simple;
	bh=Pip3wql6yyEL2BrMvPa75zxHMs613XqiPAnva0+Dfu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EErXFgKz5ZWHJt2iGeT52ky6zQfHga9BMwVlwZyV0Gb1Yc45qr4bR6uikhgB15ypsXrfEziRxIih35WCkArEquTI+m0dwA+FRguO1zUErYFlu/cEndNScdNH/sAYOltWwkSomgB4k0DmPRyFIoxFzgyuIys8u/DrtzNh0ntCKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dmh04/mW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715881588; x=1747417588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pip3wql6yyEL2BrMvPa75zxHMs613XqiPAnva0+Dfu0=;
  b=Dmh04/mWZPbR2CIabH5vXK9S5aAj/EruZeLxL585EVk5EeivnVvcvQp6
   swDhXGAduSnkYDjCN7C14LFVErueWhknD8AWe6QxWXYZZEYnzkI/6uW1U
   KbQwitEzzd3YgymnGBLzz+ilMS+biYU9Uh1yNGZMP6UJXl+DMKo/Dkddm
   +RlPArT/m2XSHAGpLpAFuDYq3kxBz4fPzrDjhUYIazoQPNJV49XfFeDZG
   K78mDiCxCkYqV+JN9Y/qdrQIBMmoLENA0g4huDscLQFRCsWbq3VQCb6bQ
   ii4Ig09goi2jxfjfs74mSaHqEyGsX8g/HIKksGoQ3XLPCc0xMVNaEzrna
   A==;
X-CSE-ConnectionGUID: HYhNevZERySCeZYSYwC+aw==
X-CSE-MsgGUID: e2K+LT00Sya4JamvZEEQAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29533974"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="29533974"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:46:27 -0700
X-CSE-ConnectionGUID: uXhyjaUSSdikXinTg+GxpQ==
X-CSE-MsgGUID: uAWpkVS3RR2aBkwFDDbn9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31650787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:46:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7fBP-000000088AH-1hpF;
	Thu, 16 May 2024 20:46:23 +0300
Date: Thu, 16 May 2024 20:46:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <ZkZGbz0RlUHshneC@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <ZkXdXO4Xb83270V7@smile.fi.intel.com>
 <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>
 <2fccdd9a-5b97-4dc6-a6b1-ce2d9e0819bd@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fccdd9a-5b97-4dc6-a6b1-ce2d9e0819bd@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 16, 2024 at 12:25:19PM -0400, Nícolas F. R. A. Prado wrote:
> On Thu, May 16, 2024 at 04:25:35PM +0300, Andy Shevchenko wrote:
> > On Thu, May 16, 2024 at 01:18:04PM +0300, Andy Shevchenko wrote:
> > > On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > All the same applies to other DMA mapping API calls.
> > > > > 
> > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > checks.
> > > > > 
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > this commit caused a regression which I reported here:
> > > > 
> > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > 
> > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > familiar with this code base at all and would really appreciate any feedback you
> > > > may have.
> > > 
> > > Thanks for the report and preliminary analysis!
> > > I'll look at it hopefully sooner than later.
> > > 
> > > But at least what I think now is that my change revealed a problem somewhere
> > > else, because that's how DMA mapping / streaming APIs designed, it's extremely
> > > rare to check orig_nents field.
> > 
> > Can you test the below patch?
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index b2efd4964f7c..51811f04e463 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> >  	else
> >  		rx_dev = ctlr->dev.parent;
> >  
> > +	ret = -ENOMSG;
> >  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> >  		/* The sync is done before each transfer. */
> >  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
> > @@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> >  			}
> >  		}
> >  	}
> > +	/* No transfer has been mapped, bail out with success */
> > +	if (ret)
> > +		return 0;
> >  
> >  	ctlr->cur_rx_dma_dev = rx_dev;
> >  	ctlr->cur_tx_dma_dev = tx_dev;
> 
> Hi Andy,
> 
> thank you for the patch. Unfortunately it didn't completely solve the issue. Now
> the stack trace is slightly different and points at the next line:
> 
> 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
> 
> So now we're hitting the case where only the tx buffer was DMA mapped, but the
> rx is still uninitialized, though the cur_msg_mapped flag is set to true, since
> it is shared between them. The original code checked for the initialization of
> each scatterlist individually, which is why it worked.

I was kinda expecting that, and already have another patch to try (should
applied on top):

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51811f04e463..5c607dd21fe7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1258,6 +1258,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 						attrs);
 			if (ret != 0)
 				return ret;
+		} else {
+			memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
 		}
 
 		if (xfer->rx_buf != NULL) {
@@ -1271,6 +1273,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 				return ret;
 			}
+		} else {
+			memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
 		}
 	}
 	/* No transfer has been mapped, bail out with success */


If my understanding is correct, my patch revealed two issues:
- for non-mapped message at all;
- for unidirect transfers.

But I will wait for your test results to make the final conclusion.

-- 
With Best Regards,
Andy Shevchenko



