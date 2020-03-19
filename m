Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB418AAEC
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCSDB3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:01:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43351 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDB3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:01:29 -0400
Received: by mail-io1-f65.google.com with SMTP id n21so717618ioo.10;
        Wed, 18 Mar 2020 20:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sj5DRONGePFnAMD0m6VwnAwVGsYINDFZs3kKiK2BySo=;
        b=WCn21DDyFjQ3qza/Ays62MZLl4hzwSRJfB22/PObS5yqc7bZBktGnjaV7ZfkqIBGH5
         h9znTzlLeIfbvDtoG2zYYL3+WTEuEwcrfX9wroBTLHZivEALwGbHizmHSNOU57VgCT0y
         RwH1IskD9Yv4YoIdyIwtNiPwIKk92a9d/0eTtf1bH7O2IPMZPcEJE/gazL/u1QySZTlZ
         EzQzSHSiny0R61ssUlmPczpe1QjBjem7YV7wUMAU2qpTKlizEPNgAcvsPgJ1DfhQBeQb
         8Tj2h4CQRUJQMlEhBo+ynMUOiodPAVSPfBZXBN4G6yMWayhZNXdf0G+MVmWzj0D6R7XV
         eMMA==
X-Gm-Message-State: ANhLgQ2OvPVj/Lg6H83Nffnd6DgJQRhaLXnjyJ/qAHFCMKPuK99BNdVO
        P1yxXdHG8turb5IN+6/7ug==
X-Google-Smtp-Source: ADFU+vvN0tEy2UoeXt0Uq35t7gg00cu9CjMfX2ZU0Ge4y43gv6B+0p9BCv6ru2cztfJ4yG4somcKuQ==
X-Received: by 2002:a6b:8f11:: with SMTP id r17mr804807iod.92.1584586887956;
        Wed, 18 Mar 2020 20:01:27 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m70sm321127ilh.84.2020.03.18.20.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:01:27 -0700 (PDT)
Received: (nullmailer pid 30049 invoked by uid 1000);
        Thu, 19 Mar 2020 03:01:24 -0000
Date:   Wed, 18 Mar 2020 21:01:24 -0600
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
Subject: Re: [PATCH v1 22/36] dt-bindings: display: convert samsung,ld9040 to
 DT Schema
Message-ID: <20200319030124.GF29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-23-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-23-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:44:02PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/display/panel/samsung,ld9040.txt |  66 ------------
>  .../display/panel/samsung,ld9040.yaml         | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
> deleted file mode 100644
> index 354d4d1df4ff..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
> -
> -Required properties:
> -  - compatible: "samsung,ld9040"
> -  - reg: address of the panel on SPI bus
> -  - vdd3-supply: core voltage supply
> -  - vci-supply: voltage supply for analog circuits
> -  - reset-gpios: a GPIO spec for the reset pin
> -  - display-timings: timings for the connected panel according to [1]
> -
> -The panel must obey rules for SPI slave device specified in document [2].
> -
> -Optional properties:
> -  - power-on-delay: delay after turning regulators on [ms]
> -  - reset-delay: delay after reset sequence [ms]
> -  - panel-width-mm: physical panel width [mm]
> -  - panel-height-mm: physical panel height [mm]
> -
> -The device node can contain one 'port' child node with one child
> -'endpoint' node, according to the bindings defined in [3]. This
> -node should describe panel's video bus.
> -
> -[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
> -[2]: Documentation/devicetree/bindings/spi/spi-bus.txt
> -[3]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -
> -	lcd@0 {
> -		compatible = "samsung,ld9040";
> -		reg = <0>;
> -		vdd3-supply = <&ldo7_reg>;
> -		vci-supply = <&ldo17_reg>;
> -		reset-gpios = <&gpy4 5 0>;
> -		spi-max-frequency = <1200000>;
> -		spi-cpol;
> -		spi-cpha;
> -		power-on-delay = <10>;
> -		reset-delay = <10>;
> -		panel-width-mm = <90>;
> -		panel-height-mm = <154>;
> -
> -		display-timings {
> -			timing {
> -				clock-frequency = <23492370>;
> -				hactive = <480>;
> -				vactive = <800>;
> -				hback-porch = <16>;
> -				hfront-porch = <16>;
> -				vback-porch = <2>;
> -				vfront-porch = <28>;
> -				hsync-len = <2>;
> -				vsync-len = <1>;
> -				hsync-active = <0>;
> -				vsync-active = <0>;
> -				de-active = <0>;
> -				pixelclk-active = <0>;
> -			};
> -		};
> -
> -		port {
> -			lcd_ep: endpoint {
> -				remote-endpoint = <&fimd_dpi_ep>;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> new file mode 100644
> index 000000000000..b6e7e87411e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,ld9040.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
> +
> +maintainers:
> +  - Andrzej Hajda <a.hajda@samsung.com>
> +
> +allOf:
> +  - $ref: ../../spi/spi-slave.yaml#
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,ld9040
> +
> +  display-timings: true
> +  port: true
> +  reg: true
> +  reset-gpios: true
> +
> +  vdd3-supply:
> +    description: core voltage supply
> +
> +  vci-supply:
> +    description: voltage supply for analog circuits
> +
> +  power-on-delay:
> +    description: delay after turning regulators on [ms]

This shouldn't really be needed with a specific compatible...

It needs a type reference.

> +
> +  reset-delay:
> +    description: delay after reset sequence [ms]

So does this.

> +
> +  panel-width-mm:
> +    description: physical panel width [mm]

And this.

> +
> +  panel-height-mm:
> +    description: physical panel height [mm]
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd3-supply
> +  - vci-supply
> +  - reset-gpios
> +  - display-timings
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lcd@0 {
> +            compatible = "samsung,ld9040";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reg = <0>;
> +            vdd3-supply = <&ldo7_reg>;
> +            vci-supply = <&ldo17_reg>;
> +            reset-gpios = <&gpy4 5 0>;
> +            spi-max-frequency = <1200000>;
> +            spi-cpol;
> +            spi-cpha;
> +            power-on-delay = <10>;
> +            reset-delay = <10>;
> +            panel-width-mm = <90>;
> +            panel-height-mm = <154>;
> +
> +            display-timings {
> +                timing {
> +                    clock-frequency = <23492370>;
> +                    hactive = <480>;
> +                    vactive = <800>;
> +                    hback-porch = <16>;
> +                    hfront-porch = <16>;
> +                    vback-porch = <2>;
> +                    vfront-porch = <28>;
> +                    hsync-len = <2>;
> +                    vsync-len = <1>;
> +                    hsync-active = <0>;
> +                    vsync-active = <0>;
> +                    de-active = <0>;
> +                    pixelclk-active = <0>;
> +                };
> +            };
> +
> +            port {
> +                lcd_ep: endpoint {
> +                    remote-endpoint = <&fimd_dpi_ep>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
