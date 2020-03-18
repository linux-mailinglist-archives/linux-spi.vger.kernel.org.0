Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC318A78F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRWGM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 18:06:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42766 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWGM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 18:06:12 -0400
Received: by mail-io1-f68.google.com with SMTP id q128so156452iof.9;
        Wed, 18 Mar 2020 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Xze8cFopLDbFOqjih69kfqww1TXWirDlONQxIRQG5o=;
        b=X0kp7JxTcAonZw0wi97fo/ewp5sW1ET+bmpEO/6HKfNyJtzLAxbBR+2RQhSD8MgZuV
         NEQW7OrkNB0ZFM/WGbxIPR/F/OvLcvq46+7VUuDFwwhneo4xp0ayDFxHr0F32wDsWU4X
         GGtw3UnLOzaH79bPN+q84FhBigMdQl0Jcj2YXOLgc6LsoNkTMT5og6TwvZUSx2KvNgkm
         rokiKpY1CHxxo+OpTwUIvXMg6jFTXX53Aew6+I/b53dPMUEEwGsjQ3p63ZiTyfh/X87N
         VbO652wZDCD/1L3hiwt9ciey+NEALrj4UnoXJiAMUvFf3MLAShAb/zqblP68fEusIrvr
         YUiA==
X-Gm-Message-State: ANhLgQ30fGfHryHvy+7Cdy16hqd8RKHGT2TO+gcKLz7LZsV7HXsGQw8k
        oeqdB9wM0C69s5QhVFamFQ==
X-Google-Smtp-Source: ADFU+vtzA6Dpinbv6sJfxyaBb8R5TiTF03H79zFRAVOl5zpT6M6xKMFpKk0gVF2+B7B9QBZD7gxILw==
X-Received: by 2002:a5d:84d0:: with SMTP id z16mr5584547ior.88.1584569171213;
        Wed, 18 Mar 2020 15:06:11 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n23sm63773ild.34.2020.03.18.15.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:06:10 -0700 (PDT)
Received: (nullmailer pid 18697 invoked by uid 1000);
        Wed, 18 Mar 2020 22:06:07 -0000
Date:   Wed, 18 Mar 2020 16:06:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
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
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
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
        Sam Ravnborg <sam@ravnborg.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 07/36] dt-bindings: display: convert ilitek,ili9881c
 to DT Schema
Message-ID: <20200318220607.GA17902@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-8-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-8-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 15 Mar 2020 14:43:47 +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/ilitek,ili9881c.txt         | 20 --------
>  .../display/panel/ilitek,ili9881c.yaml        | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.example.dt.yaml: panel@0: 'power-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.example.dt.yaml: panel@0: 'power-supply' is a required property

See https://patchwork.ozlabs.org/patch/1255018
Please check and re-submit.
