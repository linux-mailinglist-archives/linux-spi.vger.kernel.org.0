Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87D43F1DB
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJ1Vhn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:37:43 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40716 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhJ1Vhn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:37:43 -0400
Received: by mail-ot1-f41.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so5899759otv.7;
        Thu, 28 Oct 2021 14:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVpB6t/XH+sh2qfT1aM2PNoYeGU85zqXSS4jjTp9y90=;
        b=gHcqszkMaz/nLF2AgrI4x7Mi1egg36gbX7eursb5z9uODRspSFhoix3Yu2gUIxM9V+
         j3Kt/im/uAMwGGqcb3COImI+OiM9E5suZA0jgbO2PLhsr1HZ+mwwTuDf5j+IwHl9Yoeo
         tGNESkwp/uCHMYxfTYl5bYTO1Z+20MXwtGCOUqz9ok+i/JMygImYaoByKh2pmwvxE2xo
         4fktRrDIW+fSwLdMj8WToJBDiL/apdmOoK9U0Hytl70OxTkUcLm+nN8sxiVvCXmtE1RL
         z9ZcttrAyFBvgP8ZAtnn+alF2KRPbDnVcWNa/fda691r8CJ/n8ywN89z9DUi6DAOtzvC
         ezag==
X-Gm-Message-State: AOAM533BxXPGEz4ZdcgQAEpop8tVQUo6R8LQcKpRTZ0E3TfCTTJAj1gr
        j10NVGuPVHwRyx14npAsJF5lKk/pWg==
X-Google-Smtp-Source: ABdhPJy03vHBCBw25GpIZT2cQy06T0I69YsG5Io9Nkfdi9p8Jll53OaZVmFHQAoQgzXTLljfZbxSqQ==
X-Received: by 2002:a05:6830:40b0:: with SMTP id x48mr5379834ott.89.1635456915421;
        Thu, 28 Oct 2021 14:35:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r22sm1352984otq.5.2021.10.28.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:35:14 -0700 (PDT)
Received: (nullmailer pid 627527 invoked by uid 1000);
        Thu, 28 Oct 2021 21:35:13 -0000
Date:   Thu, 28 Oct 2021 16:35:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/18] dt-bindings: mtd: Describe Macronix NAND ECC engine
Message-ID: <YXsXkfGNtMFLPMA2@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-9-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:59 +0200, Miquel Raynal wrote:
> Describe Macronix NAND ECC engine. This engine may be used as an
> external engine or can be pipelined with either a raw NAND controller or
> a SPI controller. Both hardware designs with a SPI controller are shown
> in the examples.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/mxicy,nand-ecc-engine.yaml   | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
