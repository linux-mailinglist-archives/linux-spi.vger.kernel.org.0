Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA19E4749EF
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 18:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhLNRp2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 12:45:28 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33677 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbhLNRp1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 12:45:27 -0500
Received: by mail-oi1-f178.google.com with SMTP id q25so28281798oiw.0;
        Tue, 14 Dec 2021 09:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDAQFAlYmMYrsN3W7pDsfMhVrlZtlZ4Z+Zsjot1vjnE=;
        b=dYuGe/UKd4xOeDz0X1bbssgYhN6btNWl6Hcb1qlWxwr9bebbOEUQ5i44ZYc1CUlFm7
         xLQdnrnNVPjpsZrAdgSnt+WR9Vg4tbGDkjgf4CIFzC7rtoTbaNWwcK3CKtXxhr2JWLOx
         DoJxaefA1i4QZV9y5aaGKXjd/67rwdFcRFNlx6Q7wj2a//qs8kkc5BwMGCb+fsCg9HUG
         H3KGZFz4GFOHwb6ZJ0AtMhD+n8DgrUeBLud8iQO/EFKbrXfeg3qkCI2voxi6y6yQ/eJf
         DeZoVqDkUXWy0xNnbOekcfExDANUDgyZqNQw2Iy8ir0013+92x+ttzVNpGhcuxgFXdsn
         aucg==
X-Gm-Message-State: AOAM531gN9gc6YpjvBLB904knSuWR4ueCKZMihmyTzB89gxQQGorR16K
        DttOB3ADsLxqa/RWUb2O9g==
X-Google-Smtp-Source: ABdhPJyv9araoJQUDNF2ES2aBqcsEhsMdYAqkrICAwluC2ddu59UxTqLaT/hJbItOG8FqVqQUhhGqQ==
X-Received: by 2002:a05:6808:1413:: with SMTP id w19mr5600749oiv.128.1639503927011;
        Tue, 14 Dec 2021 09:45:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w4sm89501oiv.37.2021.12.14.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:45:26 -0800 (PST)
Received: (nullmailer pid 3616024 invoked by uid 1000);
        Tue, 14 Dec 2021 17:45:25 -0000
Date:   Tue, 14 Dec 2021 11:45:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v3 03/22] dt-bindings: mtd: nand-controller: Harmonize
 the property types
Message-ID: <YbjYNVOVL/sLda9H@robh.at.kernel.org>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
 <20211207093422.166934-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207093422.166934-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 07, 2021 at 10:34:03AM +0100, Miquel Raynal wrote:
> Harmonize the different properties in this file by:
> * dropping the non-necessary allOf's
> * always defining the keywords in the following order:
>     - first: "type"/"$ref",
>     - second: "description" (when relevant),

If we're going to muck with this, really I prefer description first or 
last and everything else together.

>     - then the other generic keywords ("enum", "default", etc).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/mtd/nand-controller.yaml | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 5cd144a9ec99..7024ca24c2e2 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -58,8 +58,7 @@ patternProperties:
>            Contains the chip-select IDs.
>  
>        nand-ecc-engine:
> -        allOf:
> -          - $ref: /schemas/types.yaml#/definitions/phandle
> +        $ref: /schemas/types.yaml#/definitions/phandle
>          description: |
>            A phandle on the hardware ECC engine if any. There are
>            basically three possibilities:
> @@ -79,25 +78,24 @@ patternProperties:
>          description: Do not use any ECC correction.
>  
>        nand-ecc-placement:
> -        allOf:
> -          - $ref: /schemas/types.yaml#/definitions/string
> -          - enum: [ oob, interleaved ]
> +        $ref: /schemas/types.yaml#/definitions/string
>          description:
>            Location of the ECC bytes. This location is unknown by default
>            but can be explicitly set to "oob", if all ECC bytes are
>            known to be stored in the OOB area, or "interleaved" if ECC
>            bytes will be interleaved with regular data in the main area.
> +        enum: [ oob, interleaved ]
>  
>        nand-ecc-algo:
> +        $ref: /schemas/types.yaml#/definitions/string
>          description:
>            Desired ECC algorithm.
> -        $ref: /schemas/types.yaml#/definitions/string
>          enum: [hamming, bch, rs]
>  
>        nand-bus-width:
> +        $ref: /schemas/types.yaml#/definitions/uint32
>          description:
>            Bus width to the NAND chip
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [8, 16]
>          default: 8
>  
> @@ -113,15 +111,15 @@ patternProperties:
>            build a volatile BBT in RAM.
>  
>        nand-ecc-strength:
> +        $ref: /schemas/types.yaml#/definitions/uint32
>          description:
>            Maximum number of bits that can be corrected per ECC step.
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          minimum: 1
>  
>        nand-ecc-step-size:
> +        $ref: /schemas/types.yaml#/definitions/uint32
>          description:
>            Number of data bytes covered by a single ECC step.
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          minimum: 1
>  
>        nand-ecc-maximize:
> -- 
> 2.27.0
> 
> 
