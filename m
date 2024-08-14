Return-Path: <linux-spi+bounces-4194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C29520D0
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DE5281C00
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 17:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E11BBBD5;
	Wed, 14 Aug 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PM1LQgUu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2261B9B28
	for <linux-spi@vger.kernel.org>; Wed, 14 Aug 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655667; cv=none; b=m5VdPQaH909yE1F7d466ouI6sM7WUD7I5uthwHOPYyiAnQE9TJMN/yfdvLXnarPGcedVjWPRQIAjgnMVfh+Z1NIsP/c5OniDSqeJWPRC3KYKPMtzh6exWmXBHi3w8YsJ1y/NWcflhd+FUm0o/qBuWxMJuY0EfGEUqhWQkw/u3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655667; c=relaxed/simple;
	bh=blA3SSlWobp+ymfR6wJSN8N7F9m9dTpcI5LCBJp96tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fn5Y9IHVN3CaF5jX4zJkcKT+wMp8GWiYhI0jXUmOq+ZRAeFlzHVHoWH/gX0xz4dE2vvOnvFNdwfvjuiyUZLJFzM0ja/siFI4uRMmshB00rG7xRTEGs7fqDYyQJI3NQnIE+wHWtL8n7RJAsoUNy9DFRwokwZlr7H+2X4DsNZJQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PM1LQgUu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so1593141fa.2
        for <linux-spi@vger.kernel.org>; Wed, 14 Aug 2024 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723655661; x=1724260461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVbOQ51p6R1MiYPVnFg0RL8dPh9TQ81XjE0YMdoGDEk=;
        b=PM1LQgUurYCwLYDINIJnOisowOyEve/EBHBn7deNsHBIA35oSiZwnlHyTFzJ7Aucyp
         VVdDIKhkmN35r29ISm6IsZufZO29F2eoOwks6UgKrlglkfhhp52i2BIHD0xR4MOked66
         JbA0VU5AmHKqzZ+eq4ixZcpBJqKF8UN9aEk9bpZf4Ya0Rmzswx4cw+jZcxRFjpizwc0x
         5HTe+VhG9wq4+NA+ctFYrvFRhaKOy2xDKuo1Mg3TxPvffGF9/xiX9suHvaMRj20YcK+E
         P27Tgm0l1RUamhlgigXry9lrkWsohHxBfZNxV6WkRxp9W3rkbLjxg5UN1V9GHiXrqcw1
         w3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655661; x=1724260461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVbOQ51p6R1MiYPVnFg0RL8dPh9TQ81XjE0YMdoGDEk=;
        b=JP7uZAqwSM97wW6GsxNlP9f7d2gYyY9JzcxQ8pghmsoxeGc8eS94hGs/HMXFqJMuJT
         aYV2cIXBU+hZBX5F7b4RSb0PMFbhkbhN4Gs6zumrv7+2hMAjmT7GoMvMZvc1oDDz8Zfw
         djCsXyWTyn1xeSh0utY8qdXU6OWjZUC/Zb9Oo4Pmfq2p2gsTm0KT/H5Y+MnWtv/s7oPP
         CjBmtCgbeG+aMdKEdGlYqltojrc5MOQoIXev5BaZUHYyhoDC8+2XCXq+ql60x6E8nGgE
         A7twb2tneK+GvAvybyigYhkYGp4m0mAJPhmqxZSJ7l060jAiSq3gMgYxLcQw8PtwFICV
         f3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXM5G1KY2Fz88tH/YzCP+KlW6HpMN0IWZONCizs6ntdaZF0jJWLpQ1XjfDGOaRIp6BxIK3XOKQwr4ZuUtZGDLZ7Sv31Wp4Nr1/Z
X-Gm-Message-State: AOJu0YyRtYV3d5S1NfGouyc5EQmHR+9aNAziBLLYF1qEy/ytU/Fi9tVk
	3UkomTCdv/akxSJOCr0B6s0IsNpltnW4QKD9CdJ7CcegAF1fwKJlQueGFKhdHjaV7tFgJkabiVn
	lm9k2eNjsiPqM/d5SGaFpcfdNdGPKT01+qyiP7g==
