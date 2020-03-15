Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B3185E76
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgCOQZG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 12:25:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41196 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgCOQZG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 12:25:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id o10so15853806ljc.8
        for <linux-spi@vger.kernel.org>; Sun, 15 Mar 2020 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhIY9OOZnxZOPAI5wEukr5F3CCpgPoGyTg20FwGK9Tw=;
        b=p3BYWIc86jjcI6oonq+LpWal5UzLF4chdphbUkZtArCrHw3fHc0r6fLgOPpwW0F8hR
         gP4Wfu+rzzPF0TiSEeQmNwk7YZek2PC/56HeWXaU9kxZFmJvQJWL48w/6bXJGpQpscx5
         mQX9XtRjy9J6ILCe4VTqiwLdoLeZcGSF3Iysfgputl8Zcpgi6nfthRWP8WGtplaOHCLV
         CNMRfxnmU/gE4fUM38FDIXmAIE3eXmYiOp66YfTTZUEbCG7yNMmznET0H3BKDguuKLBT
         R/j398gdVF4udQkU44i1ljFDNFJWmHisvPXTUXOtNS5ggRoJNJLfpoNBC6m0Wd1NyfIy
         bWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhIY9OOZnxZOPAI5wEukr5F3CCpgPoGyTg20FwGK9Tw=;
        b=ZtBSMmJDeaApey+kMEMwPxLsJALVZmic7nZ0LY4a5mp+LJPb7/FaKO9k+8bmny5ARS
         67kxjvY2jv/rb8wQbckCjMcG7hrqxmp3kSWjGHH/Y+lxroO0CLpn0xJbxDPYbQCDQlrx
         bQrE6n5P41Ggb12T/pXksKWZz8U2+kWi+8F5VPKBU08NpQgYnJVbrZwe3z8b54WHsGMM
         n27QabcnRCYQTdGTF+oeQJJhKg2nLr4fQSNwFNnjmNKdEp9oNe5/Pj0+2LyugjjnWkVE
         /7J6xul6w7wlULORDu/YhH4PDnYdqiO/86PR65kwp7dQPWcgFYWbZ3tbE0sLY9q85ITT
         bRNA==
X-Gm-Message-State: ANhLgQ3RjFun4R2tTXGL1FIOI4gZH3NlVxFg6XuGcVFE8T5z3+nwI3mF
        lD+41HrnOTMdDRM8IfhtXFhF4tRSAUrEjRe04Ypoag==
X-Google-Smtp-Source: ADFU+vvfAn91cdIuck/jsg/zit0I3le1KpoewT5X+4/992npdZo2Qy9O+m/M8W1xq/3HAyQmj+l2pjjAwAxIq9vsk0M=
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr12246494lji.258.1584289503947;
 Sun, 15 Mar 2020 09:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-3-sam@ravnborg.org>
In-Reply-To: <20200315134416.16527-3-sam@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 Mar 2020 17:24:52 +0100
Message-ID: <CACRpkdZszEA+-KVrgALx3NdtVi86ExnEHB3p0EwxMeCCvHxD5A@mail.gmail.com>
Subject: Re: [PATCH v1 02/36] dt-bindings: spi: support non-spi bindings as
 SPI slaves
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Sun, Mar 15, 2020 at 2:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:

> Independent bindings can be SPI slaves which for example is
> the case for several panel bindings.
>
> Move SPI slave properties to spi-slave.yaml so the independent
> SPI slave bindings can include spi-slave.yaml rather than
> duplicating the properties.

To me it seems like you are creating the common SPI slave
bindings? Maybe the commit message should be about that.

> +  reg:
> +    minimum: 0
> +    maximum: 256

255? Or am I wrong?

Apart from that it looks good to me.

Yours,
Linus Walleij
