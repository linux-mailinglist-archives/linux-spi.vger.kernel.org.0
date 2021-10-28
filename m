Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2F43F1F3
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJ1VlM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:41:12 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38599 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1VlM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:41:12 -0400
Received: by mail-oi1-f180.google.com with SMTP id t4so10284361oie.5;
        Thu, 28 Oct 2021 14:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6OiNYLAxsFXPFjL0FqyFvTnwfqy6iGdQjj9Dv8HGhtw=;
        b=oOC/gyb3JyCuNjj/TY0e/9L5hdBXLUKgFJ4ghshcwfLujt4grw2abN1eZsZ+rsgv8O
         KOQO18xBxtcIA6wMsh24snpNXjWA2rARZ4CneMi7xODS1teK4BWsWYAwMjMwsWnZeSL3
         DRrOxQrvfyLaRZsbnRCqfLbxWYZSUHCPQR5hmlw8d9y0Xd0n75vrFAROmCUCiKIHnz30
         8ywMhslP/DFAuA5yAkfANmoPS9vtzIWo/jvCotoOG01X58ZFNU7kdaCv+y0LKnex7J7V
         avJzWicwTkFQh0lWs+ZqUr8Cmu0pWUP52QPHg6QSaRkFIHX9viXIEIak5FXlGxzQsO25
         Eqow==
X-Gm-Message-State: AOAM53399kMhWoAJqz1f3j6p1XetoLIZWgifWRIG0g8PKneu0/r7Y8Ih
        MpjHqBmPkXidSHF8YGgw/w==
X-Google-Smtp-Source: ABdhPJxutP3x4GwMxsrgkPLF2C0wZhHfpPHmdB7Z+SB06+/wmcoJve0rxdzTGctUMhJZaHnPWesQ7A==
X-Received: by 2002:a05:6808:1898:: with SMTP id bi24mr5172217oib.3.1635457124640;
        Thu, 28 Oct 2021 14:38:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q15sm1381169otm.15.2021.10.28.14.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:38:44 -0700 (PDT)
Received: (nullmailer pid 632711 invoked by uid 1000);
        Thu, 28 Oct 2021 21:38:43 -0000
Date:   Thu, 28 Oct 2021 16:38:43 -0500
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
Subject: Re: [PATCH 09/18] dt-bindings: spi: mxic: Document the
 nand-ecc-engine property
Message-ID: <YXsYY6JaglRjan+L@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-10-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-10-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 04:28:00PM +0200, Miquel Raynal wrote:
> This SPI controller supports interacting with an external ECC
> engine. The nand-ecc-engine property already exist in the NAND world but
> also applies to SPI controller nodes which have external correction
> capabilities like Macronix's.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)

This should come before patch 8. The example would fail if 
'unevaluatedProperties' did anything.

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
> index 4036c14fc533..01618a77627d 100644
> --- a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
> @@ -43,6 +43,12 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  nand-ecc-engine:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +    description: NAND ECC engine used by the SPI controller in order to perform
> +      on-the-fly correction when using a SPI-NAND memory.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.27.0
> 
> 
