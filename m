Return-Path: <linux-spi+bounces-8144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BEAB901C
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B330B3A9DFB
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1071F584E;
	Thu, 15 May 2025 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4NiOE7v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187D1E480;
	Thu, 15 May 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338618; cv=none; b=cgCKH3aheOdG3LKK+hYnURIF8XP8jz9/D9EsafO7Z0lbxxz36krOMasj9w3SZ7ojAQ6tpz9cphS894SdipQQGL6XddcINnUtZIStgoWhHqx9pCmiLch1ASvKJCZJEL3YAuf18AH2U3PkM65KNqfuA5gdQ/ySq/mk7ck64A7BslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338618; c=relaxed/simple;
	bh=lxxelPHJ7wXSemMsnQrJQMrKhPa3J1sfe3rMd1zKZqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqLYGqKrgS5mTvmQZ3kvIIl9Vkp6zuVWdiSe7iSvKiHbZh+eeQ0zzSZt6bsRXPFsVV4a4Cv7nyC75jdhUn1R+Ttb9HeF7QnE1mGvtq3eTEt+COB0A4auxJnVpJWID8kPuU8Dpfyjsm4DmqhfaNQJNNCWSKjxjrGVWNU+A/5Z2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4NiOE7v; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4766631a6a4so14793131cf.2;
        Thu, 15 May 2025 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338615; x=1747943415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijKQzzLB6fn0l9HXOynSzKmWa93u4m5lk6YgCJ/52bA=;
        b=m4NiOE7vNKqVRTEU/F8GlsUirH+Ksvb4wfsXrcijSbrFw+BurpygyyldGS4h2tXwz/
         m+VrYutNVVpC12CTwKlZPMYp57jw1cJaSYVu3eqT1qWu8wXAlAhQXNoFbc8r/5IyOXCY
         uWApjC8ZEOHv3ofs+oVt03JJMfAK63EeV14XCNtNRe4ykds02EvNP4eNjaXo7dhuVApR
         lRuFZLmkj8uSE9QRioyTEyztOAmR5jY2uwulBbMgNneIHMt8/Q2GYp035aC+DXAwxOE2
         6/G2ia7CI2Byt9YVu1fIMAa6PI+TKcPWgWfeWViNkjoKhae24jQT7ZpMC/0VpdjHlhcI
         qZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338615; x=1747943415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijKQzzLB6fn0l9HXOynSzKmWa93u4m5lk6YgCJ/52bA=;
        b=pA0lX7h053XefjVZuSMsKJpEOLfpqSjKU8ddX0dqdXoAPT9/Z2JvGos2O1VFo6y6p9
         81NZeqqq3Ixt4vGFAFfVd9ztyK77t04oUenybX+PIoNcqbYCPEpNdRXgxdb4zagiAa2x
         yuU/1U8RwNaGccymxcC/qiQ+X/LRDa8ag0mwvP7xaTRVlxAy1Mk8FtRAdznoqbdTold7
         DvQ+JN6B74b9avPttEMZeWMg0mg/+9AZlMtnO/5AYh2vB/bewgmbWpzy2TjvP72mLvLP
         r2FRA+xVhJAd/4te+hdt/jBsn8wVobwKhSruF4OOotoZY31dh0l49yMzvvUWVewqU2t5
         ncFw==
X-Forwarded-Encrypted: i=1; AJvYcCVh4RvByJgdGJ3BW+d5HCixYvTrJMjwVcnRf9tKU6VGkDmbtTrOchSHMx1OmfR/iuPD2WhBBQuM4TQM@vger.kernel.org, AJvYcCW1fy96OqjYcmeIBVUyVaNhwTYCkuxcO4WY90moGw3wBsh03oLNVMs90j2mwENRbJz1wfChCfZBoqGP@vger.kernel.org, AJvYcCWuWsDEV6wcpASZB+HOG4yO3TFcHEQHwbtcd81L7EZM64PXfSQF14UoWGnUToRrHzxQ41a3FVZdpe3Ty5dz@vger.kernel.org
X-Gm-Message-State: AOJu0YxghtiZt5CFHjmOQDEx9keejMWhq/gZnKEJd6UW/Z8bbS49tKli
	h73PmIevHdk4HEkBqJcyTibgpQ2Bzpd1SUemrHbNMkFfNR28gkIR0IBr+OVz13AaFE3muad1PF9
	HKS6P7XjyG0u55okv5yX01vOTVzWk458=
X-Gm-Gg: ASbGnctU9A4lIi7oYycbViBQsQHjw0Yo5r0Qr2935DU2HTpRyQEf5mNDAREEFgTgt3F
	1nywtkQewItNBjEFBqbLS3NjsA+0d5BPfDGZxd7sQaT6vDsLhkJpxylAFgT9Hq+NmJPRumWrR79
	YeFj7fwgINh8i6nmEX/jowLQn0jiC6VmZ6
