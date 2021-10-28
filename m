Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863D43F1A8
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1VbC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:31:02 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46716 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1VbA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:31:00 -0400
Received: by mail-oi1-f182.google.com with SMTP id m11so5467653oif.13;
        Thu, 28 Oct 2021 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UbQ3X7BD6qpgtn540MLFzrLrimBO17bm2/cyxoaaA+k=;
        b=tZgBGmFvfUFJ3if1guKwoyCEM6IXcdOaPc856L6LvLqrk+S0U0/VPfkBIQnSMoTWi4
         9tB2qoZesqfoLFnioj2vS4H8DtKNzjzy2yl2BNOmdUBKgOe5PhP+sDZzPE80bgSCaxox
         az3pV81unYiPd3ERYGY2JKGZ0LZ3EEDB4kxktM/oVVTjxRvgA+w6VmiDTxO9hL6LJ7tA
         zfe403v19eDE4m3AIYLS2JYY2NE1SlqAD0OPJvZ3TRl46TsI+99yGmzVJhEC6QZpbZ+p
         4CG07hGhRi099GiYoyteZpsj09PLKyQWfUhLZygzh12MbJeJah+RpTtWmy5Pik78W4WJ
         eq8w==
X-Gm-Message-State: AOAM532r5lg3mq7XOagJQmKMZd5az+tg/nE/FhN/kofNTZOcJoBRaKFc
        pdWGA+qlHttQQCvaDzoWbw==
X-Google-Smtp-Source: ABdhPJyGQdpbdp9+nSux0RGdftKN1RUp3rufQfJSKzdQIJX4Kd5pHVOiVZw6cP3YM+RToI8p67J7VQ==
X-Received: by 2002:aca:280c:: with SMTP id 12mr10593329oix.93.1635456511984;
        Thu, 28 Oct 2021 14:28:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r44sm1512242otv.39.2021.10.28.14.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:28:31 -0700 (PDT)
Received: (nullmailer pid 617930 invoked by uid 1000);
        Thu, 28 Oct 2021 21:28:30 -0000
Date:   Thu, 28 Oct 2021 16:28:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>
Subject: Re: [PATCH 04/18] dt-bindings: mtd: spi-nand: Convert spi-nand
 description file to yaml
Message-ID: <YXsV/l+/vU1fBanY@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-5-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 20, 2021 at 04:27:55PM +0200, Miquel Raynal wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
