Return-Path: <linux-spi+bounces-2911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B68C7DE6
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 23:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7757282B3F
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C7157E9E;
	Thu, 16 May 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u4McJBe8"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70A5250;
	Thu, 16 May 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893888; cv=none; b=OpyZDhiidh0oUZtEc7F7pxduMqtmxW6byKQXGPodoq7dobZtaBnxkxrHe2exsyXlwg6XJS66DEIL75F5b2KudGX4pz1Z/a9sEDLQ51TrsG1YyWmkcwaoMR/xhurRi6VkSv3CSVHHJZyShYFqo+dFA0ijiecV09KXPxUYrweSHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893888; c=relaxed/simple;
	bh=cravbn4MV/KVF/u5zIEyrt9Uh9e/yN5beMqcBhMb6xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlYnX4hBIMoeYAPmKimz4upeKtB3MF1VHlxZPPfCVcKdK6dfXI/q6NOaTLGCT7osTIk3MON5H9KvkJ8fgmaO/CBT1VbhOa3Z2xz0//C4dNZCryKfFqfeXB58epxzwc0lmf/ZxYg6q+X7JWLpwrdRNewd/gVwLnOULhDQ3ePKGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=u4McJBe8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715893884;
	bh=cravbn4MV/KVF/u5zIEyrt9Uh9e/yN5beMqcBhMb6xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4McJBe8IhgsJVGKmL7r63tEs0Y8DpJXPBZC5M2CDxXFE0ThXRd2V5rDLlnYQ3nIH
	 5tVxJW2a3AXYFSthBmI92J2XMjnKncBbZjONt6HCljx7apSFNcU2zeTvaJL94gBB18
	 Yr+Z0RAgcuuH1LtcttQG8uYDmclpXvgEmnwM4IszfptJ3cvp3kBJbAFIfpnacn36iO
	 nH15/I8W1Q6djo4hSWmRlZzsB0a8+xSXJX7FTqAu25SFqr4fDNI2me5JvYto0s1lBn
	 WjKOMEBLlbg851s8VMjFg+i2zGe2zYLrLWyhyVEIVZvztT0T0q83OFPkIqR9E39kHo
	 Y5iLRnmfvmFGA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3FBD37821A8;
	Thu, 16 May 2024 21:11:23 +0000 (UTC)
Date: Thu, 16 May 2024 17:11:21 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <038b55ec-9cbc-4303-a962-906f073892b8@notapiano>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <ZkXdXO4Xb83270V7@smile.fi.intel.com>
 <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>
 <2fccdd9a-5b97-4dc6-a6b1-ce2d9e0819bd@notapiano>
 <ZkZGbz0RlUHshneC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkZGbz0RlUHshneC@smile.fi.intel.com>

On Thu, May 16, 2024 at 08:46:23PM +0300, Andy Shevchenko wrote:
> On Thu, May 16, 2024 at 12:25:19PM -0400, Nícolas F. R. A. Prado wrote:
> > On Thu, May 16, 2024 at 04:25:35PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 16, 2024 at 01:18:04PM +0300, Andy Shevchenko wrote:
> > > > On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> > > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > > All the same applies to other DMA mapping API calls.
> > > > > > 
> > > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > > checks.
> > > > > > 
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > this commit caused a regression which I reported here:
> > > > > 
> > > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > > 
> > > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > > familiar with this code base at all and would really appreciate any feedback you
> > > > > may have.
> > > > 
> > > > Thanks for the report and preliminary analysis!
> > > > I'll look at it hopefully sooner than later.
> > > > 
> > > > But at least what I think now is that my change revealed a problem somewhere
> > > > else, because that's how DMA mapping / streaming APIs designed, it's extremely
> > > > rare to check orig_nents field.
> > > 
> > > Can you test the below patch?
> > > 
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index b2efd4964f7c..51811f04e463 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> > >  	else
> > >  		rx_dev = ctlr->dev.parent;
> > >  
> > > +	ret = -ENOMSG;
> > >  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > >  		/* The sync is done before each transfer. */
> > >  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
> > > @@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> > >  			}
> > >  		}
> > >  	}
> > > +	/* No transfer has been mapped, bail out with success */
> > > +	if (ret)
> > > +		return 0;
> > >  
> > >  	ctlr->cur_rx_dma_dev = rx_dev;
> > >  	ctlr->cur_tx_dma_dev = tx_dev;
> > 
> > Hi Andy,
> > 
> > thank you for the patch. Unfortunately it didn't completely solve the issue. Now
> > the stack trace is slightly different and points at the next line:
> > 
> > 	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
> > 
> > So now we're hitting the case where only the tx buffer was DMA mapped, but the
> > rx is still uninitialized, though the cur_msg_mapped flag is set to true, since
> > it is shared between them. The original code checked for the initialization of
> > each scatterlist individually, which is why it worked.
> 
> I was kinda expecting that, and already have another patch to try (should
> applied on top):
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 51811f04e463..5c607dd21fe7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1258,6 +1258,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  						attrs);
>  			if (ret != 0)
>  				return ret;
> +		} else {
> +			memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
>  		}
>  
>  		if (xfer->rx_buf != NULL) {
> @@ -1271,6 +1273,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  
>  				return ret;
>  			}
> +		} else {
> +			memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
>  		}
>  	}
>  	/* No transfer has been mapped, bail out with success */

Still the same issue. I've attached the backtrace at the end for reference. But
I don't see how a memset would help here. As far as I can see, there's nothing
in the DMA API protecting it from a null pointer to be passed in. So when

	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);

