Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB547D76C
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbhLVTJD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 14:09:03 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:34629 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbhLVTJC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 14:09:02 -0500
Received: by mail-qk1-f175.google.com with SMTP id b85so3298918qkc.1;
        Wed, 22 Dec 2021 11:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyJ75PdIZRPYqc1qFXz30jQrZAv9clyNlJRO4OktcXA=;
        b=luXbdPH4k9HR/M49ggQ0SWSKWjfhkikq8Y6aZnjlsTviMH+pkNcwuDVF70KZOfoSu6
         IzY6TVQOuFyFGBz/Mj5uKXqo508nMnyvy05/MKfap2sRa5sst4be+XZKFMrNwG88veLI
         8OqA3GFX5cRSXfZfW5pqfvEFoprX/pJ8ZzfuqHAvhwltPJR20AerAEZjrKqWwwAFM0Ro
         486ctvz8MbtI50g/EhkRAFroUZ/6eWaOphFmTlz8bZFymYwk1MSlEkcFuSsbLUUsDbWC
         j91kVH6spGhQMfjSldzIb2MCyNuNIrCG+Zg5DdmdoUN25erJSBepSZzaqmHP3F1Q1yI6
         +yaA==
X-Gm-Message-State: AOAM533Aiq69m1g3Qlq8CePxldVJwG3f+ae+Z2pKaD6Wbmdh6YiUgKCv
        whai5tBgBT8cjlYW/ycYoIcVJmiEAJku
X-Google-Smtp-Source: ABdhPJzsJQ9a7vww9S4gJzF6yBE2P2CkUmEENsV5AilTQ+5G7lfExKnyMXVokY+ytYbtDy+izFuXeg==
X-Received: by 2002:a05:620a:1358:: with SMTP id c24mr2694388qkl.699.1640200141655;
        Wed, 22 Dec 2021 11:09:01 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q15sm2313155qkj.108.2021.12.22.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:09:01 -0800 (PST)
Received: (nullmailer pid 2529650 invoked by uid 1000);
        Wed, 22 Dec 2021 19:08:59 -0000
Date:   Wed, 22 Dec 2021 15:08:59 -0400
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <YcN3y/gelGcH5/Be@robh.at.kernel.org>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221170058.18333-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 21, 2021 at 06:00:57PM +0100, Miquel Raynal wrote:
> Describe two new memories modes:
> - A stacked mode when the bus is common but the address space extended
>   with an additinals wires.
> - A parallel mode with parallel busses accessing parallel flashes where
>   the data is spread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Hello Rob,
> 
> I know the below does not pass the tests (at least the example patch 3
> does not pass) but I believe the issue is probably on the tooling side
> because the exact same thing with uing32-array instead is accepted. The
> problem comes from the minItems/maxItems lines. Without them, this is
> okay. The maxItems btw matches the "good enough value for now" idea.
> 
> The errors I get are:
> 
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>   DTEX    Documentation/devicetree/bindings/spi/spi-controller.example.dts
>   DTC     Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> 	From schema: /src/Documentation/devicetree/bindings/spi/spi-controller.yaml
> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> 	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'sensor@1', 'flash@2' were unexpected)
> 	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: flash@2: stacked-memories: [[268435456, 268435456]] is too short
> 	From schema: /src/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

I'm not seeing any of these. Are you up to date with dtschema?

Rob
