Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630CA46673C
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbhLBPza (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Dec 2021 10:55:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46074 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359294AbhLBPzY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Dec 2021 10:55:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815F76268F;
        Thu,  2 Dec 2021 15:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5886C00446;
        Thu,  2 Dec 2021 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638460318;
        bh=g3x2golTGf5LugWWOotMX5nRZX1ofZdncgn84uvvPlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g6yl5S3JYHbzjRbXILCSprPqXuXohk/c8wPkgDh3Wx7E7ZAVwZ0YvZkSMHkcliUhu
         8iN8cz92mLSvsOv1EdQXKIj2//eUuorBmlQEP7bSRjTSSLvCoOLwuY2sySf1nmxfFP
         yxJ85XxtnxRQAFxVOZZ/mw+iDqTndt+quoFAzwRrFAmYSNsM06722ogs2TJh7XCC6d
         x8qOQSgr42rq8v+p5NtTdsw/4ghC3gqP4sBv4gQ2Oukgsg4+6T7f1jDtmyVBP6yD8w
         GQ69kB4Jja4TlQSIS3+Bk2orG0ojUvjgf1DkuswlDqjGTPHG41VHpM1lhEa/OeKTVx
         BDfEl2Z6fXpkg==
Received: by mail-ed1-f41.google.com with SMTP id y12so117393334eda.12;
        Thu, 02 Dec 2021 07:51:58 -0800 (PST)
X-Gm-Message-State: AOAM530zA4qaVCWBxDlsQ+ZwFUp2eVDCOY42I1vFbVm95Es2UVY3wGp9
        qJnbAsrNAToN5VyjJbQWiHbpRRlSr1UZ0capyg==
X-Google-Smtp-Source: ABdhPJwQBKOUdKbAtcY9buMEqJoescJX1oqIF6R8Pi1NUjzxQDmpidmsR3w6UdwGQEcoQbYSmGssgYFJ11kH/XOXeDU=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr18177641edt.201.1638460310108;
 Thu, 02 Dec 2021 07:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
 <20211126163450.394861-3-miquel.raynal@bootlin.com> <YagN1c7/Ltt/mhNp@robh.at.kernel.org>
 <20211202082521.77c2837f@xps13>
In-Reply-To: <20211202082521.77c2837f@xps13>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Dec 2021 09:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLL3rxA4p7T1girYOJ2cHTWSEJWWvSUpFOfz9ZTjMXAHQ@mail.gmail.com>
Message-ID: <CAL_JsqLL3rxA4p7T1girYOJ2cHTWSEJWWvSUpFOfz9ZTjMXAHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mtd: spi-nor: Allow external properties
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 2, 2021 at 1:25 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> robh@kernel.org wrote on Wed, 1 Dec 2021 18:05:41 -0600:
>
> > On Fri, Nov 26, 2021 at 05:34:47PM +0100, Miquel Raynal wrote:
> > > Setting "additionalProperties: false" will refuse any generic SPI
> > > property while they should be of course authorized. In practice it looks
> > > like many people used compatibles different than "jedec,spi-nor" in
> > > order to workaround this limitation because otherwise no SPI property
> > > could be used in the examples. Use "unevaluatedProperties: false"
> > > instead to allow defined properties to be used. It is likely that at the
> > > time of the conversion to yaml of the jedec file, the unevaluated
> > > keyword was not yet introduced.
> > >
> > > Fixes: 3ff9ee2a8890 ("dt-bindings: mtd: spi-nor: Convert to DT schema format")
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > index ed590d7c6e37..81be0620b264 100644
> > > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > > @@ -88,7 +88,7 @@ patternProperties:
> > >    "^otp(-[0-9]+)?$":
> > >      type: object
> > >
> > > -additionalProperties: false
> > > +unevaluatedProperties: false
> >
> > This has no effect unless you have referenced some other schema here.
> > The series I referenced will solve what your trying to solve I think.
>
> Maybe this is not the right fix indeed, but my understanding of json
> reaches its bounds here.
>
> Without this change, any example in this file that references a
> spi-controller.yaml property (which is correctly defined) will throw an
> error. The fact is, all the examples out there with a spi-nor flash
> using the jedec,spi-nor compatible *cannot* contain any
> spi-controller.yaml property, otherwise the tooling errors out. This is
> a real issue.

That's probably because unevaluatedProperties is unimplemented in the
last dtschema release, but now supported in main branch. I'll be
tagging a release soon. So once the newer version is used, you should
be back to the same error.

> I will give Pratyush's series a try.

Referencing spi-peripheral.yaml with 'unevaluatedProperties: false'
should give you what you need.

Rob
