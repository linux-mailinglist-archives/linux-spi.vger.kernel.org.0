Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2942465A68
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 01:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353968AbhLBAJ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 19:09:27 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45700 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353941AbhLBAJ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 19:09:26 -0500
Received: by mail-oi1-f181.google.com with SMTP id 7so51987406oip.12;
        Wed, 01 Dec 2021 16:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnG7ZThgpV4GS+FXFDhi+FpBe4m9EJe3SskbxvTtuKI=;
        b=wky9WofkeM7cW+OT1CvyJ2vK+5R6k+4fGKvGIa45gHNdIOl7LRHBTtMm5mFwPBpEMO
         G9RlXF6NC6y6rcp/bC3w/fKNrwguRYNpg6V3MT9cm3v1TaiBBzusAQnAgzNNnoxuKpYN
         Yx4aIZ1xfCDI5QdP9A6xapqhj489n9aCRodfzrn5WdEEdASdSadXA3+oCXSPY/8OfIfQ
         h4jXk5SKTT9U4JiJQ3nlLmOpIAKFqabOFNgtw/95GDZqIVWvuJsyB9N4R1DBMLqTQRat
         g0/VAc1eKY3Hzlmc3Gvcasgb3JRo16UxwUqMwn8/Db7LGH1aSKUMcAoTGy8NugX+dKu+
         95Tg==
X-Gm-Message-State: AOAM531N7o6KaCJYf7Q4vUvLKQjWpBfVMo7hF8KAcdPQg/KtWOeh2YoI
        YTNYtx7hpHsK2+NAkyCvuA==
X-Google-Smtp-Source: ABdhPJy2jWZVjDaroFsVsg0OQeJFnrVrrkoB0ro9GC9c7tWalmkOqE7zHj7rA0Xl4XxjSd/sBct4Dg==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr1587056oiw.117.1638403564899;
        Wed, 01 Dec 2021 16:06:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm610048oic.39.2021.12.01.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:06:04 -0800 (PST)
Received: (nullmailer pid 3268585 invoked by uid 1000);
        Thu, 02 Dec 2021 00:06:03 -0000
Date:   Wed, 1 Dec 2021 18:06:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mtd@lists.infradead.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: mtd: spi-nor: Allow two CS per device
Message-ID: <YagN64lqGVcTHi+e@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126163450.394861-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Nov 2021 17:34:48 +0100, Miquel Raynal wrote:
> This will be needed in order to be able to describe Xilinx QSPI
> controller stacked and parallel modes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
