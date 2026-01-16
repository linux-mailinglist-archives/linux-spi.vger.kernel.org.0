Return-Path: <linux-spi+bounces-12442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BCBD30D9E
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 13:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C522304D87C
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279838757A;
	Fri, 16 Jan 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqX9fna/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57A36C5BA
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565210; cv=none; b=JvDj3SUaU5AvBzhDnMQPH79SSIuWbjtg2CJrXXlxblJ0NicuRzSt4gafW14rNPc/dd734g4MClSWHDgjZWXASsJl0+rhw7wIQvpdCuDc3Ad2X5EEGp/Lm6z7pkUfVbwmsL4qTBuQtHJp9tM/rMfsfntM/mKcTpzuLkxz6RWkBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565210; c=relaxed/simple;
	bh=1Chm4qipOR1WWNJw+O37Qjdt4PyEzHqmBOZXUvxyCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzrIxuQ5kr4Pfh5vA46Enj5lMSz2i7e0SoEaFthPPjYOmbjw7new65SoVvn8o83tNb+l2MryDdsLHQGQVcZ5T89lun8ZQMX92JTaSidinSh2Sg6LwNtElSg+E9GoxKBpTH+6w0j1Hd8Rl8AhERYv8W97VvbaNHfdojDHWxBZdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqX9fna/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430f57cd471so1108380f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768565205; x=1769170005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXtJZmoS9jbqcWFLtnf9b41r+qZwCl52nnOgeevwdjw=;
        b=CqX9fna/TkuMGLmGDXtgVyLkMJB+2uCg/6XgerpsBX5HGoDKQekvpAbp84rt+sV2xh
         lnR1NRu1jo2g99apq0qGdFSa/DxZoNdAGjlcYA2Yah79Jt23GPaI38SqYjXcC/CaCqtu
         zhiuDXT2/epR9sySJN05qWG+D3nqaXPHtBauEfF2CL502dZMXYjYMYjChDouJBtA1Uvl
         KO7hfpbMRlHjkl19gGQCYR5D+TpByjoYZyOze+3qlXP2M2wYMb15sYBALUdDBjvRSb1B
         dQfq9L2GPVoOVs4mYJfKbY5m5aToxnB13z95j4qHKBHp1jVSwgylreX51x+LuoJmYkif
         dQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768565205; x=1769170005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXtJZmoS9jbqcWFLtnf9b41r+qZwCl52nnOgeevwdjw=;
        b=Dl5C6WYLMDIofzjhJxJVdnusQvJSnup85kRa9u1mAvzT72DykV2EbTc1W3v4MlTeXm
         yo9P/86NEm0B37xuRM8/QnyfwfKzmrmALdotuKHhGOie44KO4ms3NsCeZK1sXkjMFZ12
         KJmAJipMVD+p1slqGPza2C1rigAEGQKarb5X776RYtX5nSBhukZFqMBj/WQXvnI6l/3T
         TAIu7xDiQYUV/aRdC/J0bnfYCs134TXS9Z72dIe5Qz6vbYzj+98C/4o+Rqw8ui5z4NyO
         E5kqcBS2oAZnc5CR5Wzx7I2KfBmT8SgFtH4zy27I2Roxs2B06QFtd9J4wgHe082+XyAc
         HTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXgS+i3LbMQz5tBvbVyWECzfyTrLlqEJKDSThicQq7qkG/AOrOBpTw8R0mfUAJmZSAbwdFjNbei7zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzq1lsNTpODH99d7SIf3A3PIENt7OxVGHCARRLoC+XC8XmNeQ
	RKTcI//4gvpjnsWBFG+0GjTGBgwe+KtM+uxi+At6WDwGAkSWHQJo9KT9
X-Gm-Gg: AY/fxX7BlYSUgBeqwCI6lo47MRpU9hOYjdE5hOC1iEZbxPRlLNqCIQPHX+d+e7A+1ud
	NICcyh/MOu+DlJawSPozg6zBm1utFTKdk31K6BZXC4YBtD9usAkQ2S84SM+lvuWRpD6A4riqJxS
	wrQ2Or/sZjtKZbqOBKsF0OUcj22/hZoV+9zlepjRWMXOjXJsAA8y+dgBF0YwyVNU3edcsz2LHP0
	YQvrS1+b1hYfAZ8KLQv0eb4nLdhTVBlYWa6TMKo6uU5l6QdQ17k5RFJlGouFR33tvxvh+vc6SmW
	nhoegRFTQXLEh3PaQHYqCV89QkFKELYZByaYCTo905rXcpmuvBXuxWhBXB2PT8rC7acCMiWVspU
	pICBzIx/ato1IU3nkNh86lUBdN+8zGFUS9BGIVA5LkNRC4d++JXOgd1oeJ/J/QuCneEuEYxBqhX
	g8HXV4n+cK5vUrjMNCtl/DmlwHcAhaY3PxdGlpMqJ4YoNzxZ8VeuHhHmVNqUCk6vKmHKPGlDpOD
	A==
X-Received: by 2002:a05:6000:2c0c:b0:42f:bc44:1908 with SMTP id ffacd0b85a97d-4356a0249b0mr3007911f8f.6.1768565205117;
        Fri, 16 Jan 2026 04:06:45 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm4980007f8f.31.2026.01.16.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:06:43 -0800 (PST)
