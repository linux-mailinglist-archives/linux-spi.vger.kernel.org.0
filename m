Return-Path: <linux-spi+bounces-3768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BE928D12
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713E9B22F13
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A816B3A0;
	Fri,  5 Jul 2024 17:37:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A831F94C;
	Fri,  5 Jul 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201036; cv=none; b=LJr3ZhrZZIdJxST+moKYAXCmqHsjKSUG08MYuTXOYtnnhLJCHRVyci2DCz3jhFHqkxUUy2r+iraaDTyTsIbQh13MXEKwNSjD6aaUYUlM2J2yCjDepzxlELvmW0tTvvXSp4DzO12mHzjL7XYzJRKAxYnjMIHtaaBAAZRiqyx7EU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201036; c=relaxed/simple;
	bh=e7YSaWF77rgGetEEK69jDsfRDfe3JVxLuUMxZ6fGYo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFvDWp4WEYD/t/L6XCQTtRFVfr/Gp5LCYAfZ7oTbzpypUOvoCFehMe8tDgSCdaieqNmJoDV810pgSVsPMNZRwEbVSBUEiJmmvzxHeHYOG3u2PDUOEYwX8b1DLTOMqjhoMDaYA8ugQx13G+VihLDghRugrfALaODNP0KrnLGXbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-650469f59d7so17168207b3.2;
        Fri, 05 Jul 2024 10:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201032; x=1720805832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE2siGt7Dsk8wnjgDVkLAR9HwluMfAZE92CRWcBjgLU=;
        b=e4L8fslLGhV2Scy83UaecVGtd/qcZqe3L+/caTX213ILYJiof940DWiwEzOIANfC9L
         +8p1J5qzZhN0QcoUbxkzmm6QsyfegsUUdJ299DWi9B4Ksw+gdBz5xv3jrFU0bgD54R19
         FcVmvTa55xlVcFCVXNA/QOKQNX7zppN5MwTZhbyDqIdf8hwMZpI8pAjOLLxilKY3ju7+
         yxrZQRagijo6CStX8dQx2RQmkCdfdn+E04ZPjqFAFB9szMFjnNknP3dfgKnHmgLYJS1p
         vVemqrXzK9qW+wyTOVUTXoyGdR9LcdMgMA4GvabxjoyZZQXHyMjasn4ziV2nRKL/Q4bq
         FETg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Qzpa1U6vzIySOMlvAngwpobSMqCvWKgDTnkyl740ztNtmhly+IbeiOpwPLq8faD0ECEr1Atl4dJvOkWZpVAsgdKrcA02xbJGiBcsw1i14ILcl1RTFDeWIP8uR8YRmvbdRE7pguMTufka8ErbJ8CV5meH8v2KqpNiPKh91azJU0KkqQ==
X-Gm-Message-State: AOJu0Yz6SnfYNUOYpQr9x1DlWficLpk6gzteY6Y10JmnTazPzoKnJhtH
	iO6ek/K05Id7ZTbuN/r0h2Une/kfAQYQdVh1mx8IEF1buKyQRwkW7RUwcgcb
X-Google-Smtp-Source: AGHT+IFsURydJ8bx983Oho8WbV+F978ix/P1z2fX+H6fep6L4vK7Qce6qob2qieivPBy46+l5/3yow==
X-Received: by 2002:a05:690c:45c5:b0:64a:e7ec:f45 with SMTP id 00721157ae682-652d80377b1mr66844477b3.40.1720201032299;
        Fri, 05 Jul 2024 10:37:12 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6533c12b0a9sm5031457b3.81.2024.07.05.10.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:37:12 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df481bf6680so1753905276.3;
        Fri, 05 Jul 2024 10:37:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcNIuf+fnqBJqE+kcjdE6cOOiRqBAwuPcSLSu7b3I8dcgeoPoDJ1RBFOovgE2i4hVEZMokkE8NIdQEjd65dMKCf8Ua5F/nssUoFA8P2SE+ib69mfnVYlqpR+FOIqQe3NUQuqwE6iNofWe1m85S0pbdv0ghqyBO5IY7WjG4D0EJlYZhnw==
