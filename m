Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7E47D7B8
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbhLVTag (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 14:30:36 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42685 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbhLVTag (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 14:30:36 -0500
Received: by mail-qk1-f169.google.com with SMTP id r139so2451686qke.9;
        Wed, 22 Dec 2021 11:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EQ5clRItjzdQ2JTUj7nt608zvWfdp4GJggrfSEY9ADI=;
        b=jKcNQUBo0/Ss0LOORhTEa4a4GqOnhqr9IUDbFv20Wv8LLQzsZ0/imRswkUtT2fPYx7
         zRzHnOCrD12WD8zLpeGSHFaLfc64UofuNFwlgnkWOSsA1oRlyly6tL34IeyVN4aO6QC2
         T07wUl3YyvZrCL2F5qD+FJAaOpkXywygt6i07xPDCpOsZ2h/+JXs/VKh9V4k/SQ6kxVS
         m/mKbTMHxAK3t04S65UmSTFZZZGt8yxuA6aH5jc6EDfYZHArK+kehQTthCAVM4mVdjLY
         fHQjvlcJYJCBsmal0Xq8wDwg/W5xWx/o9Ehn2bd0VpQEhaA0ZAYDjMY/r1FQqSXDB0E6
         AYyA==
X-Gm-Message-State: AOAM531HkUEAADbO8mxSLqzwrvr92s3ST8eZm2Bfxkh3os29j0j0YX0W
        KzZl8ZggoybIq/CxQ/6WpA==
X-Google-Smtp-Source: ABdhPJyYfBrWJNIz29wi2pj6bdHbgGZbKC3mazPyPS3o68gSADuEbyZiGdfiqpXize4GypruElh3lQ==
X-Received: by 2002:a05:620a:40d5:: with SMTP id g21mr3079216qko.478.1640201435457;
        Wed, 22 Dec 2021 11:30:35 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id w63sm2335013qkd.88.2021.12.22.11.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:30:34 -0800 (PST)
Received: (nullmailer pid 2564998 invoked by uid 1000);
        Wed, 22 Dec 2021 19:30:32 -0000
Date:   Wed, 22 Dec 2021 15:30:32 -0400
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor.Ambarus@microchip.com, devicetree@vger.kernel.org,
        monstr@monstr.eu, thomas.petazzoni@bootlin.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, richard@nod.at, vigneshr@ti.com,
        p.yadav@ti.com, michael@walle.cc, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Message-ID: <YcN82JIbFzi1N8r2@robh.at.kernel.org>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
 <20211221170058.18333-3-miquel.raynal@bootlin.com>
 <a11a0650-4624-0a9f-d0a5-c45393fead7c@microchip.com>
 <20211222090542.43dfe12e@xps13>
 <be9d451a-6451-be58-1c2a-a9aea7f67c56@microchip.com>
 <20211222093523.30f8ae7c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222093523.30f8ae7c@xps13>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 22, 2021 at 09:35:58AM +0100, Miquel Raynal wrote:
> Hi Tudor,
> 
> Tudor.Ambarus@microchip.com wrote on Wed, 22 Dec 2021 08:22:05 +0000:
> > On 12/22/21 10:05 AM, Miquel Raynal wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > Hello Tudor,  
> > 
> > Hi!
> > 
> > > 
> > > Tudor.Ambarus@microchip.com wrote on Wed, 22 Dec 2021 07:52:44 +0000:
> > >   
> > >> On 12/21/21 7:00 PM, Miquel Raynal wrote:  
> > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >>>
> > >>> Describe two new memories modes:
> > >>> - A stacked mode when the bus is common but the address space extended
> > >>>   with an additinals wires.
> > >>> - A parallel mode with parallel busses accessing parallel flashes where
> > >>>   the data is spread.
> > >>>
> > >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > >>> ---
> > >>>
> > >>> Hello Rob,
> > >>>
> > >>> I know the below does not pass the tests (at least the example patch 3
> > >>> does not pass) but I believe the issue is probably on the tooling side
> > >>> because the exact same thing with uing32-array instead is accepted. The
> > >>> problem comes from the minItems/maxItems lines. Without them, this is
> > >>> okay. The maxItems btw matches the "good enough value for now" idea.
> > >>>
> > >>> The errors I get are:
> > >>>
> > >>> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml
> > >>>   LINT    Documentation/devicetree/bindings
> > >>>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > >>>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > >>>   DTEX    Documentation/devicetree/bindings/spi/spi-controller.example.dts
> > >>>   DTC     Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> > >>>   CHECK   Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
> > >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> > >>>         From schema: /src/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
> > >>>         From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> > >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'sensor@1', 'flash@2' were unexpected)
> > >>>         From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
> > >>> /src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: flash@2: stacked-memories: [[268435456, 268435456]] is too short
> > >>>         From schema: /src/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > >>>
> > >>>
> > >>>  .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
> > >>>  1 file changed, 25 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >>> index 5dd209206e88..fedb7ae98ff6 100644
> > >>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > >>> @@ -82,6 +82,31 @@ properties:
> > >>>      description:
> > >>>        Delay, in microseconds, after a write transfer.
> > >>>
> > >>> +  stacked-memories:
> > >>> +    description: Several SPI memories can be wired in stacked mode.
> > >>> +      This basically means that either a device features several chip
> > >>> +      selects, or that different devices must be seen as a single
> > >>> +      bigger chip. This basically doubles (or more) the total address
> > >>> +      space with only a single additional wire, while still needing
> > >>> +      to repeat the commands when crossing a chip boundary. The size of
> > >>> +      each chip should be provided as members of the array.
> > >>> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> > >>> +    minItems: 2
> > >>> +    maxItems: 4  
> > >>
> > >> Why do we define maxItems? Can't we remove this restriction?  
> > > 
> > > Rob usually prefers to bound properties, that's why we often see "good
> > > enough values for now" in the bindings. If it's no longer the case it's  
> > 
> > right, I saw it.
> > 
> > > fine to drop the maxItems property.  
> > 
> > There's no such hardware limitation as far as I know, that's why I've
> > asked. Maybe Rob can advise.
> 
> Yes, I'll follow what Rob thinks its best:
> - keeping maxItems: 4 (as it is), which is a good enough value

That's what I already suggested, though I would have expected a bigger 
value. For example, something more than the cost or electrical limit of 
what's practical. I don't know that is though. We don't want to be 
updating it frequently.

> - dropping the maxItems here because in the end no bounding is necessary

This will implicitly set the max to 2 based on minItems. That's because 
most of the time we want an exact number of entries.

> - using maxItems: 2 to match the SPI CS even though in theory these two
>   numbers are not correlated (stacked-memories might very well be
>   used by other non SPI memories as well).
> 
> BTW if you're fine with the proposal your Ack is welcome ;)
> 
> Thanks,
> Miquèl
> 
