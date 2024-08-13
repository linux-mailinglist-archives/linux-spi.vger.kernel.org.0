Return-Path: <linux-spi+bounces-4173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE2950777
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C728B249D7
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3519D082;
	Tue, 13 Aug 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOI8fe0K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084619D076;
	Tue, 13 Aug 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559082; cv=none; b=hdrWcark/Gh56uXzq1nhz2Bkx9lSI8yjlS7xHWLlajr2Bo3jFiRaVwaLzj89PXJCfPQKCCfR8IuxbqIW2PHBkbVA24sBUhFt/OHfpHMUbEKyCwZu+2ARhHH1Xyg53HFBKn2kj4JTyuij230/H1PEB09i2XkZxHI+Qn1hM29N2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559082; c=relaxed/simple;
	bh=Cf5nrxOfWp3lPGd3cNKVX3NV1/THCONrMkgor6cC/74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/JdkFZffZKMhXLMopWAG0eyf89IwmZnU86F7k9j8QUGovSSbzFOsXfk6e2p8WJwyNIfCEVU3RHvV+i1kM69fFZiROvgzePVytu+DyhHe2jHvDGhcIVo0xQN5nB18EsCXfDZUuxo6N483CzfOtcZH11gGWKEDK0rh33EIVPybaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOI8fe0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B52C4AF0B;
	Tue, 13 Aug 2024 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559082;
	bh=Cf5nrxOfWp3lPGd3cNKVX3NV1/THCONrMkgor6cC/74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOI8fe0K1UKV7J4nHg1SoV2ZzWhU1nOSzpzzyq8XX3UaH/oujjT+zj8qtyewZTVlo
	 Io3cfLgrEWDUOu1CeD7i9sshCZr9OjACJYSQuJ+xVB0n3O41mbTr4fVoWDBszwiql1
	 Yneol9ZWfKGiJqNEweht/kiaT/Tr2bM26CKc9e8np9TVIOaYNMDZkPIsQLYch0U8wb
	 +QBU+HJHQfzMtACqE7yixFcOyHmMVPks/1eC7Oz2DwSfjtnh5us4JkDL86Ohsqzw3i
	 uc30OTkWlYESufLgZDVQV7bvICnQ9jqKaKPsuuTYzBi0qBANsIOra+xLNWJ6y7ghtr
	 NPTHhvloxFonA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so71175591fa.0;
        Tue, 13 Aug 2024 07:24:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgjUM9sA+cCcyLVXDDl9Q+nX2M/0C6mfwVFg59I+UOulf3gQJ0IRBo84suCYnzU4E5G/3HLXc97FshfnilWyhBcjwQnFYKblEMI0LRusbvsUxQNYPCEdk71GTYPTDOa1V8BCnlXGT62aC9Nzu/QBTHp3czDqBr8CiWf6PU5KSGCpR5ZQ==
X-Gm-Message-State: AOJu0YzO10apMfNTeBaubAT4WqbUf/fkK13qtP1pX9CnDSSrR4E9aq36
	lCAa6sVnY5TlYBoNm39nIco1uXLIlbg7nauiRIa43EN9mVic9GwowcKEX1nGVYwH0A9tLGNZKof
	yGJzvrvGDzOlKQpv4AGksHTeKtg==
X-Google-Smtp-Source: AGHT+IGEtxJXAokVeHylGyvLbWPxf9oslPNLlY5/p+Gnfc4iXdhDKRm8W9C2iFoUYgmtU70ocpuAKUExkf0GIUkUUYA=
X-Received: by 2002:a2e:b6c7:0:b0:2ef:29cd:3183 with SMTP id
 38308e7fff4ca-2f2b727737bmr24740261fa.48.1723559080584; Tue, 13 Aug 2024
 07:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812203004.3831481-1-Frank.Li@nxp.com>
In-Reply-To: <20240812203004.3831481-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Aug 2024 08:24:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2HAeS5BWsmJRzeJb1b7nXgB92KsGe87tT5-LeYmaeyQ@mail.gmail.com>
Message-ID: <CAL_JsqL2HAeS5BWsmJRzeJb1b7nXgB92KsGe87tT5-LeYmaeyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:30=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Convert binding doc spi-sc18is602.txt (I2C to SPI bridge) to yaml.
>
> Additional change:
> - ref spi-controller.yaml
>
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
> /soc/i2c@2000000/i2c-mux@77/i2c@7/i2c-mux@75/i2c@0/spi@28: failed to matc=
h any schema with compatible: ['nxp,sc18is602b']
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/spi/nxp,sc18is.yaml   | 52 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-sc18is602.txt | 23 --------
>  2 files changed, 52 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sc18is602.t=
xt
>
> diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml b/Docu=
mentation/devicetree/bindings/spi/nxp,sc18is.yaml
> new file mode 100644
> index 0000000000000..8a5d45d976984
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nxp,sc18is.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SC18IS602/SCIS603 I2C to SPI bridge

SCIS603 or SC18IS603?

> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sc18is602
> +      - nxp,sc18is602b
> +      - nxp,sc18is603
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 7372000
> +    description:
> +      external oscillator clock frequency. If not specified, the SC18IS6=
02
> +      default frequency (7372000) will be used.

Drop prose that the schema says already.

With those fixes,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> The clock-frequency
> +      property is relevant and needed only if the chip has an external
> +      oscillator (SC18IS603).
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        spi@28 {
> +            compatible =3D "nxp,sc18is603";
> +            reg =3D <0x28>;
> +            clock-frequency =3D <14744000>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt b/Do=
cumentation/devicetree/bindings/spi/spi-sc18is602.txt
> deleted file mode 100644
> index 02f9033270a24..0000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -NXP SC18IS602/SCIS603
> -
> -Required properties:
> -       - compatible : Should be one of
> -               "nxp,sc18is602"
> -               "nxp,sc18is602b"
> -               "nxp,sc18is603"
> -       - reg: I2C bus address
> -
> -Optional properties:
> -       - clock-frequency : external oscillator clock frequency. If not
> -         specified, the SC18IS602 default frequency (7372000) will be us=
ed.
> -
> -The clock-frequency property is relevant and needed only if the chip has=
 an
> -external oscillator (SC18IS603).
> -
> -Example:
> -
> -       sc18is603@28 {
> -               compatible =3D "nxp,sc18is603";
> -               reg =3D <0x28>;
> -               clock-frequency =3D <14744000>;
> -       }
> --
> 2.34.1
>

