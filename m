Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A080643F1A0
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1V2s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:28:48 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38540 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhJ1V2q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:28:46 -0400
Received: by mail-ot1-f41.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso10567761otp.5;
        Thu, 28 Oct 2021 14:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dshGJTXKhxAlRxDf0FyX5GlWtlY3Ecc9O706tlW+d0s=;
        b=Jrvo6AyO0xAxRXcuENKeQqAObaW1jYHFpAQo74wVgm2az4o99xY6+bBs10i3++naMb
         nqQ59lg3RltIqSCdtmhR0PflEcPgvWFolkEiulktgxDvXKvPXpoPgwTEN+lFvNuMknuw
         MHBNsQ3Lfid5H1USCUw99xBMgzPmvnzFDY7E7uJQY2v/XWxvEpkVGeunjSuLPtYHUd/H
         gof7TObPd3puOyfuoxwOUzxcLezVm952xIHtRe+bXlpXo4qjXha1kutwMh8Y8DysQ9Cr
         PtGz38FIq26tJJ5uQ2oEa1jPJH5fj9u4zW5ijThSRPL+1Ld3+M6y8uuvDuFD4WnMovn+
         3/Vg==
X-Gm-Message-State: AOAM530XqNMGfNtBLTlOLsG2Cs9m/Nva5/oP9wPBvTn7qfBQTRKK80TQ
        lodzDeL72JxBhIs98YZRiQ==
X-Google-Smtp-Source: ABdhPJy3nAR6IwXfr5ce0NJ1RbxUXtRHrIb5BQhVH6kbqcnF6WXBWOQHEeB1ZutHwDV4jQn45hpiTQ==
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr5525992ota.337.1635456379145;
        Thu, 28 Oct 2021 14:26:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i13sm1345977oik.6.2021.10.28.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:26:18 -0700 (PDT)
Received: (nullmailer pid 614889 invoked by uid 1000);
        Thu, 28 Oct 2021 21:26:17 -0000
Date:   Thu, 28 Oct 2021 16:26:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/18] dt-bindings: mtd: nand-controller: Fix a comment
 in the examples
Message-ID: <YXsVeTmJBWnrWysb@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:53 +0200, Miquel Raynal wrote:
> The controller properties should be in the controller 'parent' node,
> while properties in the children nodes are specific to the NAND
> *chip*. This error was already present during the yaml conversion.
> 
> Fixes: 2d472aba15ff ("mtd: nand: document the NAND controller/NAND chip DT representation")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
