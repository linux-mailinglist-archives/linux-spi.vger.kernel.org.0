Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D9185EC6
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 18:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgCOR6r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 13:58:47 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:51210 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbgCOR6r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Mar 2020 13:58:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id EBD7BFB03;
        Sun, 15 Mar 2020 18:58:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QEgVtUjIBhwL; Sun, 15 Mar 2020 18:58:40 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 62A474117D; Sun, 15 Mar 2020 18:58:39 +0100 (CET)
Date:   Sun, 15 Mar 2020 18:58:39 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Schocher <hs@denx.de>,
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
Subject: Re: [PATCH v1 19/36] dt-bindings: display: convert
 rocktech,jh057n00900 to DT Schema
Message-ID: <20200315175839.GA4953@bogon.m.sigxcpu.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-20-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200315134416.16527-20-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
On Sun, Mar 15, 2020 at 02:43:59PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Guido Günther" <agx@sigxcpu.org>
> Cc: Purism Kernel Team <kernel@puri.sm>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Thanks!
 -- Guido

> ---
>  .../display/panel/rocktech,jh057n00900.txt    | 23 --------
>  .../display/panel/rocktech,jh057n00900.yaml   | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> deleted file mode 100644
> index a372c5d84695..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "rocktech,jh057n00900"
> -- reg: DSI virtual channel of the peripheral
> -- reset-gpios: panel reset gpio
> -- backlight: phandle of the backlight device attached to the panel
> -- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
> -- iovcc-supply: phandle of the regulator that provides the iovcc supply
> -  voltage.
> -
> -Example:
> -
> -	&mipi_dsi {
> -		panel@0 {
> -			compatible = "rocktech,jh057n00900";
> -			reg = <0>;
> -			backlight = <&backlight>;
> -			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> -			vcc-supply = <&reg_2v8_p>;
> -			iovcc-supply = <&reg_1v8_p>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> new file mode 100644
> index 000000000000..827417bbff63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/rocktech,jh057n00900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel
> +
> +maintainers:
> +  - Guido Günther <agx@sigxcpu.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: rocktech,jh057n00900
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  vcc-supply:
> +    description: The regulator that provides the vcc supply voltage
> +
> +  iovcc-supply:
> +    description: The regulator that provides the iovcc supply voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - backlight
> +  - vcc-supply
> +  - iovcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "rocktech,jh057n00900";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +            vcc-supply = <&reg_2v8_p>;
> +            iovcc-supply = <&reg_1v8_p>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
