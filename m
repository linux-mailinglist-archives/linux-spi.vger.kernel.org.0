Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D836185F39
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCOS4b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 14:56:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43942 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgCOS4b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 14:56:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so16128900ljp.10
        for <linux-spi@vger.kernel.org>; Sun, 15 Mar 2020 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3S0v5oR3bTCtw3b5Uz5rVvk64YK1h/rSLcltspTzzJc=;
        b=cKhTiwe8JLQgXFORz+fw8VRZAu9macKEjSEE1sB7WsCErjroARHh+wKst5Wo7Gwhf4
         0p5dOI3Ky/JtcXSm+cM9StCGahFcvwO0Lo6mTjY3l0QxKNN66nG5vL9exxBmHn6LE8Pd
         uU2G0nqvo02Lhasx0pForQUFgAvOaP5VoY5SHdTjI6dwpdSBFxgyozq4p9cg0fiwcU+F
         W8qa4XnFe0refvD8FeqdwdjO0MSOTpFPwVLVsqCLYhHlJ9xeLihIQ1kJ45zWid3eV3Ds
         cWiMIQ5ESqzXry3YWHmcRmXR6JtOOuKfw3HWefDaXrcVveKYLIjeczPuc7YXSfJMfzft
         fN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3S0v5oR3bTCtw3b5Uz5rVvk64YK1h/rSLcltspTzzJc=;
        b=puAht6+6vjwt3tsDEEkr20+CeVdWBGIgax0cmQUQ1paFLajTzZ4hM7OtKSbpUaZ79G
         xBY6ZSHZ7MIj+OfV10/CyvgzMagcNMZP+d3ACt4wy8oWqZvUvOxBL+VKa2S2xpQYZ/Zq
         OhEaYzH9snzk6wsXpvxYUAufldxcaz2pGVjSWhST+bzNqV/o3hudmX7ZjBza10T5PQwy
         IHmjNqD2uSp0xYB2vTY1/+hGXpNoez+q+sr5qprG5827b8pIC8pFGAljNdGzEnitoBis
         vBn4P/++6yrLs9FZbY/IcUsT9zTJW45t3toXvsS+Zp4aGLEUuohzQOczadwmsxCzKdVV
         Uw4A==
X-Gm-Message-State: ANhLgQ335etZjpeLIp4OK45ZjYAY8vKnzneaXLFfj7Zx4vaIybDhAC17
        yISIVTebyO8BuDR1CxPiltuII+BvYA85MqEAEz9zYw==
X-Google-Smtp-Source: ADFU+vu8FHCAUtRF0Yn3tqP8EsUWnhS9Glxv1rrGugkRmD6+x0k9o222/MFlQ/3JytyCUYbtCsS2+dDrEb9WqE/9ABM=
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr14032427ljo.125.1584298587802;
 Sun, 15 Mar 2020 11:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-22-sam@ravnborg.org>
In-Reply-To: <20200315134416.16527-22-sam@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 Mar 2020 19:56:15 +0100
Message-ID: <CACRpkdZF8fx2RtHKivAkn+aQiC8B27Lzwk69S0RS5QUcfj1uVw@mail.gmail.com>
Subject: Re: [PATCH v1 21/36] dt-bindings: display: convert samsung,s6d16d0 to
 DT Schema
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

On Sun, Mar 15, 2020 at 2:45 PM Sam Ravnborg <sam@ravnborg.org> wrote:

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