X-Google-Smtp-Source: AGHT+IEL1JxJHsQVWFrwUNuPiVOcA6sWDEaFvbmneam38L+A5QIC+EqMK3s5NkkHC1kDhbTcuPkHxAMp4ntfuYQBQ4s=
X-Received: by 2002:a05:651c:19ac:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f3aa1d9de7mr24706231fa.2.1723655661371; Wed, 14 Aug 2024
 10:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
 <20240726123836.GA998909-robh@kernel.org> <9f57e41f-3534-4188-ae78-d323aa45e2a1@baylibre.com>
 <20240814-breeding-revolving-ba26c46164de@spud>
In-Reply-To: <20240814-breeding-revolving-ba26c46164de@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 14 Aug 2024 12:14:10 -0500
Message-ID: <CAMknhBHxq3MKXATBXg6tZkkkUmiAtph=+8mV4KgcLne+J8kGzw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document spi-offloads
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:58=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Jul 26, 2024 at 02:17:00PM -0500, David Lechner wrote:
> > On 7/26/24 7:38 AM, Rob Herring wrote:
> > > On Mon, Jul 22, 2024 at 04:57:12PM -0500, David Lechner wrote:
> > >> The AXI SPI Engine has support for hardware offloading capabilities.
> > >> There can be up to 32 offload instances per SPI controller, so the
> > >> bindings limit the value accordingly.
> > >>
> > >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >> ---
> > >>
> > >> RFC: I have a few questions about this one...
> > >>
> > >> 1.  The trigger-source properties are borrowed from the leds binding=
s.
> > >>     Do we want to promote this to a generic binding that can be used=
 by
> > >>     any type of device?
> > >
> > > I would make it specific to spi-offload.
> >
> > OK
> >
> > Meanwhile, we are working on some other ADCs (without SPI offload) and
> > finding that they are using basically the same sorts of triggers. And
> > on the driver side of things in this series, I'm getting feedback that
> > we should have some sort of generic trigger device rather than using,
> > e.g. a clk directly. If we need this same sort of trigger abstraction
> > for both SPI offloads and IIO device, it does seems like we might want
> > to consider something like a new trigger subsystem.
>
> A "device" in the sense that "pwm-clk" is a device I suppose. >

In simple cases, yes it could be like "pwm-clk" where a PWM/clock/gpio
is used directly as the trigger. We also have a case where there is a
PWM output combined with a clock output using an AND gate, so more of
a "real" device. And finally, there is actual dedicated hardware, like
this [1] time division duplexing (TDD) controller that, in addition to
it's primary purpose for RF applications, can be used as a general
purpose trigger source - mostly useful for creating burst of a finite
number of pulses.

[1]: http://analogdevicesinc.github.io/hdl/library/axi_tdd/index.html

> Are any of
> these other things WIP on the lists (that I may have missed while I was
> away) or are they still something you're working on internally.

My ideas on actual trigger devices and bindings are still mostly on
paper, but we do have a couple of ADCs on the mailing lists right now
where I think it would make more sense to have a flexible "trigger"
but we have been making due with what is currently available.

ad7525

In this case, we need two coordinated triggers for the CNV and CLK
signals, one that generates a single pulse and one that generates a
burst of 16 or 18 pulses, both repeating periodically. Right now, the
proposed DT bindings only allow specifying a PWM to provide the CNV
signal and a second PWM combined with a clock and an AND gate (same
one mentioned above) to provide the CLK signal because that is the
reference hardware design. But technically if one wanted to use, for
example, the aforementioned TDD controller to create these signals for
CNV and CLK instead, it should work just the same.

[ad7525]: https://lore.kernel.org/linux-iio/20240809-ad7625_r1-v2-0-f85e7ac=
83150@baylibre.com/

ad4030

This also needs a CNV trigger, but it works slightly differently than
ad7525. For now, the proposed DT bindings just have a cnv-gpios to
describe what is connected to the CNV pin. But for certain
applications, a GPIO is not the best choice. For example, to use the
oversampling feature of the chip, we have to provide a burst of some
power of 2 pulses, up to 16k pulses, with specific timing to trigger
2**N conversions before reading one sample. This can be done by
bit-banging the GPIO but could be done much better/faster by something
like the TDD controller that is specifically designed to create a
burst of a finite number of pulses.

[ad4030]: https://lore.kernel.org/linux-iio/20240627-eblanc-ad4630_v1-v1-0-=
fdc0610c23b0@baylibre.com/

Having a generic DT binding for these ADC input pins that can be
connected to a wide variety of outputs seems more future proof than
having to modify the bindings each time someone wants to support a new
type of output provider.

