Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85128376C54
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 00:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhEGWOy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 18:14:54 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46775 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGWOx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 18:14:53 -0400
Received: by mail-ot1-f54.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso9165497otb.13;
        Fri, 07 May 2021 15:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+JwTxvkP5L75f+W39v35nFwuY+Fa/AUNZlHVWen03w=;
        b=N68CyN/lfLgasqijHDypNjWxffDvjq+8WvB2ZE4Lk8mc1LVgfIo7b4oMnolPESUiXV
         CUHtvAf17ZQKVUthL+7+LWO5497AmXSU64hI2LkEt0dF2kikkB4bm5wpkeB+f0g2nW1t
         eNR9SPMRVfnu/1Mt0Dci+yY1eyxC/kNL54lad++dktmn6Ssh5GfpBNiW+CdZsUVbZYLi
         rDAMyBIbUb5ib5QzaLHxTPnje5VEbk2wVcp8vOF5e7aluscYD+xczUR4UDnhhXhAHu4c
         kru0FXK8ZZRzY214/K0qNsI1BlOzvMX/IuiqILSK8IAVrwLiB6tEPqNOEEQxn8o88wmJ
         28cg==
X-Gm-Message-State: AOAM532nKNvvybvJ8pHSTNbTd6nsRreUGGqW4x7/FlmPMDxf426Up/E2
        iiQhPft7Ot27jnos0txtzw==
X-Google-Smtp-Source: ABdhPJwJXZ/u8YQCpF44jVtSE26QxC86aijJjzgs3C1XhultyjIZL4g2ByHBMktyIbqIrQNvlNWZmw==
X-Received: by 2002:a9d:5382:: with SMTP id w2mr9900695otg.153.1620425632197;
        Fri, 07 May 2021 15:13:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n98sm1453330ota.24.2021.05.07.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:13:51 -0700 (PDT)
Received: (nullmailer pid 2990988 invoked by uid 1000);
        Fri, 07 May 2021 22:13:50 -0000
Date:   Fri, 7 May 2021 17:13:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: Re: [PATCH] dt-bindings: spi: dw-apb-ssi: Integrate Renesas RZ/N1
 SPI controller
Message-ID: <20210507221350.GA2990934@robh.at.kernel.org>
References: <aef15aa119ed02487ded4691141678bc1040c3b4.1620301936.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef15aa119ed02487ded4691141678bc1040c3b4.1620301936.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 06 May 2021 13:52:59 +0200, Geert Uytterhoeven wrote:
> Originally, the Renesas RZ/N1 SPI Controller DT bindings were not
> integrated in the main DT bindings for the Synopsys DesignWare
> Synchronous Serial Interface, but in its own file, as the RZ/N1
> controller has additional registers for software CS control and DMA.
> 
> As so far DMA is not supported on RZ/N1, and json-schema can handle any
> possible differences fine, integrate the RZ/N1 compatible values in the
> main DT bindings for the Synopsys DW SSI.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> There are no upstream users of this binding, but it validates the
> following (modified) example taken from the RZ/N1 BSP[1] fine:
> 
>     spi0: spi@50005000 {
> 	    compatible = "renesas,r9a06g032-spi", "renesas,rzn1-spi";
> 	    reg = <0x50005000 0x400>;
> 	    interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> 	    clock-names = "ssi_clk", "pclk";
> 	    clocks = <&sysctrl R9A06G032_CLK_SPI0>, <&sysctrl R9A06G032_HCLK_SPI0>;
> 	    #address-cells = <1>;
> 	    #size-cells = <0>;
> 	    spi-max-frequency = <12500000>;
> 	    num-cs = <4>;
>     };
> 
> [1] https://github.com/renesas-rz/rzn1_linux/blob/rzn1-stable-v4.19/arch/arm/boot/dts/rzn1.dtsi
> ---
>  .../devicetree/bindings/spi/renesas,rzn1-spi.txt      | 11 -----------
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      |  6 ++++++
>  2 files changed, 6 insertions(+), 11 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
