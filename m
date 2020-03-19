Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3021918AAF5
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCSDHl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:07:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46535 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDHl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:07:41 -0400
Received: by mail-io1-f65.google.com with SMTP id v3so711461iom.13;
        Wed, 18 Mar 2020 20:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86v811Y5uL+B0s1Q5xmlGYr7t3LK+8i6eRl/RIQzj58=;
        b=iQ2nYDYUEmhxCVg8tUwGG6UZF5jttoknc2hUT3PvIGwuiUYKEMTxeKwlGqp65fl8KX
         uIbBRdT3Dy2cAXm6qhQdCitEkxzAwK3RFGRVuHbE3LmNbAenQl3wvE9mePcGMucPScWJ
         StAE9Z0/HY8Wt94zN9DuzXmJHKKFxWGxKPSthZInV+WVM8nmmaGnYZaqxcVof0qBD1WM
         r8shk5HZeLq9V21J35jnSIJOhWqIWAxAkBnxpKENUwpd5X6Glqo7R9GJ5apkrYugDKec
         VLlblKVB3IY6hoxT/5tTpYLmAOwQHKCOyqG3V+UBFSn91vsZyttRQ5Y3V3IC9/1Z/OmW
         f62A==
X-Gm-Message-State: ANhLgQ0HkZ+AKIBFLJXBplXByVEx5VKDVGcSCd/6iCDAja4xzzAE1HyW
        oQoyY9K2t1AMcd+OY5hfTw==
X-Google-Smtp-Source: ADFU+vvs+NLdPOFavAz5j6lj6RjwlLqqc+kyKy9RSv7PjfP9rE6u06LEJYD7+wFpe3wpOlq1hE41Wg==
X-Received: by 2002:a02:5d89:: with SMTP id w131mr1171921jaa.127.1584587260151;
        Wed, 18 Mar 2020 20:07:40 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p189sm278807iof.17.2020.03.18.20.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:07:39 -0700 (PDT)
Received: (nullmailer pid 6632 invoked by uid 1000);
        Thu, 19 Mar 2020 03:07:34 -0000
Date:   Wed, 18 Mar 2020 21:07:34 -0600
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
Subject: Re: [PATCH v1 32/36] dt-bindings: display: convert sharp,ls037v7dw01
 to DT Schema
Message-ID: <20200319030734.GH29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-33-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-33-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:44:12PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/sharp,ls037v7dw01.txt       | 43 ------------
>  .../display/panel/sharp,ls037v7dw01.yaml      | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
> deleted file mode 100644
> index 0cc8981e9d49..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -SHARP LS037V7DW01 TFT-LCD panel
> -===================================
> -
> -Required properties:
> -- compatible: "sharp,ls037v7dw01"
> -
> -Optional properties:
> -- label: a symbolic name for the panel
> -- enable-gpios: a GPIO spec for the optional enable pin.
> -  This pin is the INI pin as specified in the LS037V7DW01.pdf file.
> -- reset-gpios: a GPIO spec for the optional reset pin.
> -  This pin is the RESB pin as specified in the LS037V7DW01.pdf file.
> -- mode-gpios: a GPIO
> -  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
> -
> -Required nodes:
> -- Video port for DPI input
> -
> -This panel can have zero to five GPIOs to configure to change configuration
> -between QVGA and VGA mode and the scan direction. As these pins can be also
> -configured with external pulls, all the GPIOs are considered optional with holes
> -in the array.
> -
> -Example
> --------
> -
> -Example when connected to a omap2+ based device:
> -
> -lcd0: display {
> -	compatible = "sharp,ls037v7dw01";
> -	power-supply = <&lcd_3v3>;
> -	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> -	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> -	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> -		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> -		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> -
> -	port {
> -		lcd_in: endpoint {
> -			remote-endpoint = <&dpi_out>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
> new file mode 100644
> index 000000000000..56bd510ae398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sharp,ls037v7dw01.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SHARP LS037V7DW01 TFT-LCD panel
> +
> +description: |
> +  This panel can have zero to five GPIOs to configure to change configuration
> +  between QVGA and VGA mode and the scan direction. As these pins can be also
> +  configured with external pulls, all the GPIOs are considered optional with holes
> +  in the array.
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sharp,ls037v7dw01
> +
> +  label: true
> +  enable-gpios: true
> +  reset-gpios: true
> +  port: true
> +  power-supply: true
> +
> +  mode-gpios:
> +    description: |
> +      GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf

3 or...

> +      This panel can have zero to five GPIOs to configure to

5?

> +      change configuration between QVGA and VGA mode and the
> +      scan direction. As these pins can be also configured
> +      with external pulls, all the GPIOs are considered
> +      optional with holes in the array.

minItems: 3
maxItems: 5

> +
> +required:
> +  - compatible
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    lcd0: display {
> +        compatible = "sharp,ls037v7dw01";
> +        power-supply = <&lcd_3v3>;
> +        enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;    /* gpio152, lcd INI */
> +        reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;     /* gpio155, lcd RESB */
> +        mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
> +                      &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
> +                      &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */
> +
> +        port {
> +            lcd_in: endpoint {
> +                remote-endpoint = <&dpi_out>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
