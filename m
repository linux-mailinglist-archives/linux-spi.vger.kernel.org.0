Return-Path: <linux-spi+bounces-3755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C92928307
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B61F212E8
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993ED145343;
	Fri,  5 Jul 2024 07:44:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191314532A;
	Fri,  5 Jul 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165470; cv=none; b=IdN/5yNBGWnwogVfxpGh7t5zlN5DzcuG+MNdtThkdUk85AhXUNoTpDU//f4ai9DiBeNeS9NvDL7ggsCVYmAYUNI9KYtiu7Oz8GuP2xC+rmXYxCr/nABkNQ2UwJtaeXGyEC8Qyzdzj9FrnlLPsGF73DxvCN36rmDngLobjBGcmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165470; c=relaxed/simple;
	bh=oSwBgych3VEMOE22AaK4rg+/aWO15m6ol78WqqdUKuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU9JGI0bwWXRwO0zqgCU21zKuC1J3HVK/BvWkGX1ES+/vpKUAfq99UKq1wYl4qbdN0uBaBcfC3P/OFw5HOWWd9SvH+aSGlgr1SawWA5Gf/0uwVTX61DX30dxmszhj0iSGJ4jxVylIT55e94/f8UkM+I3IB0aZzhXkYSh2oyewrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65465878c1fso1509487b3.2;
        Fri, 05 Jul 2024 00:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165466; x=1720770266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1SDFiWQ0nEyqIMe3v2gBQzkSPZVxdM8AxvMACbfltA=;
        b=i+JxuXxAsSj2DcPqPNxvIMu1KCaIf2AOoV96RS+Ol1jM172D61DwuEcyGptyntdS90
         aQsT/pFD8DTvb3IK2oKHXZ64Wx7UmIFtM4uan8u0ThUMkghDZcjjGYuUzf3L97V7G5Hd
         QEmgb2KJu2wvpCPfz9Z7OCFGt7k59MgO9xAzqV11PHRjR1r0mPYgB4AirFa+5HLz4rdA
         dLcBqDKfopAGQQqWMEMu+j8kBX0ADh/y73/XpAS3y9iii2D+xyT17nXC858FYp/6++8J
         pfkw96d9xiS5lpgC10iCDfvrQNbbR/U5eLUs3rS4QDcI8BIRip3im9sIu/q+AqZB0AUD
         umIg==
X-Forwarded-Encrypted: i=1; AJvYcCUx7aXhcOr8hyqeRqooSvPXt3Hn3Mj2JZep4DO/1gHfUG5g27XpZ87EnZsdxgCQeudnKluWewSrH98j/YRLPmPewX6ejrPL2HDMCIf7rXYJHMWifGP6QLnhOA64IC79PwdLa6sUmXC7/ib2O05PNDKUbzrpCSlcucG5pr1HgYVxkhKGwg==
X-Gm-Message-State: AOJu0YwHg4EPPYimre0h9WtfWn3Vf6spONHfNmMndcp5F92JKsx8viKo
	ZKNW4sWx/d9NbvDyTJqhqP/w6mw9tSjn28J6FYz1M8ewmGnpeEePNEMCkiaO
X-Google-Smtp-Source: AGHT+IEslyDL3fxdMpazQfHtBANM90Fh0BMevN+XbKDjllUseDLkcHHLtbjuNgswJ55MbJUn4dC33w==
X-Received: by 2002:a05:690c:72a:b0:648:c8ca:f2d4 with SMTP id 00721157ae682-652d67c21admr39114527b3.27.1720165466401;
        Fri, 05 Jul 2024 00:44:26 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-651d036bad4sm7623747b3.54.2024.07.05.00.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 00:44:25 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65465878c1fso1509237b3.2;
        Fri, 05 Jul 2024 00:44:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvcOCjlCJ3jMd/Jr5UHh0hHydosY8zVRB8iZHzu611zonGM/RVQbngLx/fhzP4Ss9MXX69m9k4RVGPkahdjR1/5AWkDE0WkANyjCtUWVcNeVUwhYmUCTlfxzReztb70NYbaCK998KebbXcOF1WxhNwZbzRsnC/mJmne0IQTC7/pilqJA==
X-Received: by 2002:a81:8482:0:b0:63c:4140:a0de with SMTP id
 00721157ae682-652d5a15025mr36511367b3.6.1720165465602; Fri, 05 Jul 2024
 00:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org> <20240628-cake-ocean-25363137b1ab@spud>
In-Reply-To: <20240628-cake-ocean-25363137b1ab@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 09:44:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_u-TxpP49pybyH+FyBN-1R__c=bE=6rnUXFG0RkiYQA@mail.gmail.com>
Message-ID: <CAMuHMdW_u-TxpP49pybyH+FyBN-1R__c=bE=6rnUXFG0RkiYQA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: mikrobus: Add mikrobus-spi binding
To: Conor Dooley <conor@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>, 
	Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:48=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
> On Thu, Jun 27, 2024 at 09:56:13PM +0530, Ayush Singh wrote:
> > Add bindings for MikroBUS boards using SPI interface.
> >
> > Almost all of the properties that are valid for SPI devices can be used
> > except reg. Since the goal is to allow use of the same MikroBUS board
> > across different connectors, config needs to be independent of the actu=
al
> > SPI controller in mikroBUS port(s), it is not possible to define the
> > chipselect by number in advance. Thus, `spi-cs-apply` property is used =
to
> > specify the chipselect(s) by name.
> >
> > Another important fact is that while there is a CS pin in the mikroBUS
> > connector, some boards (eg SPI Extend Click) use additional pins as
> > chipselect. Thus we need a way to specify the CS pin(s) in terms of
> > mikcrobus-connector which can then handle bindings the actual CS pin(s)=
.
> >
> > Link: https://www.mikroe.com/spi-extend-click SPI Extend Click
> >
> > Signed-off-by: Ayush Singh <ayush@beagleboard.org>

Thanks for your patch!

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml

> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    thermo-click {
> > +      compatible =3D "maxim,max31855k", "mikrobus,spi";
>
> I am really not keen on what this implies, as I think Rob and I have
> already mentioned, the connector should handle the "mapping" and the
> regular SPI/I2C/whatever bindings for the SPI devices themselves
> should be usable.

Indeed.

The (thermocouple component on the) click itself is not compatible with
"mikrobus,spi", but with "maxim,max31855k". "mikrobus,spi" here means
SPI is used as the transport layer.

I guess you need "mikrobus,spi" because the click is pointed to by the
"board" phandle in the connector, instead of being a subnode of the
connector, like it should be?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

