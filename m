Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3231618AAF1
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCSDDy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:03:54 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33037 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDDy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:03:54 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so914385ilg.0;
        Wed, 18 Mar 2020 20:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CND1werjXjnr3pVIsMouNWnu+A/2qN84WfMPPBk4tFs=;
        b=l+x2fqG1G4lk/f2lqeRHkGYqqX+pUlUAWxJmo0yzmAOInkZV28h/bgbJPwuA1D5GIP
         y4Ce0A0KRPZR3wBBcdt0+8efpiivSvv41b/THHKmSveVVJ+RhtSqAXhf1ZObQpYe/vDf
         YfvXy3VO2RvnlVWKbp5VllsGXvJCtlttsITmTQBJve2ynEKJHaYNqwwMV3ytoYn8jPBE
         QVNDY4Qkx0YCp2d8D5eipSJ64kko1mWhv6bhTs0WaP9Agv3lJM5++P2ve1968KsVDE/0
         1dbQRMMsKipAcC5cfV94R7C+RckGSD0bY+Fvv+a23qhULOkYiH+pSfSwCsGW2YxPrQkJ
         dReg==
X-Gm-Message-State: ANhLgQ2GbWOvCwhrLIja114LA6G/9mhK2Tr/Eo4PRqr2TV/qPAh3KgMQ
        4PCwcLXhZ+Bi8W0m1PT2kw==
X-Google-Smtp-Source: ADFU+vvvaIyQmliyGtnvNHkWxNq15ZE9edlH7I0JSMtircoI1Ajn5rZI1LeIcw4jrt1tPg3sa58WBw==
X-Received: by 2002:a92:aa0e:: with SMTP id j14mr1277521ili.52.1584587031724;
        Wed, 18 Mar 2020 20:03:51 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w22sm325250ili.71.2020.03.18.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:03:51 -0700 (PDT)
Received: (nullmailer pid 922 invoked by uid 1000);
        Thu, 19 Mar 2020 03:03:45 -0000
Date:   Wed, 18 Mar 2020 21:03:45 -0600
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
Subject: Re: [PATCH v1 26/36] dt-bindings: display: convert sony,acx565akm to
 DT Schema
Message-ID: <20200319030345.GG29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-27-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-27-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:44:06PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/display/panel/sony,acx565akm.txt | 30 -----------
>  .../display/panel/sony,acx565akm.yaml         | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
> deleted file mode 100644
> index e12333280749..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Sony ACX565AKM SDI Panel
> -========================
> -
> -Required properties:
> -- compatible: "sony,acx565akm"
> -
> -Optional properties:
> -- label: a symbolic name for the panel
> -- reset-gpios: panel reset gpio
> -
> -Required nodes:
> -- Video port for SDI input
> -
> -Example
> --------
> -
> -acx565akm@2 {
> -	compatible = "sony,acx565akm";
> -	spi-max-frequency = <6000000>;
> -	reg = <2>;
> -
> -	label = "lcd";
> -	reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> -
> -	port {
> -		lcd_in: endpoint {
> -			remote-endpoint = <&sdi_out>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> new file mode 100644
> index 000000000000..a0b1abb9f33d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,acx565akm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony ACX565AKM SDI Panel
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ti.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: ../../spi/spi-slave.yaml#
> +
> +properties:
> +  compatible:
> +    const: sony,acx565akm
> +
> +  label: true
> +  reset-gpios: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - port
> +
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        acx565akm@2 {

panel@2

> +            compatible = "sony,acx565akm";
> +            spi-max-frequency = <6000000>;
> +            reg = <2>;
> +
> +            label = "lcd";
> +            reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> +
> +            port {
> +                lcd_in: endpoint {
> +                    remote-endpoint = <&sdi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