Date: Fri, 16 Jan 2026 13:06:42 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, Vishwaroop A <va@nvidia.com>, 
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, puranjay@kernel.org
Subject: Re: [PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout
 already processed transfer
Message-ID: <aWonUKplkzM2unQV@orome>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260116-tegra_xfer-v1-1-02d96c790619@debian.org>
 <9d845244-bad0-4e7c-8f7c-bd3224cabac4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ag2pcqryjkcrfgu"
Content-Disposition: inline
In-Reply-To: <9d845244-bad0-4e7c-8f7c-bd3224cabac4@gmail.com>


--4ag2pcqryjkcrfgu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout
 already processed transfer
MIME-Version: 1.0

On Fri, Jan 16, 2026 at 11:48:44AM +0000, Usama Arif wrote:
>=20
>=20
> On 16/01/2026 10:41, Breno Leitao wrote:
> > When the ISR thread wakes up late and finds that the timeout handler
> > has already processed the transfer (curr_xfer is NULL), return
> > IRQ_HANDLED instead of IRQ_NONE.
> >=20
> > Use a similar approach to tegra_qspi_handle_timeout() by reading
> > QSPI_TRANS_STATUS and checking the QSPI_RDY bit to determine if the
> > hardware actually completed the transfer. If QSPI_RDY is set, the
> > interrupt was legitimate and triggered by real hardware activity.
> > The fact that the timeout path handled it first doesn't make it
> > spurious. Returning IRQ_NONE incorrectly suggests the interrupt
> > wasn't for this device, which can cause issues with shared interrupt
> > lines and interrupt accounting.
> >=20
> > Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/spi/spi-tegra210-quad.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> Hi,
>=20
> I am not familiar with tegra SPI specifically, so I might be missing some=
thing, but
> I was wondering if its actually better to not handle the transfer in time=
out at all.=20
>=20
> We have 1000ms before timeout and I feel like that should have been enoug=
h.
> Looking at other spi drivers: imx, fsl,.. these dont handle transfers in =
timeout
> and are therefore lockless. tegra_qspi_handle_timeout also at the end che=
cks
> if for some reason the transfer fails (although it looks like handle_cpu/=
dma_based_xfer
> cant really fail?), and would just return failure.
>=20
> Removing the attempt to transfer in timeout will get rid of the spinlock,=
 all the bugs,
> make isr handling quicker as you dont need to acquire a spinlock (which m=
ight lead to lesser
> timeouts?) and makes the whole driver much more simpler. Or maybe I am mi=
ssing something?
>=20
> I have a potential untested patch below for how it would look like. We ca=
n work on testing this
> if it makes sense to the maintainers?

These issues on Tegra are subtle. The primary reason for these latest
rounds of fixes is that under typical circumstances there are no issues
because transfers complete normally.

However, it turns out that if there's enough load on CPU 0, the threaded
IRQ handler ends up running much too late (we've seen something on the
order of several seconds and in extreme cases even 10s of seconds).
Granted, these are extreme circumstances, such as when an erroneous
driver blocks CPU 0 for prolonged amounts of time during boot (in this
case it was a display driver reading EDID and using mdelay() in a loop)
or high CPU load at runtime caused by things like NVMe I/O stress tests
and such.

I think the root problem is that we rely entirely on the threaded IRQ
handler, which was fine for some of the more classic cases for this
driver but it ends up breaking in these new cases. The problem is that
most of these transfers actually do complete at a hardware level, i.e.
the data ends up in the SPI client chip, it's just that we get
notification too late. We've verified this by testing with a hard IRQ
handler and that one is never late. The threaded IRQ is the problem, but
we also need threading here because of all the DMA handling, etc.

Given that the transfers at a hardware level complete, we cannot simply
return failure on timeout. The recovery mechanism implemented is the
simplest way to make sure software and hardware state remain consistent.
Unfortunately it's riddled with bugs right now.

So I don't think getting rid of the failure/timeout handling and the
locking is the right move here. I think maybe a significant improvement
would be to not rely on the threaded IRQ handler as much, but instead
employ a combination of a hard IRQ handler and a work queue to defer the
actual processing to. That might also be a bit overkill because the SPI
transfers are already serialized by the core, so we're only ever going
to have a single transfer in flight.

Thierry

--4ag2pcqryjkcrfgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqKc4ACgkQ3SOs138+
s6GwrxAAgWHu55awBjpQju9YJhGtBP5RiCUQCnj2HHoB3LlOxFKrVPQywzrjYBKq
EdcqF9k0dfxlcdCOLWU//Qt8bKN7yGig2CMTre7o/fWB1vvApp/WA016acNhyVFR
pZDBKDXhppLtpQaue9y8OiZlE0b3w/gE5XVIF4p4qnECi2ee3qMDJx9mDS+3eRKv
ZDel8nVd93iDJkGXo1eihPexLipPltAxNkG0otADmGajubcRmTeUKOqzyLMZZv1N
YNn29UdOSYugL7JTfEfKakEAx7Z4+LBZKPcntU7lURsvYyoIWOuY1KXUy8qLU0JT
hS4/xz9xqDFl4ya3pX3+r/MgWacU7/5d71SBY6BOGBEDScVQhHz66UDfpNnJ1RdA
Mtr7GQl7RXBW1qyygZ7zV6fzlbysB1S7qyHud3L/phbUEly9yYd+jkhrpMFDcNks
z+J9HNQXAA3DA+HMs7epuEF/WrWMH1RhLrilQbi1lVnZTGZ/ArgOzZzEiXht2DEx
Tvt6MfrgH2GAGs8H+IZalCzX90NB6ty+PYbrrlavRya1vng1b1CqeNBi7OFQ70Lb
hua/k5YweTSGb7DFcLvqfAPl+CFZMKkTVVVmQLMm9q+jrz/4UhV8C2KzwDZhutSK
SlAljHnEnvJOIRwKGwRTNUUHVwCOf3bs15MfLuNcdS8KjmF5LLc=
=/aIv
-----END PGP SIGNATURE-----

--4ag2pcqryjkcrfgu--

