Return-Path: <linux-spi+bounces-11985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238CECC7A5B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC4A30A0995
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357C342536;
	Wed, 17 Dec 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="A2rYCXgU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF06340A63
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974838; cv=none; b=AYV6yamPqebso8eKBXcTeaYFG0RPJ3IzAd+KdURoksJ9/afPCydBFZD5bsnZpQxpixw6DMjguP29F12SbmgZRhjK2RAOyy7tAECx2wb9FdG8mY3t/fVpEhmCaQJby+04yco5g0148rMTmzwu9J9EapvRcGXWmaGqEdWB+tVHVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974838; c=relaxed/simple;
	bh=s8GEKXnaSXfLaP2KVal8xoX7Yub2x5YeO61XyI9SmwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQc7BkNfhNIXsBBWzHMfZ9VvbR8V9L+0t7sZlcSnCOh7XrbzfXrh2IvoHrXHSubOyOI7VjdEhZpUi+PEXwEVAkOKtmAlEMQbmrilj6NhZeGQ662SsH2FX/67gnmfakKy0Zc3PblzPbFOKoouhaC4vZ7+1t41LSxMeW4vCYPimzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=A2rYCXgU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so180557a12.0
        for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765974835; x=1766579635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8GEKXnaSXfLaP2KVal8xoX7Yub2x5YeO61XyI9SmwQ=;
        b=A2rYCXgUYr9ALJpNgKYHWr7vJr+BFYlLRilkjQiry5X9M3LQQ88mX4hFh1RagqJ6lZ
         uLtt7f7uVrILg7+B+4YELj4FONtVCFqJA7XwsLHNNYAUI6dirg68L6UOFtUVg/pflSZn
         976Z2ay8EvD2m28JR88LPxi35onEJ8E+FN4FGVILCcgQKmTMqb22K5nAnVyqmLxQDd6O
         LbFKdJDvIY/Y8kWMUSdGNCbLVuKFxZCVvOnWjidEXE282hJwaojoXOnOsdvcE8Yo8AOE
         MRm/wjI6RrNDNxlhO3goPl87r39rYRTEA/cEsAWTInxIkFYA/Fm8IQlepQjUUy1g/gnO
         RIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765974835; x=1766579635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8GEKXnaSXfLaP2KVal8xoX7Yub2x5YeO61XyI9SmwQ=;
        b=hDrMMBYB13vXFr0jLUNxUkl6yrEuNzJ/qqT7uLMb2MkZNlcbhyWG9oxVAot2RzkYcO
         6vfJ3H5PitjqEiiQ/5gHHrsu9Cvna2W/1tsjF/2QLOXR8ajAkrYPMKM0xiSGEvrmA0Ah
         zw3nq9aB/T0/28qUfYc8XusR+zV0O/53IbyO6k8w1QWzf1hR8ZUepU2RcZxFI+7xjDsv
         2xJXtUXTNRxnwJI5xvnHVslUuAk0Fh+XRiBoY+egpMSzJNxI8288nAqdFtsQpOoNFqAF
         b9l6j2D/4vW76GhEWPBSSLeGRJNQlH3NKvfjSR72LDG6PnpSbMjrK/IxfXXx67fpX5Pe
         vapg==
X-Forwarded-Encrypted: i=1; AJvYcCXIQ2wBd303PLRfhteu9TpuwyxKGjoLxS7QYYwj2ZDnSJ5GH4/ImOa16SYgsCpBwmvT0uU9sGCtp4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1Mwam1c7sakXo2iZ0wv8qq9cabH7ap3ILwVt7jV9tIbpfcGA
	ggx1awvgPLPGgUHSdn6Lze/1XVV1fqgYJiiJI9RqOkelBKr6A4eT/qEWplw5iB6c99I+mxLDQJT
	jafGcW2jZdukzieVcIK8QEszAOuJDeeFrDv1l3AblTw==
