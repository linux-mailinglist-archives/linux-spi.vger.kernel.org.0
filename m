Return-Path: <linux-spi+bounces-3757-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0D928391
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA3B1C20C13
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B413AA2A;
	Fri,  5 Jul 2024 08:20:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DA41A81;
	Fri,  5 Jul 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167607; cv=none; b=JFxL90DX/hIlun3JN8lo627Y2OKWkaBKmCLh44RjyQR2dJaH+KWze3pYxnIUI5QAEv93NrY834eBK9lAoTJd/rroADJnpp9SVRpsgt9SQK/2sMolbSjuJH/0cnxSA23Kj6IgESR6xJUgucZBknAzuu+d6MenzURRIxi1VTKC8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167607; c=relaxed/simple;
	bh=jFGRbdA7tKtx3QnHJW0WGtj8O5GZzjYMpM3YNyHn9yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Smuv1nv3HwG7+yxNYGSvQOosiUKal3yVX0+BK6Nt2f30yY4sT5ypfCuWCZaqzqS2NsWAIm0N1SMMNmZO3PJQ1fjIIs9u3U79OyrrKKtRqNGtfK4S1K8hRi/iSh0+VprZ0urH87F81FLk8r6bZKQfbp3o2w9JK6yBK0n++dn368w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02748b2402so1430623276.0;
        Fri, 05 Jul 2024 01:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167604; x=1720772404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaxw+yU3olE39ZGuCHYEWF5pYVtM1aOWdXpgzSzRbkk=;
        b=qgrcfEKWDGtd+LWak7z9B6yi/fP3Fh/abkj2wgMujpM002rbMDsHj0HrnqKnyukIWw
         g6fjKpXoykdouwQ42H1XnKTIKzmZKdQs5X/Vt3B0KgHOWdohLmMujgdSLInOcdQ0L5T3
         h82bBjhPpdmAVb3o12jJqbt8Hm2bJ7UxGdBc1KeXWuWKljEnGhEyur53K9eMPWf6+7N1
         3wZGSPwLP9zyMC7cDBhMRvh59sgGL6O4FGV8jD5iFeAwTXxui/F/xlyC5vmExZBrLEGr
         jU16dPra6BqKlBbD6H9pKAox/hVqeQR9gW3mmur+G6ycBQa2UzxhlxGpQ7rxFjFTgjJ+
         OpMg==
X-Forwarded-Encrypted: i=1; AJvYcCV5c8bgB0xlmT6CAXk6lbTt+9CFNsx0oPGb9/uCxLdSUUO0flL8QiUyG5DUCAXpMd97V48Yui5S4U6/r1lCQB69HbgxxaQaTpvupTsNkDQFh299eO/lJuIedGUCXnySFmPuSSg50FjJlqbA2R2kYPszBIm5OAlkVrPP/AgtonepfRQw2g==
X-Gm-Message-State: AOJu0Yy81NXBlxZm1r+gjOsv1UuqXXm6RC0LAojJhp7UxuqUVvz84Em2
	rVx8L4uO2rtPylaOnHQuxvj5vqMf4uOii6KWDuo2ParfbyVsNu4C5SOOsjGN
X-Google-Smtp-Source: AGHT+IEDkJQHLzg8ELxnp1+X1e66rvylg9Ll+/vvp3XPjosCkpZq4WVo58/Mb6bv7u7Pumi9ejSGhg==
X-Received: by 2002:a81:b65c:0:b0:62c:c5ed:234e with SMTP id 00721157ae682-652d8037339mr38162367b3.36.1720167604486;
        Fri, 05 Jul 2024 01:20:04 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-654861c4e33sm250997b3.29.2024.07.05.01.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:20:04 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65240d22f7cso12219467b3.0;
        Fri, 05 Jul 2024 01:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAKD3J1QvQ9YanZWG1ykWA/oromOWoaW8k86MG0cPvymExZsQh7z9XlHjqB19RFwLSQOFoZWPPoV/IOknfljPbnnhc0GEHUb0/Y0htC/immIoxrNkZ3skx4PupmwcFKJ0gmkMhPlSD94H2Y45hP0GvlKw7066RN9wTHPKxXg9Zl6hTtg==
X-Received: by 2002:a05:690c:80f:b0:627:ddf0:9e7f with SMTP id
 00721157ae682-652d8037794mr38128577b3.39.1720167603850; Fri, 05 Jul 2024
 01:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com> <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
 <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org>
In-Reply-To: <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:19:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvxXZUE0LwCYPt3HyuQTvM6Rus_RidJ24Ttd_4e_m-HQ@mail.gmail.com>
Message-ID: <CAMuHMdXvxXZUE0LwCYPt3HyuQTvM6Rus_RidJ24Ttd_4e_m-HQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
To: Michael Walle <mwalle@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>, 
	Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 10:01=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Thu, 27 Jun 2024, Michael Walle wrote:
> > On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
> >>> +   mikrobus_boards {
> >>> +           thermo_click: thermo-click {
> >>> +                   compatible =3D "maxim,max31855k", "mikrobus-spi";
> >>
> >> I might be missing something, but your solution cannot possibly be
> >> to list every click board that could be connected (all 1500+ of them)
> >> to every mikroBUS connector on every device's DT file..
> >>
> >> Each click board should have a single DTSO overlay file to describe th=
e
> >> click board, one per click board total. And then that overlay should
> >> apply cleanly to any device that has a mikroBUS interface.
> >>
> >> Which means you have not completely solved the fundamental problem of
> >> abstracting the mikroBUS connector in DT. Each of these click device c=
hild
> >> nodes has to be under the parent connector node. Which means a phandle
> >> to the parent node, which is not generically named. For instance
> >> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
> >> the click board's overlay would look like this:
> >>
> >> /dts-v1/;
> >> /plugin/;
> >>
> >> &mikrobus0 {
>
> Let's use just "&mikrobus" instead...
>
> >>      status =3D "okay";
> >>
> >>      mikrobus_board {
> >>              thermo-click {
> >>                      compatible =3D "maxim,max31855k", "mikrobus-spi";

Max31855k is an SPI device, so its device node should be under an "spi"
subnode (with proper #{address,size}-cells) of the mikrobus connector,
and use a suitable unit-address and "reg" property, pointing to the
right SPI chip select.

> >>                      spi-max-frequency =3D <1000000>;

This belongs to the "spi" subnode, not the Max31855k device node.

> >>                      pinctrl-apply =3D "spi_default";

This belongs to the mikrobus connector node.

> >>              };
> >>      };
> >> };

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

