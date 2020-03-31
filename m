Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567A8199CB5
	for <lists+linux-spi@lfdr.de>; Tue, 31 Mar 2020 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgCaRU2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Mar 2020 13:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgCaRU2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 31 Mar 2020 13:20:28 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9632321707;
        Tue, 31 Mar 2020 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585675227;
        bh=D7FWF2ylL+0NQ2FWuF8jpzvckwDCaUUfutqBPPPnLhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xm4DyzFlw4jGGUBlaafwQAckXswyUC7+wK8f9dZih9Eow6b2D8WjrmJf5p/Jld3fG
         gQB5Lnaki+PI71nuqEdqSxCB4N0N8kXzta0yDfuH9HdjW0bjHdxslO1Ws5cAcqT3op
         uQeXB1rPjS35avDSI+GNxcBACEkSyeQLXjnU25xY=
Received: by mail-qt1-f181.google.com with SMTP id z24so17804787qtu.4;
        Tue, 31 Mar 2020 10:20:27 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2obgHecaefchuOKsJ5SrybElLJdQaXltG6u81KOEZuoo6gv2Qa
        gNvvfPR4oCPKMbTXIDCH5Nc6M7WWTLPh/a9CJQ==
X-Google-Smtp-Source: ADFU+vuIDLlP6mJJzdijDIsPAvdYaGjDtb9aCWKF5WJKEAR+/umG5DoIAzKXfoqzc8KIaBO8hshbu4VG7fPqaOkBerA=
X-Received: by 2002:aed:3461:: with SMTP id w88mr6324133qtd.143.1585675226482;
 Tue, 31 Mar 2020 10:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-33-sam@ravnborg.org>
 <20200319030734.GH29911@bogus> <20200329190352.GA21479@ravnborg.org>
In-Reply-To: <20200329190352.GA21479@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Mar 2020 11:20:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGpCBohddU+h3366rzGVw6mgn5H9YMqq-MF4Ka=mVkzw@mail.gmail.com>
Message-ID: <CAL_JsqJGpCBohddU+h3366rzGVw6mgn5H9YMqq-MF4Ka=mVkzw@mail.gmail.com>
Subject: Re: [PATCH v1 32/36] dt-bindings: display: convert sharp,ls037v7dw01
 to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 29, 2020 at 1:04 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob.
>
> > > +
> > > +  mode-gpios:
> > > +    description: |
> > > +      GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf
> >
> > 3 or...
> >
> > > +      change configuration between QVGA and VGA mode and the
> > > +      scan direction. As these pins can be also configured
> > > +      with external pulls, all the GPIOs are considered
> > > +      optional with holes in the array.
> >
> > minItems: 3
> > maxItems: 5
>
> This binding can specify up to three GPIOs like this:

So it should be:

minItems: 1
maxItems: 3

> > > +        mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
> > > +                      &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
> > > +                      &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */
>
> They are in the linux kernel driver accessed like this:
>
>     devm_gpiod_get_index(&pdev->dev, "mode", 2, GPIOD_OUT_LOW);
>
> The following is OK in the DT file:
>
>     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
>
>     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
>                   &gpio1 2 GPIO_ACTIVE_HIGH>;
>
>     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH
>                   &gpio1 2 GPIO_ACTIVE_HIGH
>                   &gpio1 3 GPIO_ACTIVE_HIGH>;

With the above, the 2nd 2 should fail...

> But the following is not OK:
>     mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>, <&gpio1 2 GPIO_ACTIVE_HIGH>;

And this should pass. We want phandle+arg type properties to be
bracketed like this.

If that's not working, then it's a bug in the tooling. Please confirm
and I'll investigate.

Rob
