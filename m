Return-Path: <linux-spi+bounces-2867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8528C7A4F
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE47A283CA1
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12214D71B;
	Thu, 16 May 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xm+tt4vj"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAB14D719;
	Thu, 16 May 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876725; cv=none; b=DYu7jtCUA14I9tzylwGiWKa8gjrhbk4SyKZegheLwjYlSpiQSsLlYxWnZ8mFQw5Cr+X9kDKbcYuDmwLyJZqJFl9GCJKrtdPaVNs5t5wsmqLB7hS1bd8TjqsYqTfWuJzyzTrAuHQsBRYUwlEQx3Lf8+UXuLFuMJwgH6GW3ihItko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876725; c=relaxed/simple;
	bh=ManuiqZkVA/LH1oUi2yvZnP0nenBUYYloncINkTTt/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeZibkrTPWWTBDbkKZk+JMr6SK9VSQPsTKg4zuVdqGjShZDJKCwSrSkcdkjGr1U401SxKVeOdwsN5YbS6sWQEUk0PKytzsPyNLW1lq9Jye2zF1wAD2ljhR1uQBPEe365Ab4uivrfJegZz5nvLFfo0CTS2VYash7I8trv65S7xfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xm+tt4vj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715876722;
	bh=ManuiqZkVA/LH1oUi2yvZnP0nenBUYYloncINkTTt/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xm+tt4vj6fqAqYaWHMwVxBRNN8IZbrcKZPOKlbahvYjbr9pbSTsFviXlxn9Vli/UU
	 hhwcWkdWc0uj6pvmD2TdX/QqOPk5iKPS5LlmFf1b3AsQGkwKHKcF+1xTvJ5HXgI1/w
	 0KdnZ+9h4XCrW3M5nWnSTcYVKtLa1efrKXzWY4qrq+dRBs6juWPMKR+cXAXghDts1G
	 E+N59YppiTHxN+O3tK8eusFL0w0YwReqjMrN4KEGBmscTs+mL5FpFb2VNk1ne2q8DY
	 yQ2bkdCgJYjWwo0fF5N7zzIbc6nURvnFt0nT0ON3qDrTqPOtJNgWKcgDKAM6/cug89
	 A5w0XmuK9wUOw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 23933378143B;
	Thu, 16 May 2024 16:25:21 +0000 (UTC)
Date: Thu, 16 May 2024 12:25:19 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <2fccdd9a-5b97-4dc6-a6b1-ce2d9e0819bd@notapiano>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <ZkXdXO4Xb83270V7@smile.fi.intel.com>
 <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>

On Thu, May 16, 2024 at 04:25:35PM +0300, Andy Shevchenko wrote:
> On Thu, May 16, 2024 at 01:18:04PM +0300, Andy Shevchenko wrote:
> > On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > All the same applies to other DMA mapping API calls.
> > > > 
> > > > Also note, there is no other user in the kernel that does this kind of
> > > > checks.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > this commit caused a regression which I reported here:
> > > 
> > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > 
> > > along with some thoughts on the cause and a possible solution, though I'm not
> > > familiar with this code base at all and would really appreciate any feedback you
> > > may have.
> > 
> > Thanks for the report and preliminary analysis!
> > I'll look at it hopefully sooner than later.
> > 
> > But at least what I think now is that my change revealed a problem somewhere
> > else, because that's how DMA mapping / streaming APIs designed, it's extremely
> > rare to check orig_nents field.
> 
> Can you test the below patch?
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b2efd4964f7c..51811f04e463 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  	else
>  		rx_dev = ctlr->dev.parent;
>  
> +	ret = -ENOMSG;
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		/* The sync is done before each transfer. */
>  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
> @@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  			}
>  		}
>  	}
> +	/* No transfer has been mapped, bail out with success */
> +	if (ret)
> +		return 0;
>  
>  	ctlr->cur_rx_dma_dev = rx_dev;
>  	ctlr->cur_tx_dma_dev = tx_dev;

Hi Andy,

thank you for the patch. Unfortunately it didn't completely solve the issue. Now
the stack trace is slightly different and points at the next line:

	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);

So now we're hitting the case where only the tx buffer was DMA mapped, but the
rx is still uninitialized, though the cur_msg_mapped flag is set to true, since
it is shared between them. The original code checked for the initialization of
each scatterlist individually, which is why it worked.

Thanks,
Nícolas

