Return-Path: <linux-spi+bounces-2827-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5E8C3334
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1401F21625
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707311BC4F;
	Sat, 11 May 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5ifuh/R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06228E8
	for <linux-spi@vger.kernel.org>; Sat, 11 May 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715452885; cv=none; b=sskJIMi6uprzy26FCJoTVhUIPdeIiDO0g/ooJ+GgrQwXwC0tcCKJBZltkAZIaD7V4mZfZpML0IlKp4d/vcdmiwMWPi1eW3ePxqbN7r2w4SUAtehnW0RQro5I0i0aBrFlPufZKfUeIhRs1XfHgjAGiBZU46d3arxVaM6iGDVyzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715452885; c=relaxed/simple;
	bh=G7PBUQYX86PTVKHgYsiAhpQ9G51BoCbvNoBIlqfcN94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir8GSKxbXbqTspvSyhMCG7VJF9rxxQH85afiy3k3VYAroZ4yE8/Ps+gi/tsISlX0BEgt2fR4e990XofB8PokykoCfDFYDZDrxjNxFx6quzJ+Di+NoXiXtKqJ2803mNrkTlmi1uUv6yzcf2d2FRbtGxDFb6yxIji/8mbNkSVQHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5ifuh/R; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e43c481b53so37302111fa.2
        for <linux-spi@vger.kernel.org>; Sat, 11 May 2024 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715452881; x=1716057681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBbqjiAUkd73PlK8VV9pGC4FnSlljTALl1NxrlDsjME=;
        b=P5ifuh/RAGkkYb3MkvGj86DcdV0ZiW9sGPDI4AkDnWZ8S7a/ryJG71fMZy0QrhdTvB
         pnaBzEDEBm/I9u3BmsSKJVN0S+yjBi+QJ+BSpP90K2qkSeEJzZmUj8o1++EFHdu06+PJ
         NiWuRZ/cwO3EuZ0fpDrQeTrhCrIWzjX9xjKuE+XM4V23YG4HqFxhgidKrv+vWzaG20ks
         42omJPctXufYTL3wL2pDOPZn3gdiD0/u7f+hgxV7C3aCODQPZP93Jr6gxzXgjl6qdLKj
         RLD8939UDnCCzAUAbjzs1QYUmoNbwu8pbLhmRo3bn92qY9MLpvAw9nuM4f4B0/TJHVAW
         ACiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715452881; x=1716057681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBbqjiAUkd73PlK8VV9pGC4FnSlljTALl1NxrlDsjME=;
        b=js9BGm3OKbQM5fgEqf8JqXGbEPQpp6tvfFKRrMX9hYZ/5zanaY+gRHYDxMd60nj1OE
         5i9LfW+eW6Z0J8QsUaIrezftlsnrWEXkyzst8PzdCqJe39ue15BrRg9SK7OmDj64K4M3
         gO6h1m4GtqqtKTRhI6V8hYMJV6UTB4J2704qkK3ILQgY2rDGO7Xwly2WotpNWtDnEwAn
         vghyXcrOBbLCi71mYfI+l/mpIlPGHWU7xU+ShNNGIC2cy+YY1JD0Cd78exK87L82h86R
         eUR/jE82twesHN4D+twBq0gN0oD1Mr1hfMVENn10+7UG2vKdIudStRduq0FIR3SRROzx
         +l9A==
X-Forwarded-Encrypted: i=1; AJvYcCV5EXrgt/Ogpep+90odgjrYCDOKMP0xwSWOAVMt+MiCGfPAEbwM5Jhl5K3fqElul99wTME/iAfUa9/mElgvNJmH8qWtx3nI1Ai0
X-Gm-Message-State: AOJu0YwfMiXOID30yTMrRl3o6XWYa22Zq1zv+wrVWX/ytylqgAo1Jv09
	IMy9DzVBDoktf57noyS2gRdglgWewheyLbeV4Ihc43sugyEJnH5SSpTd06f8q7NRTdtyt3iTCGX
	43AoQujqATcGTXJj+yed193xXX3WRL3OqWFGbYw==
X-Google-Smtp-Source: AGHT+IHk09J0epwNKiamnPnuOxBAoPSoJ+QFxlb6XhnzmVPVhZf+8cgD1rQnZtCrwvWEu7WxDbrLbDioToUvsHW2xSU=
X-Received: by 2002:a2e:8896:0:b0:2e5:15d0:511c with SMTP id
 38308e7fff4ca-2e52028da88mr37305651fa.40.1715452881036; Sat, 11 May 2024
 11:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com> <20240511175832.6c2f6517@jic23-huawei>
In-Reply-To: <20240511175832.6c2f6517@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 11 May 2024 13:41:09 -0500
Message-ID: <CAMknhBGG9bYwzPw8woaR_YaVRW+wpT4W1KpHzG32nWj9Qi7fig@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] iio: adc: ad7944: add support for SPI offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:58=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 10 May 2024 19:44:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds support for SPI offload to the ad7944 driver. This allows
> > reading data at the max sample rate of 2.5 MSPS.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v2 changes:
> >
> > In the previous version, there was a new separate driver for the PWM
> > trigger and DMA hardware buffer. This was deemed too complex so they
> > are moved into the ad7944 driver.
> >
> > It has also been reworked to accommodate for the changes described in
> > the other patches.
> >
> > RFC: This isn't very polished yet, just FYI. A few things to sort out:
> >
> > Rather than making the buffer either triggered buffer or hardware buffe=
r,
> > I'm considering allowing both, e.g. buffer0 will always be the triggere=
d
> > buffer and buffer1 will will be the hardware buffer if connected to a S=
PI
> > controller with offload support, otherwise buffer1 is absent. But since
> > multiple buffers haven't been used much so far, more investigation is
> > needed to see how that would work in practice. If we do that though, th=
en
> > we would always have the sampling_frequency attribute though even thoug=
h
> > it only applies to one buffer.
>
> Why would someone who has this nice IP in the path want the conventional
> triggered buffer?  I'm not against the two buffer option, but I'd like to=
 know
> the reasoning not to just provide the hardware buffer if this SPI offload
> is available.
>
> I can conjecture reasons but would like you to write them out for me :)
> This feels like if someone has paid for the expensive hardware they proba=
bly
> only want the best performance.
>

For me, it was more of a question of if we need to keep the userspace
interface consistent between both with or without offload support. But
if you are happy with it this way where we have only one or the other,
it is less work for me. :-)