is called with xfer->tx_sg.sgl being null, that will get passed all the way to
iommu_dma_sync_sg_for_device() and sg_dma_is_swiotlb(), where it'll be
dereferenced and cause the issue. So it seems to me that either the DMA API
functions should check for the null pointer, or if the API doesn't want to
handle those cases (like sync being called before the buffer has been mapped),
then the caller needs to do the check, as was done in the original code.

The same applies for the change in spi_unmap_buf_attrs(). I see sg_free_table()
does handle a null sgl, but dma_unmap_sgtable() doesn't (and indeed I verified
null pointer dereference happens there too if I avoid this one).

Thanks,
Nícolas

[    3.418996] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.425173] Mem abort info:
[    3.425175]   ESR = 0x0000000096000004
[    3.425178]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.425183]   SET = 0, FnV = 0
[    3.425186]   EA = 0, S1PTW = 0
[    3.437092]   FSC = 0x04: level 0 translation fault
[    3.446403] Data abort info:
[    3.446405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.452779]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.460666]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.467487] [000000000000001c] user address but active_mm is swapper
[    3.478571] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    3.486896] Modules linked in:
[    3.495580] CPU: 6 PID: 68 Comm: kworker/u32:2 Tainted: G        W          6.9.0-next-20240515-00003-g3f984d58a25f #400
[    3.507103] Hardware name: Google Kingoftown (DT)
[    3.507108] Workqueue: events_unbound deferred_probe_work_func
[    3.516498] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.525275] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.580070] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.585089] sp : ffff800080942dc0
[    3.588495] x29: ffff800080942dc0 x28: ffff5a9cc33ac000 x27: ffff5a9cc1482010
[    3.595821] x26: ffff800080943008 x25: ffff5a9cc33ac480 x24: ffffb11b69bcfc00
[    3.603146] x23: ffff5a9cc1482010 x22: 0000000000000001 x21: 0000000000000000
[    3.610473] x20: ffffb11b69f3d718 x19: 0000000000000000 x18: ffffb11b6ac19c48
[    3.617797] x17: 0000000000010108 x16: 0000000000000000 x15: 0000000000000002
[    3.625130] x14: 0000000000000001 x13: 0000000000161361 x12: 0000000000000001
[    3.632454] x11: ffff800080942cd0 x10: ffff5a9cc3dafff8 x9 : ffff5a9cc33ac469
[    3.639782] x8 : ffff5a9cc148d704 x7 : 00000000ffffffff x6 : 0000000000000001
[    3.647109] x5 : ffffb11b6933a780 x4 : ffffb11b68504b34 x3 : 0000000000000001
[    3.654442] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff5a9cc1482010
[    3.661769] Call trace:
[    3.664285]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.669388]  __dma_sync_sg_for_device+0x28/0x4c
[    3.674052]  spi_transfer_one_message+0x378/0x6e4
[    3.678898]  __spi_pump_transfer_message+0x1dc/0x504
[    3.684002]  __spi_sync+0x2a0/0x3c4
[    3.687589]  spi_sync+0x30/0x54
[    3.690825]  spi_mem_exec_op+0x26c/0x41c
[    3.694866]  spi_nor_spimem_read_data+0x148/0x158
[    3.699708]  spi_nor_read_data+0x30/0x3c
[    3.703745]  spi_nor_read_sfdp+0x74/0xe4
[    3.707784]  spi_nor_parse_sfdp+0x120/0x11d0
[    3.712174]  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
[    3.717807]  spi_nor_scan+0x7ac/0xef8
[    3.721579]  spi_nor_probe+0x94/0x2ec
[    3.725352]  spi_mem_probe+0x6c/0xac
[    3.729038]  spi_probe+0x84/0xe4
[    3.732359]  really_probe+0xbc/0x2a0
[    3.736035]  __driver_probe_device+0x78/0x12c
[    3.740511]  driver_probe_device+0x40/0x160
[    3.744814]  __device_attach_driver+0xb8/0x134
[    3.749381]  bus_for_each_drv+0x84/0xe0
[    3.753330]  __device_attach+0xa8/0x1b0
[    3.757280]  device_initial_probe+0x14/0x20
[    3.761580]  bus_probe_device+0xa8/0xac
[    3.765526]  device_add+0x590/0x750
[    3.769108]  __spi_add_device+0x138/0x208
[    3.773234]  of_register_spi_device+0x394/0x57c
[    3.777898]  spi_register_controller+0x394/0x760
[    3.782651]  qcom_qspi_probe+0x328/0x390
[    3.786691]  platform_probe+0x68/0xd8
[    3.790464]  really_probe+0xbc/0x2a0
[    3.794147]  __driver_probe_device+0x78/0x12c
[    3.798622]  driver_probe_device+0x40/0x160
[    3.802923]  __device_attach_driver+0xb8/0x134
[    3.807487]  bus_for_each_drv+0x84/0xe0
[    3.811434]  __device_attach+0xa8/0x1b0
[    3.815383]  device_initial_probe+0x14/0x20
[    3.819682]  bus_probe_device+0xa8/0xac
[    3.823629]  deferred_probe_work_func+0x88/0xc0
[    3.828281]  process_one_work+0x154/0x298
[    3.832409]  worker_thread+0x304/0x408
[    3.836272]  kthread+0x118/0x11c
[    3.839596]  ret_from_fork+0x10/0x20
[    3.843284] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    3.849541] ---[ end trace 0000000000000000 ]---

> 
> 
> If my understanding is correct, my patch revealed two issues:
> - for non-mapped message at all;
> - for unidirect transfers.
> 
> But I will wait for your test results to make the final conclusion.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

