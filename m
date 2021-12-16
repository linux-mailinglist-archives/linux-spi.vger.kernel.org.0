Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20E477E72
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 22:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhLPVJg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 16:09:36 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35408 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbhLPVJF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 16:09:05 -0500
Received: by mail-oi1-f181.google.com with SMTP id m6so739861oim.2;
        Thu, 16 Dec 2021 13:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06/jjv/bJmHWFH5eUbQUmPo7yQuVde6Xip0Sorxfb7M=;
        b=e12yNnPqvSFOvU86nKoYLw/7f6Vv+iBeBYaHqmE3bD3dpl/Da2iAz8ZKmYXgsMYYEE
         A4Cj57gxhDGMeaDREiCHu8WHtFAHvKJW/iX3BfzwtVap5x6Wfbx6x3SmKyw0BCeU9q0f
         QsGE7hz8PiThQELVuMa5wA3fdOPVXT8Y57jZXqdlpZlq3NsmZn8wP2ZwGDW2oLm/QV1D
         7Q1fPEH60vZop4lpjtCWxYkHheaDFMuGk7+ud3klln/UJ1pYqb8X/gG9Gxv3CAwUs6zy
         6s8YqgrdhHmUo4/rY15wr2onJS0iTvsgiIzbla7j/ooMc2tst9Ak/+6ueTCDogZSlpPu
         2RHQ==
X-Gm-Message-State: AOAM530AQSOJbaIX58IMW6nzJdUBNH72YlPlMcekqLa+FXcHDezNXsoO
        hhFSqE+/yaLQgKFpRrw+SU1rIMQ4+A==
X-Google-Smtp-Source: ABdhPJyYWmGUU8dkqr2GR0ddHvgpdwaNTc1g8sUB/ahEy63zu3VTYyvBjyCm533wqZrALABZQx1a5g==
X-Received: by 2002:aca:130e:: with SMTP id e14mr5746806oii.51.1639688945201;
        Thu, 16 Dec 2021 13:09:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm1210472oiy.12.2021.12.16.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:09:04 -0800 (PST)
Received: (nullmailer pid 766284 invoked by uid 1000);
        Thu, 16 Dec 2021 21:09:04 -0000
Date:   Thu, 16 Dec 2021 15:09:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Julien Su <juliensu@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 03/28] dt-bindings: mtd: nand-controller: Harmonize
 the property types
Message-ID: <Ybuq8AFCd7wC2RLe@robh.at.kernel.org>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
 <20211216111654.238086-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111654.238086-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Dec 2021 12:16:29 +0100, Miquel Raynal wrote:
> Harmonize the different properties in this file by:
> * dropping the non-necessary allOf's
> * always defining the keywords in the following order:
>     - first the "description" (when relevant),
>     - then the "type"/"$ref" and the other generic keywords ("enum",
>       "default", etc).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/nand-controller.yaml         | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
