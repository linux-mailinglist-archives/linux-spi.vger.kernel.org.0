Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B02465EA7
	for <lists+linux-spi@lfdr.de>; Thu,  2 Dec 2021 08:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhLBH2s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 2 Dec 2021 02:28:48 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51813 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbhLBH2s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Dec 2021 02:28:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DEABCE0008;
        Thu,  2 Dec 2021 07:25:21 +0000 (UTC)
Date:   Thu, 2 Dec 2021 08:25:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 2/5] dt-bindings: mtd: spi-nor: Allow external
 properties
Message-ID: <20211202082521.77c2837f@xps13>
In-Reply-To: <YagN1c7/Ltt/mhNp@robh.at.kernel.org>
References: <20211126163450.394861-1-miquel.raynal@bootlin.com>
        <20211126163450.394861-3-miquel.raynal@bootlin.com>
        <YagN1c7/Ltt/mhNp@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Wed, 1 Dec 2021 18:05:41 -0600:

> On Fri, Nov 26, 2021 at 05:34:47PM +0100, Miquel Raynal wrote:
> > Setting "additionalProperties: false" will refuse any generic SPI
> > property while they should be of course authorized. In practice it looks
> > like many people used compatibles different than "jedec,spi-nor" in
> > order to workaround this limitation because otherwise no SPI property
> > could be used in the examples. Use "unevaluatedProperties: false"
> > instead to allow defined properties to be used. It is likely that at the
> > time of the conversion to yaml of the jedec file, the unevaluated
> > keyword was not yet introduced.
> > 
> > Fixes: 3ff9ee2a8890 ("dt-bindings: mtd: spi-nor: Convert to DT schema format")
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index ed590d7c6e37..81be0620b264 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -88,7 +88,7 @@ patternProperties:
> >    "^otp(-[0-9]+)?$":
> >      type: object
> >  
> > -additionalProperties: false
> > +unevaluatedProperties: false  
> 
> This has no effect unless you have referenced some other schema here. 
> The series I referenced will solve what your trying to solve I think.

Maybe this is not the right fix indeed, but my understanding of json
reaches its bounds here.

Without this change, any example in this file that references a
spi-controller.yaml property (which is correctly defined) will throw an
error. The fact is, all the examples out there with a spi-nor flash
using the jedec,spi-nor compatible *cannot* contain any
spi-controller.yaml property, otherwise the tooling errors out. This is
a real issue.

I will give Pratyush's series a try.

Thanks,
Miquèl
