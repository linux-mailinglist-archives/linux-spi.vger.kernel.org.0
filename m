Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0D4659BA
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353805AbhLAXXw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 18:23:52 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34340 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353839AbhLAXXo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 18:23:44 -0500
Received: by mail-ot1-f45.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso37520492otj.1;
        Wed, 01 Dec 2021 15:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3VfKp0svPniJPx3S2KRfg6+sZau5YCfKLct8VulnAI=;
        b=dEjwfDYLp21t5uaa56TkGqiFGOskNyCF0iTUJ1gCuL2WjZnEAWYDN3Y2UnV7smi68E
         HAzFPNs5blHtpmMMd0a6JJ4X58RDMbWWE2ehTyJ/WHKAiqonq3IQrumTAgro3aXDNmrj
         U9UCUFF7WfohGo7lerHlJsRAAa2nVmZkTPlMH2z46Cj/64ylcx4tl7R3zH0zM9918sUy
         CCAZQ3xV+Sm6nKysW8BnGwV6rsjBSJpiBMcdh/3WHJWCorOLQoz2XBfgpl4K9V4/I1wt
         osKH6K2h2P8NgamYQ/+GBPFwXlpiJEJ5T0YACGvOV4wbL+3M6j12BojYXisu7tWT8hvF
         MplA==
X-Gm-Message-State: AOAM532m6My7Lu72OTzqpeDJpoFnXf1dqb7dBde24Z5OjIJmc7x8P5nS
        UFL5e5tw4pEMkplS/vUOIw==
X-Google-Smtp-Source: ABdhPJwgXa+JwMa+UIdiWdNVSPZAGFCYemTgRhJO5gLo2NywfsC7syhoN5+dj5qjTcDpaGEdqoWfUg==
X-Received: by 2002:a05:6830:2b14:: with SMTP id l20mr8617911otv.42.1638400822290;
        Wed, 01 Dec 2021 15:20:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb8sm629332oib.9.2021.12.01.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:20:21 -0800 (PST)
Received: (nullmailer pid 3150169 invoked by uid 1000);
        Wed, 01 Dec 2021 23:20:20 -0000
Date:   Wed, 1 Dec 2021 17:20:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 03/20] dt-bindings: mtd: nand-chip: Create a NAND chip
 description
Message-ID: <YagDNLy+gGFiH5oU@robh.at.kernel.org>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
 <20211126113924.310459-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126113924.310459-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 26, 2021 at 12:39:07PM +0100, Miquel Raynal wrote:
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
> diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
> new file mode 100644
> index 000000000000..6d13e8cdbb21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/nand-chip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAND Chip and NAND Controller Generic Binding
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +description: |
> +  This file covers the generic description of a NAND chip. It implies that the
> +  bus interface should not be taken into account: both raw NAND devices and
> +  SPI-NAND devices are concerned by this description.
> +
> +properties:
> +  reg:
> +    description:
> +      Contains the chip-select IDs.
> +
> +  nand-ecc-engine:
> +    allOf:

Can you drop the allOf here.

> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      A phandle on the hardware ECC engine if any. There are
> +      basically three possibilities:
> +      1/ The ECC engine is part of the NAND controller, in this
> +      case the phandle should reference the parent node.
> +      2/ The ECC engine is part of the NAND part (on-die), in this
> +      case the phandle should reference the node itself.
> +      3/ The ECC engine is external, in this case the phandle should
> +      reference the specific ECC engine node.
> +
> +  nand-use-soft-ecc-engine:
> +    type: boolean
> +    description: Use a software ECC engine.
> +
> +  nand-no-ecc-engine:
> +    type: boolean
> +    description: Do not use any ECC correction.
> +
> +  nand-ecc-algo:
> +    description:
> +      Desired ECC algorithm.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [hamming, bch, rs]
> +
> +  nand-ecc-strength:
> +    description:
> +      Maximum number of bits that can be corrected per ECC step.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +
> +  nand-ecc-step-size:
> +    description:
> +      Number of data bytes covered by a single ECC step.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +
> +  secure-regions:
> +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +    description:
> +      Regions in the NAND chip which are protected using a secure element
> +      like Trustzone. This property contains the start address and size of
> +      the secure regions present.
> +
> +required:
> +  - reg
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 5cd144a9ec99..44825dc95412 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -52,32 +52,15 @@ properties:
>  patternProperties:
>    "^nand@[a-f0-9]$":
>      type: object
> +
> +    allOf:

Also not needed here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      - $ref: "nand-chip.yaml#"
> +
