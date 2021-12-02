Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C6465A64
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 01:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353989AbhLBAJG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 19:09:06 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35506 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbhLBAJE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 19:09:04 -0500
Received: by mail-oi1-f170.google.com with SMTP id m6so52099315oim.2;
        Wed, 01 Dec 2021 16:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bkKn3tZ7FiBBVjYUALy+8qnEtiYJ39lDvMOVGYdBNQ=;
        b=k5VNZf+XQ6AweBB56fABx21DcaPiir/yfocBb8ucBTrRJte/Mh3Ggf/ZMFCJSo0gYy
         Dx2ErkTvzeTnY+J5DLPolr3eKNq2+lmegDMSIe0GhrtWmYRe3VbxcbLxV2NEO3RisbT1
         jUyVdRe9sf7bcNhwOQ4BeDbxKX6JAXVHP2QytyEBD/zAXbfnEuphzQ+/8HuYUSJUgyab
         AoRrUgNI3viYt2P9dLcN1FoxlmU1Xs+Ra+9NytwZuFCSmrM5ZVTH3bEn+fOfaQsPauYU
         w/zrORO042PGB8NuwV14pMPN9bYeARV48d7TyZ1rGclorgIkLhiv4jrzwLvxhRXaVZ23
         5F1g==
X-Gm-Message-State: AOAM533vEwVWcavnm7NKxEVGLzssidzSihHL3Eo5EXlPTwJ+qOCT7coh
        /mkTXkkx2+soAUMhbsWWuA==
X-Google-Smtp-Source: ABdhPJxvdKd5rlLlmcEgsM/v7ECzfatKekSh4MbmYVPn8M3B5sIO32f72Plo/XfSU7NkhSXcBeLbGA==
X-Received: by 2002:a05:6808:1aa8:: with SMTP id bm40mr1592625oib.38.1638403543151;
        Wed, 01 Dec 2021 16:05:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 109sm520704otv.30.2021.12.01.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:05:42 -0800 (PST)
Received: (nullmailer pid 3267913 invoked by uid 1000);
        Thu, 02 Dec 2021 00:05:41 -0000
Date:   Wed, 1 Dec 2021 18:05:41 -0600
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
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 2/5] dt-bindings: mtd: spi-nor: Allow external
 properties
Message-ID: <YagN1c7/Ltt/mhNp@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126163450.394861-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 26, 2021 at 05:34:47PM +0100, Miquel Raynal wrote:
> Setting "additionalProperties: false" will refuse any generic SPI
> property while they should be of course authorized. In practice it looks
> like many people used compatibles different than "jedec,spi-nor" in
> order to workaround this limitation because otherwise no SPI property
> could be used in the examples. Use "unevaluatedProperties: false"
> instead to allow defined properties to be used. It is likely that at the
> time of the conversion to yaml of the jedec file, the unevaluated
> keyword was not yet introduced.
> 
> Fixes: 3ff9ee2a8890 ("dt-bindings: mtd: spi-nor: Convert to DT schema format")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index ed590d7c6e37..81be0620b264 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -88,7 +88,7 @@ patternProperties:
>    "^otp(-[0-9]+)?$":
>      type: object
>  
> -additionalProperties: false
> +unevaluatedProperties: false

This has no effect unless you have referenced some other schema here. 
The series I referenced will solve what your trying to solve I think.

Rob
