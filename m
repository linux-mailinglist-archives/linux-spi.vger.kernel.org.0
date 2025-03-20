Return-Path: <linux-spi+bounces-7250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F955A6A8F8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266CF189C17C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C51E22E9;
	Thu, 20 Mar 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wtr3/ELP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C61E1DF1
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481343; cv=none; b=NtZEuOhiWRClGLfUfjOzeqA6+myXL2x+cgMhXuFdYg/hZlMORFtdoCJjx/8wgAEdDFR8IGITxj5xB0WnOgcMcYvmxmkqyeAnm/M6gVffOj0tmvkmV7g3c1vdWYb4iackfsang08aXNBbuXXKWTudZCWthDyibRc8RhPK1A1WViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481343; c=relaxed/simple;
	bh=XE36aQlPHu1f09kZQRfPUZPJhkYLKBrRpAnZ8PnP3Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek/abehe1eoqebmrtuRU6AmlxHfGGExErRRdK7cmUwybkw/zPQheAVpx+HYoWHUIYxvh7Nq/zmpoE7g4xs+9KiVKG1Mg5+XdGijh6+vCNtYFrrvleJmg3OoFTNc8259giGUWSZ3A4I1V7EXOU2LmmOzWylGWiMPaDpzxwW95rsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wtr3/ELP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf7c2c351so480925e9.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742481339; x=1743086139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VA38vm2cbMMFGfsG0EfdD8B3SSoB6yClUZnugP16Ak=;
        b=Wtr3/ELPInN3QopAYJVjpKNp4dqxJa4MdHxtDB8QJiDCNkS9j/QIJ3Eea0lfAEr2kl
         3SN1aAuK5QLDtiHY9o5BuQa79RC9kgJDM5ojLiFM/lUkWlVwMm4ijuv4dvFmRABRBYaY
         dKSbyETxSywkgpPwS/hU1NWR2WUnENtZDyFYjz4eIOq9Iv8ccmYN7djGMF1P0yX+yYuI
         VJbJY3MUWkaYtwBh6coiF/TCA1FAgARxRXb0cCS3hGEvb1IXKtkm5u4u6Mlwv1Zop9t7
         YJdCm832xuv/4DGw8cjH1xTRPPvkMRMH5p9XqY2ecxudoftUPRyGp89+48Sf+R5P7jV5
         6l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481339; x=1743086139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VA38vm2cbMMFGfsG0EfdD8B3SSoB6yClUZnugP16Ak=;
        b=jLTmBQ+iGEjGvi+N5Qc3jmBJC6au7zF8+iKmceCn6ljtkNTH5cR748TL6XMBPsSpb1
         40zWZNtSfJWbhkRAprrawgkKOstZKHMc/PWGWZfzFY3s2KUWVJ7197R57Keq1/UTqmp/
         Jtm0nGD/lY1dcIFUa86gEZOyG9pSKM1wNUurC1zPU4V5f9BAPXEYQF3K8wON8e0fUL59
         A89GlvUSIOBQQvQ3r/p0OJuOiuXw6j75L+u3w8NyLUPuFUgC/vGC96EOAik69/DIemP4
         cwm3PWCC80ElZu0zqNTZuvTOJGfU84GmRMfVfvGSw0P9TGYHqCY3AFPvBtX95eyRPJGC
         sJLA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvkeUkYoRr71Q3CGzRKKap84irShZBsLa3F1yNO1N8Asjz9bfAJosun+d/Tq1JN+1jGomCPVvEjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRdQztcFvfwgAQlBs8WRkq0yj5Q+2XhAQo3J5guQMI5iYJ9Zw
	yK9gj5LgFgJe/BL4jnlRxg6uE/z9jPuIOH1zbF0VHEFkcwvDueAGcclj/xLb9dc=
