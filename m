Return-Path: <linux-spi+bounces-12217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F433D03B05
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A25A30B6C33
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882313D7D92;
	Thu,  8 Jan 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlPEEBaV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D12248B3
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883261; cv=none; b=M9RQTXRvsHfAqY65eO7cesJmsfJLao9G04MH5Az8iMFnKzOVAj3jSipDcJ5s8TpJqBWto0/HZRvtGH6S9/eUXGaizz28vD/Tlzt/WCxE0am/kc8pqUZm4MTLT+vdNxQZ3naoBS++REtR65IpWd4k0v+Bi2rXAvkhZlE1ZU4Rqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883261; c=relaxed/simple;
	bh=VCvoKljqX3kZKrg0wl5o7D7vP2IqS4NfiwwNUjNseAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thy3UGBzVh1Lhq8SXgOckQp7cc93a8OQiyNl7p6FyXxznL1BQIWYZdYEQEbg1J68joqHp2y8YJJSEhWPVIqIJPZq2idjIcCcMPmFQ6Jd8ok9pKk8eIh5VFPqJ4oOGCkX4Iwi/tQOcjhnxsFBhxYfQGyopl44XFUeFIXbu8BXZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlPEEBaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B65C19425
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767883261;
	bh=VCvoKljqX3kZKrg0wl5o7D7vP2IqS4NfiwwNUjNseAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DlPEEBaVI+xP7JjLfS9LR7e7TGlmyC5TXYpt0PNmPihe3YioXsrVmtrq1bDvAbAlr
	 DGQBoe0/BBqPxEDAat093atVemL+rsMNoS4kC49Pg9BpmAZgGRFiEkQdkSTLecOfG+
	 poB3TiqB3KlW5jq1VyvVP3hp3sorPJDtMbWrYvxFO8lusCSeJyKRcPIrCqDY3ofN3a
	 j77fZG3Y/Wr/xsiaSXRnJzZlY2y9ukAD9v5DlTjUi4i7Sd7nHzz0KYnoANhj8k8luW
	 A1jJFXxGdReXBvIrTVbgWB83BJbBPTv2KiA8ytRN+HMBPxWAg09+sQor/s3ENg9Znp
	 H7nY7A1BD5mtA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so635189166b.3
        for <linux-spi@vger.kernel.org>; Thu, 08 Jan 2026 06:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTQA46FEDOX2SQ4D3b1eTUr/Tj8Fhgb7iNgxZ97qRe3wKkvnN9AmGD3Wv1zvT5DDDJJOs4WJXr9dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJ9YDcJ5wztO/mxi68/qHFer11jw8mjbfOsBrPKm/rZjNzlo/
	o0EH1VqHYZs3qXHxk5EMNW8J8zPB9IRI/iTTAPSllf6gHVYhGbei11FlmfHKtgNXq+fdbMBR6Zd
	EJfZtS5r7XW1ow0QBoy6UGeAKE1N7qQ==
X-Google-Smtp-Source: AGHT+IHI33xhADwXbn0vf2H6UNw8erJbbT8WWPi8EUBJ/Ob7LvrmYmQ7U0+rDVaaapOIsNUCqxvWDN4KWUHOnOQ+6Dw=
X-Received: by 2002:a17:907:72cd:b0:b83:f09f:4e56 with SMTP id
 a640c23a62f3a-b844516d7admr651521166b.63.1767883259450; Thu, 08 Jan 2026
 06:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com> <aV-jQImroXxFqj3Z@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aV-jQImroXxFqj3Z@debian-BULLSEYE-live-builder-AMD64>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Jan 2026 08:40:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+y86RJ3PwN1DSbw1zUgL-f-R98u7s+zfrKr99V+za1Zw@mail.gmail.com>
X-Gm-Features: AQt7F2o2jGkKFch4Ba0iemfY8-pqG-ebcXF772c-dsVzMB7IP52XjuMQWCjxSCI
Message-ID: <CAL_Jsq+y86RJ3PwN1DSbw1zUgL-f-R98u7s+zfrKr99V+za1Zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map properties
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:28=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 12/19, David Lechner wrote:
> > Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI periphera=
l
> > device tree binding. These properties allow specifying the mapping of
> > peripheral data lanes to controller data lanes. This is needed e.g. whe=
n
> > some lanes are skipped on the controller side so that the controller
> > can correctly route data to/from the peripheral.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v4 changes:
> > - This replaces the data-lanes property from the previous revision. Now
> >   there are separate properties for tx and rx lane maps. And instead of
> >   being the primary property for determining the number of lanes, this
> >   is only needed in special cases where the mapping is non-trivial.
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++=
++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 59ddead7da14..2f278f145f78 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -75,6 +75,13 @@ properties:
> >        enum: [0, 1, 2, 4, 8]
> >      default: [1]
> >
> > +  spi-rx-lane-map:
> > +    description: Mapping of peripheral RX lanes to controller RX lanes=
.
> > +      Each index in the array represents a peripheral RX lane, and the=
 value
> > +      at that index represents the corresponding controller RX lane.
> These are peripheral props so I guess RX is from peripheral perspective.
> In that case, those would be routed to controller TX lanes, no?

I'm pretty sure it's the input to the controller like the other rx
properties. Like rx-delay is for reads.

I guess "peripheral RX lanes to controller RX lanes" is a bit oddly worded.

Rob

