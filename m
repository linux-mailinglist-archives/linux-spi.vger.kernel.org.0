Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4E438063
	for <lists+linux-spi@lfdr.de>; Sat, 23 Oct 2021 00:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJVWt6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 18:49:58 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43797 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJVWtv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 18:49:51 -0400
Received: by mail-oi1-f181.google.com with SMTP id o4so6841017oia.10;
        Fri, 22 Oct 2021 15:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NuD6bogNZk9RrvAuHPuJ1Tao9hcVN0ozF9HHBb/7+oc=;
        b=OQP3aPe9/WShtRfENUZxUyGTr873wWIu2sFspSPBoEVQy3uRf0lTBVEf7bfqEmMgk4
         gISm3uOMaU8fKg+EQxxYrmKmFnmWAWgDw83y1GLQ1y0zI8zpRc2gjDJ0JergImbMRvdZ
         OnSq3zwzBRDsXXxsjom93fixvY1W2KGHSYubwCOn49rpL4rKpD8FGkMI+e4Jzrkrlj4z
         EHbaP5g5V3/yk3KFcX0GJHn2C57O5tCjslWK5s1oBJbc0w2iMcSyHhCE6p0S+pT5aF3j
         xxQZtvoZvkXJBEl6Eiou1lLPb5bDD21EtzwOYz7YVcCEevO4DdyTTxbFhggTnxrAXPFy
         34MA==
X-Gm-Message-State: AOAM532D6GHPJ1GSD4HArNvgvZY83NCl7h3w4gF0bMoCBe7I8WcAhXxr
        2BkHZ7TudmLEbVqvpIee+Q==
X-Google-Smtp-Source: ABdhPJxlp2fL4Skst4jfVYsFRVcGyOBV+4iSlYe8p+vWxwSKWx6gTbwQwo/LS4qXMBg51++bzqqYQQ==
X-Received: by 2002:a05:6808:ec3:: with SMTP id q3mr1836622oiv.57.1634942852960;
        Fri, 22 Oct 2021 15:47:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f13sm1953909oto.53.2021.10.22.15.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:47:32 -0700 (PDT)
Received: (nullmailer pid 3310215 invoked by uid 1000);
        Fri, 22 Oct 2021 22:47:30 -0000
Date:   Fri, 22 Oct 2021 17:47:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>
Subject: Re: [PATCH 03/18] dt-bindings: mtd: nand-chip: Create a NAND chip
 description
Message-ID: <YXM/giZYKFc0BJHe@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 04:27:54PM +0200, Miquel Raynal wrote:
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
> index 000000000000..1f230a3ee27d
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
> +additionalProperties: false

This is the source of the errors reported as this wasn't set before. If 
we're allowing custom properties (not defined here) within nand chip 
nodes, then each schema with custom properties has to reference 
nand-chip.yaml, set 'unevaluatedProperties: false', and then define 
their custom properties. And then this needs to be true. 

Rob