X-Gm-Gg: ASbGnctcQ+Yvj2+Rt4OFEsJ4+OISyL4vDvb0ZL/1nSJn2gpW8ro7xnqlFIRhi3JmQ50
	ETaNMYIe3QSKc49v4L6qiUWQL0KD/61vUm6F9jY+jSMXaqYMllHSgG1dOR6o3PLWlVNA4YnbJ2n
	bXtzSmZ9YeRy+sA7nifWGzUmoUI4lbe7sSJ0RMqhbAaj3+pgWoF20liRE2KX3UZ6aIUgR25nqJL
	Ob+tWvfJQnQmF4trPWMs5Wj+d2LIjnoF1PzcrJ/IfchL0UTp+gpuvsaMWfPwTociFhcQGcUXGfE
	gT1O+LlLyORsL2RzN45PUnjFJ87aYNLH4qCTGwJ/8AQP2fym2sgkSWGwBJ/lKUPJFrRMafNZWua
	Y4N3f3xKlzoinaCKYDmBVmegb2nBLNq/AIeuF3Ex7udYipB0aaA==
X-Google-Smtp-Source: AGHT+IFPzSaWNlI0T0x2dv/D+tmc8IvDQPs7CrbECcxjhuDInr5xxQHRTGkofpOXn0zZcZk5OdpayQ==
X-Received: by 2002:a05:600c:524d:b0:439:a1c7:7b3a with SMTP id 5b1f17b1804b1-43d44cd3476mr23031375e9.1.1742481338570;
        Thu, 20 Mar 2025 07:35:38 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4863b4a7sm35276685e9.8.2025.03.20.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:35:36 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Mark Brown" <broonie@kernel.org>, "Grant Likely"
 <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is
 DMA safe
Message-ID: <20250320153536.44774a74@mordecai.tesarici.cz>
In-Reply-To: <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20130205142128.2E28D3E1265@localhost>
	<20250320124330.480d652d@mordecai.tesarici.cz>
	<ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
	<b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC'ing Robin Murphy, because there seem to be some doubts about DMA API
efficiency.

On Thu, 20 Mar 2025 14:35:41 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Mar 20, 2025, at 13:29, Mark Brown wrote:
> > On Thu, Mar 20, 2025 at 12:43:30PM +0100, Petr Tesarik wrote:  
> >> Grant Likely <grant.likely@secretlab.ca> wrote:  
> >> > On Sun, 27 Jan 2013 14:35:04 +0800, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:  
> >  
> >> > > Use GFP_DMA in order to ensure that the memory we allocate for transfers
> >> > > in spi_write_then_read() can be DMAed. On most platforms this will have
> >> > > no effect.  
> >  
> >> > Applied, thanks.  
> >  
> >> I'm sorry to revive such an old thread, but I'm trying to clean up DMA
> >> zone use in preparation of killing the need for that zone entirely, and
> >> this use looks fishy to me. I'm curious if it solves a real-world issue.  
> >
> > Copying in Arnd who was muttering about this stuff the other day.  Since
> > the original patch was over a decade ago I have absolutely no
> > recollection of the circumstances around the change.  I imagine I was
> > running into issues on some customer platform.  
> 
> Thanks for adding me!
> 
> >> Second, this code path is taken only if transfer size is greater than
> >> SPI_BUFSIZ, or if there is contention over the pre-allocated buffer,
> >> which is initialized in spi_init() without GFP_DMA:  
> >  
> >> 	buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);  
> >  
> >> IIUC most transfers use this buffer, and they have apparently worked
> >> fine for the last 10+ years...  
> >
> > On a lot of systems most transfers are short and won't be DMAed at all
> > since PIO ends up being more efficient, and most hardware is perfectly
> > happy to DMA to/from wherever so *shrug*.  SPI_BUFSIZ is a maximum of 32
> > bytes which is going to be under the copybreak limit for quite a few
> > controllers, though admittedly 16 is also a popular number, so a lot of
> > the time we don't actually DMA out of it at all.  
> 
> I saw the same thing looked at it the other day and got confused
> about why 'local_buf' is allocated with GFP_DMA and 'buf'
> uses plain GFP_KERNEL when they are both used in the same place.
> 
> It also seems that the copy happens in the regmap_bulk_read()
> path but not the regmap_bulk_write(), which just passes down
> the original buffer without copying, as far as I can tell.
> 
> >> What about reverting commit 2cd94c8a1b41 ("spi: Ensure memory used for
> >> spi_write_then_read() is DMA safe"), unless you have strong evidence
> >> that it is needed?  
> >
> > The whole goal there is to try to avoid triggering another copy to do
> > the DMA so just reverting rather than replacing with some other
> > construct that achieves the same goal doesn't seem great.  I think
> > possibly we should just not do the copy at all any more and trust the
> > core to DTRT with any buffers that are passed in, I think we've got
> > enough stuff in the core though I can't remember if it'll copy with
> > things allocated on the stack well.  I'd need to page the status back
> > in.  

No, I'm afraid kernel stack addresses (and many other types of
addresses) cannot be used for DMA:

