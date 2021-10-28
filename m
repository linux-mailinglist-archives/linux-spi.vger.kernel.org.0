Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6DF43F1BA
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhJ1VeL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:34:11 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41667 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhJ1Vd4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:33:56 -0400
Received: by mail-oi1-f176.google.com with SMTP id y128so10247438oie.8;
        Thu, 28 Oct 2021 14:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+qPtDQaqseg1rU0SAu/DvoYp4TWdxNR8dGfzDgYPBA=;
        b=W6eh1OkCc7ZH8TlfNe2Nzwl38510BKszGw/kxcIF1nH1lsWl3KW0jza4vuOHqj1tWj
         J2XCmh2emXmEMwIc0o50l7QHrdK4Fy6kyDh/d/2LiGl6O7echo7MdE+aBsCabKW/pYQS
         K5f6oW96H0qY6DvP221BVJHriUhEiYLM2QNAb6ZiL4dZ034HPG4JmJsu4CnxF+O57uxV
         XNdtvJ+6RQRuMOdNlR4LX/HWK4UGT0/Bj927iE1F0E8NLbJlRDsmGF7nU6NPjXKgns2K
         n2+kXRy0UD85IznAgcJojXBZIM8Hhzkm3pDUNp1KvBmkFm1m411S8t6zb/L+FBAfIb/6
         RrZA==
X-Gm-Message-State: AOAM531wCg6J1NXtM1L3yhbQgEELoeNY3/4ZaYfHaRaf7ZFZRKxdvdpP
        05meVrTuaIDwrUMczwUXlw==
X-Google-Smtp-Source: ABdhPJyn0uHM4S3b450KWKg+1utYRpqTm/tyjiH0wlvami17ti2zOIj1hgx4YhMjMlXM5T6rdPTGeg==
X-Received: by 2002:aca:7c3:: with SMTP id 186mr5241810oih.60.1635456688810;
        Thu, 28 Oct 2021 14:31:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l2sm1370413otl.61.2021.10.28.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:31:28 -0700 (PDT)
Received: (nullmailer pid 621898 invoked by uid 1000);
        Thu, 28 Oct 2021 21:31:27 -0000
Date:   Thu, 28 Oct 2021 16:31:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Jaime Liao <jaimeliao@mxic.com.tw>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Julien Su <juliensu@mxic.com.tw>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 05/18] dt-bindings: vendor-prefixes: Clarify Macronix
 prefix
Message-ID: <YXsWrwPrDJh+d9ay@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-6-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:56 +0200, Miquel Raynal wrote:
> When looking at compatible prefixes, Macronix is sometimes referred as
> "mxicy":
> - mxicy,mx25r1635f
> - mxicy,mx25u6435f
> - mxicy,mx25v8035f
> - mxicy,mx25f0a-spi
> and sometimes as "mxic":
> - mxic,multi-itfc-v009-nand-controller
> - mxic,enable-randomizer-otp
> 
> The oldest prefix that is also the one preferred by Macronix engineers
> is "mxicy", so document the other one and mark it deprecated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
