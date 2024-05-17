Return-Path: <linux-spi+bounces-2914-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2EB8C8973
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB661C21680
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEB12F586;
	Fri, 17 May 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY2AeTfX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D55399;
	Fri, 17 May 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960434; cv=none; b=VEVW5p4OPQCaVxqv5bq3ycO/oELHJ2vAMLJB3MvZXixY4A5l5ITzFLxuK1SyJKbg9M0RgWS4HzLeP/GsKB4wTIHZROm7TwZAryySE85T78I7bLqAJSMUeHCpEnnIgxLBuVwbT/Y28AstQwWNXKARJzUqs1PONM/IDJs9B2khl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960434; c=relaxed/simple;
	bh=aG3RtNH2+NoYfsNFRkxMtSClfXr8mPQMvy5B25eK8RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMBXg8UptadKngRg/RYuwoSGdKbQeEGyKfiyH/hFSY+gVH1PGRL1TJ+ZnBOkoqNa0mN4Ho/aso55J91W0nkgrY5R8bfTiqSnWHnVHCi/nizd/Bh9sp6e/cmrYhBOlMr1L1NSNnyGNYimXBunqd9HYhKqP6VyY9J1p4g1N5JsCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY2AeTfX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715960432; x=1747496432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aG3RtNH2+NoYfsNFRkxMtSClfXr8mPQMvy5B25eK8RY=;
  b=XY2AeTfXl7l9l1LdKFDdg5Vu1MmExT/IjKWlXkQEm6j6XfvmdJYjUOI+
   iiRjmBYIrCQn95k+mU5k8zzQIph8RuTGxGlst10lAUB6a3lLObF/vBkmp
   pdQNfmJpP1TLn43IkcSRB48FeZH0OJzOn6972WQCAuDrKuoUGYfNurIV2
   gLwbZlfYE/R1bi9GvSPe/rBHh/cpgwmDCKW4pfnOWufmPtjnx4w5Z44pJ
   /1WmVtWqNm52+h188pil28ZdlQ9+EB5VywivPWsLzk8yhbnCRH/JA6gsE
   6Cg/UPSnBSkG8iVvwSIqubLR0OdXtYCd728ce6dzUOkrQ76N1DuuFTuFF
   g==;
X-CSE-ConnectionGUID: Rg61jqxQTsy+lAh89T0Fsw==
X-CSE-MsgGUID: uKClZLmTTBqQXOv7Ma3WFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22818419"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="22818419"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:40:27 -0700
X-CSE-ConnectionGUID: oPtOzEnISUyS8yDsF50QMw==
X-CSE-MsgGUID: 90GJvq+yTmeNIXyz0shCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32234746"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:40:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7zh0-00000008OLi-3Ca6;
	Fri, 17 May 2024 18:40:22 +0300
Date: Fri, 17 May 2024 18:40:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <Zkd6Znvh3-AZROS4@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <ZkXdXO4Xb83270V7@smile.fi.intel.com>
 <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>
 <2fccdd9a-5b97-4dc6-a6b1-ce2d9e0819bd@notapiano>
 <ZkZGbz0RlUHshneC@smile.fi.intel.com>
 <038b55ec-9cbc-4303-a962-906f073892b8@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <038b55ec-9cbc-4303-a962-906f073892b8@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 16, 2024 at 05:11:21PM -0400, Nícolas F. R. A. Prado wrote:
