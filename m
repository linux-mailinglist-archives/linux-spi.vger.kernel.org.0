Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ECB43F1BF
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJ1Ve4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 17:34:56 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45667 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhJ1Vef (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 17:34:35 -0400
Received: by mail-oi1-f169.google.com with SMTP id z126so10230613oiz.12;
        Thu, 28 Oct 2021 14:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pV+lYlLAx38YX42772eORjOf2v8z4XTyW8SH1ArbmLs=;
        b=HJZnUIDGLAky9D06HCWNr5EycKhPLTCu8cuaQBJTcoqe8TSJZSLM5Q8oFXq4s4/o9t
         w0MIpui2O/swlwMxBHo6MtIk2b15rWcu5wobHfFpSidx8saCpqxba3rgTbyVewRlssOs
         HusNh1nIs4SL1WB+3D91iHTDvzj8Qp+WFrXYsD2dAbSx7ax0+/fr9fWTPKKuo/nLAUAs
         gtgl1geiLE87FmclhdM6Ou2G6BPC/iJxTvFTgL07VGfrzjn0ovPg3qz9KwKby0Sabgao
         YMPKbvBG7tF7hmem+lBA2jujMjqirjq03VuhJtKDUY5Aabg2lAZMGssnpla6pg1EiKH4
         n2DA==
X-Gm-Message-State: AOAM5306jffaKC/Klllwdc8EV71ir42OQ80K5Cvjnp4AUYKuZ/xA6FFI
        c7Q0Xu6F65latMoBpgtCvg==
X-Google-Smtp-Source: ABdhPJyuxPMrmxNkcdcCEerZo6yZspo2c/4b31BFtQfeY5X28VqH21jX8eIJFihX+OyHXAGdgbwp9g==
X-Received: by 2002:a54:4e8f:: with SMTP id c15mr4927670oiy.113.1635456727512;
        Thu, 28 Oct 2021 14:32:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h17sm1261392oog.17.2021.10.28.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:32:06 -0700 (PDT)
Received: (nullmailer pid 622969 invoked by uid 1000);
        Thu, 28 Oct 2021 21:32:05 -0000
Date:   Thu, 28 Oct 2021 16:32:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-kernel@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 06/18] dt-bindings: spi: mxic: The interrupt property is
 not mandatory
Message-ID: <YXsW1Q1dh2+e2ONB@robh.at.kernel.org>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
 <20211020142809.349347-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020142809.349347-7-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 16:27:57 +0200, Miquel Raynal wrote:
> The interrupt property is not mandatory at all, this property should not
> be part of the required properties list, so move it into the optional
> properties list.
> 
> Fixes: 326e5c8d4a87 ("dt-binding: spi: Document Macronix controller bindings")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-mxic.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
