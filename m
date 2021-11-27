Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320D9460254
	for <lists+linux-spi@lfdr.de>; Sun, 28 Nov 2021 00:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356582AbhK0XS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Nov 2021 18:18:56 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36457 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbhK0XQw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 27 Nov 2021 18:16:52 -0500
Received: by mail-oi1-f169.google.com with SMTP id t23so26447177oiw.3;
        Sat, 27 Nov 2021 15:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NHj7bPxI6fq1N93RbHviuq859RaSpvvAa3Q1mOwEKtc=;
        b=4XSTZN5AcQSsihudhAH+rMuCw4w9+azPTklfkJg4xd9CKRJpeyIvkP16UYDMnMaUG7
         JERTnPLWlHB4qQvhynS7HHFppgCvQVomm4ImK6srUKVjc19xpl5QznC/uwyxxQiDgYW/
         r+ZfQQjwpcFE1lfLr0bXpfAeqevxnNIBmrOcxwvshpaFUX/RJ2bajWjidiy9MW75F9V8
         rIgWACp4IahzHmMZd62eRElyQ6TyjZs1htu5ega7JVq0zurLkReV+D5nCXerQ4Taap9U
         UXXICCiSjexVQg2vyUrttOMsiEiybYAKbtStGMpcCThw6gyvGrPXmyNMOE3jVQogOkaz
         0rqw==
X-Gm-Message-State: AOAM531x5LgDT6ptQJlwnONJaYEaVK+3CacuHnizYvkOVd2eXTwyOlKh
        iELHwT7Mlm5Ef/QIkq76RA==
X-Google-Smtp-Source: ABdhPJwAYQLRS1w5wIjJjByV/RMDaS4Nmwr980kCT4ajWNcu05VSEMfU6uzQlEU5RDZEhtt577Vmkg==
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr31905725oic.123.1638054817351;
        Sat, 27 Nov 2021 15:13:37 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e14sm1696635oow.3.2021.11.27.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 15:13:36 -0800 (PST)
Received: (nullmailer pid 1973543 invoked by uid 1000);
        Sat, 27 Nov 2021 23:13:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mtd@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>
In-Reply-To: <20211126163450.394861-6-miquel.raynal@bootlin.com>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com> <20211126163450.394861-6-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 5/5] spi: dt-bindings: Add an example with two stacked flashes
Date:   Sat, 27 Nov 2021 16:13:22 -0700
Message-Id: <1638054802.100671.1973542.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Nov 2021 17:34:50 +0100, Miquel Raynal wrote:
> Provide an example of how to describe two flashes in eg. stacked mode.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/spi-controller.example.dts:40.23-45.15: Warning (spi_bus_reg): /example-0/spi@80010000/flash@2,3: SPI bus unit address format error, expected "2"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1560255

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

