Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCF18AAE3
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 03:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCSC4L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 22:56:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36113 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSC4K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 22:56:10 -0400
Received: by mail-io1-f68.google.com with SMTP id d15so757122iog.3;
        Wed, 18 Mar 2020 19:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPkja5C25VerS45bxtKqwCdIAsJE8Q53wltiW2Ahl8s=;
        b=CtUp8gxqC3+DRYKVIUSzc61WqPWnT+Or93Qwn0LqRkDsYddAgqQ1oi8lOV+t/YlRf6
         P09L9fnXaGnWzeuUicqc87IVmmk8pSPO8kixNNvsTDWrpa60+YgJ1OF/q6QDaxBdjdNE
         WeZiorTIxBeUHYHjXEtjAIoo8/FKfVbq73sxERtmErtoO6ZxeTKBhEKufnvuP1XWE0ea
         w2kMDQefVOw/O0sD/uQWmIFcN1A/N3i2VaaePys27a4tdHV8eIBaUhI0ejSUv/KxLgQZ
         8lyrf/BwVX/EKiyTwVEhh0XT9vh/nuGqPJoAXhdbfn2mE62K1Oe0C1gqh0M2LQR1dgme
         soGw==
X-Gm-Message-State: ANhLgQ1Rd5RN7/xaLvHN2J6djtTTysw7AEZrYNwAyzmhTRX1ZReT2TnO
        jmfJLvwgwn4qF9D/AexWbA==
X-Google-Smtp-Source: ADFU+vu8Zs4sikgQ9qOl1rtXnWnxbh11VSlCCgp2VF3kXoJHSN0x4GdzUn913Ju/MZHC3HITrrVJBw==
X-Received: by 2002:a02:9608:: with SMTP id c8mr1114138jai.68.1584586566760;
        Wed, 18 Mar 2020 19:56:06 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q17sm314741ilm.85.2020.03.18.19.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 19:56:06 -0700 (PDT)
Received: (nullmailer pid 22642 invoked by uid 1000);
        Thu, 19 Mar 2020 02:56:01 -0000
Date:   Wed, 18 Mar 2020 20:56:01 -0600
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
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 16/36] dt-bindings: display: convert lg,lg4573 to DT
 Schema
Message-ID: <20200319025601.GD29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-17-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-17-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:56PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/display/panel/lg,lg4573.txt      | 19 ---------
>  .../bindings/display/panel/lg,lg4573.yaml     | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt b/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
> deleted file mode 100644
> index 824441f4e95a..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/lg,lg4573.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -LG LG4573 TFT Liquid Crystal Display with SPI control bus
> -
> -Required properties:
> -  - compatible: "lg,lg4573"
> -  - reg: address of the panel on the SPI bus
> -
> -The panel must obey rules for SPI slave device specified in document [1].
> -
> -[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -
> -	lcd_panel: display@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "lg,lg4573";
> -		spi-max-frequency = <10000000>;
> -		reg = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> new file mode 100644
> index 000000000000..b5b475cf8406
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,lg4573.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG LG4573 TFT Liquid Crystal Display with SPI control bus
> +
> +maintainers:
> +  - Heiko Schocher <hs@denx.de>
> +
> +allOf:
> +  - $ref: ../../spi/spi-slave.yaml#
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lg,lg4573
> +
> +  reg: true
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +        compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";

Better to drop this or it's going to fail when there's a schema for this 
spi controller.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lcd_panel: display@0 {
> +            compatible = "lg,lg4573";
> +            spi-max-frequency = <10000000>;
> +            reg = <0>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