https://docs.kernel.org/core-api/dma-api-howto.html#what-memory-is-dma-able

> From what I found, there are two scenarios that may depend on
> GFP_DMA today:
> 
>  a) a performance optimization where allocating from GFP_DMA avoids
>     the swiotlb bounce buffering. This would be the normal case on
>     any 64-bit machine with more than 4GB of RAM and an SPI
>     controller with a 32-bit DMA mask.

I must be missing something. How is a memcpy() in spi_write_then_read()
faster than a memcpy() by swiotlb?

>  b) An SPI controller on a 32-bit machine without swiotlb and an
>     effective DMA mask that covers less than the lowmem area.
>     E.g. on Raspberry Pi 4, the brcm,bcm2835-spi lives on a
>     bus with an 1GB dma-ranges translation, but there may be more
>     than 1GB of lowmem with CONFIG_VMSPLIT_2G=y and CONFIG_SWIOTLB=n.
>     Without GFP_DMA that would just end up causing data corruption.

Thanks for mentioning RPi4. You may remember that the wrapper around
the PCIe block in early BCM2711 chip revisions had a bug preventing it
from accessing memory beyond the first 3GB (physical):

https://www.spinics.net/lists/arm-kernel/msg740693.html

What does it mean? The limit does not depend only on the device, but
also on how it is connected to the CPU. We had some trouble defining
the DMA zone on Arm because of that...

Even worse, you can have multiple buses with different limits. An
offset may be added by a bus bridge (this does happen in the wild).
OTOH an IOMMU may map any physical address into the target device's
limited address space...

In short, I believe you should not try to reinvent the DMA API here.

> I've started playing around with a patch that annotates all
> kmalloc(..., GFP_DMA) users that use buffers for SPI transfers,
> as opposed to those that do it for another reason (ISA driver,
> odd DMA mask, ...). There are probably some missing below, and some
> of the regmap users are likely not SPI but something else, but
> overall there are not a lot of them.
> 
> I think we have some corner cases where a driver allocates
> a GFP_DMA buffer, calls spi_write_then_read through regmap,
> which copies the data to the non-GFP_DMA global buffer,
> and then the SPI controller driver calls dma_map_single()
> on that, ending up with a third bounce buffer from
> swiotlb.
> 
> I don't know what a good replacement interface would be, but
> ideally there should never be more than one copy here,
> which means that any temporary buffer would need to be
> allocated according to the dma_mask of the underlying
> bus master (dmaengine, spi controller, ...).

Thank you for the attached patch. That's a lot of places that may be
using GFP_DMA incorrectly, and you have put a lot of effort into
understanding every single one of them. Greatly appreciated!

I still believe the SPI subsystem should not try to be clever. The
DMA API already avoids unnecessary copying as much as possible.

Petr T

