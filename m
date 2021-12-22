Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF79847D7AC
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbhLVT26 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 14:28:58 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:40694 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhLVT26 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 14:28:58 -0500
Received: by mail-qv1-f44.google.com with SMTP id q3so3209089qvc.7;
        Wed, 22 Dec 2021 11:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JLlzL6JkLMvYS8qsLxxlj+RLmlEabUucYr74EUim5s=;
        b=IzXd+udmDoCz4bWT4719XvDit7enpKLGVaV/IabkwwSahwiv8uHalIlf09kazCTZht
         fH8MnJEFog0mdsq2wn5qYXx7CfwE/JJQkREqNZXoxefxZm6xFfxF8OC3HXwOjX7bxPAV
         DV+f7QMgv+qPtK6Tkt+gqGwSAnFFnpnCvj+0aWuTB81DyZYpv6pMedBPKByrUvqX7/qy
         FHwd/EpzN9NPyotLJN1kjSZguuvuCHF5unLuylL4Z+AM8MY+CQQShJQvQVeUyQz8Wmqq
         DczZRZ5kGB1Xw5l9qY8P42aigOekQi6YmOfaaSqRcVHlCJEyaldRVJKtsXPP1mT5K+dM
         fwWg==
X-Gm-Message-State: AOAM5337Hs1j2CeuIlHD9eIfsSB/Ck6DKd3Z7CJcphN8cqptaLZOVwhI
        mhpcHDM472YQNJqjMyWZryIPGQeSDSYm
X-Google-Smtp-Source: ABdhPJy0xCxfPK2k14T0nQonufth8X5fCM724vTU/sv3JASArUBgc6mnYEe955x2Jj6M3C+2a+Vymg==
X-Received: by 2002:ad4:48c5:: with SMTP id v5mr3737347qvx.64.1640201337574;
        Wed, 22 Dec 2021 11:28:57 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id ay42sm2473637qkb.40.2021.12.22.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:28:56 -0800 (PST)
Received: (nullmailer pid 2562386 invoked by uid 1000);
        Wed, 22 Dec 2021 19:28:55 -0000
Date:   Wed, 22 Dec 2021 15:28:55 -0400
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
Message-ID: <YcN8d1xA1sx2llzk@robh.at.kernel.org>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
 <YcN3y/gelGcH5/Be@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcN3y/gelGcH5/Be@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 22, 2021 at 03:08:59PM -0400, Rob Herring wrote:
> On Tue, Dec 21, 2021 at 06:00:57PM +0100, Miquel Raynal wrote:
> > Describe two new memories modes:
> > - A stacked mode when the bus is common but the address space extended
> >   with an additinals wires.
> > - A parallel mode with parallel busses accessing parallel flashes where
> >   the data is spread.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > 
> > Hello Rob,
> > 
> > I know the below does not pass the tests (at least the example patch 3
> > does not pass) but I believe the issue is probably on the tooling side
> > because the exact same thing with uing32-array instead is accepted. The
> > problem comes from the minItems/maxItems lines. Without them, this is
> > okay. The maxItems btw matches the "good enough value for now" idea.
> > 
> > The errors I get are:
> > 
> > $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >   DTEX    Documentation/devicetree/bindings/spi/spi-controller.example.dts
> >   DTC     Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> >   CHECK   Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> > /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> > 	From schema: /src/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> > 	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> > /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'sensor@1', 'flash@2' were unexpected)
> > 	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> > /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: flash@2: stacked-memories: [[268435456, 268435456]] is too short
> > 	From schema: /src/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 
> I'm not seeing any of these. Are you up to date with dtschema?

NM, I was missing a patch and now see it. It is indeed a tool problem. 
I'll work on a fix.

Rob
