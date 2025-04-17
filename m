Return-Path: <linux-spi+bounces-7631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B3CA91586
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427BA3BF669
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10D21ABB3;
	Thu, 17 Apr 2025 07:43:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBB1E1DEB;
	Thu, 17 Apr 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875825; cv=none; b=SwjoKngO9IbqO+Zb6beGg+9j4WGoYRz389zm+b9jGELq0KlNSCpOrQvyW+RwCfHCZm8BtCIiEP4IjqDPcLjB8AcrnxVYW4MdPVxDjPkW6nBA9DgXgFOkhRA8hnFbNsgCLq8HA6vDfHfRbIswfOcM2rLnXbAKGTCCw3n8ad5y9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875825; c=relaxed/simple;
	bh=Bgzo4iWGFalQmXgeWcFdRlUJPi80Z+hTZ60GVUaVKoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG4i2XccYOkfHxBkCrH1SNYdlYuTs6feFhIXN67ZCBzj6Y7P7w2rkQReb8etcGDRt6gFPYs+T6ee4twDIhWoMbwi0uxgsgrWag9mFNU7Hnt6GDXSGVDQ/KP6zMNF1BNNgcPvzcFZm9cB7nzF8m3M5O7JwkMw7I8RXQPp5QE/4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-524038ba657so583127e0c.0;
        Thu, 17 Apr 2025 00:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744875821; x=1745480621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uANl5Q11SWDJeQns1Rq9+5b2CgEJ0DOnZDyZ8/s4n7I=;
        b=lqaW+wMTXNqGRz8lLti1X7bGmNiaHdq+elMwPZ+jPwJqDjsi8RPoDIzYxXMVL59yXs
         8jOO77PJauxtKlr7K3YzKrf/EgSXt3XONixfT0ivVmaFSM9AOCUW6pKoAE7ANB9gwNJw
         lkiQCEHKb2RMzzYVxeOb/cKYvOdreo761wwZyPIAaBs9eNNX+yr6lmhgOcxor17h4+x8
         2ep+QFmJ6VuruW7mXOo7AZ+HsyDw3kPVbxbZJQ8AgKB5FIIPCQUphhiRc41tX4ZSpSG7
         Q+RueyL4U753ebKE/wS/aJSKLm0TmRWjbWfwcrQrte3B/V5PR4ScaDLduK2WjqXrHUuj
         0kZw==
X-Forwarded-Encrypted: i=1; AJvYcCUb8a585IYEBKYLuLAZXmZU7fnzY3K1aSOC4Oiay4vG3XVW0B+M16OH8GwC0OqkYHNd3L82cRvnSQLZd5smfDXn4SU=@vger.kernel.org, AJvYcCV7uQyBzM4msNeQKUow3HcD+n7c0TKafG028Z75NF4MNz7wLIfFwRpP6Htwd6o6v4SKw2JAQQOx6I+5@vger.kernel.org, AJvYcCWVIlAOMqRNTnKCTXR0PD1UOLIyBey2qFmyX0y5Pb6ympDc6serK9OS4S0UUF/iwEHP4pkOSVR6uPKZxa8=@vger.kernel.org, AJvYcCXUknV0qtCy3zgvow+BvCpfrruNW1XGbxcjA9jzOhUtdN3TrowmFeyhty5KB3uN3RGufnrK5mXZflZV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTo9OIEFjfBNwZSLyKSgygfdT88gcbhnPUCwpKRcwdPGT7O9b6
	7mx4cqZtcaHqAlg0kWp0z5UwFNmovI3322f8/TMmp8/HqqBxCn/HCwkJGaGQ
X-Gm-Gg: ASbGncuNsC3b5fq+I1gR4OCM54gj16e1eRHblmNMT9P1LHb6GiqBOOxvOBdLIG5a5vD
	SdbBQ2sRPaeiEf9/FBPbvBtBF6S80UPwHTK9QRUb5JcpndnMJZsiX/VMRS9BuOExK7+BQ0fECP2
	ibA6/OmfEwLcvaNsAOWwWbxFMLoTMrd1Us6Gjxv3IVFv9BIT6VZJJhp1l/usYyRDUbFGzzQS9DQ
	0oRX9Dwr2j0s7X3w6lkHXbBqS+s2dOEJpb1k5GZuZAbTw0crSVq+ALN5lSYbJR+y1+prmwI/dFZ
	icLdmhK71SiBdxYmxsvoyPtZHdK4zg6Mm20iRuqsl57mednfuTlgwY0O6aY3bYRwrzOTLhj4HKY
	trnE=
