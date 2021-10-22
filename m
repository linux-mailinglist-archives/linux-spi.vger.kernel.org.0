Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF4438047
	for <lists+linux-spi@lfdr.de>; Sat, 23 Oct 2021 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhJVWij (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 18:38:39 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33559 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJVWii (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 18:38:38 -0400
Received: by mail-ot1-f53.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso6189949otv.0;
        Fri, 22 Oct 2021 15:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOXe3VMjgKim4OsLC2/pNiSdoxCkW2CDkjd2aP4EASQ=;
        b=jcrb5WbHw+bgoj0q7kEOh0OGuFh4PLR/3LceV5z1nbwwlqKw6S118MeZaay89Omg0G
         udbSsLoX3ckpMVOGoHcOAFKz2IyW9ahXTaYhoRcBbuZS4Ebt4c7IleNAo+iFHFPRIlBK
         U4HEMyQZnG+IbyMc9rB6DGri/MQpFCQ29dbx07B+0Dd0vkFR8i6Uf5/9+ZMH/Tuzby+l
         OSQT62zhkWESKzXfpvvk28WvzUJeV06LIHaLvPsV73+Nbo/aGay6Hnw5NX1ABdN4J9Eg
         XWu1UVGbd3YyjQN2KKAT6QgtWluweyqOlQ47DfOOMyQNX8QBIGnlKmdFpjetD1FhNdq6
         vh3Q==
X-Gm-Message-State: AOAM532/nmIi7Qqzri0T5Bt4PdI4dgsx4AIOebDOtprAdTqb3SIK1aGP
        +QmzriZch6ca5OLHZCd0TIyH0xHwyg==
X-Google-Smtp-Source: ABdhPJz3YY0oBGgzE95RJYSfRS7Vop51WChSu23ig9VAzKncjIpwvEfV3xpMXLgwneL2AKN6pHrWgA==
X-Received: by 2002:a05:6830:2386:: with SMTP id l6mr2082728ots.88.1634942180249;
        Fri, 22 Oct 2021 15:36:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm1981116otm.50.2021.10.22.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:36:19 -0700 (PDT)
Received: (nullmailer pid 3294476 invoked by uid 1000);
        Fri, 22 Oct 2021 22:36:18 -0000
Date:   Fri, 22 Oct 2021 17:36:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Julien Su <juliensu@mxic.com.tw>,
        linux-spi@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] dt-bindings: mtd: spi-nand: Convert spi-nand
 description file to yaml
Message-ID: <YXM84oCOAr6pSOw2@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-5-miquel.raynal@bootlin.com>
 <1634764487.038982.2962586.nullmailer@robh.at.kernel.org>
 <20211021160932.4169f66f@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021160932.4169f66f@xps13>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 21, 2021 at 04:09:32PM +0200, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Wed, 20 Oct 2021 16:14:47 -0500:
> 
> > On Wed, 20 Oct 2021 16:27:55 +0200, Miquel Raynal wrote:
> > > Let's get rid of spi-nand.txt by converting it to yaml schema. While at
> > > converting this file, let's actually pull all the generic properties
> > > from nand-chip.yaml which might apply to a SPI-NAND chip.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../devicetree/bindings/mtd/spi-nand.txt      |  5 ----
> > >  .../devicetree/bindings/mtd/spi-nand.yaml     | 27 +++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 5 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > >   
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> > xargs: dt-doc-validate: exited with status 255; aborting
> > make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml'
> > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
> > make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml] Error 255
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1441: dt_binding_check] Error 2
> 
> I am not able to reproduce this error and in general I don't understand
> it. There is no relationship between this change and
> snps,dw-apb-ssi.yaml. Also the fact that nand-chip-yaml do not exist,
> it was just created in the patch before so I wonder how much I should
> trust this error.

I think you can ignore this. The prior patch should have been applied, 
but looks like it wasn't. My script's patch applying logic is not what 
I'd call robust.

> Also, maybe I am not using the tools properly, but it is very hard to
> send correct bindings at the first try. Running make dt_binding_check
> takes ages, any change in one yaml file will recheck the entire data
> base and filtering out on a single yaml file is generally too
> restrictive and still prints unrelated errors of syntax on other files.

Do you set 'DT_SCHEMA_FILES'? That will check just the schema you set 
it to. You still need to not set it at the end because any schema could 
apply to any example, so we have to check everything.

Also using DT_SCHEMA_FILES should be a bit faster with what's queued for 
5.16.

> I don't know how much of this is actually expected and/or if someone is
> working on it.

Due to python startup times being slow, it turns out to generally be 
faster to not have make track changes and do things incrementally. 
That's why all the schema are checked at once (though sharded with 
xargs). So I'm not really sure there's much we can do. I've certainly 
investigated it.

Rob
