Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2548C427189
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 21:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhJHTvB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 15:51:01 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38668 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbhJHTu7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 15:50:59 -0400
Received: by mail-ot1-f42.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so3957104otu.5;
        Fri, 08 Oct 2021 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TCu09rsdz9qaZNlW814ROPgBIe73GMu1odd3xsCgFZE=;
        b=VcYYbtWAqaNCDh0qkoFH/5sywPVtYzckZbRNKNV4iJ/jkLgmPVdTkvz72gQK38ABa4
         cBJsXB/Ps5bzIK7ih1RSF/5kURU4u+Xvmp5qN7GtJhJE2fKysjMm3q191DsEg6K1AiTP
         zZGNVtB3TUrJImR3PofQ3b5dFOzuc0t9CwtDgTM5g+63MM2EyLrvNX5nge/7GOIh3AqX
         HV6zA+HoX7+ZCFGjXbyUqTmeE2+Rzncb4JB0iLNRBm9XXDRIjEKawSm6iGqgmsj81RMq
         NnB98+REd7c42ls+z6Df/5Qqvk/8CBhKlUCa44v2vOK1845MuzZfiLR2Je6CxB8IlcrY
         hwSg==
X-Gm-Message-State: AOAM531YxOKU7AhxcoTIyvxk+/GOJB7go0kHitTGtY2YubpXu3hkhehX
        yesDGfDKV7Rv9zzHKCs72HRKuAigVw==
X-Google-Smtp-Source: ABdhPJyooYbBa5WC5aVtNl1rU8mTcfgxB8u7iK9YF1J28Lc/pabtIK+ms2WbyxzEMrlWnTKOqLWGGQ==
X-Received: by 2002:a9d:3b2:: with SMTP id f47mr10405415otf.253.1633722543650;
        Fri, 08 Oct 2021 12:49:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b19sm57350otk.75.2021.10.08.12.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:49:03 -0700 (PDT)
Received: (nullmailer pid 3211955 invoked by uid 1000);
        Fri, 08 Oct 2021 19:48:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        jaimeliao@mxic.com.tw, Rob Herring <robh+dt@kernel.org>,
        juliensu@mxic.com.tw, Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>
In-Reply-To: <20211008162228.1753083-5-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com> <20211008162228.1753083-5-miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 04/10] dt-bindings: mtd: Describe Macronix NAND ECC engine
Date:   Fri, 08 Oct 2021 14:48:56 -0500
Message-Id: <1633722536.880854.3211954.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 08 Oct 2021 18:22:22 +0200, Miquel Raynal wrote:
> Describe Macronix NAND ECC engine. This engine may be used as an
> external engine or pipelined, both ways are shown in the examples.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/mxic,nand-ecc-engine.yaml    | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.example.dt.yaml:0:0: /example-0/spi@43c30000: failed to match any schema with compatible: ['mxicy,mx25f0a-spi']
Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.example.dt.yaml:0:0: /example-0/spi@43c30000/flash@0: failed to match any schema with compatible: ['spi-nand']
Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.example.dt.yaml:0:0: /example-1/spi@43c30000: failed to match any schema with compatible: ['mxicy,mx25f0a-spi']
Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.example.dt.yaml:0:0: /example-1/spi@43c30000/flash@0: failed to match any schema with compatible: ['spi-nand']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1538445

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