> On Thu, May 16, 2024 at 08:46:23PM +0300, Andy Shevchenko wrote:
> > On Thu, May 16, 2024 at 12:25:19PM -0400, Nícolas F. R. A. Prado wrote:
> > > On Thu, May 16, 2024 at 04:25:35PM +0300, Andy Shevchenko wrote:
> > > > On Thu, May 16, 2024 at 01:18:04PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> > > > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > > > All the same applies to other DMA mapping API calls.
> > > > > > > 
> > > > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > > > checks.
> > > > > > > 
> > > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > 
> > > > > > this commit caused a regression which I reported here:
> > > > > > 
> > > > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > > > 
> > > > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > > > familiar with this code base at all and would really appreciate any feedback you
> > > > > > may have.
> > > > > 
> > > > > Thanks for the report and preliminary analysis!
> > > > > I'll look at it hopefully sooner than later.
> > > > > 
> > > > > But at least what I think now is that my change revealed a problem somewhere
> > > > > else, because that's how DMA mapping / streaming APIs designed, it's extremely
> > > > > rare to check orig_nents field.
> > > > 
> > > > Can you test the below patch?
> > > > 
> > > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > > index b2efd4964f7c..51811f04e463 100644
> > > > --- a/drivers/spi/spi.c
> > > > +++ b/drivers/spi/spi.c
> > > > @@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> > > >  	else
> > > >  		rx_dev = ctlr->dev.parent;
> > > >  
> > > > +	ret = -ENOMSG;
> > > >  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > > >  		/* The sync is done before each transfer. */
> > > >  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
> > > > @@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> > > >  			}
> > > >  		}
> > > >  	}
> > > > +	/* No transfer has been mapped, bail out with success */
> > > > +	if (ret)
> > > > +		return 0;
> > > >  
> > > >  	ctlr->cur_rx_dma_dev = rx_dev;
> > > >  	ctlr->cur_tx_dma_dev = tx_dev;
> > > 
> > > Hi Andy,
> > > 
> > > thank you for the patch. Unfortunately it didn't completely solve the issue. Now
> > > the stack trace is slightly different and points at the next line:
> > > 
> > > 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
> > > 
> > > So now we're hitting the case where only the tx buffer was DMA mapped, but the
> > > rx is still uninitialized, though the cur_msg_mapped flag is set to true, since
> > > it is shared between them. The original code checked for the initialization of
> > > each scatterlist individually, which is why it worked.

(So the above patch is okay, the below is wrong, but read at the bottom as well)

> > I was kinda expecting that, and already have another patch to try (should
> > applied on top):
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 51811f04e463..5c607dd21fe7 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1258,6 +1258,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> >  						attrs);
> >  			if (ret != 0)
> >  				return ret;
> > +		} else {
> > +			memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
> >  		}
> >  
> >  		if (xfer->rx_buf != NULL) {
> > @@ -1271,6 +1273,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> >  
> >  				return ret;
> >  			}
> > +		} else {
> > +			memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
> >  		}
> >  	}
> >  	/* No transfer has been mapped, bail out with success */
> 
> Still the same issue. I've attached the backtrace at the end for reference. But
> I don't see how a memset would help here. As far as I can see, there's nothing
> in the DMA API protecting it from a null pointer to be passed in. So when
> 
> 	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
> 
> is called with xfer->tx_sg.sgl being null, that will get passed all the way to
> iommu_dma_sync_sg_for_device() and sg_dma_is_swiotlb(), where it'll be
> dereferenced and cause the issue.

Right, sorry I was missing that piece.

> So it seems to me that either the DMA API
> functions should check for the null pointer, or if the API doesn't want to
> handle those cases (like sync being called before the buffer has been mapped),
> then the caller needs to do the check, as was done in the original code.

The dma-api.rst seems to imply that sync calls done after the mapping:

  "With the sync_sg API, all the parameters must be the same as those
   passed into the sg mapping API."


The dma-api-howto.rst is clearer on this:

  "So, firstly, just map it with dma_map_{single,sg}(), and after each DMA
   transfer call either::

        dma_sync_single_for_cpu(dev, dma_handle, size, direction);

   or::

        dma_sync_sg_for_cpu(dev, sglist, nents, direction);

   as appropriate."

So, it means the calling sync APIs on unprepared resources is a shooting in
a foot. OTOH

> The same applies for the change in spi_unmap_buf_attrs(). I see sg_free_table()
> does handle a null sgl, but dma_unmap_sgtable() doesn't (and indeed I verified
> null pointer dereference happens there too if I avoid this one).

Taking into account the above, I think those memset()'s has actually to be
paired with a dummy SG table, which is empty.

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
+/* Dummy SG for unidirect transfers */
+static struct scatterlist dummy_sg = {
+	.page_link = SG_END,
+};
+
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1260,6 +1265,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 				return ret;
 		} else {
 			memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
+			xfer->tx_sg.sgl = &dummy_sg;
 		}
 
 		if (xfer->rx_buf != NULL) {
@@ -1275,6 +1281,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		} else {
 			memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
+			xfer->rx_sg.sgl = &dummy_sg;
 		}
 	}
 	/* No transfer has been mapped, bail out with success */

But the best shot is to fix IOMMU for nents == 0 case in my opinion. Neglecting
nents before accessing the SG is not a good idea. Catalin?

The commit in question here is this one 861370f49ce4 ("iommu/dma: force
bouncing if the size is not cacheline-aligned").

-- 
With Best Regards,
Andy Shevchenko