> 
>       Arnd
> 
> diff --git a/drivers/firmware/cirrus/cs_dsp.c
> b/drivers/firmware/cirrus/cs_dsp.c index 42433c19eb30..10611858bef6
> 100644 --- a/drivers/firmware/cirrus/cs_dsp.c
> +++ b/drivers/firmware/cirrus/cs_dsp.c
> @@ -763,7 +763,7 @@ static int cs_dsp_coeff_write_ctrl_raw(struct
> cs_dsp_coeff_ctl *ctl, if (ret)
>  		return ret;
>  
> -	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_DMA);
> +	scratch = kmemdup(buf, len, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!scratch)
>  		return -ENOMEM;
>  
> @@ -868,7 +868,7 @@ static int cs_dsp_coeff_read_ctrl_raw(struct
> cs_dsp_coeff_ctl *ctl, if (ret)
>  		return ret;
>  
> -	scratch = kmalloc(len, GFP_KERNEL | GFP_DMA);
> +	scratch = kmalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!scratch)
>  		return -ENOMEM;
>  
> @@ -1724,7 +1724,7 @@ static void *cs_dsp_read_algs(struct cs_dsp
> *dsp, size_t n_algs, /* Convert length from DSP words to bytes */
>  	len *= sizeof(u32);
>  
> -	alg = kzalloc(len, GFP_KERNEL | GFP_DMA);
> +	alg = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!alg)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c
> b/drivers/iio/common/ssp_sensors/ssp_iio.c index
> 78ac689de2fe..246d03187b54 100644 ---
> a/drivers/iio/common/ssp_sensors/ssp_iio.c +++
> b/drivers/iio/common/ssp_sensors/ssp_iio.c @@ -27,7 +27,7 @@ int
> ssp_common_buffer_postenable(struct iio_dev *indio_dev) /* the
> allocation is made in post because scan size is known in this
>  	 * moment
>  	 * */
> -	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL |
> GFP_DMA);
> +	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL |
> GFP_SPI_DMA); if (!spd->buffer)
>  		return -ENOMEM;
>  
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c
> b/drivers/iio/common/ssp_sensors/ssp_spi.c index
> f32b04b63ea1..b70dd891801f 100644 ---
> a/drivers/iio/common/ssp_sensors/ssp_spi.c +++
> b/drivers/iio/common/ssp_sensors/ssp_spi.c @@ -87,7 +87,7 @@ static
> struct ssp_msg *ssp_create_msg(u8 cmd, u16 len, u16 opt, u32 data)
> h.data = cpu_to_le32(data); 
>  	msg->buffer = kzalloc(SSP_HEADER_SIZE_ALIGNED + len,
> -			      GFP_KERNEL | GFP_DMA);
> +			      GFP_KERNEL | GFP_SPI_DMA);
>  	if (!msg->buffer) {
>  		kfree(msg);
>  		return NULL;
> @@ -375,7 +375,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones -
> it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL |
> GFP_DMA);
> +			buffer = kmalloc(length, GFP_KERNEL |
> GFP_SPI_DMA); if (!buffer) {
>  				ret = -ENOMEM;
>  				goto _unlock;
> @@ -420,7 +420,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> +		buffer = kzalloc(length, GFP_KERNEL | GFP_SPI_DMA);
>  		if (!buffer)
>  			return -ENOMEM;
>  
> diff --git a/drivers/input/rmi4/rmi_spi.c
> b/drivers/input/rmi4/rmi_spi.c index 9d92129aa432..a9abc021bfad 100644
> --- a/drivers/input/rmi4/rmi_spi.c
> +++ b/drivers/input/rmi4/rmi_spi.c
> @@ -67,7 +67,7 @@ static int rmi_spi_manage_pools(struct
> rmi_spi_xport *rmi_spi, int len) 
>  	tmp = rmi_spi->rx_buf;
>  	buf = devm_kcalloc(&spi->dev, buf_size, 2,
> -				GFP_KERNEL | GFP_DMA);
> +				GFP_KERNEL | GFP_SPI_DMA);
>  	if (!buf)
>  		return -ENOMEM;
>  
> diff --git a/drivers/media/spi/cxd2880-spi.c
> b/drivers/media/spi/cxd2880-spi.c index 65fa7f857fca..7063d46c4166
> 100644 --- a/drivers/media/spi/cxd2880-spi.c
> +++ b/drivers/media/spi/cxd2880-spi.c
> @@ -389,7 +389,7 @@ static int cxd2880_start_feed(struct
> dvb_demux_feed *feed) if (dvb_spi->feed_count == 0) {
>  		dvb_spi->ts_buf =
>  			kzalloc(MAX_TRANS_PKT * 188,
> -				GFP_KERNEL | GFP_DMA);
> +				GFP_KERNEL | GFP_SPI_DMA);
>  		if (!dvb_spi->ts_buf) {
>  			pr_err("ts buffer allocate failed\n");
>  			memset(&dvb_spi->filter_config, 0,
> diff --git a/drivers/misc/gehc-achc.c b/drivers/misc/gehc-achc.c
> index b8fca4d393c6..42af67fd232d 100644
> --- a/drivers/misc/gehc-achc.c
> +++ b/drivers/misc/gehc-achc.c
> @@ -225,7 +225,7 @@ static int ezport_flash_transfer(struct
> spi_device *spi, u32 address, if (ret < 0)
>  		return ret;
>  
> -	command = kmalloc(4, GFP_KERNEL | GFP_DMA);
> +	command = kmalloc(4, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!command)
>  		return -ENOMEM;
>  
> @@ -255,7 +255,7 @@ static int ezport_flash_compare(struct spi_device
> *spi, u32 address, u8 *buffer;
>  	int ret;
>  
> -	buffer = kmalloc(payload_size + 5, GFP_KERNEL | GFP_DMA);
> +	buffer = kmalloc(payload_size + 5, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!buffer)
>  		return -ENOMEM;
>  
> diff --git a/drivers/net/wireless/st/cw1200/fwio.c
> b/drivers/net/wireless/st/cw1200/fwio.c index
> 2a03dc533b6a..6cdbb4980b02 100644 ---
> a/drivers/net/wireless/st/cw1200/fwio.c +++
> b/drivers/net/wireless/st/cw1200/fwio.c @@ -148,7 +148,7 @@ static
> int cw1200_load_firmware_cw1200(struct cw1200_common *priv) goto exit;
>  	}
>  
> -	buf = kmalloc(DOWNLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_DMA);
> +	buf = kmalloc(DOWNLOAD_BLOCK_SIZE, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!buf) {
>  		pr_err("Can't allocate firmware load buffer.\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/net/wireless/st/cw1200/wsm.c
> b/drivers/net/wireless/st/cw1200/wsm.c index
> 4a9e4b5d3547..9a8c6510d1d6 100644 ---
> a/drivers/net/wireless/st/cw1200/wsm.c +++
> b/drivers/net/wireless/st/cw1200/wsm.c @@ -1775,7 +1775,7 @@ void
> wsm_txed(struct cw1200_common *priv, u8 *data) void
> wsm_buf_init(struct wsm_buf *buf) {
>  	BUG_ON(buf->begin);
> -	buf->begin = kmalloc(FWLOAD_BLOCK_SIZE, GFP_KERNEL |
> GFP_DMA);
> +	buf->begin = kmalloc(FWLOAD_BLOCK_SIZE, GFP_KERNEL |
> GFP_SPI_DMA); buf->end = buf->begin ? &buf->begin[FWLOAD_BLOCK_SIZE]
> : buf->begin; wsm_buf_reset(buf);
>  }
> @@ -1804,7 +1804,7 @@ static int wsm_buf_reserve(struct wsm_buf *buf,
> size_t extra_size) 
>  	size = round_up(size, FWLOAD_BLOCK_SIZE);
>  
> -	tmp = krealloc(buf->begin, size, GFP_KERNEL | GFP_DMA);
> +	tmp = krealloc(buf->begin, size, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!tmp) {
>  		wsm_buf_deinit(buf);
>  		return -ENOMEM;
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c
> b/drivers/net/wireless/ti/wlcore/cmd.c index
> cd8ad0fe59cc..a0063878e47c 100644 ---
> a/drivers/net/wireless/ti/wlcore/cmd.c +++
> b/drivers/net/wireless/ti/wlcore/cmd.c @@ -172,7 +172,7 @@ int
> wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl, 
>  	*timeout = false;
>  
> -	events_vector = kmalloc(sizeof(*events_vector), GFP_KERNEL |
> GFP_DMA);
> +	events_vector = kmalloc(sizeof(*events_vector), GFP_KERNEL);
>  	if (!events_vector)
>  		return -ENOMEM;
>  
> diff --git a/drivers/net/wireless/ti/wlcore/main.c
> b/drivers/net/wireless/ti/wlcore/main.c index
> 8fb58a5d911c..02962702b72d 100644 ---
> a/drivers/net/wireless/ti/wlcore/main.c +++
> b/drivers/net/wireless/ti/wlcore/main.c @@ -6477,7 +6477,7 @@ struct
> ieee80211_hw *wlcore_alloc_hw(size_t priv_size, u32 aggr_buf_size, }
>  
>  	wl->mbox_size = mbox_size;
> -	wl->mbox = kmalloc(wl->mbox_size, GFP_KERNEL | GFP_DMA);
> +	wl->mbox = kmalloc(wl->mbox_size, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!wl->mbox) {
>  		ret = -ENOMEM;
>  		goto err_fwlog;
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 65db9349f905..6c3d3d7cc6fe 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -382,6 +382,7 @@ enum {
>  #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
>  #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS |
> __GFP_HARDWALL) #define GFP_DMA		__GFP_DMA
> +#define GFP_SPI_DMA	__GFP_DMA
>  #define GFP_DMA32	__GFP_DMA32
>  #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
>  #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE |
> __GFP_SKIP_KASAN) diff --git a/include/sound/cs35l56.h
> b/include/sound/cs35l56.h index 5d653a3491d0..415497307c45 100644
> --- a/include/sound/cs35l56.h
> +++ b/include/sound/cs35l56.h
> @@ -295,7 +295,7 @@ static inline int
> cs35l56_init_config_for_spi(struct cs35l56_base *cs35l56, {
>  	cs35l56->spi_payload_buf = devm_kzalloc(&spi->dev,
>  						sizeof(*cs35l56->spi_payload_buf),
> -						GFP_KERNEL |
> GFP_DMA);
> +						GFP_KERNEL |
> GFP_SPI_DMA); if (!cs35l56->spi_payload_buf)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
> index 74b0968f425a..c679d278c53e 100644
> --- a/sound/soc/codecs/arizona.c
> +++ b/sound/soc/codecs/arizona.c
> @@ -2734,7 +2734,7 @@ int arizona_eq_coeff_put(struct snd_kcontrol
> *kcontrol, 
>  	len = params->num_regs *
> regmap_get_val_bytes(arizona->regmap); 
> -	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL |
> GFP_DMA);
> +	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL |
> GFP_SPI_DMA); if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
> index bc3470cf2c54..c75f6a617c73 100644
> --- a/sound/soc/codecs/madera.c
> +++ b/sound/soc/codecs/madera.c
> @@ -4754,7 +4754,7 @@ int madera_eq_coeff_put(struct snd_kcontrol
> *kcontrol, 
>  	len = params->num_regs *
> regmap_get_val_bytes(madera->regmap); 
> -	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL |
> GFP_DMA);
> +	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL |
> GFP_SPI_DMA); if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
> index 6f432b992941..2b66c50bbf1b 100644
> --- a/sound/soc/codecs/nau8810.c
> +++ b/sound/soc/codecs/nau8810.c
> @@ -205,7 +205,7 @@ static int nau8810_eq_put(struct snd_kcontrol
> *kcontrol, __be16 *tmp;
>  
>  	data = kmemdup(ucontrol->value.bytes.data,
> -		params->max, GFP_KERNEL | GFP_DMA);
> +		params->max, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
> index edb95f869a4a..7cca9dac7e5f 100644
> --- a/sound/soc/codecs/nau8821.c
> +++ b/sound/soc/codecs/nau8821.c
> @@ -303,7 +303,7 @@ static int nau8821_biq_coeff_put(struct
> snd_kcontrol *kcontrol, return -EINVAL;
>  
>  	data = kmemdup(ucontrol->value.bytes.data,
> -		params->max, GFP_KERNEL | GFP_DMA);
> +		params->max, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
> index 15d6f8d01f78..016f537ebb30 100644
> --- a/sound/soc/codecs/nau8822.c
> +++ b/sound/soc/codecs/nau8822.c
> @@ -221,7 +221,7 @@ static int nau8822_eq_put(struct snd_kcontrol
> *kcontrol, __be16 *tmp;
>  
>  	data = kmemdup(ucontrol->value.bytes.data,
> -		params->max, GFP_KERNEL | GFP_DMA);
> +		params->max, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 25b8b19e27ec..43a73aabf891 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -1017,7 +1017,7 @@ static int nau8825_biq_coeff_put(struct
> snd_kcontrol *kcontrol, return -EINVAL;
>  
>  	data = kmemdup(ucontrol->value.bytes.data,
> -		params->max, GFP_KERNEL | GFP_DMA);
> +		params->max, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!data)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
> index 6c6e7ae07d80..a0f75b089aa4 100644
> --- a/sound/soc/codecs/tas571x.c
> +++ b/sound/soc/codecs/tas571x.c
> @@ -150,7 +150,7 @@ static int tas571x_reg_write_multiword(struct
> i2c_client *client, int ret;
>  	size_t send_size = 1 + len * sizeof(uint32_t);
>  
> -	buf = kzalloc(send_size, GFP_KERNEL | GFP_DMA);
> +	buf = kzalloc(send_size, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!buf)
>  		return -ENOMEM;
>  	buf[0] = reg;
> @@ -183,7 +183,7 @@ static int tas571x_reg_read_multiword(struct
> i2c_client *client, unsigned int recv_size = len * sizeof(uint32_t);
>  	int ret;
>  
> -	recv_buf = kzalloc(recv_size, GFP_KERNEL | GFP_DMA);
> +	recv_buf = kzalloc(recv_size, GFP_KERNEL | GFP_DMA); // XXXX
>  	if (!recv_buf)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 8d1a575532ff..d1ef988aa84e 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -405,14 +405,14 @@ static int wm0010_firmware_load(const char
> *name, struct snd_soc_component *comp xfer->component = component;
>  		list_add_tail(&xfer->list, &xfer_list);
>  
> -		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
> +		out = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  		if (!out) {
>  			ret = -ENOMEM;
>  			goto abort1;
>  		}
>  		xfer->t.rx_buf = out;
>  
> -		img = kzalloc(len, GFP_KERNEL | GFP_DMA);
> +		img = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  		if (!img) {
>  			ret = -ENOMEM;
>  			goto abort1;
> @@ -504,13 +504,13 @@ static int wm0010_stage2_load(struct
> snd_soc_component *component) dev_dbg(component->dev, "Downloading
> %zu byte stage 2 loader\n", fw->size); 
>  	/* Copy to local buffer first as vmalloc causes problems for
> dma */
> -	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
> +	img = kmemdup(&fw->data[0], fw->size, GFP_KERNEL |
> GFP_SPI_DMA); if (!img) {
>  		ret = -ENOMEM;
>  		goto abort2;
>  	}
>  
> -	out = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +	out = kzalloc(fw->size, GFP_KERNEL | GFP_SPI_DMA);
>  	if (!out) {
>  		ret = -ENOMEM;
>  		goto abort1;
> @@ -638,11 +638,11 @@ static int wm0010_boot(struct snd_soc_component
> *component) 
>  		ret = -ENOMEM;
>  		len = pll_rec.length + 8;
> -		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
> +		out = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  		if (!out)
>  			goto abort;
>  
> -		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
> +		img_swap = kzalloc(len, GFP_KERNEL | GFP_SPI_DMA);
>  		if (!img_swap)
>  			goto abort_out;
>  
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 91c8697c29c3..7e8b44b911c0 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -1373,7 +1373,7 @@ int wm_adsp_compr_set_params(struct
> snd_soc_component *component, compr->size.fragment_size,
> compr->size.fragments); 
>  	size = wm_adsp_compr_frag_words(compr) *
> sizeof(*compr->raw_buf);
> -	compr->raw_buf = kmalloc(size, GFP_DMA | GFP_KERNEL);
> +	compr->raw_buf = kmalloc(size, GFP_SPI_DMA | GFP_KERNEL);
>  	if (!compr->raw_buf)
>  		return -ENOMEM;
>  
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index cd5f927bcd4e..231e80ca0386 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -749,7 +749,7 @@ int snd_soc_bytes_put(struct snd_kcontrol
> *kcontrol, len = params->num_regs * component->val_bytes;
>  
>  	void *data __free(kfree) =
> kmemdup(ucontrol->value.bytes.data, len,
> -					   GFP_KERNEL | GFP_DMA);
> +					   GFP_KERNEL | GFP_SPI_DMA);
>  	if (!data)
>  		return -ENOMEM;
>  


