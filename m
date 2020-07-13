Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539F121E0B8
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 21:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGMT3G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 15:29:06 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33375 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMT3F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 15:29:05 -0400
Received: by mail-il1-f195.google.com with SMTP id a11so12243471ilk.0;
        Mon, 13 Jul 2020 12:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0xhnbPe/d0IoJEyGabZetRlZ0skbc4H/mFckdi1EPy0=;
        b=b6tPECtrqPSfx1D0THC+NnMyvxpQ/S5qNJbNKsuFM9y5YVzcUlQCQbQf7Fl05HiGeC
         v8wUGrdWRwsq6XyfhwUdK4CBv/P4EpbTavQCiTfn35wPlZua2L7TRM0qD8l0rk4sM+AN
         oamR/+GV1gCVXo94aV21fWLhP6Btz6l4EPzg35XtPM4Vx+zCPleEvRKU6Ao3+dvwEXiJ
         eicK8XRbqhUI01fg9VW+8ClzxiXuPHcSk4HpHbYZS3HtlpjNwPp/pH5i5BJTDYy5a8A7
         b17a6HLOWYNJsHJZ6KgXyjVPfgkzrKLNo7zU4JFCjqNNCehbwLYXKtfnWKtnwQEhoR0/
         XmxA==
X-Gm-Message-State: AOAM531ZjqbURmlgl5QGrTr7PTKDPc8F7x9khbZkm7roBSlqged1z3ZL
        ISmBcLiLuVzGAWYp+wZWrg==
X-Google-Smtp-Source: ABdhPJwcnmo4dFijfK2zsP8oqdDChinnbZfr1/3zp9e1DRKY9KOL8Cee8Awl5jrCTQGoYDftFXQVTg==
X-Received: by 2002:a92:1bdb:: with SMTP id f88mr1343200ill.233.1594668543927;
        Mon, 13 Jul 2020 12:29:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l13sm8012974iob.28.2020.07.13.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:29:03 -0700 (PDT)
Received: (nullmailer pid 598129 invoked by uid 1000);
        Mon, 13 Jul 2020 19:29:02 -0000
Date:   Mon, 13 Jul 2020 13:29:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 6/8] dt-bindings: microchip,sparx5-spi-mux: Add Sparx5
 SPI mux driver bindings
Message-ID: <20200713192902.GA587038@bogus>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
 <20200702101331.26375-7-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702101331.26375-7-lars.povlsen@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 02, 2020 at 12:13:29PM +0200, Lars Povlsen wrote:
> The Microchip Sparx5 SPI controller has two bus segments, and use this
> mux to control the bus interface mapping for any chip selects. This
> decribes the bindings used to configure the mux driver.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mux/microchip,sparx5-spi-mux.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
> new file mode 100644
> index 0000000000000..b0ce3b15a69e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mux/microchip,sparx5-spi-mux.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mux/microchip,sparx5-spi-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Sparx5 SPI mux
> +
> +maintainers:
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +description: |
> +  The Microchip Sparx5 SPI controller has two bus segments. In order
> +  to switch between the appropriate bus for any given SPI slave
> +  (defined by a chip select), this mux driver is used. The device tree
> +  node for the mux will define the bus mapping for any chip
> +  selects. The default bus mapping for any chip select is "0", such
> +  that only non-default mappings need to be explicitly defined.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sparx5-spi-mux
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#mux-control-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^mux@[0-9a-f]$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        description:
> +          Chip select to define bus mapping for.
> +        minimum: 0
> +        maximum: 15
> +
> +      microchip,bus-interface:
> +        description:
> +          The bus interface to use for this chip select.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +    required:
> +      - reg
> +      - microchip,bus-interface
> +
> +examples:
> +  - |
> +    mux: mux-controller {
> +      compatible = "microchip,sparx5-spi-mux";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #mux-control-cells = <0>;

How is this mux accessed? You have no control interface defined.

> +      mux@e {
> +        reg = <14>;
> +        microchip,bus-interface = <1>;

This looks odd. I take it that there's 2 muxes for this h/w? If so then 
#mux-control-cells should be 1 and the cell value can be whatever you 
want that is meaningful for the mux controller. Could be 0,1 or perhaps 
0xe if that's more useful.

Rob
