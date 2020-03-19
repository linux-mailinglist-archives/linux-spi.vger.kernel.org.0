Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24618AAE0
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 03:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCSCyB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 22:54:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43881 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSCyB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 22:54:01 -0400
Received: by mail-io1-f68.google.com with SMTP id n21so705388ioo.10;
        Wed, 18 Mar 2020 19:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRhELSIFosVhDEfSNhPBf3PHkVl8ZbRKQYUpPQ7wXzU=;
        b=D7qd8tbAS65M9294XGGqKvamUjmAK6EzK50zlVhQiOSvLxw0mV6FbqOIgLtooy7kXg
         6avGvV7LWOwrEeqZ2tT/87IJ8nliqENN3Y5E8vAfUgE8L+kBP96VgT+FovYVE36EzWGQ
         SNbZLULtyeMwBu2RBy6XuTbqIbVYJm1Pk1/mUyqWILXrJOXUXu8Y3et6KnM56HJgHPkh
         Q2gLvCP1Qao0GvAlz1VoOEzt4F/J5pQ8XHjA1xoQKdNl0FjiqR36C/Gki5aQDrUeoal/
         EkjUrIa/Sb3IhO+2OASjNa+AI5tXSVfddI37rTUpL/ZTYW4I1sCDPuqM6VUqJkUCiBCi
         xr3Q==
X-Gm-Message-State: ANhLgQ2+NVYktJaU655xdNWVWFT381B29mAmIcc2x+pdIT8UIX/5FYHR
        XHqCCyaoK1SEqCNQ87pnUw==
X-Google-Smtp-Source: ADFU+vvO6YKwIA3nl5Aq0cvBeeEaRXfOPZCSBBGG5GRV0LI81AIikeYB18kU3nz/ODE3APMAgXW1Kg==
X-Received: by 2002:a02:7714:: with SMTP id g20mr1134154jac.88.1584586440057;
        Wed, 18 Mar 2020 19:54:00 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n23sm323694ild.34.2020.03.18.19.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 19:53:59 -0700 (PDT)
Received: (nullmailer pid 19802 invoked by uid 1000);
        Thu, 19 Mar 2020 02:53:56 -0000
Date:   Wed, 18 Mar 2020 20:53:56 -0600
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
Subject: Re: [PATCH v1 12/36] dt-bindings: display: convert jdi,lt070me05000
 to DT Schema
Message-ID: <20200319025356.GC29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-13-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-13-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:52PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinay Simha BN <simhavcs@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/jdi,lt070me05000.txt        | 31 ---------
>  .../display/panel/jdi,lt070me05000.yaml       | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
> deleted file mode 100644
> index 4989c91d505f..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -JDI model LT070ME05000 1200x1920 7" DSI Panel
> -
> -Required properties:
> -- compatible: should be "jdi,lt070me05000"
> -- vddp-supply: phandle of the regulator that provides the supply voltage
> -  Power IC supply (3-5V)
> -- iovcc-supply: phandle of the regulator that provides the supply voltage
> -  IOVCC , power supply for LCM (1.8V)
> -- enable-gpios: phandle of gpio for enable line
> -  LED_EN, LED backlight enable, High active
> -- reset-gpios: phandle of gpio for reset line
> -  This should be 8mA, gpio can be configured using mux, pinctrl, pinctrl-names
> -  XRES, Reset, Low active
> -- dcdc-en-gpios: phandle of the gpio for power ic line
> -  Power IC supply enable, High active
> -
> -Example:
> -
> -	dsi0: qcom,mdss_dsi@4700000 {
> -		panel@0 {
> -			compatible = "jdi,lt070me05000";
> -			reg = <0>;
> -
> -			vddp-supply = <&pm8921_l17>;
> -			iovcc-supply = <&pm8921_lvs7>;
> -
> -			enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
> -			reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
> -			dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> new file mode 100644
> index 000000000000..e0abf68ecb19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/jdi,lt070me05000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: JDI model LT070ME05000 1200x1920 7" DSI Panel
> +
> +maintainers:
> +  - Vinay Simha BN <simhavcs@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: jdi,lt070me05000
> +
> +  enable-gpios: true
> +  reg: true
> +  reset-gpios: true
> +
> +  vddp-supply:
> +    description: |
> +      The regulator that provides the supply voltage Power IC supply (3-5V)
> +
> +  iovcc-supply:
> +    description: |
> +      The regulator that provides the supply voltage IOVCC,
> +      power supply for LCM (1.8V)
> +
> +  dcdc-en-gpios:
> +    description: |
> +      phandle of the gpio for power ic line
> +      Power IC supply enable, High active
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddp-supply
> +  - iovcc-supply
> +  - enable-gpios
> +  - reset-gpios
> +  - dcdc-en-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi: qcom,mdss_dsi@4700000 {

dsi {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "jdi,lt070me05000";
> +            reg = <0>;
> +
> +            vddp-supply = <&pm8921_l17>;
> +            iovcc-supply = <&pm8921_lvs7>;
> +
> +            enable-gpios = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_LOW>;
> +            dcdc-en-gpios = <&pm8921_gpio 23 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
