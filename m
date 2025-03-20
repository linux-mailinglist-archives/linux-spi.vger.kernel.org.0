Return-Path: <linux-spi+bounces-7256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFACA6AAB9
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF293B2959
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D381DED6F;
	Thu, 20 Mar 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I15WQL+z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222EF21D5B0
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486933; cv=none; b=V38h7vUjGZ+V3LZ9A/R/JXnPS9LRZkT4JvxE6jQf9UW0w537Dqc57gxlZXoOn3EnnHLgo7AuwVEhiezfWa6M3SUn7MSdanwMKaSRCfrf+9oc6zbR2jXp1DFPkvxlRmhP5claLNBHURn4XMBhxqHVUsnNJqxV0botOi3T+xzS76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486933; c=relaxed/simple;
	bh=z84sso7f3UfJQQ/31OsOx2FNEB5xtG36UftFfRP7B8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXy+O26kGSEnKSWfQDDglvlo6CyOEaUFtfPUT9rsgBroVyzzBsfUltKOLwJ3fTsIXwAnzkroUmVC9+lfVwkvf6uzpbyQwIFUhpcGKXv7ojXFLkMI8M0TlUH7XUIADJDhlCsZhAs32SFT3SaYay7e4qnyG+puxgrnPEkFqH6fV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I15WQL+z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391324ef4a0so126905f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742486929; x=1743091729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kHa60JIYKX9PlEg/V64hxswvAVtVGYMyVrVKFBfiB0=;
        b=I15WQL+z42+lJ28g7mTs90ZQWyiHemkkhySDP86hqkOMQ2Qf1VVS4tjPMAy75GZ9Jb
         pVkHf3i6lylfZCr17gZKr/qgWy2tAzVCyT1PPHWqdUlgDj4iqxnY6LwLFiixX3Rc72P0
         VCvayJee/TwqtAs7rQt99KsGCCpSQQzFvTtThMOg25PlYM65wzjryNBvFNKZ+eDSX774
         xr4X/e+6xDrBfYDEsgUjrzTm019nLNHeAZn8AvqfPN4CrY8CAXwTlJc4fOdDXVOpbiKL
         PnJBh8WqfD+bs00oCPjeO65aihd1yiVU0hsnkK7d24+JbXN391wxIF2GK1dcLvdXOZ/F
         BacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486929; x=1743091729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kHa60JIYKX9PlEg/V64hxswvAVtVGYMyVrVKFBfiB0=;
        b=InCD1E6LaSA7qrb/ZCGvH6l4x/+BOvB5w2fjGFh0HxpirtVuuePGhoGxoa0A/X5hh5
         MUa9RNoHXAZjtY7RI2KU8W8IZrt25p8RGbRXav9Fb1newpFo+azZQS94W6v1gP/80Ca6
         BkfuWizMBDdUGodZ4YIBfTLibyLmzIj2+dSPHjIhw9P9cU1cVpCiuOwY0AnI/hcDo5vO
         COBD1afiDSyDOdfzL+nv+evHXxIQQGYsBn+rApjo3eFW8eeg4UesMVqS0RTMiaj9D8LZ
         20AsFWb5Efgq19y1UOPZ1z9tx2GLImTyHu5MovUuproQJMlSrj/w6G6yxPSDE0zwRaY5
         JE6A==
X-Forwarded-Encrypted: i=1; AJvYcCXgTowdI2z8ycP3j0zXvu2AE4nv/N04ZxMIBY1supkSy1poYfLJ1c+5Li0CGEslRT0/DQdD+6TbxLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULdJU6rQISGrgdqNZpCGibiaHvhs8PmLnckfqMLUK8Sy1EpYZ
	UPWE+Eurw1jjXRrg/CzR8JMXgTukndIyGikxCuQTty66It2yjlQ2Hpl1FpbduTg=
X-Gm-Gg: ASbGnctZhLTrBzspUBVBTVR9uNjbCuWAsEkz6t1TLJuFmxA+i/eP1s+YNxNbjJ1tfC0
	GR01duhgbzKlAS2z1x9qwCJHtP/UV9cAjLQvfodDvph6TAi0OP66xitICD0EQ6HrpOmmrMD9UoB
	G5D7GCulXCAGcr1/RfXzTa/s+ntIhFdX2IFVaZzi9zgu5EmX506Zzhx6Wknw/X9MrBRn3qon2W9
	8bdkOJzzjLwwT0Ff5dap5lmbVg5qtPIK7mQGtUBc/B537b2dFLV5uXmzE5CTDMrklZugJ0GMfl3
	Mg+Ir+fdda1sTvhaBZ/3zQxvGt3+VaPXdxO0udpp3QfRT5ag9MZdcj2G68PZT66VPKyitpRGFwc
	KG561alMQ6lMuhekn8QNZCm7YwtNOS5K3WvPmVUnb2SdUfnjKtg==
