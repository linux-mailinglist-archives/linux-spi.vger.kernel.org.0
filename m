Return-Path: <linux-spi+bounces-3737-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD31926EFA
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 07:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EBDB213E4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC741A00FD;
	Thu,  4 Jul 2024 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0KsCSY6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C89FBF6;
	Thu,  4 Jul 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071778; cv=none; b=GZGfAdiFFnTZIKMPtHK2yVeK53MFxZdAM00OCFspUa6KAE6XsxEK8Qw+sxcuQlO8KjreiMZ/sArF4urDesEFKcKit0asZmP0po0CcOWMU6I/+LJPwyNbZKAvsaFAo7SZnQ0kjwnBFqhfPk4IwPjJc+2XbgJl6EtjVmH50PZ0Ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071778; c=relaxed/simple;
	bh=7D1WYB2toSHakmy4+rbGJLYS5K2VC1xaYZBRJPiKUbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxJ9nUDO65Az0wGOi2OnC+GyTqboQoLFu1AvMvCniS+arq3sJ7egJ1xAzIRd6vWHoTTrov5sz4Vncn3qwI1vidqcceul/DDdmJmB/3M4a/uEbTCHjtvYMS4QipJTDHodWp1pDfZROsWhNHu+jCzXyd4k5CWAjXhNWYlaNgsb7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0KsCSY6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso286073a12.0;
        Wed, 03 Jul 2024 22:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720071775; x=1720676575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c/+Q9nS+xoM8+OHdZVaW7nYRO1GVfCIQiZ/xNi76w0=;
        b=O0KsCSY6KL+ZFnCPUUZnE+l7uEXG/O4vW9v9SCKU2SZrjdw1WElX1xj9kUQom19Dzh
         VVChyRBvh5sa1L89p/+esVW9PTwBVRvuHU/OE4ipId3SmrWkF4ufklm/zrHSbg/kQK3L
         ajpSyQPCeLMEp2vQ5tjQ0MWzMe8ZrmMHefbuzsJ/1auTa0qQoZamHZpUp9snYlS9GzzA
         vF3ohAnumKuo0c/SqfXlStexeihcas1icw1GlwBbUAeD7BoMR9ydGLNjVzdDIX6SM+f/
         1bZBh6Ckl3X28DvO9ujdYNEWKhscdRS3zWPnTu5mFAwNKzyBnmsZ7Y5wU/PBJAdtGFh0
         Sq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720071775; x=1720676575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c/+Q9nS+xoM8+OHdZVaW7nYRO1GVfCIQiZ/xNi76w0=;
        b=JJHXU5MqCQ2s62Ol8av2PYiLLizWOiDHh+KXt8qSdw2VMzpJe+U/Jf+f759+n9PZyE
         kQcyWJxKJ019ziO4SFsFt9ukOZpSbaXpnGCW8bUpH+x9wPZ6/MH1fCwPx9XGFcCiW00Z
         EcJ7AxH/SE/6iDJqPqbgXcXKRFRmDzryvER3CEy54ML8lGYEYUbXZBGcvYE8NbXvpDd2
         WP+y+yGYILicjueoQyE9RlF1hLSFmG0RyYpA2dXTVfYDg9HctOCwKa7mqJiv/2qoIz8P
         XT/lqxNE/tTmRpLJCuZUkFV6mjFv8I0CvlKKt3Q+Wqp01NCOl4yG6ByOqJM50fj+iN4c
         SxSg==
X-Forwarded-Encrypted: i=1; AJvYcCV1GfPhyKjW+zWWrRnMRyMImlOgmTYIJIuiz6pFWRh+e0c6QiBtNlHtiPmoG+ELyP94SoRBDcSrkmLPFzeJf6sYmvCfkiZ3O7rabtL4Hc46AaQKf+P7OYbF0xRpCTW+SlFNX271VzqtreYzdjxWQXa4cZ4xEv9+eJNM4g7erHV67PMhGw==
X-Gm-Message-State: AOJu0Yy73JyoEgwnjJJpjvCzCpEZMBkG8bBwOu81SReS0uRjhC4D/QQN
	bLbe9StrfpPU0XKSgCoD2yn7x3eC+SyAVz3BkmlIRVYgXFI2wP9g1EYjL6nZjWHEklCPl4tmhDO
	Xygp27BWJKFLigNkw9W9tHbPBrOA=
X-Google-Smtp-Source: AGHT+IH+oZ9eq9ibdelDbiyyU9I7yRc+N1gUCalQ7B8pON06oHDFUPonn5DyQdiYwH2BKwt/klYV/jcBFxzToz/Yp5Q=
X-Received: by 2002:a05:6402:3594:b0:57c:6740:f47c with SMTP id
 4fb4d7f45d1cf-58e5c6366a2mr332180a12.27.1720071774803; Wed, 03 Jul 2024
 22:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-5-kanakshilledar@gmail.com> <20240703-juice-refreeze-62c468a56ea5@spud>
