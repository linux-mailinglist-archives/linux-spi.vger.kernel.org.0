Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A443159E8
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 00:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhBIXNJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Feb 2021 18:13:09 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36732 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhBIXA2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Feb 2021 18:00:28 -0500
Received: by mail-oi1-f178.google.com with SMTP id k204so19703067oih.3;
        Tue, 09 Feb 2021 15:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ue7D4O8vdXw9UDhxOL/f68EqD5Djbx8qy8gM4ZTo8o=;
        b=hSNdV7t1PmNYoSCcQAPTCWTG1cVErnnP58PDKKh47L6lR2woKXaKYPN06fLIwGeMiY
         P4gRT4+xGwFwfi12suxUPvz6Kjh+O0sIbSrXFawqBKTkaAOhD01XMM0Bgb/tMvaeMJW1
         qEyfHhhT7mTx67+nTVYO6nOe8TxOXHOq2KSa2MGd2FlLJyxjH6pfsuDgHh5Es4MtWHyr
         3uwsuz3AuFa7W3UJtXLtNQsx1skHrhLD77BZc9E2JSU2mCmo6w671+5p7Lm7wgbw/tKl
         Z+IaBLZV5k3eDN49Z+KBQEpYnpGIzIZsNvilpTwKZI/hvmJnCEv1IV+h4g2tLyVB6qRb
         g7ew==
X-Gm-Message-State: AOAM532N5EP5/NehUP3YGmD5SMAmo3NgqjQG/jjKA5NF4JZ3r2o36Quz
        D4ngDALbf0sNEJWSe8SzZ3j6yI7jJA==
X-Google-Smtp-Source: ABdhPJzO6QBdZCXZG20mYXd4tre7KcvWOOgg+uJllJfNXFTuS1MiX/nrrW1uhMgjESZC0Jg1/nh8XQ==
X-Received: by 2002:a54:478c:: with SMTP id o12mr43726oic.28.1612910978323;
        Tue, 09 Feb 2021 14:49:38 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w124sm25348oiw.40.2021.02.09.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:49:37 -0800 (PST)
Received: (nullmailer pid 366377 invoked by uid 1000);
        Tue, 09 Feb 2021 22:49:36 -0000
Date:   Tue, 9 Feb 2021 16:49:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml
Message-ID: <20210209224936.GA338434@robh.at.kernel.org>
References: <22ca0a9a15ccdf4b520baacc5ed837f6d3a3f781.1612360002.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ca0a9a15ccdf4b520baacc5ed837f6d3a3f781.1612360002.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 03, 2021 at 02:46:44PM +0100, Michal Simek wrote:
> Convert spi-zynq-qspi.txt to yaml.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  .../devicetree/bindings/spi/spi-zynq-qspi.txt | 25 --------
>  .../bindings/spi/xlnx,zynq-qspi.yaml          | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 60 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> deleted file mode 100644
> index 16b734ad3102..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Xilinx Zynq QSPI controller Device Tree Bindings
> --------------------------------------------------------------------
> -
> -Required properties:
> -- compatible		: Should be "xlnx,zynq-qspi-1.0".
> -- reg			: Physical base address and size of QSPI registers map.
> -- interrupts		: Property with a value describing the interrupt
> -			  number.
> -- clock-names		: List of input clock names - "ref_clk", "pclk"
> -			  (See clock bindings for details).
> -- clocks		: Clock phandles (see clock bindings for details).
> -
> -Optional properties:
> -- num-cs		: Number of chip selects used.
> -
> -Example:
> -	qspi: spi@e000d000 {
> -		compatible = "xlnx,zynq-qspi-1.0";
> -		reg = <0xe000d000 0x1000>;
> -		interrupt-parent = <&intc>;
> -		interrupts = <0 19 4>;
> -		clock-names = "ref_clk", "pclk";
> -		clocks = <&clkc 10>, <&clkc 43>;
> -		num-cs = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> new file mode 100644
> index 000000000000..03269a7433b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/xlnx,zynq-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq QSPI controller
> +
> +description:
> +  The Xilinx Zynq QSPI controller is used to access multi-bit serial flash
> +  memory devices.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    const: xlnx,zynq-qspi-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +      - description: peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: true

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    spi@e000d000 {
> +        compatible = "xlnx,zynq-qspi-1.0";
> +        reg = <0xe000d000 0x1000>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <0 19 4>;
> +        clock-names = "ref_clk", "pclk";
> +        clocks = <&clkc 10>, <&clkc 43>;
> +        num-cs = <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 546aa66428c9..e494b061dcd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2766,6 +2766,7 @@ W:	http://wiki.xilinx.com
>  T:	git https://github.com/Xilinx/linux-xlnx.git
>  F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
>  F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> +F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
>  F:	arch/arm/mach-zynq/
>  F:	drivers/block/xsysace.c
>  F:	drivers/clocksource/timer-cadence-ttc.c
> -- 
> 2.30.0
> 
