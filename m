Return-Path: <linux-spi+bounces-7201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9415A67810
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A3C1773EC
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2C20E339;
	Tue, 18 Mar 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUgAWKSo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075828FD;
	Tue, 18 Mar 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312252; cv=none; b=Zm+LDQYnZJoj1VeUSI0OfKRgfyPlSmDE5Byo9y/k8puJhdudcTfXhREWXbvIVDwlsmtb3PsZPYR9n+1NQBFKnlogFVOta7G9Eare/QpMxwqQidvUZ34ajglH3/k/ptfHsXwXCdJDPIE4HmjxxIWlkWOkNYHnyPSSol02tz65Iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312252; c=relaxed/simple;
	bh=2FADrrGOuhJNxGZb/t5P0+jQhpdMvnVntdR+ZZPNqr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgp91XOAD6vfCPr4C10vkdl4MMrS7SsetqLFdxDnB6tNLE57vHMfcSgufWm0abT3KfQ2GUzi7TOwehvZhz1+QaONKoNFGXFMcqq0vnUOaGvmn9TbU/6bZ5lAGY+Bjyg0vRnxXTjHHomrQMLuf83n+BOkLJ4zt2siuK6WUbbWQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUgAWKSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FEBC4CEF3;
	Tue, 18 Mar 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312252;
	bh=2FADrrGOuhJNxGZb/t5P0+jQhpdMvnVntdR+ZZPNqr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUgAWKSoR+zd3nYx9HF24H40SI1zpeqK0K1rX8zyORhsDGhrNVKiAW1ZIfxzTYVYd
	 sgpk3sQsWZIQcLytPAL9WDHLXxuhOeZQx8BVbNdQJGFMxiP+Sy8CEU0xznjQrQDdql
	 b8KUlAv7dr3pAq0ud7VhEwIay9QKdIWuAIkCeYvFIFN+JQgRFzn2mebcXcgGN5PkSJ
	 bzoThTVPrUWeyiGQ39LZjEgk4DMqfleosGaYsdKZWfOr5HI0tdJU8S9ZaU+sD8KMkC
	 Z561p0zg6f53uFF7UFY4NEn6GRjVbO2kIsn/bF9K/x1DRSMkwoCZjwQ9PErFPj2Dlm
	 RZGwdNBy6t8gw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so10010829a12.1;
        Tue, 18 Mar 2025 08:37:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpZFsi7/mgWMi7eH1mvq6aif48r2ke4oRdmAQvDnmVQ7alekaqFap0XQZ4fIUJAcR3ce0y+4u0LkiPq0Se@vger.kernel.org, AJvYcCVNXXDx8GXe7usoJto+sdMEJSmKjmbtge4Wt986if+VYGUv9MLTEL37v4yOvaRapL/VdZbJLseZjVfA@vger.kernel.org, AJvYcCWPN9N+eU1RvFlRGM7slbyomL3HI4OuzVlbujGNlcrA4dWYZEeMVgkgQPnsL/PdEJx2L6KYzIlGPyEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tTBdTWnQFrLRj7lmXlCAP/+H2o668AIvv8HfxQpVf6eUuVwl
	wQ8bZsk0neMx+B8lIljBhgwqJTIN9zXM0KE60THwvHLwQHXo2UG/bH5mQcAR98nmtD0KaP3Ozmn
	3sZBPoArXXULUF63JFkKnKy8ftQ==
X-Google-Smtp-Source: AGHT+IFxNikh/zPyi87/yPKISRD75uRN3LN7OEe83oBU+Jm0RfN/NRF8Jwu1275PkN7yYWLFFVO4RlTc7PstjVcm0CI=
X-Received: by 2002:a05:6402:84d:b0:5e4:9348:72d4 with SMTP id
 4fb4d7f45d1cf-5e8a09faa0bmr16499578a12.24.1742312250511; Tue, 18 Mar 2025
 08:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
 <20250226-initial_display-v2-3-23fafa130817@gocontroll.com>
 <20250314210652.GA2300828-robh@kernel.org> <PA4PR04MB7630094413C8E1F3D715EE23C5DD2@PA4PR04MB7630.eurprd04.prod.outlook.com>
 <20250317-massive-calm-bat-43ff61@krzk-bin> <PA4PR04MB7630DA5DF63C18530B86AB59C5DF2@PA4PR04MB7630.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB7630DA5DF63C18530B86AB59C5DF2@PA4PR04MB7630.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Mar 2025 10:37:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiWyMMqZwdvbZp8pebqDYrA7MwoD3AGAST6iixXzU0LQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqdfYH-dOSKs1kb8D0C16udXHv06QqBb0LECvEA4U-xF3d7uL0jX9WyoUw
Message-ID: <CAL_JsqKiWyMMqZwdvbZp8pebqDYrA7MwoD3AGAST6iixXzU0LQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: connector: Add the GOcontroll
 Moduline module slot bindings
To: "Maud Spierings | GOcontroll" <maudspierings@gocontroll.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 5:42=E2=80=AFAM Maud Spierings | GOcontroll
<maudspierings@gocontroll.com> wrote:
>
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Monday, March 17, 2025 11:34 AM
>
> >On Sat, Mar 15, 2025 at 07:32:28AM +0000, Maud Spierings | GOcontroll wr=
ote:
> >> >> +required:
> >> >> +  - compatible
> >> >> +  - reg
> >> >> +  - reset-gpios
> >> >> +  - interrupts
> >> >> +  - sync-gpios
> >> >> +  - i2c-bus
> >> >> +  - slot-number
> >> >> +
> >> >> +additionalProperties: false
> >> >> +
> >> >> +examples:
> >> >> +  - |
> >> >> +    #include <dt-bindings/gpio/gpio.h>
> >> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> >> +
> >> >> +    spi {
> >> >> +        #address-cells =3D <1>;
> >> >> +        #size-cells =3D <0>;
> >> >> +
> >> >> +        connector@0 {
> >> >
> >> >I find this being a SPI device a bit strange. Is there a defined SPI
> >> >device that every slot is going to have? Or the connector has SPI
> >> >interface and *anything* could be attached on it?
> >>
> >> So a module slot is like a pcie slot, it can be occupied or not, and w=
hen
> >
> >But which buses...
>
> I don't think I am fully understanding what you are asking of me. The
> module will always be an spi device, that is the main communication bus.

Okay, that clears up whether it should be a SPI device or not, and I
think it should as SPI is always used. The 2nd question is what does
"gocontroll,moduline-module-slot" mean exactly. Normally, the
compatible implies how you interact with the device (or what is the
programming model). For SPI, that's what do the SPI transactions look
like to begin with. Does the slot spec define that such that every
module is the same? Then when it comes to different module types, are
those discoverable (e.g. PCI has vendor and device ID) or will you
need "compatible" to make that distinction?

Rob