X-Google-Smtp-Source: AGHT+IF+n4/125DWwRd4QO/E8Ib23KmYraVt8CqKURPcw7uagoIh6m4BUkg4QsmBHaueqHPBc4Swww==
X-Received: by 2002:a5d:6da1:0:b0:38d:d371:e03d with SMTP id ffacd0b85a97d-3997f8ee224mr36284f8f.3.1742486928898;
        Thu, 20 Mar 2025 09:08:48 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm9920f8f.35.2025.03.20.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:08:48 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:08:46 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is
 DMA safe
Message-ID: <20250320170846.64db4a4d@mordecai.tesarici.cz>
In-Reply-To: <9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20130205142128.2E28D3E1265@localhost>
	<20250320124330.480d652d@mordecai.tesarici.cz>
	<ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
	<b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
	<20250320153536.44774a74@mordecai.tesarici.cz>
	<9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 15:34:42 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 20, 2025 at 03:35:36PM +0100, Petr Tesarik wrote:
> 
> > CC'ing Robin Murphy, because there seem to be some doubts about DMA API
> > efficiency.  
> 
> Or possibly just documentation, the number of memory types we have to
> deal with and disjoint interfaces makes all this stuff pretty miserable.

I have to agree here. Plus the existing documentation is confusing, as
it introduces some opaque terms: streaming, consistent, coherent ...
what next?

I volunteer to clean it up a bit. Or at least to give it a try.

> > > > The whole goal there is to try to avoid triggering another copy to do
> > > > the DMA so just reverting rather than replacing with some other
> > > > construct that achieves the same goal doesn't seem great.  I think
> > > > possibly we should just not do the copy at all any more and trust the
> > > > core to DTRT with any buffers that are passed in, I think we've got
> > > > enough stuff in the core though I can't remember if it'll copy with
> > > > things allocated on the stack well.  I'd need to page the status back
> > > > in.    
> 
> > No, I'm afraid kernel stack addresses (and many other types of
> > addresses) cannot be used for DMA:  
> 
> > https://docs.kernel.org/core-api/dma-api-howto.html#what-memory-is-dma-able  
> 
> Right, that's what I thought.  Part of what spi_write_then_read() is
> doing is taking the edge off that particular sharp edge for users, on
> the off chance that the controller wants to DMA.

Thanks for explaining the goal. It seems that most subsystems pass this
complexity down to individual device drivers, and I agree that it is
not the best approach.

If we want to make life easier for authors who don't need to squeeze
the last bit of performance from their driver, the core DMA API could be
extended with a wrapper function that checks DMA-ability of a buffer
address and takes the appropriate action. I kind of like the idea, but
I'm not a subsystem maintainer, so my opinion doesn't mean much. ;-)

> > > From what I found, there are two scenarios that may depend on
> > > GFP_DMA today:  
> 
> > >  a) a performance optimization where allocating from GFP_DMA avoids
> > >     the swiotlb bounce buffering. This would be the normal case on
> > >     any 64-bit machine with more than 4GB of RAM and an SPI
> > >     controller with a 32-bit DMA mask.  
> 
> > I must be missing something. How is a memcpy() in spi_write_then_read()
> > faster than a memcpy() by swiotlb?  
> 
> spi_write_then_read() is just a convenience API, a good proportion of
> users will be using spi_sync() directly.

Got it.

> > I still believe the SPI subsystem should not try to be clever. The
> > DMA API already avoids unnecessary copying as much as possible.  
> 
> It's not particularly trying to be clever here?

Well, it tries to guess whether the lower layer will have to make a
copy, but it does not always get it right (e.g. memory encryption).

Besides, txbuf and rxbuf might be used without any copying at all, e.g.
if they point to direct-mapped virtual addresses (e.g. returned by
kmalloc).

At the end of the day, it's no big deal, because SPI transfers are
usually small and not performance-critical. I wouldn't be bothered
myself if it wasn't part of a larger project (getting rid of DMA zones).

Petr T

