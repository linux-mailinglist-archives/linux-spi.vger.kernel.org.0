Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E636435522
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhJTVRJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 17:17:09 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33359 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhJTVRH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 17:17:07 -0400
Received: by mail-ot1-f51.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso8160063otv.0;
        Wed, 20 Oct 2021 14:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dmICp/48/qSEs70Ri+eIX62qUssRgZltzHF+47kbHhk=;
        b=yxHc1va7a3v357yHBJaBHcAvuQTWXhhLafwiLIYRfRD+Z76JhORJFTG4HeQ4Ccg8x1
         WoFHNMXy2beAjh6YoimU92gEY4x1yW4YrpJ6URH7W+X42lxn302lzzcS87ZRPv3Az91B
         UTZqD/Wwu1mTZZ0HMv5xZ40u33RaMl/dL9JTvcuR1/U8OXIkqhGkOFOs9YA9uInPTye9
         xTnFNEkS2lyk55J8xnFzRpedYjDDoYlsHJ3rpvSWV+Fx4k53s9O909sRJSgUA+XSoSzd
         xJPYfgHx0uNnuk6Uq3tgxsImcQO8CdGEePTiPgAfxO62cunex5lUMsYlFeg0hVc4v5uf
         /KSA==
X-Gm-Message-State: AOAM531gpSBti1jYz24VBBN4WF0v/gty5odjY9GdLqVusrlFK7Ni2Li/
        kIpS8Yrg+NA0mMmRgi79xg==
X-Google-Smtp-Source: ABdhPJzFQpY139+LDDMM4EG73vjZiHXnA+KX2/jVPuaZ0J/OUKjeaw7YvzggrjVYGN3KqAOf2IVyhw==
X-Received: by 2002:a05:6830:236b:: with SMTP id r11mr1333531oth.145.1634764492353;
        Wed, 20 Oct 2021 14:14:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n187sm639709oif.52.2021.10.20.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:14:51 -0700 (PDT)
Received: (nullmailer pid 2962587 invoked by uid 1000);
        Wed, 20 Oct 2021 21:14:47 -0000
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
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20211020142809.349347-5-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com> <20211020142809.349347-5-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 04/18] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
Date:   Wed, 20 Oct 2021 16:14:47 -0500
Message-Id: <1634764487.038982.2962586.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:55 +0200, Miquel Raynal wrote:
> Let's get rid of spi-nand.txt by converting it to yaml schema. While at
> converting this file, let's actually pull all the generic properties
> from nand-chip.yaml which might apply to a SPI-NAND chip.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 ----
>  .../devicetree/bindings/mtd/spi-nand.yaml     | 27 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/nand-chip.yaml'
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1543922

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