X-Google-Smtp-Source: AGHT+IFg/wcvnBBQLcYze3vfJPGy+GNXDNI9xDfhAt+JQBd/EhhLBzPOLi2CERDJ8hqiCo+MSJ2a3RvbExF4wMUuIyY=
X-Received: by 2002:a05:622a:8c9:b0:476:b02d:2b4a with SMTP id
 d75a77b69052e-494ae39531dmr14532621cf.27.1747338614671; Thu, 15 May 2025
 12:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com> <20250514204159.GA2988411-robh@kernel.org>
In-Reply-To: <20250514204159.GA2988411-robh@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 15 May 2025 22:50:03 +0300
X-Gm-Features: AX0GCFtuH7yt6ihjR9mFd6CzYnznZejyyxToXHyqEx8rsfGB1bgn9WZkvaxFaRI
Message-ID: <CABjd4Yz3w75PtkRk_edzD5yf6b2xPuf20gopbm8ygddgCBfpkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash controller
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:42=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Sat, May 10, 2025 at 11:42:21PM +0400, Alexey Charkov wrote:
> > Add a binding for the serial flash controller found on VIA/WonderMedia
> > SoCs, which provides semi-transparent access to SPI NOR chips by
> > mapping their contents to the physical CPU address space.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  .../devicetree/bindings/spi/via,vt8500-sflash.yaml | 122 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 123 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/via,vt8500-sflash.ya=
ml b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..d2ea0dacdd56118c0cb5a1c=
b510ceb7591e1e5ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
> > @@ -0,0 +1,122 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/via,vt8500-sflash.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: VIA/WonderMedia serial flash controller
> > +
> > +description:
> > +  This controller is used on VIA/WonderMedia SoCs such as VIA VT8500,
> > +  WonderMedia WM8850 and similar. It provides a semi-transparent inter=
face
> > +  for reading and writing SPI NOR chip contents via a physical memory =
map,
> > +  abstracting away all SPI communication, while also providing a direc=
t
> > +  mechanism for issuing "programmable commands" to the underlying SPI =
chip
> > +
> > +maintainers:
> > +  - Alexey Charkov <alchark@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - via,vt8500-sflash
> > +      - wm,wm8505-sflash
> > +      - wm,wm8650-sflash
> > +      - wm,wm8750-sflash
> > +      - wm,wm8850-sflash
> > +
> > +  reg:
> > +    items:
> > +      - description: MMIO registers region of the controller
> > +      - description:
> > +          Physical memory region within which the controller will map =
the
> > +          flash contents of chip 0 for reading and writing. If the fla=
sh
> > +          size is smaller than this region, it will be mapped at its e=
nd.
> > +          Note that if this chip is used as the boot device (as is mos=
t
> > +          often the case), the boot ROM maps it at the very end of the
> > +          CPU address space (i.e. ending at 0xffffffff)
>
> Period needed on the end.

Noted, thank you! Will adjust in the next version.

> > +      - description:
> > +          Physical memory region within which the controller will map =
the
> > +          flash contents of chip 1 for reading and writing. If the fla=
sh
> > +          size is smaller than this region, it will be mapped at its e=
nd
>
> Period needed on the end.

Ditto.

> > +
> > +  reg-names:
> > +    items:
> > +      - const: io
> > +      - const: chip0-mmap
> > +      - const: chip1-mmap
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>
> This follows the SPI binding, right? Drop these 2 and add a $ref to
> spi-controller.yaml.

Need some advice here. While this controller speaks SPI protocol to
its connected flash chips, it's a special-purpose thing that doesn't
expose much SPI functionality to the outside world, nor can it drive
any SPI devices other than SPI NOR flash. Does that still qualify as
an SPI controller as far as the bindings are concerned?

Happy to reference the spi-controller.yaml binding if so.

> > +patternProperties:
> > +  "^flash@[0-1]$":
> > +    type: object
> > +    additionalProperties: true
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sflash: spi-nor-controller@d8002000 {
>
> spi@...

Related to the question above... Happy to call it spi@ if appropriate
in this case.

> > +        compatible =3D "wm,wm8850-sflash";
> > +        reg =3D <0xd8002000 0x400>,
> > +              <0xff800000 0x800000>,
> > +              <0xef800000 0x800000>;
> > +        reg-names =3D "io", "chip0-mmap", "chip1-mmap";
> > +        clocks =3D <&clksf>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        flash@0 {
> > +            compatible =3D "jedec,spi-nor";
> > +            reg =3D <0>;
> > +
> > +            partitions {
> > +                compatible =3D "fixed-partitions";
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <1>;
> > +
> > +                partition@0 {
> > +                    label =3D "U-boot";
>
> The somewhat standard value here is 'u-boot'.

Noted, thanks - will adjust in the next version.

> > +                    reg =3D <0 0x50000>;
> > +                    read-only;
> > +                };
> > +
> > +                partition@1 {
> > +                    label =3D "U-boot environment 1";
>
> u-boot-env

Ditto.

> > +                    reg =3D <0x50000 0x10000>;
> > +                };
> > +
> > +                partition@2 {
> > +                    label =3D "U-boot environment 2";
>
> alt-u-boot-env or u-boot-env-backup?

Ditto.

Thanks for your review and comments Rob!

Best regards,
Alexey

