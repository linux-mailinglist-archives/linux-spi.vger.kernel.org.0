Return-Path: <linux-spi+bounces-11315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836CC6ED1D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 119BA2E4C2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4E35F8A2;
	Wed, 19 Nov 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFCi7GzT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84635E559
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558301; cv=none; b=VMucykEOrEtPDGr55WTbMZ01VnahRjtFBbgtvdyOnmnN8RlwrPpcuBn5uw2+uu5uzzL7eciFM6bL38fxSHHGaOHfO4hwndQUXR7w8tp2rS7/xnq14elZdBxFXQaI6TbBG+BScD8yz+WPlobLN4KsrYazdqe4jRIpUeqIgAX+BsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558301; c=relaxed/simple;
	bh=gcdTK3i8ksdurmCsuu3zAydlGu7kz2DZI1wbgJnoUJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb/besQvTXXH+PCEPdntPBnqTQCE1d7nnewLDkqyfBcAHQ//4hkTbN3gbtWDylrLxq5rt3qeoYaNY0lplcE039mTe9UsY9L42lpd0+bGTlxt7hYZJ1ylI9h6Zu0j6EKj/rWlvYjFUbWWtpYSbTn1MzHZQ97vUksiBSS7TM789as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFCi7GzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C6DC4AF14
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763558301;
	bh=gcdTK3i8ksdurmCsuu3zAydlGu7kz2DZI1wbgJnoUJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFCi7GzTgsYkBIS6y/c91cYilhXe9WWHK+Jc1w0wsMgPq2/DkyfSPACH6r9Toi9Cb
	 bgjZWs8gx9CkUEZCsbOq9cvqPpHILyEmOSoM+mPLRJwgCokGsbXFlX/xDX/+wTqPrn
	 aRT4Ca5PBcS9C5DWEzZFSMzvuS1VqgQfIw/CRc5Rn+L+2neN5cblsFNjctJf94XFPD
	 VEqZSx1SlYzwV5cl7ZNdVnZzkivurEEmFLPb9M6fRLO7WIll9kNPnliLbZidTVIlo7
	 ZVT+TX56iyDQcdFV1Zy4ror17zPVQi4vGHqtGGy6nAyVTCLR2JVzVmtJ9pGY1Bk9Th
	 xiGB9+S+UqItQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so3955702a12.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 05:18:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWf5dceOYeXz4Z90h+R2l91j4UgMto3NotVww6dJgDDu+bR6pEuu6Nu3JFD0zNwZexxnTw1KzDT4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3RJXnznMU5WwOrHK0F5TE/8hJ2pbxrZGPKYd8LACvh/CHEwS
	q0jdTG6931zFcJ3YSbi7PAhF5XuQm30CIRMFfbnja7K2Gu0AXOJQa5fsY6e6T/ZOhkCuOUFD6kg
	rZbFajE5fJ6vnac87xnetrHeElYc8wQ==
X-Google-Smtp-Source: AGHT+IEnJMvCQApFNzDeK8Ljri8dKV8og33IOyjT7qad4tVg9oG0FZmoA7KNeUxXr/c1ycYbMnzDOoWtc7XuvKe0fy0=
X-Received: by 2002:a05:6402:20c5:10b0:641:2c5d:81a6 with SMTP id
 4fb4d7f45d1cf-64350ebf916mr13840898a12.33.1763558296663; Wed, 19 Nov 2025
 05:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
 <20251118155905.GB3236324-robh@kernel.org> <97c6b55d-9505-4091-8f0b-317dcbd70838@baylibre.com>
In-Reply-To: <97c6b55d-9505-4091-8f0b-317dcbd70838@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Nov 2025 07:18:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZZE0g424jE75xeCt2KY1ThPLqmbmOs0o_ddaJ8fOf3w@mail.gmail.com>
X-Gm-Features: AWmQ_blXpULYEhFIFBogakXs1wyuUr-smJ6bc27pMQ0DeY9XTQbnRHbF_oMXb-I
Message-ID: <CAL_Jsq+ZZE0g424jE75xeCt2KY1ThPLqmbmOs0o_ddaJ8fOf3w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses property
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:46=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 11/18/25 9:59 AM, Rob Herring wrote:
> > On Fri, Nov 07, 2025 at 02:52:51PM -0600, David Lechner wrote:
> >> Add spi-buses property to describe how many SDO lines are wired up on
> >> the ADC. These chips are simultaneous sampling ADCs and have one SDO
> >> line per channel, either 2 or 4 total depending on the part number.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 +++++++++++++=
+++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >> index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fb=
c345f58c5b09083385 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >> @@ -62,6 +62,10 @@ properties:
> >>    spi-cpol: true
> >>    spi-cpha: true
> >>
> >> +  spi-data-buses:
> >> +    minItems: 1
> >> +    maxItems: 4
> >> +
> >
> > As the property is not required, what's the default?
>
> spi-perepheral-props.yaml defines:
>
>         default: [0]
>
> Do I need to repeat that here?

No. So that means you only use one channel and the others are not connected=
?

>
> >
> >>    vcc-supply:
> >>      description: A 3V to 3.6V supply that powers the chip.
> >>
> >> @@ -245,6 +249,22 @@ allOf:
> >>        patternProperties:
> >>          "^channel@[0-3]$": false
> >>
> >> +  # 2-channel chip can only have up to 2 buses
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          enum:
> >> +            - adi,ad7380
> >> +            - adi,ad7381
> >> +            - adi,ad7386
> >> +            - adi,ad7387
> >> +            - adi,ad7388
> >> +            - adi,ad7389
> >> +    then:
> >> +      properties:
> >> +        spi-data-buses:
> >> +          maxItems: 2
> >> +
> >>  examples:
> >>    - |
> >>      #include <dt-bindings/interrupt-controller/irq.h>
> >> @@ -260,6 +280,7 @@ examples:
> >>              spi-cpol;
> >>              spi-cpha;
> >>              spi-max-frequency =3D <80000000>;
> >> +            spi-data-buses =3D <0>, <1>;
> >>
> >>              interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> >>              interrupt-parent =3D <&gpio0>;
> >> @@ -284,6 +305,7 @@ examples:
> >>              spi-cpol;
> >>              spi-cpha;
> >>              spi-max-frequency =3D <80000000>;
> >> +            spi-data-buses =3D <0>, <1>, <2>, <3>;
> >
> > An example that doesn't look like a 1 to 1 mapping would be better.
> > Otherwise, it still looks to me like you could just define the bus
> > width.
>
> I'm not sure we could do that on this chip since it doesn't have
> the possibility of more than one line per channel.

That's a property of the SPI controller though, right?

If the above controller had 4 lines per channel/serializer, then you could =
have:

spi-data-buses =3D <0>, <4>, <8>, <12>;

Rob

