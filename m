Return-Path: <linux-spi+bounces-10931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33625C23F89
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 10:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EF818991AD
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE5328624;
	Fri, 31 Oct 2025 08:58:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757942192F5
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901100; cv=none; b=PTvyCI7ed3yoU6vmr9biMDOY3DuKhsOxkBoY0osd8rTpiAmP9oqG/MokVE2PIeU64oLSaYxVsBGyU5lYYe1T2Jtw+ngQGYIMkU/HenSqUhg0XbIehy7JVTkqOGom2GAcdJJmf7Kqm7nIB5WH7XE4z9nIWSrc2bXydJq5gm7czQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901100; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrxJCKkRWmgxUV2jlf+3vnTvBvNEjH4xyBpOUvBuTLwEB3T4EweQaQ6Z2ju0hb7sERHpCRNEFHA2B6XRFUpxy2IDlgjH+SjJIhMpiF1Hc8mKZ+BMmWWtgcfUcklUUBWjlcSnchcMOwrKAbpOdeLACx6CTFg2v2FnR4Q7LM2HbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-880255e7e4aso13974556d6.0
        for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 01:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901097; x=1762505897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=palVuobhSheH+GE7UWeBtK9Y9nBXudzev8YFNuDOiL8SX5bsNp7h+LWE4+u3f8zdi0
         /Up0mBlz5HW6wZm97zmXU1X10lc2pJKSkkuJl4FFZCjkjlRJIu1T20cu0OgM9laT7L/g
         rJjHY3PKV7ul28ta7wRit1Nle1akPZR6kG1LrmGivmij6boPlJSCBkNp8u5JcKiEHYsN
         UXFNAMUsdORm2YlzxD30Y20uB6axV8NsMFrU8e70OZlfLDnoDEXDLE5WgrohCtqvXFJc
         8NfKfaAmw4dpstkYs1E6L4HfPGkqiM4prVRcilzfHmLNy28Q5P72mlkOwRLjsqeQnSc0
         3vdw==
X-Forwarded-Encrypted: i=1; AJvYcCV8RYYLKYkwfwJovy+XTQ2yVkqUodzUvvAYNoCNgAn3hrCyvcrUO8wwmuGsV7m+l8TLnJI+ChhItJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd14ASQxKvpH84g1rHLveHbwKgZKIY8mTEdd+gaa5Dz8+3gubQ
	AW+lcgqTVaHHkxQW2DirbrlK0HnkUF8APYxx6crHVpMCrGxLWgVL8dK2WGoi/hk6
X-Gm-Gg: ASbGncv8uBKCs7WwopgC7Q88UTRO73jlZAA87Crt2afeFwLUMdgfBb+jYdoml8/yLie
	F83/8s2fITl6uF9y5iqliMQQqvi6sepC9OwndFbrkmdzO6hdUtVBchHpah3Td1uQfH/Y4Nh9MnL
	qDQrfHer4SLfiszHr+FQ6znBMym0flOIYLb9MW18zZritWAvzhVgPQ7YUNnbtH8lVhifC7WWpOE
	IS6vwdcYSe071xprBcazb+TSbovwrLqx2q2/QvDyldDHC76XbyfOuVPa61RZe+ELcHe3phyMPga
	W96jz10Dw2tRrvnt84AHsoCzowvVm0xjTNOjpGz13lHrKqr2YOnhEPU0830Gq1manVmC8EJAX/Y
	QPoooAwF08nJ7SfLNmEHKl25nWKFLD66I9FV8NJazHzbXhml0nWa4Fy1/hfrRyVv/WTCj2z2hwI
	sMJoJNzvxusU0fUR1faKw0R8/eea+ziHQbWv2QokF9HSjNAHPTDAJg
X-Google-Smtp-Source: AGHT+IEZXw+CDHBi2lL94htMwmhq8cKrW0UH6LBlMUTZrDx2sl4xDHOriLg5EPS3pThwQIxqe45SbQ==
X-Received: by 2002:ad4:5dcc:0:b0:7dd:b2b5:9fc5 with SMTP id 6a1803df08f44-8802f2d6b40mr28844566d6.16.1761901096903;
        Fri, 31 Oct 2025 01:58:16 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880360602c3sm8168016d6.19.2025.10.31.01.58.16
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:58:16 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88f2b29b651so202209885a.0
        for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 01:58:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHI4DwLBXE3RDt3ULpU2WHKii4efL16X0+T3kM1FVvtyyZnkLkkAENl97sUoE/62fduBzD5VbEyxY=@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