X-Google-Smtp-Source: AGHT+IGcljcGH8kYKp2UyBRjUwL3ZGZ18rs7ubHaAyllCJmhHKAOiw6ZyMDeQXey3Geq7xDQ3ZmmEQ==
X-Received: by 2002:a05:6122:8c7:b0:527:67d9:100d with SMTP id 71dfb90a1353d-5291806c720mr734277e0c.4.1744875821531;
        Thu, 17 Apr 2025 00:43:41 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd7b25csm3495828e0c.16.2025.04.17.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:43:41 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-875b8807011so544211241.0;
        Thu, 17 Apr 2025 00:43:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVY7bxjSObQwdL3Xqg+SBImBVTxd+GHUDF6LWpYo9HAUIaYGGBJUyKu2cIinDgRz1oKxFGmzfjjNnOdKFE3F0EdOWI=@vger.kernel.org, AJvYcCW8ATnt8R0pBbR9AF5x+479l5zeoOI4CBrBDuZJliaGH4jqrRA6Z9fP/kWnjxmhhWRbAJksT/coEvmH@vger.kernel.org, AJvYcCWJIVdZ1tgN4FA00w8nmpbfMvPzdAVjs7Rgvke/adLOWzEWYidRQ/RZKLIP1rdafSE6VgURxr3nSsi/@vger.kernel.org, AJvYcCX8njToacmITDUsSGK4F9zmEttvV3I4yATtUIXIEavrE2q3RsJG3cVP7tA7bdVymbevQyKIeUGhg+cqDu8=@vger.kernel.org
X-Received: by 2002:a05:6102:3912:b0:4c4:ebb1:4f6d with SMTP id
 ada2fe7eead31-4cb64d4d131mr1210538137.11.1744875820807; Thu, 17 Apr 2025
 00:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
 <87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
 <87msch81yh.wl-kuninori.morimoto.gx@renesas.com> <87plhb4qbb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87plhb4qbb.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Apr 2025 09:43:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKBdTyA0fnfpQT6iad3S7+z3dJkh4UnS14miqgFcUhuA@mail.gmail.com>
X-Gm-Features: ATxdqUF2bZHe-ozMJQDNYeXQsVz3rsBcK0YuvI5xGINR3hvEjJy_EjuKdnkB1zE
Message-ID: <CAMuHMdUKBdTyA0fnfpQT6iad3S7+z3dJkh4UnS14miqgFcUhuA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S
 Sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 17 Apr 2025 at 01:52, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > > +  # "MSIOF-SPI" specific
> > > > +  - if:
> > > > +      properties:
> > > > +        $nodename:
> > > > +          pattern: '^spi@'
> > >
> > > This condition does not match what you wrote in the cover letter:
> > > the controller is used in I2S mode when a port(s) subnode is present,
> > > and in SPI mode when no port(s) subnode is present.
> > >
> > > > +    then:
> > > > +      allOf:
> > > > +        - $ref: spi-controller.yaml#
> > >
> > > Documentation/devicetree/bindings/spi/spi-controller.yaml indeed
> > > requires that the node-name matches "^spi(@.*|-([0-9]|[1-9][0-9]+))?$".
> > > The controller's node is located in the SoC-specific .dtsi, where its
> > > intended use case is not yet known, and its node name cannot easily be
> > > overridden in the board .dts that specifies the use case.  Hence the
> > > node name must always be "spi" (and cannot be e.g. "serial-engine").
> > > Let's hope there is no other use case for MSIOF that requires using
> > > a different node name...
>
> Hmm...
>
> Now, MSIOF node has "spi@xxxx".
> SoC file indicates MSIOF-SPI as default, so it has below lines
>
>         --- SoC file ----
>         msiof1: spi@xxxx {
>                 ...
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 ...
>         };
>
> These are not needed for MSIOF-I2S, so removes these
>
>         --- Board file ----
>         &msiof1 {
>                 ...
>                 /delete-property/#address-cells;
>                 /delete-property/#size-cells;
>                 ...
>         };
>
> Now, my dt-bindings doesn't load spi-controller.yaml (as sample), but I got
>
>         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #address-cells for SPI bus
>           also defined at [Board file]
>         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #size-cells for SPI bus
>           also defined at [Board file]
>
> MSIOF dt-bindings doesn't load spi-controller.yaml, but why I got "spi_bus_bridge"
> warning ?? I wonder dt compiler (?) automatically check "spi" node ?
> I have tryed some code, my expectation seems correct (In case of node name was "spi@xxx",
> I got many SPI related warnings even though I didn't load spi-controller).

These come from dtc, which makes its own assumptions:

    $ git grep spi_bus_bridge
    scripts/dtc/checks.c:static void check_spi_bus_bridge(struct check
*c, struct dt_info *dti, struct node *node)
    scripts/dtc/checks.c:WARNING(spi_bus_bridge, check_spi_bus_bridge,
NULL, &addr_size_cells);
    scripts/dtc/checks.c:WARNING(spi_bus_reg, check_spi_bus_reg, NULL,
&reg_format, &spi_bus_bridge);
    scripts/dtc/checks.c:   &spi_bus_bridge,

Perhaps we do need to extend the use of role-specifying properties
like "interrupt-controller" (in Device Tree Specification v0.4 and in
dt-schema) and the few others in Documentation/devicetree/bindings:

    gpio-controller
    mctp-controller
    msi-controller
    system-power-controller

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

