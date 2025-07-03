Return-Path: <linux-spi+bounces-9027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A94AF7407
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FB13B96C8
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829F2E54A8;
	Thu,  3 Jul 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="0ph2alOI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22E28D8CD
	for <linux-spi@vger.kernel.org>; Thu,  3 Jul 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545567; cv=none; b=kuHNdidQssmuW/ARKbuKfCApjKUadsqpr+Et+KiO09IJoVviA26uiXLtTnvbvcDDLoQ/GTiI8PloQ2gqJ8AhJJm32lK9du6UvKLK91nyRj9XO3RE9e0j1GyaBZlhejmo9NCUfLTpTcJ3d65Ma+Nk1xXRdvBQqlu128k6iT1aCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545567; c=relaxed/simple;
	bh=xsHVzhy9sxS1+Yu3Y3Hn/VCKn8LRiyWwMmN5vGs+6YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mymNPg220G7HU6H05JR635twc0e+Yrsac5gs9Ci+C4dPkf/0BHEffOXLSrQxFjJhsCpYttC/t2n7JwghC8OEc39qDfmEMZr9r6qQuvRTDsml5TdhDFPih2UhqNXG3vm/cHi4ZRExDAC4MgBKtSsM8KBLnkPdj/yCFeF12idbZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=0ph2alOI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9311967a12.2
        for <linux-spi@vger.kernel.org>; Thu, 03 Jul 2025 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751545563; x=1752150363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nObl+SYcIa3QW/piwikKudB5bjd1HimTQxS37KWupiE=;
        b=0ph2alOIDnUdDxyGI0N55UnsDPiWsccgdo657pw4tSifz4aFf2qYzWwNJ66HvjQYPg
         P9hLIcINI3/I13YyzcVxD3LIeRDD5lo6aqKlDATR14yJmmNb1rICuLTZbqG8Jj5rQ8y1
         21weVM+c+DYPtVt1b9FbFA56JgCxm6gemqPc6CVDX1zcpbfuI3BHTXNNEu6TNoca8cgq
         VR8+4jjvAIr0agxWNOfXt5pbkh4aWzCokOXr4qTjswmXjTHZEC3M1cgetNnjbBzc09L4
         FEyf5WFNig2f6N5QBS6c/O1spGl3AMXYIqQ16h4WO+k6z+4RItNT9tLrtxEN1UragL81
         wQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545563; x=1752150363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nObl+SYcIa3QW/piwikKudB5bjd1HimTQxS37KWupiE=;
        b=Y/1hIcBj9y/NlVbGp0CI7hWaLtTju5x+f0+HU153UfIKTw361aIsjg+q+7PvCm5xRh
         3tYfhGRWCdjkP1VuTOyVhj7VuA/LRNPYNnH3HFHjyvnhFTbomLj0d7wBLg6296QlNFGU
         lZFLyM0Zpc3vz7P9WITliIOQ8cd7+JzXp9uscxb2urUq2W21sO5TGppaHb0OslqQeBaE
         A5GMUzCNXZ6vK8zFpNVLIhkV+sDKivKf8D8v1A22OavGC5IIq4drP4cJRShSRH8Sro08
         La+9JukaDO1Omo2YWXuYWwIHnWQfmvndyMtYqDP0OIVA0ca/67XT2bCJrAxdGCRXwPWR
         J3iw==
X-Forwarded-Encrypted: i=1; AJvYcCXDa/fMHyCaD6v13nTWUnY3QjbijXzSNGz/5ctgIQKlx2jEtxI8PeO4AI4Mdy9S7I/m97zHEKoeNSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyaA4AdlXWmiwQBlo9G+EH3WwFpj74P70C/FDOdhMsmzqHgnb
	O0fUyssrLe6rUl2f/qpNdwcmEcm5q6H0IgF+ZFSvbKJuArgAlkejb6XPh4oBd0+l7TYikIa6WkU
	Ca5bk5Wk9HqbYFbbtJ/jV1PeAW5+mL4ODV5MAUykoWw==
