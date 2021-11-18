Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278C845658E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKRW0d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 17:26:33 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43006 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhKRW0d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Nov 2021 17:26:33 -0500
Received: by mail-oi1-f180.google.com with SMTP id n66so17476471oia.9;
        Thu, 18 Nov 2021 14:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90rjTt6sCjRL8QevMPYuFl/P99rXCqrTBx6fBN4whw0=;
        b=LZ0J6np2MRl2LPWTgUA3h0G6km8SeQNPWvwdU/JJZ4Mr1TFMMnO43OKll7vMM5fIaT
         vKSQKRZBgMIIEhxdjaWl4GjR7U6mJCpeg3PMqm5NkxQCX1wkDYGi3Hb4u0siX+2aOJXH
         XSahxKyjbcnH1aLEr6fLaXcuX13bpb8cN8TB2DIXgidKpo2VFvdOMIeZtTltoaPdFAxo
         I02cJD5TVvVOpyEiGziXlibHScKQgPpEKcxHzoZL17npaHLH1X1v/Ha+XJ9P/3atk8j6
         E86FkWVw/TDzD4x8bc8GRwuNSxng6c8/iBgf43i0I1zdPvSjiYAwk0VvaBJuArQaoFxD
         RIWA==
X-Gm-Message-State: AOAM530PfF1c9dQmywMGS0jhyMKgJ/+6xOK09jpGpyuTV76f2r2IaP9b
        pBE6JcQ6ai3GtlkxbCBy4Q==
X-Google-Smtp-Source: ABdhPJy5i/iXgnkQUQyKkZPVmCaH4AfnPGt8E+GJVKgm68l5AgifFZp04t/jxek2rBsgGWa7pl2BRQ==
X-Received: by 2002:aca:a989:: with SMTP id s131mr408097oie.71.1637274212460;
        Thu, 18 Nov 2021 14:23:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r5sm203721oov.48.2021.11.18.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:23:31 -0800 (PST)
Received: (nullmailer pid 1864403 invoked by uid 1000);
        Thu, 18 Nov 2021 22:23:30 -0000
Date:   Thu, 18 Nov 2021 16:23:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: cdns,qspi-nor: Move
 peripheral-specific properties out
Message-ID: <YZbSYl6Bjob+LxIi@robh.at.kernel.org>
References: <20211109181911.2251-1-p.yadav@ti.com>
 <20211109181911.2251-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109181911.2251-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 09, 2021 at 11:49:10PM +0530, Pratyush Yadav wrote:
> The spi-peripheral-props.yaml schema contains peripheral-specific
> properties for SPI controllers that should be present in the peripheral
> node. Move peripheral-specific properties to a separate file and refer
> to it in spi-peripheral-props.yaml.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v3:
> - s/slave/peripheral/g
> 
> Changes in v2:
> - New in v2.
> 
>  .../spi/cdns,qspi-nor-peripheral-props.yaml   | 42 +++++++++++++++++++
>  .../bindings/spi/cdns,qspi-nor.yaml           | 33 ---------------
>  .../bindings/spi/spi-peripheral-props.yaml    |  2 +
>  3 files changed, 44 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
