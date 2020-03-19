Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710D118AAD4
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 03:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSCrS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 22:47:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40123 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSCrS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 22:47:18 -0400
Received: by mail-il1-f195.google.com with SMTP id p12so849309ilm.7;
        Wed, 18 Mar 2020 19:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LFJUbgPmZnM/0vjLHNR92Cihn1D16v1W4tMgoyRC/8Y=;
        b=UDLP61qwTBpo01H7pgpdfpJW88+RukQ8D65fS+biREIsdsP11A59sogX1PquRM/ynI
         8no0zLJD36CgI8NebCcBToTELUnLJkfYilHK8qX32P1Zz3Lg9uuvq9iV6wx4Xg6cGMJg
         Zv2KkQFE41rKyvrpg5ECIbC07QxzlPIbTCuOwRQsfZiKS/L96F1yCTp+aP7w5q0EPsPc
         o3hFRPaoVlS70eoCnP30DIsVPIFUiaaeT54d0jhpqe8HOc9btxJV6gN8ac8V52AOIokM
         Wg2kEk99OgAcQXZOjjjxALNp7Sjb5RoXcUOGqPn3OZR7SEnWA7aAKmgYBVyElcqT+ihC
         LlxA==
X-Gm-Message-State: ANhLgQ3tWhOyXRiTIuD+26vdYNTP+LBqEeblU0FVTiCPWkiGHOj7sdd+
        pwRQv68kJwaAF4b4/uY7Q2t/S+I=
X-Google-Smtp-Source: ADFU+vvB25aqqRFdEbb7Rs8BlZEuCb7ybdlBskdooN3izD0G2f/Xld2e6bLFF84uTsuI9uz6YIKIDQ==
X-Received: by 2002:a92:2910:: with SMTP id l16mr1072231ilg.155.1584586035604;
        Wed, 18 Mar 2020 19:47:15 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p70sm309238ilk.53.2020.03.18.19.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 19:47:14 -0700 (PDT)
Received: (nullmailer pid 10673 invoked by uid 1000);
        Thu, 19 Mar 2020 02:47:11 -0000
Date:   Wed, 18 Mar 2020 20:47:11 -0600
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
Subject: Re: [PATCH v1 03/36] dt-bindings: display: convert samsung,s6e63m0
 to DT Schema
Message-ID: <20200319024711.GA29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-4-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-4-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:43PM +0100, Sam Ravnborg wrote:
> The binding for this panel is a SPI slave.
> Reference spi-slave.yaml
> to avoid duplicating all properties.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/samsung,s6e63m0.txt         | 33 -----------
>  .../display/panel/samsung,s6e63m0.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> deleted file mode 100644
> index 9fb9ebeef8e4..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -Samsung s6e63m0 AMOLED LCD panel
> -
> -Required properties:
> -  - compatible: "samsung,s6e63m0"
> -  - reset-gpios: GPIO spec for reset pin
> -  - vdd3-supply: VDD regulator
> -  - vci-supply: VCI regulator
> -
> -The panel must obey rules for SPI slave device specified in document [1].
> -
> -The device node can contain one 'port' child node with one child
> -'endpoint' node, according to the bindings defined in [2]. This
> -node should describe panel's video bus.
> -
> -[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
> -[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -
> -		s6e63m0: display@0 {
> -			compatible = "samsung,s6e63m0";
> -			reg = <0>;
> -			reset-gpio = <&mp05 5 1>;
> -			vdd3-supply = <&ldo12_reg>;
> -			vci-supply = <&ldo11_reg>;
> -			spi-max-frequency = <1200000>;
> -
> -			port {
> -				lcd_ep: endpoint {
> -					remote-endpoint = <&fimd_ep>;
> -				};
> -			};
> -		};
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> new file mode 100644
> index 000000000000..204ed76da84d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6e63m0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung s6e63m0 AMOLED LCD panel
> +
> +maintainers:
> +  - Jonathan Bakker <xc-racer2@live.ca>
> +
> +allOf:
> +  - $ref: ../../spi/spi-slave.yaml#
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6e63m0
> +
> +  reg: true
> +  reset-gpios: true
> +  port: true
> +
> +  vdd3-supply:
> +    description: VDD regulator
> +
> +  vci-supply:
> +    description: VCI regulator
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd3-supply
> +  - vci-supply

Shouldn't port be required? Not really clear in the binding doc, but in 
the driver it doesn't look like display data goes over spi.

Rob

> +
> +examples:
> +  - |
> +    spi {
> +        reg = <0xf00 0x20>;

Drop this or do 'spi@f00'. If it doesn't warn with W=1, it's only a 
matter of time.

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        display@0 {
> +            compatible = "samsung,s6e63m0";
> +            reg = <0>;
> +            reset-gpios = <&mp05 5 1>;
> +            vdd3-supply = <&ldo12_reg>;
> +            vci-supply = <&ldo11_reg>;
> +            spi-max-frequency = <1200000>;
> +
> +            port {
> +                lcd_ep: endpoint {
> +                    remote-endpoint = <&fimd_ep>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
