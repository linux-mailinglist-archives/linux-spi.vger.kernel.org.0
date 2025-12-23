Return-Path: <linux-spi+bounces-12099-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ABECD9E48
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F453035264
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A8299947;
	Tue, 23 Dec 2025 16:04:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28F24E4A8
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505865; cv=none; b=Fh/Y43nISDppSs3U6djq/J4ld7aEHldFHU5YFGFOii/ne8OROH0injCeq5KWWyYgw0H8qzjBwYqN/8B/N5KQMI9Y9pH5vyBbtMq5egkLNvahl0PMJGo7DnpgIjGprYOOZem91FvZ+6Oh569MWxH7It/bF2I9WdhQVQYd+ogyaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505865; c=relaxed/simple;
	bh=tW8m0sz+TxMy7bagqa/CKCdA8ogTvNRf1HesjjfNDns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtboNKgO1CWSofhWVnCIpNGCk+iWDcQpcot6q8NgrwxA2DfTFfrUY+ZWoZd++bFy2szYuKmoYnMQHIvWA9nb2VEfXQ53Z88pHebBFon3MbmkvbAUqD3nG1itC91wx9HKqp25Jjeci4qT552m+DKDTfF/L98D2R09IoYXUhEZzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso4006358137.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 08:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766505862; x=1767110662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUmrcjPrsJVbh8LyphvK5uHaAZlXwQPpsimX8t4O9kE=;
        b=vKgRKwmphD+/UMOF4ecsdwzJP86g6hpNYYQ3aQusIvKL6uHyis43iIYLiVJ0n7qcw8
         1UvPU0I7ZZnHWJ/hXiJoiZFTNul6LqCRrOucb8ePwUZhRRx6FLW3raxYOkI1ExTfqIz6
         CXSPwx8yWhvGungdCHvBs2EvZR35Zw9VtPLIQr24hGERhOVOnFHZ5AE30bcwR5e0TUFS
         AwswkJ5Cpe6TBIvf8+FvtRIe5VYUdAoW142OfdPmp4S12nxLxKgGrlbVTUQdtGdKxtmV
         gMTetTI6QcqsxeYz+TI/WLx8Ymus+q4GfrkwiLHPLVvLP+PGJtvmtoZUQZwUCPsFlgX4
         FSgA==
X-Forwarded-Encrypted: i=1; AJvYcCUB8KWhJtXS4J2se23GXGxXssdqFkx8OgpfWMwI9F3auLZFaJtttAYrI8AcmNxAME+69e87GrYPtro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+XHB2Jn6tE0Nl6rExoWqMvrx5jKAbtwi9eLHeDYRj7jyNo1h
	f2Z/p8Ewhpx1IbCKZyvlnrfiqvgGtCpYJ+tlqvTpsTG2d34+4XOZMejkUWJKDImxoSk=
X-Gm-Gg: AY/fxX7Ki3uWcHC9grrm5LQfZbhkpzpTfmz3UygqZjAz1QxtCMdsy61O7pt5yKYnq9m
	Cy1RFW36ORp1mzIlD7jl89uTXzKnsylL3bpXRKXi56sgazBBX4/spOae1BVbp53GZc6vM8Gd5sU
	ZduKlDqNPkF6FiO0ILhp3ybNhT1vDFRBYH2PdXTnFKJ8xmp7T6uQgjdQv3bwFLVbV6akzmuEcGc
	ofv/SLZlVEgfgAYfVMU4DJ3MqLvEFxIkQ548QzSppDNdzC13TvTCEO449DkHMOipoQLV/udXC46
	HKkK90RgmnvuJgrhUVFpivplche4DYh3gtaiFi1EMAz70Hi/M/tZmJ1NKo2MPHEr++REVAsf5he
	KSaT+ip4j1uYI0PGu3yhJX13JM1u3exAUkYqSxKkuUAMSuHXw/l3GMp6cO+ButWkDKis2NBThqt
	GNPOBq/X3KCm92JA8fE4BDrUMtXkpUn3h+iBv5EWXzbP2tdw7X
X-Google-Smtp-Source: AGHT+IE7bzqjlyW0lUfrZ6q1nO7cJ70M4J4ykwdh9WkoaHoHnoHROvhBh60Pq1lpha1MK2KCd1QHHQ==
X-Received: by 2002:a05:6102:3710:b0:5db:3c3b:7767 with SMTP id ada2fe7eead31-5eb187045a8mr4513432137.16.1766505862284;
        Tue, 23 Dec 2025 08:04:22 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1ac62fd0sm4533733137.9.2025.12.23.08.04.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 08:04:21 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso3115432241.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 08:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7U+zhWfALZabFYGQFEXSfUkHmhUKmKMUH8meFuqcEuTHpnq+7C2f7+A6Iu37iOW6tzI3p5YIz+L8=@vger.kernel.org
X-Received: by 2002:a05:6122:1d91:b0:559:6b7f:b0f4 with SMTP id
 71dfb90a1353d-5615b851ddemr5491694e0c.5.1766505860287; Tue, 23 Dec 2025
 08:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201134229.600817-13-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdWUPM=q7J_S_x7=CZoYxKm-v=7GGGkq9Nv0T14b8MBtpA@mail.gmail.com> <TYYPR01MB139556681F53AC66A668F7E4D85B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB139556681F53AC66A668F7E4D85B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 17:04:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeoC7OefbLd+0WihUtvV7zMtFREeor+V3efUitzcgiZw@mail.gmail.com>
X-Gm-Features: AQt7F2r8FcJNMBmChD_xiGNEJI2gOR_iQl7z1azyYjzKxdOKv8tEtQ1DkplXGqY
Message-ID: <CAMuHMdUeoC7OefbLd+0WihUtvV7zMtFREeor+V3efUitzcgiZw@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64: dts: renesas: r9a09g077: wire up DMA support
 for SPI
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Dec 2025 at 15:42, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Mon, 1 Dec 2025 at 14:44, Cosmin Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > RZ/T2H (R9A09G077) has three DMA controllers that can be used by
> > > peripherals like SPI to offload data transfers from the CPU.
> > >
> > > Wire up the DMA channels for the SPI peripherals.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > > @@ -200,6 +200,8 @@ rspi0: spi@80007000 {
> > >                         clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
> > >                                  <&cpg CPG_MOD 104>;
> > >                         clock-names = "pclk", "pclkspi";
> > > +                       dmas = <&dmac0 0x267a>, <&dmac0 0x267b>;
> > > +                       dma-names = "rx", "tx";
> >
> > RZ/T2H does not seem to have restrictions about which DMA controllers
> > can be used by which SPI instance.  Hence shouldn't these point to
> > all three DMA controllers?
>
> It does seem like there's no restriction about which DMA controller to
> use.
>
> >     dmas = <&dmac0 0x267a>, <&dmac0 0x267b>,
> >            <&dmac1 0x267a>, <&dmac1 0x267b>,
> >            <&dmac2 0x267a>, <&dmac2 0x267b>;
> >     dma-names = "rx", "tx", "rx", "tx", "rx", "tx";
> >
>
> I was not aware that the DMA core supports this. I will add the other DMA
> controllers to the list.
>
> > Note that this requires updating the DT bindings, as they currently
> > restrict dma to two entries.
>
> dma-names:
>   items:
>     enum:
>       - rx
>       - tx
>
> This should work fine, right?

Yes, dma-names is OK.  But currently dmas has "maxItems: 2".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

