Return-Path: <linux-spi+bounces-12431-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6BD2F41B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 628B1300518D
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6A35EDDD;
	Fri, 16 Jan 2026 10:07:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9635BDDB
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558040; cv=none; b=MUpf/W6l4lIzOaJszOuv+okeA20/d5tzIhPlkZBKgpR6QJvV6uyWFwNwWJljfSbZ/uhrslCQCUhz/rSSg35iruvlkdM3NP202ciAO1SKc6UQYGPCwtTELTxgAdF5ORWR9A9VsRS9vyDU9Sk03wfKNPK3eGrdWg3mhrhDqp60x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558040; c=relaxed/simple;
	bh=vFDSKDXTht/uJMvnTP9p1krfHXltHzGUh32WOHuB08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uyu/QdquzpxrN4knBZob/MWGdkO3yPT00yVKPD9SrJq7yUkK9hwA9+G1ZdpFtdbxy6Zl9LubuMucU+68qT4yhmaZLv4EEQADNwZuyPl8ztwXTQNIPshuWDjxS7hApRcBQENHyE7KjLsng4cZ5mLDzBYLSaTzl4d1e742nm/bueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5635f6cb32fso621453e0c.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 02:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768558037; x=1769162837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn67cUMU39CUXsSSgwxUh1den8X1/rN7e8d6+1v2Oh4=;
        b=qk0Fy1MZ8bBb1kUwJV6EtaePQme7by+1yetn8Gqf6FDN3KTpsCituXfv982lTsppvs
         C0A3nh+VWRI3kIPDckDYBdbw1VI9rLD+mcvkichYL9CG4Y05zXw0ogZlrJf9icll7xUS
         VWbZbuPwUqC88sLaOjHt/5JwsV2uRSXYYjs2E8HgKdawSzQo/LsuTanYMZvXGziJBr3D
         psvy6Uz03X+1KuM2TTxb2P2q+C3DcTkl9leaSk89SBtby/gMfMNGhGTaqRgFWMj/Yy6I
         QRYBhVGTpXk9OAc8Ruo34HekmLARnijViYV+lwcFt0TQMl9bSKymrDs3t/NoetIT/sRr
         XNMg==
X-Forwarded-Encrypted: i=1; AJvYcCWJe/ivYoMEs3bW4BFhH+Uu8TWIs3E4OIBYGA3hrI6SaKtpkVB/HOUfeNmgMgL8uzqOjUdOIXXxD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy2ftNukb6OBrw0rIW9fiqZLgt9NTPpFTyNdpPpCsBZLRu4rn
	eeNpR6+QMFrANFcCC9n+q5TyabMvXe4BK1B/w4fL+JJGElMhF1vQQkIEFUz/7z8YnCA=
X-Gm-Gg: AY/fxX5XL+pSMFbvn6rFUWwWCCFNHI2Bv6LSSVhRyLj9rhEXteNEuEX1lPF2vx1U+Ul
	ZRAQHCgvtdQabL5qpPKsP1hU2Z85KOnVJpojZ8R5If+xMo/QSYh56WlqcmWVaGnZgXkUpyL8rA+
	fJxY2EhzGSckOmvdVuh0kTys54I1tYV0+k+eQ+XiCz6OkGqKsDuIEXZpd3R9nHbpdZsh61uH9pQ
	AYeZJWBE5dlOUE2jfRtRvlB+7ISw3VIvIKFgH+bLMXkk8R+KANSYK5KlldWuuQNDZYZttYW07/3
	Z2cr1PXC+TUttjXUoK+JE2XoeSj3XV94fZzG0dcI+DKfvp8Hwrs2GUY3OJv/rG7gmjQtQfS2/fw
	xm2BkpUa55zOSXtRafYYTS3htz6CcTwS9tFfe4cP1XMeaF/+RTfLSFsxdRs4t6tYZFy3CSORT7x
	9c7mMtKkJAyHcKOFUYrD9E2kr607y5ziF09QmLCEj0pp8FXOzh
X-Received: by 2002:a05:6122:1312:b0:55b:180f:fed2 with SMTP id 71dfb90a1353d-563b5b69ceemr794050e0c.2.1768558037527;
        Fri, 16 Jan 2026 02:07:17 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b6ffeebdsm514804e0c.8.2026.01.16.02.07.15
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 02:07:16 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-941275fece4so472133241.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 02:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVV1VqEQ+gG19xFLErpw7pdjyQtdXbILkOEQaX8TmygsZrIPOl9lhrq31ocltmQr9Ttt5Itk8sKJ8g=@vger.kernel.org
X-Received: by 2002:a05:6102:6d0:b0:5ee:a8c4:18f2 with SMTP id
 ada2fe7eead31-5f1a552a486mr757624137.26.1768558035521; Fri, 16 Jan 2026
 02:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
 <20260115-schneider-6-19-rc1-qspi-v2-13-7e6a06e1e17b@bootlin.com>
 <CAMuHMdUHwqBrNMQTO-g7yUA_owWXxT6bPi34Oxjt-J7N0Q2CXQ@mail.gmail.com> <87ldhxubt5.fsf@bootlin.com>
In-Reply-To: <87ldhxubt5.fsf@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Jan 2026 11:07:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqWUriQHR8UY631HZfVNsejgXE64jrChi=k2=5E6Hi-Q@mail.gmail.com>
X-Gm-Features: AZwV_QiKDKKs-kGw2MFPAKLM-ZDRg69LJFyTkD_IY3NAlTAe2l416xADsDXNbp0
Message-ID: <CAMuHMdUqWUriQHR8UY631HZfVNsejgXE64jrChi=k2=5E6Hi-Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] ARM: dts: r9a06g032: Describe the QSPI controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Miquel,

On Fri, 16 Jan 2026 at 10:49, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >> +               qspi0: spi@40005000 {
> >> +                       compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi", "cdns,qspi-nor";
> >> +                       reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
> >> +                       interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
> >> +                                <&sysctrl R9A06G032_HCLK_QSPI0>;
> >> +                       clock-names = "ref", "ahb", "apb";
> >> +                       #address-cells = <1>;
> >> +                       #size-cells = <0>;
> >> +                       cdns,fifo-width = <4>;
> >
> > <4> is the default, right?
>
> It is the default in the bindings indeed, however the driver does not
> imply that default and errors out if the property is missing. The
> property is also marked required in the bindings, which is kind of
> incorrect I guess. Also, all DTS explicitly set this value to 4.

OK.

>
> However looking into the RM I found "Transmit and receive FIFOs are 16
> bytes". I haven't tested that, I will.

Oh, that bullet is not present in the docs on the CD I looked at.
It is indeed documented in newer versions.

There's also cdns,fifo-depth, which thus should be 4?

>
> >> +                       cdns,trigger-address = <0>;
> >
> > Where in the RZ/N1 docs can I find if these two properties are
> > correct?
>
> This property is mandatory. Maybe I could just discard it for my
> compatible, because it is only relevant for indirect modes, which are
> unsupported.

OK.

> >> +                       status = "disabled";
> >> +               };
> >> +
> >>                 rtc0: rtc@40006000 {
> >>                         compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
> >>                         reg = <0x40006000 0x1000>;
> >
> > The rest LGTM, ignoring my comments on the bindings:
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for the review, but I guess if I end up changing the DTS snippet
> I might drop it. Or would you like me to keep it anyway?

Please keep it as long as you don't change the (SoC integration)
things I typically focus on (address, interrupts, clocks), and don't make
too wild changes ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