X-Gm-Gg: ASbGncug9iBOJ9arKQbzdSIgLGso6WTy+UuQ9vgAQU6gYzOO4B/I6ZdJ/PC1okvL/CW
	YId79BUwG/5fQbL4lIrfaLKTfPYIMuJpAV8uejn941hHy8/PG0W9VQTbzJ/wytsN8u7/35mCiIy
	xJTnq/K9nEvW5TeP0sdCTFi3Xhql3DrsATxZyGi+5KYSoljp2P1Flkb08=
X-Google-Smtp-Source: AGHT+IEQsYSlWMf3Q9ENbLYf0hzYQ7kNTdCoTK8bDuxoivKIYAt9JBafQ0ZP5WqZFwf5XmjzV9WjVxRtGoE8EwoykYw=
X-Received: by 2002:a17:906:6dc2:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae3c2bb9a30mr525010866b.29.1751545562485; Thu, 03 Jul 2025
 05:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
 <20250702183856.1727275-2-robert.marko@sartura.hr> <ea353170-6e03-4231-afc2-3dc45253931d@app.fastmail.com>
In-Reply-To: <ea353170-6e03-4231-afc2-3dc45253931d@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 3 Jul 2025 14:25:51 +0200
X-Gm-Features: Ac12FXyEmDCCZ2eYF1-BFnQ2rb5Xpv9SlBj8TpVb-TJbG9_3w-Q9dIeIUPPsPkE
Message-ID: <CA+HBbNHxiU5+xVJTyPQFuCJLyEs5_MpybSBEgxi25bzaGfiVHA@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] arm64: Add config for Microchip SoC platforms
To: Arnd Bergmann <arnd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Daniel Machon <daniel.machon@microchip.com>, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> On Wed, Jul 2, 2025, at 20:35, Robert Marko wrote:
> > Currently, Microchip SparX-5 SoC is supported and it has its own symbol=
.
> >
> > However, this means that new Microchip platforms that share drivers nee=
d
> > to constantly keep updating depends on various drivers.
> >
> > So, to try and reduce this lets add ARCH_MICROCHIP symbol that drivers
> > could instead depend on.
>
> Thanks for updating the series to my suggestion!
>
> > @@ -174,6 +160,27 @@ config ARCH_MESON
> >         This enables support for the arm64 based Amlogic SoCs
> >         such as the s905, S905X/D, S912, A113X/D or S905X/D2
> >
> > +menuconfig ARCH_MICROCHIP
> > +     bool "Microchip SoC support"
> > +
> > +if ARCH_MICROCHIP
> > +
> > +config ARCH_SPARX5
> > +     bool "Microchip Sparx5 SoC family"
>
> This part is the one bit I'm not sure about: The user-visible
> arm64 CONFIG_ARCH_* symbols are usually a little higher-level,
> so I don't think we want both ARCH_MICROCHIP /and/ ARCH_SPARX5
> here, or more generally speaking any of the nested ARCH_*
> symbols.
>
> This version of your patch is going to be slightly annoying
> to existing sparx5 users because updating an old .config
> breaks when ARCH_MICROCHIP is not enabled.
>
> The two options that I would prefer here are
>
> a) make ARCH_SPARX5 a hidden symbol in order to keep the
>    series bisectable, remove it entirely once all references
>    are moved over to ARCH_MICROCHIP
>
> b) Make ARCH_MICROCHIP a hidden symbol that is selected by
>    ARCH_SPARX5 but keep the menu unchanged.

Hi Arnd,
Ok, I see the issue, and I would prefer to go with option b and do
what I did for
AT91 with the hidden ARCH_MICROCHIP symbol to avoid breaking current config=
s.

>
> Let's see what the sparx5 and at91 maintainers think about
> these options.

Sounds good, let's give them some time before I respin this series.

Regards,
Robert
>
> The other patches all look fine to me.
>
>      Arnd



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

