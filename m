Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA318AADA
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 03:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCSCtA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 22:49:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34541 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCSCtA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 22:49:00 -0400
Received: by mail-io1-f66.google.com with SMTP id h131so756657iof.1;
        Wed, 18 Mar 2020 19:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8iNR1+hmLqOvjeHPkSzzH6o4xUKxm3Foovicd7v/7c=;
        b=QAgcjjzhlrU0MKmMf+8tPCDGwYPLG8P3Bu4yuLebZXkZ08aSMtR1JxeejksoOml8Ym
         5G32gmhq9WFBTf8Qg57R53UiLsRQ3i4Vt5VlkU0cu2rR5eCoayK+mvn4mLin3RdPjeFB
         38TxvJAXz/5GtbR4QintE8/IVvlwq1G9LpNIoyWMq//RZObUmfP2UE4Mr8VwfyBzk6P9
         sht4UzfiY7Rbuij2dwpY8ETHp3dcpTZQedCspDBa55w7DwwgySF9SRBGbA57xH7hEl6p
         dH0li+P3G/s2S5jw7EhM2EIlxPxBLSTymfsXnWFsLR4AqLQidVwZEREKHi3B2qKxAbl1
         vC0A==
X-Gm-Message-State: ANhLgQ2dxWB80uNldVpY9Be61/PxW6L7oYT6lH3qW/WSpU/xo8+oHrLF
        1e68+QbkeAjOhwdelSJtpg==
X-Google-Smtp-Source: ADFU+vssk5i7OAkbciAzXy4RqfIbgraA+MkHyU8BtSMwj1/iWgZCmjx9dUAao8lMFv+IAp1wgD1xUQ==
X-Received: by 2002:a6b:fc1a:: with SMTP id r26mr811247ioh.134.1584586139361;
        Wed, 18 Mar 2020 19:48:59 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r29sm307156ilk.76.2020.03.18.19.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 19:48:58 -0700 (PDT)
Received: (nullmailer pid 13019 invoked by uid 1000);
        Thu, 19 Mar 2020 02:48:56 -0000
Date:   Wed, 18 Mar 2020 20:48:56 -0600
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
Subject: Re: [PATCH v1 04/36] dt-bindings: display: convert
 arm,versatile-tft-panel to DT Schema
Message-ID: <20200319024856.GB29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-5-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-5-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:44PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/arm,versatile-tft-panel.txt | 31 -----------
>  .../panel/arm,versatile-tft-panel.yaml        | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
> deleted file mode 100644
> index 0601a9e34703..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -ARM Versatile TFT Panels
> -
> -These panels are connected to the daughterboards found on the
> -ARM Versatile reference designs.
> -
> -This device node must appear as a child to a "syscon"-compatible
> -node.
> -
> -Required properties:
> -- compatible: should be "arm,versatile-tft-panel"
> -
> -Required subnodes:
> -- port: see display/panel/panel-common.yaml, graph.txt
> -
> -
> -Example:
> -
> -sysreg@0 {
> -	compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
> -	reg = <0x00000 0x1000>;
> -
> -	panel: display@0 {
> -		compatible = "arm,versatile-tft-panel";
> -
> -		port {
> -			panel_in: endpoint {
> -				remote-endpoint = <&foo>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
> new file mode 100644
> index 000000000000..8ad7305887b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/arm,versatile-tft-panel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Versatile TFT Panels
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  These panels are connected to the daughterboards found on the
> +  ARM Versatile reference designs.
> +
> +  This device node must appear as a child to a "syscon"-compatible
> +  node.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: arm,versatile-tft-panel
> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysreg {
> +        compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
> +        reg = <0x00000 0x1000>;
> +
> +        panel: display@0 {

Drop the unit-address or add 'reg'.

> +            compatible = "arm,versatile-tft-panel";
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&foo>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
