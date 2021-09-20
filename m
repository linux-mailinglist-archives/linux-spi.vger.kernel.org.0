Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017914126E1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbhITTaZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 15:30:25 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:37567 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245515AbhITT2Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 15:28:24 -0400
Received: by mail-oo1-f53.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso2210712oom.4;
        Mon, 20 Sep 2021 12:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8RDZosyarrVHJMRIOrOYWRs07UC95UsBIK16bZM00bU=;
        b=yBncfJSMrMGyW1lY0gWYCKnaxRMCcfsQvSlY4wkggkntOS6IBplpKy5ZcI8fSCysqr
         MEANr3cv4zk9pfSkGevVPEquMJl5jp9CQg9tfcUPxtYM+9WULU3Ui3z79poxpN8zqY2e
         xx+byLgTp46MC1DGIOcJjX+f07WYdNYh7VRUv+UQ4jcAMKsmlFPCL1zKABcUt6+6MUgz
         LwsqYrfTBy+Wb2Q/W89cpFseqx5NSkPMh+ZWIxKFKC9eXcya376GWQTD1mvVZ0+uYlBH
         G2oP3bvRjzZvPhDkf7yCw+MzVbM7SqhR7XR3LC0rejiyIxDNWu11LuNnXPcAjS6vUYpz
         fq5A==
X-Gm-Message-State: AOAM531aYlOWCXo/TDSzv+SwNytnDfeu8taSGB42qNhs9AjbGGOmPRsL
        PxPVss+Cmo2+rgyXQVP/YQ==
X-Google-Smtp-Source: ABdhPJxUCxd0cnnhBxoTHwKVzXGKJSzPZe/6gN7UIs+ewnpW2DHKak1OfYaEYrgDm+4SjMcJ3aAkMw==
X-Received: by 2002:a4a:6412:: with SMTP id o18mr13727649ooc.79.1632166017034;
        Mon, 20 Sep 2021 12:26:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bj27sm3222072oib.58.2021.09.20.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:26:56 -0700 (PDT)
Received: (nullmailer pid 586175 invoked by uid 1000);
        Mon, 20 Sep 2021 19:26:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mtd@lists.infradead.org, michael@walle.cc,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20210920142713.129295-2-a-nandan@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com> <20210920142713.129295-2-a-nandan@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema format
Date:   Mon, 20 Sep 2021 14:26:55 -0500
Message-Id: <1632166015.061759.586174.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Sep 2021 19:57:12 +0530, Apurva Nandan wrote:
> Convert spi-nand.txt binding to YAML format with an added example.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>  .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml: spi-flash@1: $nodename:0: 'spi-flash@1' does not match '^flash(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/spi-nand.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1530166

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

