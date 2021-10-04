Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AAB4214DD
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhJDRLm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:11:42 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36683 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhJDRLm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 13:11:42 -0400
Received: by mail-oi1-f179.google.com with SMTP id y201so22516384oie.3;
        Mon, 04 Oct 2021 10:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KLq9MkcpxBGVB7sgiyeCQaUXR/d16n3LEbxVLt/cqg=;
        b=kChq6Lz06yp2ddKLDr3yxU9ZS6r0fx8VSwFKuh0XWy9AJpeptxbBhWj76Ce4ZADGV/
         25trhaCd02OV4x3WS46oUGURpPCc850doSfoxwy4Rva+otCLJFcIHBVk9MFogbDh4M2E
         O8aJfTa3UHa1QU97K+2FEsQ4N9qC5KvqsGLaaYuKKxwEKj3W6D7zl03B5QecMXxX9nwk
         ozYlS25XTj+cCLM0ES8LTQFt+0Djw1rL6OE3lxyqoagarSd9YY3z9Aulrrkfj4wDRDGx
         IE8cGcpQzA7nTlLGlzWXcHZ7u3y9rpKrZ/ow1WG9L9m5SEh+LQTwQslNtqEUdkxEJgVn
         n64g==
X-Gm-Message-State: AOAM5306DShRPCKK1i5B6ithfHdR7OACYq8mKsMQBZQgb2+veXWPdG52
        3f0aPv0/Y5GFE08AF2+Aww==
X-Google-Smtp-Source: ABdhPJwpGLcCHuQ/ilTbzTySohMcTJl/JUKbz4U1S+2nZLmVieFfoTMv2OP5e4KmB3Dqpn/bYl08mg==
X-Received: by 2002:a05:6808:57d:: with SMTP id j29mr15099829oig.80.1633367392344;
        Mon, 04 Oct 2021 10:09:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f61sm2998816otf.73.2021.10.04.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:09:50 -0700 (PDT)
Received: (nullmailer pid 1488976 invoked by uid 1000);
        Mon, 04 Oct 2021 17:09:49 -0000
Date:   Mon, 4 Oct 2021 12:09:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-spi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1] dt-bindings: mtd: spi-nor: use unevaluatedProperties:
 false
Message-ID: <YVs1XZmeIdix1m1V@robh.at.kernel.org>
References: <20210924180705.14021-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924180705.14021-1-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 24, 2021 at 11:37:05PM +0530, Pratyush Yadav wrote:
> Many SPI controllers need to add properties to slave devices. This could
> be the delay in clock or data lines, etc. These properties are
> controller specific but need to be defined in the slave node because
> they are per-slave and there can be multiple slaves attached to a
> controller.
> 
> If these properties are not added to the slave binding, then the dtbs
> check emits a warning. But these properties do not make much sense in
> the slave binding because they are controller-specific and they will
> just pollute every slave binding.
> 
> One option is to add a separate schema that collects all such properties
> from all such controllers. Slave bindings can simply refer to this
> binding and they should be rid of the warnings.
> 
> There are some limitations with this approach:
> 
> 1. There is no way to specify required properties. The schema would
> contain properties for all controllers and there would be no way to know
> which controller is being used.
> 
> 2. There would be no way to restrict additional properties. Since this
> schema will be used with an allOf operator, additionalProperties would
> need to be true. In addition, the slave schema will have to set
> unevaluatedProperties: false.

I don't see what is the problem. If there's a $ref, then 
unevaluatedProperties is what should be used.

> 
> A much simpler option would be to make controller schemas specify those
> properties in patternProperties and set unevaluatedProperties to false
> on slave schemas, which is done in the previous approach anyway. This
> approach would have the same limitations as the 2nd limitation in the
> previous approach. But it does not have the 1st limitation since the
> properties of all controllers are not collected in a single schema, but
> instead reside in the same schema as the controller. It also has the
> added benefit of being much simpler.
> 
> The SPI NOR binding is taken as the first one to follow this. Other
> bindings like SPI NAND can follow in later patches.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> I sent the first approach mentioned in the commit message some time ago
> [0]. When re-rolling this series I realized that if we are going to use
> unevaluatedProperties: false, then it would be much simpler to just keep
> everything else as-is. This has clear positives with no negatives
> relative to [0], as explained in the commit message.
> 
> [0] https://lore.kernel.org/all/20210609111707.9555-1-p.yadav@ti.com/T/#u
> 
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

This only works until unevaluatedProperties support is actually 
implemented. Then it's back to the same warnings. In the mean time, we'd 
be allowing any extra random properties to be added for everyone.

Rob
