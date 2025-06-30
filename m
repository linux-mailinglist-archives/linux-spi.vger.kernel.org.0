Return-Path: <linux-spi+bounces-8915-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33200AEDEEB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5289B3A33A7
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D0285049;
	Mon, 30 Jun 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZQTv4zdI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245D27F001
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289694; cv=none; b=iOXj9IAoEO6FkBhGZxqzxS1nwZvUcrP6hIfB2Mw7c7UKLD/dBpMqBSbzuMlj4Xn8lvRV9SFbk8+VIH4MTfEkSIIGpHTja4YoeMgl48C/jZFuhYwvVOIJ+P16KEm8g5S9s89SB1aT4V2Pbu5p3NuuCRneYHIxIvbIQN4z9TiBZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289694; c=relaxed/simple;
	bh=wYSk7fxInjdJNOHqBT3fau/40lgp1kFco8w401sE950=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzoL6uRAyEa9h5Q/XPaDoI7mQKgwjrzk0pFyqy+yKYwx2whpxgqZW3iyKtYgdbntYig8s2/3+ANAN8dGn2ekBvELrknizcF7y4ye5orclJGYUkrSWR9oXwGmA0xJyu7Ew5WtyB6eAzayWemr1wzxov5W50GGyRnMHthhYn61W+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZQTv4zdI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade76b8356cso429055766b.2
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751289691; x=1751894491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I8CsrHjtRtD5BaYjtdOSFNgRck9IxhroTpwRBGBREc=;
        b=ZQTv4zdIh7dZ1Lg/rGgUPmWqnPT5GKG51d2hj3rr+Iar5/ZdgH8ostY0HGD9nH98oF
         eLRWZgiyAITEb6Z/oyXegjB/VS4cCK9L3P7t7+tyEjFsfjg/dygDensV6bQF1hvoGx5c
         d5gRhGF+PhBCLXbX2rAInJUHXRKouIPD2NBcwh2jGNn8Ih3bqVNq0Kam+RtqQB4QBVAC
         Ngn7WKq6Tz+uOwudmI+78VjSWRXZYyztWpu1dVtyMw7dWEIFzV0AgVniYKzRoxHVCH97
         SFmR0ZISn2FInckrd0R5ptTd95F6m1/KV+sUy6BAideGWb3nEgqWSKIFtN8pT9Jhp1zB
         9CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289691; x=1751894491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I8CsrHjtRtD5BaYjtdOSFNgRck9IxhroTpwRBGBREc=;
        b=ktE4k5WelRmtG85SKJHo/3PwZVYYt2Dw0wL4d373Gu96Ly6qNs1AGc90OSyO6+iSTF
         3FcesXO08foDvqzp8zSA5TwV6dIIHlik9daNsRRPuh5sqgWkB67pvixqN7MN8GI1eXYw
         wvHyh+KB09WbmGan0pfhO1o0tmnDxEZ5zG/J97jpl1TPoqm3TBDbA3VZf8BsynVPiHGu
         LnPR2Sf5F4NNPbO1KbpY+y+193FIFRBbTVQNJC2/6qBgYR3r30xGo3xbVYw3tDWOez/t
         v6jzzCkhnVOn1x3CRVWqZZiKdKVvWHCl6zaUdmqTrv562o3bIQZFMu5dN5Y8wRMbqqx9
         fyTA==
X-Forwarded-Encrypted: i=1; AJvYcCU+SyojP5mND6epCNpAb8UA4E++LaamzeL2xmEWFtLcZZMYv6MndzaL/YPDrRCshJmKp7lsjavRxt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTt74Vr2dK3L9Xwm0znHBCYqSpKoXiSzJVNlVFyPO61n6K2TAO
	8Bx7FQ08hECTDqhZwc5BNExzwf+fkW0rYp2wnpMtrf7CFt5oqloSGNUse+bb6zJg44mYkWUdH8T
	0PknMm6yWX4rzM7SIB0+a/I2WkGumAF4r7qouJUCQQCec8I3ZVePJ
X-Gm-Gg: ASbGncu0LQY62w47/S9HilxzQnxpsYIaanGGgVOrY+NLGsLVH+VNI5AgeIFLGXbBu+/
	0GdEu3/Cp7Sj+/dK2iX356dWcK808k+V0fZwGaPdf1yEQyi+WPbJ9K67XIz3nBxbJX9k8Ee2Lpt
	8s3YGP6vGG6Wj9Eo8R8xgdv3mp00zPhjUCsonr3lPpPGnYE6GshOez
X-Google-Smtp-Source: AGHT+IExvta/iWzBmIlIztBuCgl2cUU6u80HBaLHyHvJJXhxVNxMY8nK4KaXwhnRKNkDAhQ4ZeG0igRs73XqWwJLjCE=
X-Received: by 2002:a17:906:df08:b0:ae0:a88e:6f20 with SMTP id
 a640c23a62f3a-ae34fd88f8cmr778815366b.15.1751289691157; Mon, 30 Jun 2025
 06:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613114148.1943267-1-robert.marko@sartura.hr> <3ba837f8-70bb-4b9e-a9f9-0e71b9e073c4@app.fastmail.com>
In-Reply-To: <3ba837f8-70bb-4b9e-a9f9-0e71b9e073c4@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 30 Jun 2025 15:21:19 +0200
X-Gm-Features: Ac12FXxhA2Gp9rwQDhKKgV4ARb8lKQ6I8YMqCzExRny5q7pcafJNPwE_zl3e6I4
Message-ID: <CA+HBbNFd5hCKqUZY25Sws-o-0QALLue-JROyze_9biyuZZv4mg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: lan969x: Add support for Microchip LAN969x SoC
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, ore@pengutronix.de, luka.perkov@sartura.hr, 
	Daniel Machon <daniel.machon@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Jun 13, 2025, at 13:39, Robert Marko wrote:
> > This patch series adds basic support for Microchip LAN969x SoC.
> >
> > It introduces the SoC ARCH symbol itself and allows basic peripheral
> > drivers that are currently marked only for AT91 to be also selected for
> > LAN969x.
> >
> > DTS and further driver will be added in follow-up series.
> >
> > Robert Marko (6):
> >   arm64: lan969x: Add support for Microchip LAN969x SoC
> >   spi: atmel: make it selectable for ARCH_LAN969X
> >   i2c: at91: make it selectable for ARCH_LAN969X
> >   dma: xdmac: make it selectable for ARCH_LAN969X
> >   char: hw_random: atmel: make it selectable for ARCH_LAN969X
> >   crypto: atmel-aes: make it selectable for ARCH_LAN969X
>
> If the drivers on ARCH_LAN969X are largely shared with those on
> ARCH_AT91, should they perhaps depend on a common symbol?
>
> That could be either the existing ARCH_AT91 as we do with LAN966,
> or perhaps ARCH_MICROCHIP, which is already used for riscv/polarfire.

Hi Arnd, I thought about this, but I am not sure whether its worth it
since we need
LAN969x arch anyway for other drivers that currently depend on LAN966x
or SparX-5
but will be extended for LAN969x (I have this already queued locally
but need this to
land first).

I hope this makes sense

Regards,
Robert
>
>     Arnd



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