X-Received: by 2002:a05:690c:ec4:b0:64a:c3b0:3874 with SMTP id
 00721157ae682-652d8531072mr62065267b3.47.1720201031887; Fri, 05 Jul 2024
 10:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com> <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
 <5b2cd46e-8a51-f145-8876-55b12a6d62d1@linux-m68k.org> <ca2d7d4b-c22d-4d14-a216-8c19073e4189@ti.com>
In-Reply-To: <ca2d7d4b-c22d-4d14-a216-8c19073e4189@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 19:36:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_VFSJO-J=sfPGDyzKqF1nRXZ6wr7hgyHh01yiYC_Wvg@mail.gmail.com>
Message-ID: <CAMuHMdV_VFSJO-J=sfPGDyzKqF1nRXZ6wr7hgyHh01yiYC_Wvg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
To: Andrew Davis <afd@ti.com>
Cc: Michael Walle <mwalle@kernel.org>, Ayush Singh <ayush@beagleboard.org>, 
	Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Jul 5, 2024 at 6:34=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> On 7/5/24 3:01 AM, Geert Uytterhoeven wrote:
> > On Thu, 27 Jun 2024, Michael Walle wrote:
> >> On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
> >>>> +    mikrobus_boards {
> >>>> +        thermo_click: thermo-click {
> >>>> +            compatible =3D "maxim,max31855k", "mikrobus-spi";
> >>>
> >>> I might be missing something, but your solution cannot possibly be
> >>> to list every click board that could be connected (all 1500+ of them)
> >>> to every mikroBUS connector on every device's DT file..
> >>>
> >>> Each click board should have a single DTSO overlay file to describe t=
he
> >>> click board, one per click board total. And then that overlay should
> >>> apply cleanly to any device that has a mikroBUS interface.
> >>>
> >>> Which means you have not completely solved the fundamental problem of
> >>> abstracting the mikroBUS connector in DT. Each of these click device =
child
> >>> nodes has to be under the parent connector node. Which means a phandl=
e
> >>> to the parent node, which is not generically named. For instance
> >>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
> >>> the click board's overlay would look like this:
> >>>
> >>> /dts-v1/;
> >>> /plugin/;
> >>>
> >>> &mikrobus0 {
> >
> > Let's use just "&mikrobus" instead...
> >
> >>>     status =3D "okay";
> >>>
> >>>     mikrobus_board {
> >>>         thermo-click {
> >>>             compatible =3D "maxim,max31855k", "mikrobus-spi";
> >>>             spi-max-frequency =3D <1000000>;
> >>>             pinctrl-apply =3D "spi_default";
> >>>         };
> >>>     };
> >>> };
> >>
> >> If there should only be one DT overlay per click board, how would
> >> you apply that to to different connectors?
> >
> > You teach fdtoverlay[*] to translate anchors, e.g.
> >
> >      fdtoverlay -i base.dtb -o final.dtb \
> >             -t mikrobus=3Dmikrobus0 click1.dtbo \
> >             -t mikrobus=3Dmikrobus1 click2.dtbo
> >
>
> This basic idea is where I started also, the result is we end
> up needing a huge number of "anchor" points. And they would
> also be board specific. So we would want to store all these
> anchor points in a file, and what better file than another
> DT file.

Why wouldn't a single anchor point suffice?
For Mikrobus, the anchor point should have well-known subnodes
like "spi", "i2c", ... which would take care of the translation.

> Putting all the translations in a DT file to allow the DT overlay
> to become generic is the core idea of this series[0] (looks like
> you already found it, linking for other following along).
>
> And as you note, the symbol table trick allows us to do this
> without teaching fdtoverlay anything new, so it should work
> as-is today for any project already supporting overlays.

Yes, and it sounds cool!

> > I believe the Raspberry Pi people already have something like that.
> >
> > The mikrobus node handles all other translations (e.g. mapping from
> > Mikrobus pins to GPIO numbers), so you do not have to handle these
> > explicitly when adding an overlay.
>
> This part seems to still be an open item. For pinmux we can name
> the pinmux nodes such that their phandles are resolved on overlay
> application. For Pin number/name to GPIO number we have "gpio-names",
> and the names can also be generic. But for Interrupts and a couple
> others, we are still missing a good way to provide a generic mapping
> from pin name to number.

Isn't that the purpose of nexus nodes in the DT spec?

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

