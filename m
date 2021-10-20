Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C997443551F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJTVRE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 17:17:04 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45623 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhJTVRE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 17:17:04 -0400
Received: by mail-ot1-f54.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so9804655otq.12;
        Wed, 20 Oct 2021 14:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FqHQxiZxwpwoHOeUejJBI/puDRrvMLtd3ZP39nADFy4=;
        b=HHGqxD4xPEGY/gTrMB4OMyE5Xmg6jSdD/3kEFeKLzhNEddKWTsLQZfGXYdv1BLh2le
         ABpNUTgQevw6CVD+sfZ2ir8LvZ1b8VFJXaFl0ahrCTg3BWq73ZqvCDXfh8ZqsPp49xbS
         bUOH1TiTi/L9ygDwgpVRZW77Q9iP9l6wJ2qPf65Htm/9sDcrvdmXZVVlfjyW2b848f80
         gWi1PuBKtn83a+x3WsXxGJ8Ukl5X7V2qHaalTTpVxnVw5yRjfj3BW+KsAyblhCM2rs0N
         dX0QNFt+K80Mcmr4cQBjctjbUbi1b3qTcMAvYT4ye/FrCw6alQr736/NWbv+MuMYWv2A
         3iJg==
X-Gm-Message-State: AOAM533Ag0IloWqFl33xq3FwLsuITad2m2lxjF3pjtr+0ikLBQgt3aBH
        EKadf7tuIb6Vt4zGBoCWHqrV383qpw==
X-Google-Smtp-Source: ABdhPJydY4OKhyFAzzRNT+vCw1CPPIY1+7r+oim4QB91AmD3aJAyBsk5LyoVHeAHr7EjFFgg3a4JKg==
X-Received: by 2002:a9d:7283:: with SMTP id t3mr1383112otj.268.1634764489116;
        Wed, 20 Oct 2021 14:14:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h91sm658707otb.38.2021.10.20.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:14:48 -0700 (PDT)
Received: (nullmailer pid 2962584 invoked by uid 1000);
        Wed, 20 Oct 2021 21:14:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Julien Su <juliensu@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        devicetree@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20211020142809.349347-4-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com> <20211020142809.349347-4-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 03/18] dt-bindings: mtd: nand-chip: Create a NAND chip description
Date:   Wed, 20 Oct 2021 16:14:47 -0500
Message-Id: <1634764487.024191.2962583.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:54 +0200, Miquel Raynal wrote:
> Move the NAND chip description out of the NAND controller file. Indeed,
> a subsequent part of the properties supported by a raw NAND chip are
> also supported by SPI-NAND chips. So let's create a generic NAND chip
> description which will be pulled by nand-controller.yaml and later by
> spi-nand.yaml as well.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/mtd/nand-chip.yaml    | 71 +++++++++++++++++++
>  .../bindings/mtd/nand-controller.yaml         | 53 ++------------
>  2 files changed, 75 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.example.dt.yaml: nand-controller@f0442800: nand@1: '#address-cells', '#size-cells', 'compatible', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.example.dt.yaml: nand-controller@f0442800: nand@1: '#address-cells', '#size-cells', 'compatible', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.example.dt.yaml: nand-controller@10000200: nand@0: '#address-cells', '#size-cells', 'compatible', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/brcm,brcmnand.example.dt.yaml: nand-controller@10000200: nand@0: '#address-cells', '#size-cells', 'compatible', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/ingenic,nand.example.dt.yaml: nand-controller@1: nand@1: 'nand-ecc-mode', 'nand-on-flash-bbt', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/ingenic,nand.example.dt.yaml: nand-controller@1: nand@1: 'nand-ecc-mode', 'nand-on-flash-bbt', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.example.dt.yaml: nand-controller@ff4b0000: nand@0: 'label', 'nand-bus-width', 'nand-ecc-mode', 'nand-is-boot-medium', 'rockchip,boot-blks', 'rockchip,boot-ecc-strength' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.example.dt.yaml: nand-controller@ff4b0000: nand@0: 'label', 'nand-bus-width', 'nand-ecc-mode', 'nand-is-boot-medium', 'rockchip,boot-blks', 'rockchip,boot-ecc-strength' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.example.dt.yaml: nand-controller@58002000: nand@0: '#address-cells', '#size-cells', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.example.dt.yaml: nand-controller@58002000: nand@0: '#address-cells', '#size-cells', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/intel,lgm-nand.example.dt.yaml: nand-controller@e0f00000: nand@0: 'nand-ecc-mode' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/intel,lgm-nand.example.dt.yaml: nand-controller@e0f00000: nand@0: 'nand-ecc-mode' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.example.dt.yaml: nand-controller@1ac00000: nand@0: 'nand-bus-width', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.example.dt.yaml: nand-controller@1ac00000: nand@0: 'nand-bus-width', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.example.dt.yaml: nand-controller@79b0000: nand@0: 'nand-bus-width', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.example.dt.yaml: nand-controller@79b0000: nand@0: 'nand-bus-width', 'partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.example.dt.yaml: nand-controller@4,0: nand@0: '#address-cells', '#size-cells', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.example.dt.yaml: nand-controller@4,0: nand@0: '#address-cells', '#size-cells', 'nand-on-flash-bbt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/nand-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1543921

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

