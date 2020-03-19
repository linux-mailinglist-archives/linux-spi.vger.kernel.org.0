Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB018AAFC
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCSDLM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:11:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40774 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDLM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:11:12 -0400
Received: by mail-il1-f196.google.com with SMTP id p12so886013ilm.7;
        Wed, 18 Mar 2020 20:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+0LKz/6lSN9Mmuvfliw6x06SgGAqZYO0grtLAW3j6U=;
        b=nXvg518YAFbV9DjTogMhcW8gM3qUbTULAg2Zhlo7maUl/mgsFPCJ6ovTDAEqRLgzl1
         hwz1Nj5MAnPIP6vD90HeaIz07rh9xVfWq4VezoJoKxcBWP5J3SeK6TxtR5u0Pu4Gibv8
         bblTFRy2MjYzmhXPzkW4Kcu+p2eld3atlnsjWqIP65wZU+26bkGutFJpghV/cXakcM93
         VpwhFj1ADuVWggb/A4xi1fpAiPeWeOwQB5ZuK7btkfYu7J35B67L07jh7KE8oNWJjNRo
         Q7OI9wUlwVbJJZDlY2xQYfCBRrhq5pXfQ5r63JeXqUy8ueatSx7LZaFl/eqmXUh2LV8B
         xKEQ==
X-Gm-Message-State: ANhLgQ2HW5lV4nhxeGyOvlJIfOM/wv051othX6bFl6ZJp/0rzKjDeX9S
        vw6v4OEdfrnlXueJ7VBXiw==
X-Google-Smtp-Source: ADFU+vszxBuKK7lsj5bUamMMz4xX5tBX0FIRFTriRVyf3HZunP/b/Jfg3ti57aekAIMoKMFMzE3f8A==
X-Received: by 2002:a92:d70e:: with SMTP id m14mr1224873iln.30.1584587470975;
        Wed, 18 Mar 2020 20:11:10 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 10sm336743ilb.45.2020.03.18.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:11:10 -0700 (PDT)
Received: (nullmailer pid 11458 invoked by uid 1000);
        Thu, 19 Mar 2020 03:11:06 -0000
Date:   Wed, 18 Mar 2020 21:11:06 -0600
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
Subject: Re: [PATCH v1 36/36] dt-bindings: display: convert
 olimex,lcd-olinuxino to DT Schema
Message-ID: <20200319031106.GI29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-37-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-37-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:44:16PM +0100, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Stefan Mavrodiev <stefan@olimex.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/olimex,lcd-olinuxino.txt    | 42 -----------
>  .../display/panel/olimex,lcd-olinuxino.yaml   | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
> deleted file mode 100644
> index a89f9c830a85..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
> -
> -This device can be used as bridge between a host controller and LCD panels.
> -Currently supported LCDs are:
> -  - LCD-OLinuXino-4.3TS
> -  - LCD-OLinuXino-5
> -  - LCD-OLinuXino-7
> -  - LCD-OLinuXino-10
> -
> -The panel itself contains:
> -  - AT24C16C EEPROM holding panel identification and timing requirements
> -  - AR1021 resistive touch screen controller (optional)
> -  - FT5x6 capacitive touch screnn controller (optional)
> -  - GT911/GT928 capacitive touch screen controller (optional)
> -
> -The above chips share same I2C bus. The EEPROM is factory preprogrammed with
> -device information (id, serial, etc.) and timing requirements.
> -
> -Touchscreen bingings can be found in these files:
> -  - input/touchscreen/goodix.txt
> -  - input/touchscreen/edt-ft5x06.txt
> -  - input/touchscreen/ar1021.txt
> -
> -Required properties:
> -  - compatible: should be "olimex,lcd-olinuxino"
> -  - reg: address of the configuration EEPROM, should be <0x50>
> -  - power-supply: phandle of the regulator that provides the supply voltage
> -
> -Optional properties:
> -  - enable-gpios: GPIO pin to enable or disable the panel
> -  - backlight: phandle of the backlight device attacked to the panel
> -
> -Example:
> -&i2c2 {
> -	panel@50 {
> -		compatible = "olimex,lcd-olinuxino";
> -		reg = <0x50>;
> -		power-supply = <&reg_vcc5v0>;
> -		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
> -		backlight = <&backlight>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
> new file mode 100644
> index 000000000000..22d664abd552
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/olimex,lcd-olinuxino.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
> +
> +maintainers:
> +  - Stefan Mavrodiev <stefan@olimex.com>
> +
> +description: |
> +  This device can be used as bridge between a host controller and LCD panels.
> +  Currently supported LCDs are:
> +    - LCD-OLinuXino-4.3TS
> +    - LCD-OLinuXino-5
> +    - LCD-OLinuXino-7
> +    - LCD-OLinuXino-10
> +
> +  The panel itself contains:
> +    - AT24C16C EEPROM holding panel identification and timing requirements
> +    - AR1021 resistive touch screen controller (optional)
> +    - FT5x6 capacitive touch screnn controller (optional)
> +    - GT911/GT928 capacitive touch screen controller (optional)
> +
> +  The above chips share same I2C bus. The EEPROM is factory preprogrammed with
> +  device information (id, serial, etc.) and timing requirements.
> +
> +  Touchscreen bingings can be found in these files:
> +    - input/touchscreen/goodix.yaml
> +    - input/touchscreen/edt-ft5x06.txt
> +    - input/touchscreen/ar1021.txt
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: olimex,lcd-olinuxino
> +
> +  backlight: true
> +  enable-gpios: true
> +  power-supply: true
> +  reg: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c2 {

i2c {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@50 {
> +            compatible = "olimex,lcd-olinuxino";
> +            reg = <0x50>;
> +            power-supply = <&reg_vcc5v0>;
> +            enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...
> -- 
> 2.20.1
> 
