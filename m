Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460C4126E5
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbhITTa2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 15:30:28 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42594 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbhITT20 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 15:28:26 -0400
Received: by mail-oi1-f178.google.com with SMTP id x124so2652064oix.9;
        Mon, 20 Sep 2021 12:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Ltg68ai17ryA61wLEpw2gWNDTuZWgZYYvpF3Lm1beig=;
        b=k3YnuI5huJKCUin9mRb4ys9aJqP51LkqiUs+iGLoXDOcVRMaOwEax+JsOgmeQ90LGD
         CJ1yk/gWTEqGNNLe5zXlQTRib5Bh43dc8XaDoEf6b09/oFWpWLW8j7Ud5bKtBO32ibc6
         RR1H7fKaRgACN14a+znCTahDCaOmoSsp0CI9/nnEmOgEXgQfhFlQIUOI+Og4PmnD42e6
         Y2yQNLRAAo1RIyZm1JobSDeqgRWs2Fjyz/YC+UMaC4QnkWXHbLiMIoL1tXktS64dwTI2
         mPsfYg3myw9vsGrqC8z7jZs2KuFPyCv0SH7AP9WbqoPhz+eHy9WepDVv4ez9u4cuYmSr
         b6oQ==
X-Gm-Message-State: AOAM5318CHZCNrZ8CYXoyENdJLy2OMM1myUw4mcFJX/bJQEKyDnGMfP8
        Bym8CoBTmkc5dXFoTvrXCA==
X-Google-Smtp-Source: ABdhPJz0ghhIQUq0/xBQQZcGfNHP33ZoBoPP4+VhuvRF80iBYfK9SyWhV3s1G7XFCiXra9a7WP+VNQ==
X-Received: by 2002:a05:6808:2191:: with SMTP id be17mr574215oib.30.1632166019071;
        Mon, 20 Sep 2021 12:26:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg38sm3452836oib.26.2021.09.20.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:26:58 -0700 (PDT)
Received: (nullmailer pid 586178 invoked by uid 1000);
        Mon, 20 Sep 2021 19:26:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, michael@walle.cc,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20210920142713.129295-3-a-nandan@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com> <20210920142713.129295-3-a-nandan@ti.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node name instead of 'spi-flash' in example
Date:   Mon, 20 Sep 2021 14:26:55 -0500
Message-Id: <1632166015.080380.586177.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Sep 2021 19:57:13 +0530, Apurva Nandan wrote:
> Change the nodename in the example with spi-nand from 'spi-flash@1'
> to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
> flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
> so make the spi-nand examples in dt-bindings use it too for uniformity.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml:0:0: /example-0/spi@fff00000/flash@1: failed to match any schema with compatible: ['spi-nand']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1530168

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

