Return-Path: <linux-spi+bounces-3700-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0C91DB31
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E19D1F22189
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268584A39;
	Mon,  1 Jul 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0tU8KzQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EE5C614;
	Mon,  1 Jul 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825241; cv=none; b=W2aK8ml/p4azJzkpVmRyUI2YVms5Yv7bISy71Ce0cIrDxR9uL7QjZ61Kp5oTnciNBUzkXfcaSa9LIoM0rE9KXn1Bw07yXdG7gDFxzwtXUmyCzBy5CnIDC/4OiYkp95W6x/iKY+puoxrqGm4Kv2rl1d3e12JLR9oxiSL33qai+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825241; c=relaxed/simple;
	bh=5M05sXLCyxfg8FrspN+JZIvtVy+y3Gx64WOQcMp5378=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGCnnGEnwoPurbZ4IpobiEKwAlav0sVNNCX4s3gmyeIXKvGfvR6irqrPXS1fPZj+FsP5XAPz8fSeIRQqU93DTDq7+b6ntA+csxt31wcC/w8/VyT7siXjU83xqyy4VwHaSyu1mVrb5Jzknv9AduPobVSof1YTzAbXYpGievDsE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0tU8KzQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so3012825a12.0;
        Mon, 01 Jul 2024 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719825239; x=1720430039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxlECmQDcJb37f5C6V8ZGBnHo3bHH3o9P+OxX8YRfxo=;
        b=J0tU8KzQS54QrnHX83Agqazn8w2xrF/vh6LXdJwXaMSrztSMlnLIBozLhMbzQeU6Fp
         +mLdQziR/CWvnUUDEMISN5e27qS0a9G+O8mRxAPsrT0y/0e5RWGyby1HE+mqc3iJPNJ0
         0MV4qVX8VyhV+OA/JS4PtRSKtyek8eKfVW5TE7eDj2nFXe/W+hZ+7vJj8TwW99wo7Sxs
         MuRsCX8R8775qn5NkBhCLZ1o6kZ8cL6dxgpx6ntlIEgAm+MU6UldTKFlHDs+RIURiyag
         /0UGr+l39zsAEuBsE8740XX8MqA00R2NxjdSdKVcewgsGVBjWqu5FgRTJTlG3N/FPwlI
         epJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825239; x=1720430039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxlECmQDcJb37f5C6V8ZGBnHo3bHH3o9P+OxX8YRfxo=;
        b=pL4nj9+uf2DiGH5/TLVEN7qpFvNGzDMNdnnSAtn4GyNvGwfZxit0WlSAt5QV4ovR4y
         WrHUmm5UgUdl/A04Bv9D0FL7QVWh1wrJAz+5CZ5T3xEPazw37HYcVMTbHDPuStaqPRM6
         xPJZrpJDOAFqplBG+auiZxIuqZTpha41DFnvNXnSU0xsGNxbThkK04WNKPG/hmHNiics
         wvh3W/JtbOEvlFwsMt/4/rvLHl4XYii5p8rGP4xMEpm5OjDitTfQJOI48wqVBWb6OvSb
         FEHIRQ/zRiSyLRWK1IB+pw/6A01q6vurux7KdP6BClaDFcD9zBoJXHwv1gniBcBQmQsm
         4u7g==
X-Forwarded-Encrypted: i=1; AJvYcCWiYgcluNeoNj9eL6O9K2bNtxux6JJ2be89arHIt6YoGDCGIvduQ/3RS0mQ6jx5YWlrigGnE8n4RszB1rPF3sDHZuPHVnJCmH/CirTchXTWmtq4I6hVCa0XpGDuQvAmaUqFqQixzs59DwZJJ6l5W/XBDwFTobGRslN73uU1z1AXRQQn4w==
X-Gm-Message-State: AOJu0Yx/vjFGf/jhBOyN55xkSJLPXz0Fy1746MkCXMs4BgpoEK0pKAQn
	v87bBXYxCE+Yl61SlEmOxDi+L48ToXfLvgs2qMBIR53JVh4MgSjEdgN1wUwv3Dpm+dEwJzl3I0Q
	2WXuSWokmwkQjl54ANw+n+3SPooc=
X-Google-Smtp-Source: AGHT+IG4BaSbK+P09EoyYL8rR1buS3SjQd+OPB1e8j9B6v/dLubPk8we/fGolu3MGxMZLsJbPDat8V6n12a54ElCSvI=
X-Received: by 2002:a05:6402:440a:b0:57c:b7c3:99f1 with SMTP id
 4fb4d7f45d1cf-5879f59a549mr3114841a12.11.1719825238336; Mon, 01 Jul 2024
 02:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630063845.116307-1-kanakshilledar@gmail.com> <20240630-generous-carnation-c534f5d84a8a@spud>
In-Reply-To: <20240630-generous-carnation-c534f5d84a8a@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Mon, 1 Jul 2024 14:43:46 +0530
Message-ID: <CAGLn_=vG09C49goRkbygZdYch8H1c_kw3p7ar9NGOrgpd0_MiA@mail.gmail.com>
Subject: Re: [PATCH] arch: riscv: thead: implement basic spi
To: Conor Dooley <conor@kernel.org>
Cc: kanakshilledar111@protonmail.com, Serge Semin <fancer.lancer@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 7:22=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Jun 30, 2024 at 12:08:20PM +0530, Kanak Shilledar wrote:
> > implemented basic spi support for TH1520 SoC.
> > created a fixed clock and a simple spi0 node.
> > updated the matching binding to include thead,th1520-spi as compatible.
> > added a spidev device in devicetree which will utilise the spi0 node.
> > this is usually reserved for a SPI NOR flash which is left unpopulated
> > underneath the carrier board. I performed a SPI self loop test using
> > tools/spi/spidev_test.c and tried sending `\xDE\xAD\xBE\xEF` and verifi=
ed
> > it is being received correctly. i updated the of_device_id struct in
> > drivers/spi/spi-dw-mmio.c to include "thead,th1520-spi" as the compatib=
le.
> > this patch also adds basic spi support on beaglev ahead which shares th=
e
> > same TH1520 SoC. i have only tested on LicheePi 4A.
> >
> > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > ---
> >  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
> >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 10 ++++++++++
> >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
> >  drivers/spi/spi-dw-mmio.c                        |  1 +
>
> This needs to be 3 different patches - one for the binding, one for the
> driver and a final one for the dts files.

I will convert this into a patch set of 3 patch as you suggested.

> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +     spidev@0 {
>
> "spidev" is not a type of device, the nodename should match the type.
>
> > +             compatible =3D "rohm,dh2228fv";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <500000>;
> > +     };
> > +};
>
> I'll put money on you not having a dh2228fv on this board. Document what
> you actually have on it please, not what allows you to probe the spidev
> driver in linux.

Yes, you are right! Actually as per the vendor's kernel it should be a
"spi-nor" device from winbond.
I changed it to spidev for testing purposes. Shall I just leave it
with status =3D "okay" or add the node for
that spi-nor flash?

> Thanks,
> Conor.

Thanks and Regards,
Kanak Shilledar

