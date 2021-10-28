Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD643F19C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJ1V2I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:28:08 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42510 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhJ1V16 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:27:58 -0400
Received: by mail-ot1-f46.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso10510437ota.9;
        Thu, 28 Oct 2021 14:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+wb9pAO3Q7/CorDpYBYPsQ7RQNJbzYpLrTDXU36ZuM=;
        b=5qHqylTRNvT8/BMs3Toac09YSp77dVPNCJq9O226Jr7WvJlUi0IwNgJZ278UTt4m7E
         RC8LgEhK0cQ9CtefLKpFamfLpG6Pi6FtPcPCKOBDJG0bq14DRPnKIuSZSvlMyI/4q3I+
         1DKt/mahApXXn52ho4clUnLoAn5UjBQEtsvSunymwXLMuNWUQf/2Fjh/GBP3lRiCdBfJ
         JJ8iHQ40Y5U987DZ34nu3Hc7KKGMGT+LogTW9uitaPzMwEF1/qdMg0CM8siMBSRJj9WH
         swn4zspKHylRTbpsO2dq+rAMr7ZbMAeP3XwMjushkXMCLOUSr6BhcNpyL7ww4g6ALghs
         mX2g==
X-Gm-Message-State: AOAM530A76q7wYxAHiNuGJujoViexFLVbHzQh3bzJliBpDinoysFEBca
        invdzsYhtjTxIAiUV1rjmw==
X-Google-Smtp-Source: ABdhPJypFdc9331gl6AA1rnDnur8ut7w6EDbKwn/w23/osjkVNOViyhLs596mXdi0yYiX4C5Pu/1oQ==
X-Received: by 2002:a05:6830:232b:: with SMTP id q11mr5660195otg.164.1635456330441;
        Thu, 28 Oct 2021 14:25:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z8sm1248084oof.47.2021.10.28.14.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:25:29 -0700 (PDT)
Received: (nullmailer pid 613503 invoked by uid 1000);
        Thu, 28 Oct 2021 21:25:28 -0000
Date:   Thu, 28 Oct 2021 16:25:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Julien Su <juliensu@mxic.com.tw>
Subject: Re: [PATCH 01/18] dt-bindings: mtd: nand-controller: Fix the reg
 property description
Message-ID: <YXsVSIuS0/LOqnUH@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-2-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:52 +0200, Miquel Raynal wrote:
> The reg property of a NAND device always references the chip-select(s).
> The ready/busy lines are described in the nand-rb property. I believe
> this was a harmless copy/paste error during the conversion to yaml.
> 
> Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