In-Reply-To: <20240703-juice-refreeze-62c468a56ea5@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Thu, 4 Jul 2024 11:12:43 +0530
Message-ID: <CAGLn_=tVZ3StW3uB+CkcHBpSJG8PfNGSM6zOVV6OSJeL2Pz56A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
To: Conor Dooley <conor@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 3, 2024 at 8:15=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> Kanak, Drew,
>
> On Mon, Jul 01, 2024 at 05:43:54PM +0530, Kanak Shilledar wrote:
> > created spi0 node with fixed clock. the spi0 node
> > uses synopsis designware driver and has the following
> > compatible "snps,dw-apb-ssi". the spi0 node is connected
> > to a SPI NOR flash pad which is left unpopulated on the back
> > side of the board.
> >
> > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > ---
> > Changes in v2:
> > - Separated from a single patch file
> > ---
> >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
>
> Didn't you say there was a flash on one of these two boards?
Yes, there is a SPI nor flash pad left unpopulated on the bottom side
of the LicheePi 4a
carrier board. https://wiki.sipeed.com/hardware/en/lichee/th1520/lpi4a/2_un=
box.html#Board-hardware-overview
notice the reserved pad in the bottom part of the image.

> >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
> >  4 files changed, 34 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/=
riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > index d9b4de9e4757..3103b74e0288 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > @@ -17,6 +17,7 @@ aliases {
> >               gpio1 =3D &gpio1;
> >               gpio2 =3D &gpio2;
> >               gpio3 =3D &gpio3;
> > +             spi0 =3D &spi0;
>
> "spi" would sort after "serial".
i will fix that.

> >               serial0 =3D &uart0;
> >               serial1 =3D &uart1;
> >               serial2 =3D &uart2;
> > @@ -52,6 +53,10 @@ &sdhci_clk {
> >       clock-frequency =3D <198000000>;
> >  };
> >
> > +&spi_clk {
> > +     clock-frequency =3D <396000000>;
> > +};
>
> I'm pretty sceptical about adding more of these fixed clocks, rather
> than waiting for the clock driver. Drew, what do you think? Should we
> just add one more to your fixup list or would you rather delay? Guess it
> depends on how long more you think that clock driver is likely to take.
>
> Thanks,
> Conor.
>

Thanks and Regards,
Kanak Shilledar

> > +
> >  &uart_sclk {
> >       clock-frequency =3D <100000000>;
> >  };
> > @@ -79,3 +84,7 @@ &sdio0 {
> >  &uart0 {
> >       status =3D "okay";
> >  };
> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/a=
rch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > index 1365d3a512a3..6939bd36560c 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > @@ -33,6 +33,10 @@ &sdhci_clk {
> >       clock-frequency =3D <198000000>;
> >  };
> >
> > +&spi_clk {
> > +     clock-frequency =3D <396000000>;
> > +};
> > +
> >  &uart_sclk {
> >       clock-frequency =3D <100000000>;
> >  };
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/r=
iscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > index 9a3884a73e13..14b06dd81a9a 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > @@ -14,6 +14,7 @@ aliases {
> >               gpio1 =3D &gpio1;
> >               gpio2 =3D &gpio2;
> >               gpio3 =3D &gpio3;
> > +             spi0 =3D &spi0;
> >               serial0 =3D &uart0;
> >               serial1 =3D &uart1;
> >               serial2 =3D &uart2;
> > @@ -30,3 +31,7 @@ chosen {
> >  &uart0 {
> >       status =3D "okay";
> >  };
> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dt=
s/thead/th1520.dtsi
> > index d2fa25839012..f962de663e7e 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -140,6 +140,12 @@ apb_clk: apb-clk-clock {
> >               #clock-cells =3D <0>;
> >       };
> >
> > +     spi_clk: spi-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-output-names =3D "spi_clk";
> > +             #clock-cells =3D <0>;
> > +     };
> > +
> >       uart_sclk: uart-sclk-clock {
> >               compatible =3D "fixed-clock";
> >               clock-output-names =3D "uart_sclk";
> > @@ -183,6 +189,16 @@ clint: timer@ffdc000000 {
> >                                             <&cpu3_intc 3>, <&cpu3_intc=
 7>;
> >               };
> >
> > +             spi0: spi@ffe700c000 {
> > +                     compatible =3D "thead,th1520-spi", "snps,dw-apb-s=
si";
> > +                     reg =3D <0xff 0xe700c000 0x0 0x1000>;
> > +                     interrupts =3D <54 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&spi_clk>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     status =3D "disabled";
> > +             };
> > +
> >               uart0: serial@ffe7014000 {
> >                       compatible =3D "snps,dw-apb-uart";
> >                       reg =3D <0xff 0xe7014000 0x0 0x100>;
> > --
> > 2.45.2
> >