X-Gm-Gg: AY/fxX6DXBeISf8nrzSYY0mrrSGZPPslOP4HGSs7UVJ98cEoeDxC6oBiBAlKZSrY0u4
	Qr3p8RVI7iGkDbu7wdFhGsYk5CEW1PbRqZ1TRcxfM+/pAqzYtcNvXTUaRIycq/OoKAoXQFm+3O7
	y928xUavC+XkFnCz54vNLYY67OnIsw/wuTKevMYeeVmBMOXZFhw/SdIPRKpQTVZQ+cZRotn67NX
	Nc+7HC/YuQMucGQlYg/y1uVOm+2ESjfIEqu3VHgvGEK2b8F8bN9Elw+iwqbg7NWfJGfM4u60S4B
	Mmzc2JS/r4MOCS2wclKNQYF+ZAtCJ63gEvMQcuhZzkX6l5uB5pyx
X-Google-Smtp-Source: AGHT+IE7Hjde/+kkViqYv1A0LhGo3fNDzXkWHEO+dWmCgW+32Gp4be+4LUgDpSNymwFzE86qvkEGL0RYLcWs3u76qoo=
X-Received: by 2002:a17:907:3d43:b0:b7c:e320:5250 with SMTP id
 a640c23a62f3a-b7d238ebd71mr1711209066b.7.1765974834580; Wed, 17 Dec 2025
 04:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-4-robert.marko@sartura.hr> <202512161628415e9896d1@mail.local>
 <CA+HBbNFG+xNokn5VY5G6Cgh41NZ=KteRi0D9c0B15xb77mzv8w@mail.gmail.com>
 <202512161726449fe42d71@mail.local> <20251216-underarm-trapped-626f16d856f5@spud>
 <2025121622404642e6f789@mail.local>
In-Reply-To: <2025121622404642e6f789@mail.local>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 17 Dec 2025 13:33:42 +0100
X-Gm-Features: AQt7F2rRCO2ytZ0VdvYzTGe4b0Ox8AKF-v29YqVKrXuogSLDfcjlg9rn0S9yxlg
Message-ID: <CA+HBbNGPWcwzCSGbMCU-n8Y+g6SjBSKcS7p6Mmrn3gFCWCSCeA@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] dt-bindings: arm: move AT91 to generic Microchip binding
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Conor Dooley <conor@kernel.org>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, vkoul@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org, 
	olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, richardcochran@gmail.com, wsa+renesas@sang-engineering.com, 
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com, 
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, mwalle@kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:40=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 16/12/2025 19:21:27+0000, Conor Dooley wrote:
> > On Tue, Dec 16, 2025 at 06:26:44PM +0100, Alexandre Belloni wrote:
> > > On 16/12/2025 17:56:20+0100, Robert Marko wrote:
> > > > On Tue, Dec 16, 2025 at 5:29=E2=80=AFPM Alexandre Belloni
> > > > <alexandre.belloni@bootlin.com> wrote:
> > > > >
> > > > > On 15/12/2025 17:35:21+0100, Robert Marko wrote:
> > > > > > Create a new binding file named microchip.yaml, to which all Mi=
crochip
> > > > > > based devices will be moved to.
> > > > > >
> > > > > > Start by moving AT91, next will be SparX-5.
> > > > >
> > > > > Both lines of SoCs are designed by different business units and a=
re
> > > > > wildly different and while both business units are currently owne=
d by
> > > > > the same company, there are no guarantees this will stay this way=
 so I
> > > > > would simply avoid merging both.
> > > >
> > > > Hi Alexandre,
> > > >
> > > > The merge was requested by Conor instead of adding a new binding fo=
r LAN969x [1]
> > > >
> > > > [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/202=
51203122313.1287950-2-robert.marko@sartura.hr/
> > > >
> > >
> > > I would still keep them separate, SparX-5 is closer to what is
> > > devicetree/bindings/mips/mscc.txt than to any atmel descended SoCs.
> >
> > If you don't want the sparx-5 stuff in with the atmel bits, that's fine=
,
> > but I stand over my comments about this lan969x stuff not getting a fil=
e
> > of its own.
> > Probably that means putting it in the atmel file, alongside the lan966x
> > boards that are in there at the moment.
>
> I'm fine with this.

Works for me, will switch to it in v3.

Regards,
Robert

>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

