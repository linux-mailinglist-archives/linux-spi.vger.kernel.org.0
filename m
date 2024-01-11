Return-Path: <linux-spi+bounces-410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F069A82A528
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jan 2024 01:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6895B283685
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jan 2024 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA78360;
	Thu, 11 Jan 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tNBLgFhX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4719C
	for <linux-spi@vger.kernel.org>; Thu, 11 Jan 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccbc328744so57421401fa.3
        for <linux-spi@vger.kernel.org>; Wed, 10 Jan 2024 16:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704931631; x=1705536431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqlDI/EsbVlvlAFWwYJOMeL8Cf3uO7bR44ZqtCnNXAU=;
        b=tNBLgFhXzgqb26XyfzARzAwDH7A4+CaxX8T8FBDBIA3GvBqhBbNcypbwl6ERKUiZJp
         r/tQvxnqiyvPpfUg3uR4t0adAyZF/qu76b8DUbqM7RmIuB8kxTFUi/5c67ZpoGremEpj
         6wE+9gCPFDBbXjjXGH8vAQJhj2sc7ljIpRyenjbO1lHEq+XiMO22gn6OKsbL1qjlm/RE
         6uoKc7gjvomORZggPtNoCPcDiJRZ66psXuUQPgfQMhZBdPAMgQC8u4Pfqq07BFMeBNRY
         kf5mwyZRq72NguvclrHoyeCjR1VWoswECw+WX+n0aqhiZ1Rz0x3hSlwN/uS3qejEZFgw
         YFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704931631; x=1705536431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqlDI/EsbVlvlAFWwYJOMeL8Cf3uO7bR44ZqtCnNXAU=;
        b=ke8TQFfvv2Lwep/phVfmCPzrzFrUZcT2QVkhQT6tS+mMOQHqk0fbipoUnCTthD6bYf
         rc0l3kcqpDYM59aYLWIpQsDd73b5u+D4JWHxqugLQv6faZTrwUaRHiZ5HiKuTLXR0D3b
         DHXNSeHZPJyqBxUk8zbsfut9RkkQgqCgakusKv67A8l1soLC6ok1Uhp+RWeQBO8l2em0
         8A6F09QxdS66xaVUGldOasOWkxU28H6+h7A+PbOheHrzOio4ia6DyRMTPqeGYElipGFc
         eZPQcnz0usivzaDxA2uCK82L59cYHmC167YsEDCoVYS1Gs9HLtDsNQXtjDzXXy/Cgs+h
         0y2Q==
X-Gm-Message-State: AOJu0YwKgBV0r12ZWTA0u7HxZkC9npi+JVjuH8Fefhbw4bOoBfT3dct+
	pG6tmtoBQ4uAMWnxxoDQo4P/EQm7Cb3N6oal5Ju9E5ND9Fxzqg==
X-Google-Smtp-Source: AGHT+IF0Mh9RnhzVsC6wF2uQpMFTKctMQ6eNiIrfvgn7uo6xcil5arq2Ah4/SpxNERpEy9uAqdy/mnWErErugXYS1XA=
X-Received: by 2002:a2e:9989:0:b0:2cd:8070:7f5a with SMTP id
 w9-20020a2e9989000000b002cd80707f5amr142642lji.17.1704931630450; Wed, 10 Jan
 2024 16:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com> <20240110231456.GB2854345-robh@kernel.org>
In-Reply-To: <20240110231456.GB2854345-robh@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 10 Jan 2024 18:06:59 -0600
Message-ID: <CAMknhBGwb+9Eo5ghG+Zk3BpMuMZfQxAAwGEGUMspcJzHzKWyXA@mail.gmail.com>
Subject: Re: [PATCH 04/13] spi: dt-bindings: adi,axi-spi-engine: add offload bindings
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:15=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jan 10, 2024 at 01:49:45PM -0600, David Lechner wrote:
> > The ADI AXI SPI Engine driver supports offloading SPI transfers to
> > hardware. This is essentially a feature that allows recording an
> > arbitrary sequence of SPI transfers and then playing them back with
> > no CPU intervention via a hardware trigger.
> >
> > This adds the bindings for this feature. Each SPI Engine instance
> > can have from 0 to 32 offload instances. Each offload instance has a
> > trigger input and a data stream output. As an example, this could be
> > used with an ADC SPI peripheral. In this case the trigger is connected
> > to a PWM/clock to determine the sampling rate for the ADC and the outpu=
t
> > stream is connected to a DMA channel to pipe the sample data to memory.
> >
> > SPI peripherals act as consumers of the offload instances. Typically,
> > one SPI peripheral will be connected to one offload instance. But to
> > make the bindings future-proof, the property is an array.
>
> Is there some sort of arbitration between multiple offload engines on
> the same chip select? If not, I don't see how it would work.

