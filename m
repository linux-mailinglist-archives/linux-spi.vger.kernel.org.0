Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FB4127D5
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhITVUY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 17:20:24 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34308 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhITVSX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 17:18:23 -0400
Received: by mail-ot1-f41.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso25500499otp.1;
        Mon, 20 Sep 2021 14:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDoO1eNc1NTHogLdYUD9nVb5nV1LrqSfsmfysobQaT4=;
        b=Iv428HhpJDMmj3LfSp/1fS2CPygLPuJkNRE19p7Sgmbey5XgcjevwnXnQ47F0i9dS4
         bjOtpVJI6LsCg6fUm1AhiZT2wUqhs+TahuWsiOlV3HdDKJ1USSLLc27UrhxKuOqQZBcM
         /tyz2WbTjo6SkM6pDBjEjCvmU2859+U8IqR7bYFs4nzy9mZwrpND7NhfuG+AFefqux5r
         Iu2ypeyrG9dZisYmmozw3LffDfkPhcmD8SZPeOdwZMxdoZ+mqPMw8cxf2T8ZuMDL3CDn
         dPYYIpUMrezbkQYo0Mx0eEkLsHxyYDFJq58QCi2Jt1ka2OLIiXOPSAehz0QGT6tswhba
         X7sw==
X-Gm-Message-State: AOAM533pE+XU57WUGWg35Xo2H5AMtMSv7Lqzj11Mnhh/Z/xSZcUZDDiJ
        oYGLygxQ7UK3KyRrRjyCRg==
X-Google-Smtp-Source: ABdhPJwgM1Zno5vb1ov2P0RomgoqPf3fWk0ZwdFXPRmp8uvBGNSDGDoqkdBmCWe15JjdW2tDaLW4zA==
X-Received: by 2002:a9d:719e:: with SMTP id o30mr22262620otj.20.1632172615469;
        Mon, 20 Sep 2021 14:16:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c37sm3611930otu.60.2021.09.20.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:16:54 -0700 (PDT)
Received: (nullmailer pid 781168 invoked by uid 1000);
        Mon, 20 Sep 2021 21:16:53 -0000
Date:   Mon, 20 Sep 2021 16:16:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Apurva Nandan <a-nandan@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema
 format
Message-ID: <YUj6RUNYDoWA30Ln@robh.at.kernel.org>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-2-a-nandan@ti.com>
 <20210920150651.vvdhennblwhdi3jw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920150651.vvdhennblwhdi3jw@mobilestation>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 06:06:51PM +0300, Serge Semin wrote:
> Hello Apurva
> 
> On Mon, Sep 20, 2021 at 07:57:12PM +0530, Apurva Nandan wrote:
> > Convert spi-nand.txt binding to YAML format with an added example.
> > 
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
> >  .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
> >  2 files changed, 62 insertions(+), 5 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> >  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> 
> Thanks for the bindings conversion patch. There are several comments
> below. But before addressing them it would be better to also get a
> response from Rob.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> > deleted file mode 100644
> > index 8b51f3b6d55c..000000000000
> > --- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > -SPI NAND flash
> > -
> > -Required properties:
> > -- compatible: should be "spi-nand"
> > -- reg: should encode the chip-select line used to access the NAND chip
> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > new file mode 100644
> > index 000000000000..601beba8d971
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI NAND flash
> > +
> > +maintainers:
> > +  - Apurva Nandan <a-nandan@ti.com>
> > +
> > +allOf:
> > +  - $ref: "mtd.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    const: spi-nand
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> 
> > +  spi-max-frequency: true
> > +  spi-rx-bus-width: true
> > +  spi-tx-bus-width: true
> > +  rx-sample-delay-ns: true
> 
> Since it's an SPI-client device there are more than these properties
> could be set for it. See the SPI-controller bindings schema:
> Documentation/devicetree/bindings/spi/spi-controller.yaml
> So there is two possible ways to make it more generic:
> 1) Detach the spi-client part from the spi-controller.yaml bindings
> into a dedicated DT-schema file and refer to that new scheme from
> here.

Yes, as mentioned there's patches doing this. But the above is fine. 
There's some value in defining here which properties are valid.

> 2) Forget about these controller-specific properties and let the
> parental SPI-controller bindings parsing them. Of course there must be
> at least one of the next properties declared for it to work:
> {unevaluatedProperties, additionalProperties}.
> 
> It's up to Rob to decided which approach is better though...
> 
> > +
> > +  '#address-cells': true
> > +  '#size-cells': true
> 
> Aren't they always equal to 1?

No SPI nand devices >4GB?

> 
> > +
> > +additionalProperties:
> > +  type: object
> 
> I'd suggest to elaborate the way the partition sub-nodes looks
> like, for instance, the node names, supported compatible names,
> labels, etc.

That should probably all be in mtd.yaml. The question here is whether 
partitions are always under a 'partitions' node. Maybe this is new 
enough that only the new way has to be supported. Though if mtd.yaml 
supported both forms, allowing both all the time is okay IMO.

Rob
