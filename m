Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB72F18AB1C
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCSDW3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:22:29 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44385 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDW2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:22:28 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so878828ila.11;
        Wed, 18 Mar 2020 20:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKvd37vyAwPPIJhqFLDoBYloHbAC6NbPFy6rsa6ssic=;
        b=q9Jv7i9QoiCMJApRLXlmJkrO+gJDTABVKbNqye99/Kz+YMLFP54kNONPvKycZNw2WM
         QgEKqLJBAT3eWr9/wBj4HRq/kBPo3e7m+53I5Aw7ZYK99HTUqZS7pDMY1amFTUzJqEjP
         KEouTVJ3YBw0ODNKEvXv5RnJB3Py62/RFjJX0YeR0o0J9TEEIRgYQyEYWrN8kph5yI7i
         ycGf6zsSKMliXZmYJabZGWAODdtpn72WGjzaXVuTWgHnPO0tROXLFYtE5qBCQm2QzJkT
         WZ6/6ULNjHGff4t9DSsCpMRs4HOh7Pg/Az6XHyrZvTreARLFz+IvJYV4A80VzYb4N3Lk
         LlWw==
X-Gm-Message-State: ANhLgQ1fcm3OYgRu0AnHFPpKCkjOfEXQFHq5etBdLcN4HXlHdCFoLP7M
        4HkU6gaghxD/XmBGmzOsfQ==
X-Google-Smtp-Source: ADFU+vvwzqFRFORRH0szoEb9SOitQ3nRweLaQw0NI9PHb4vwXsrwi9AziirF/1fIeC0vv+qBVX4yHg==
X-Received: by 2002:a92:894b:: with SMTP id n72mr1354938ild.138.1584588148015;
        Wed, 18 Mar 2020 20:22:28 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s69sm339878ill.73.2020.03.18.20.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:22:27 -0700 (PDT)
Received: (nullmailer pid 26783 invoked by uid 1000);
        Thu, 19 Mar 2020 03:22:22 -0000
Date:   Wed, 18 Mar 2020 21:22:22 -0600
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
Subject: Re: [PATCH v1 18/36] dt-bindings: display: convert raydium,rm67191
 to DT Schema
Message-ID: <20200319032222.GK29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-19-sam@ravnborg.org>
 <20200319025814.GE29911@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319025814.GE29911@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 18, 2020 at 08:58:15PM -0600, Rob Herring wrote:
> On Sun, Mar 15, 2020 at 02:43:58PM +0100, Sam Ravnborg wrote:
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >  .../display/panel/raydium,rm67191.txt         | 41 ----------
> >  .../display/panel/raydium,rm67191.yaml        | 75 +++++++++++++++++++
> >  2 files changed, 75 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> > deleted file mode 100644
> > index 10424695aa02..000000000000
> > --- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> > -
> > -Required properties:
> > -- compatible: 		"raydium,rm67191"
> > -- reg:			virtual channel for MIPI-DSI protocol
> > -			must be <0>
> > -- dsi-lanes:		number of DSI lanes to be used
> > -			must be <3> or <4>
> > -- port: 		input port node with endpoint definition as
> > -			defined in Documentation/devicetree/bindings/graph.txt;
> > -			the input port should be connected to a MIPI-DSI device
> > -			driver
> > -
> > -Optional properties:
> > -- reset-gpios:		a GPIO spec for the RST_B GPIO pin
> > -- v3p3-supply:		phandle to 3.3V regulator that powers the VDD_3V3 pin
> > -- v1p8-supply:		phandle to 1.8V regulator that powers the VDD_1V8 pin
> > -- width-mm:		see panel-common.txt
> > -- height-mm:		see panel-common.txt
> > -- video-mode:		0 - burst-mode
> > -			1 - non-burst with sync event
> > -			2 - non-burst with sync pulse
> > -
> > -Example:
> > -
> > -	panel@0 {
> > -		compatible = "raydium,rm67191";
> > -		reg = <0>;
> > -		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
> > -		pinctrl-names = "default";
> > -		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> > -		dsi-lanes = <4>;
> > -		width-mm = <68>;
> > -		height-mm = <121>;
> > -
> > -		port {
> > -			panel_in: endpoint {
> > -				remote-endpoint = <&mipi_out>;
> > -			};
> > -		};
> > -	};
> > diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > new file mode 100644
> > index 000000000000..b78b66a4336f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/raydium,rm67191.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> > +
> > +maintainers:
> > +  - Robert Chiras <robert.chiras@nxp.com>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: raydium,rm67191
> > +
> > +  reg: true
> > +  port: true
> > +  reset-gpios: true
> > +  width-mm: true
> > +  height-mm: true
> > + 
> > +  dsi-lanes:
> > +    description: Number of DSI lanes to be used must be <3> or <4>
> > +    enum: [3, 4]
> > +
> > +  v3p3-supply:
> > +    description: phandle to 3.3V regulator that powers the VDD_3V3 pin
> > +
> > +  v1p8-supply:
> > +    description: phandle to 1.8V regulator that powers the VDD_1V8 pin
> > +
> > +  video-mode:
> > +    description: |
> > +      0 - burst-mode
> > +      1 - non-burst with sync event
> > +      2 - non-burst with sync pulse
> > +    enum: [0, 1, 2]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dsi-lanes
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        panel {
> 
> panel@0
> 
> I thought our dsi bus binding would catch this...

Uhhh, it's looking for dsi-controller(@.*)? which is not the common 
case found in dts files. We should fix that to dsi(@.*)?.

Rob