There is only one SPI engine driving the SPI controller, so if two
offloads are triggered at the same time, they will be executed
serially.

>
> I think this whole thing could be simplified down to just 3
> SPI controller properties: pwms, dmas, and adi,offload-cs-map. Each
> property is has entries equal the number of offload engines. The last
> one maps an offload engine to a SPI chip-select.

Offloads could be connected to virtually anything, not just pwms and
dmas, so making pwms and dmas controller properties doesn't seem right
to me. What if we have one that uses a gpio trigger or clock trigger?
Or what if we have one where the output goes to a DSP instead of DMA?
This is why I made offload@ nodes with a compatible property - to
describe what is actually connected to each offload instance since it
could be an unlimited range of different things.

>
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  .../spi/adi,axi-spi-engine-peripheral-props.yaml   | 24 +++++++++++
> >  .../bindings/spi/adi,axi-spi-engine.yaml           | 49 ++++++++++++++=
+++++++-
> >  .../bindings/spi/spi-peripheral-props.yaml         |  1 +
> >  3 files changed, 73 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-p=
eripheral-props.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-en=
gine-peripheral-props.yaml
> > new file mode 100644
> > index 000000000000..19b685fc3b39
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripher=
al-props.yaml
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/adi,axi-spi-engine-peripheral-p=
rops.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Peripheral properties for Analog Devices AXI SPI Engine Control=
ler
> > +
> > +maintainers:
> > +  - Michael Hennerich <Michael.Hennerich@analog.com>
> > +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> > +
> > +properties:
> > +  adi,offloads:
> > +    description:
> > +      List of AXI SPI Engine offload instances assigned to this periph=
eral.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    maxItems: 32
> > +    items:
> > +      items:
> > +        - minimum: 0
> > +          maximum: 31
>
> This defines a matrix. You want:
>
> minItems: 1
> maxItems: 32
> items:
>   maximum: 31
>
> (0 is already the min).

thanks

>
> > +
> > +additionalProperties: true
> > diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.y=
aml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> > index d48faa42d025..69f3261bab47 100644
> > --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> > +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> > @@ -21,6 +21,23 @@ maintainers:
> >  allOf:
> >    - $ref: /schemas/spi/spi-controller.yaml#
> >
> > +$defs:
> > +  offload:
> > +    description:
> > +      Describes the connections of the trigger input and the data outp=
ut stream
> > +      of one or more offload instances.
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          Index of the offload instance.
> > +        items:
> > +          - minimum: 0
> > +            maximum: 31
> > +
> > +    required:
> > +      - reg
> > +
> >  properties:
> >    compatible:
> >      const: adi,axi-spi-engine-1.00.a
> > @@ -41,6 +58,22 @@ properties:
> >        - const: s_axi_aclk
> >        - const: spi_clk
> >
> > +  offloads:
> > +    type: object
> > +    description: Zero or more offloads supported by the controller.
> > +
> > +    properties:
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^offload@[0-8a-f]+$":
> > +        type: object
> > +        $ref: '#/$defs/offload'
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -62,5 +95,19 @@ examples:
> >          #address-cells =3D <1>;
> >          #size-cells =3D <0>;
> >
> > -        /* SPI devices */
> > +        offloads {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            offload@0 {
> > +                compatible =3D "adi,example-offload";
>
> No fake examples please. This should give you a warning.

Ack.

FYI, unknown compatibles don't currently give a warning.

$ dt-validate --version
2023.12.dev6+gfb80ec4
$ make dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/spi/adi,axi-spi-engine.=
yaml
ARCH=3Darm KBUILD_OUTPUT=3D\$HOME/build-area/ad7944-mainline
make[1]: Entering directory
'/home/david/work/linux/OME/build-area/ad7944-mainline'
  DTEX    Documentation/devicetree/bindings/spi/adi,axi-spi-engine.example.=
dts
  DTC_CHK Documentation/devicetree/bindings/spi/adi,axi-spi-engine.example.=
dtb
make[1]: Leaving directory
'/home/david/work/linux/OME/build-area/ad7944-mainline'

>
> > +                reg =3D <0>;
> > +            };
> > +        };
> > +
> > +        adc@0 {
> > +            compatible =3D "adi,example-adc";
> > +            reg =3D <0>;
> > +            adi,offloads =3D <0>;
> > +        };
> >      };
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 1c8e71c18234..7beb5a3798a5 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -132,6 +132,7 @@ properties:
> >
> >  # The controller specific properties go here.
> >  allOf:
> > +  - $ref: adi,axi-spi-engine-peripheral-props.yaml#
> >    - $ref: arm,pl022-peripheral-props.yaml#
> >    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> >    - $ref: samsung,spi-peripheral-props.yaml#
> >
> > --
> > 2.43.0
> >

