Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E13A2CF0
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhFJN2O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 09:28:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60576 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFJN2N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 09:28:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15ADPtDP023772;
        Thu, 10 Jun 2021 08:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623331555;
        bh=hJxflv27xv7HBaKWx1YFbsMnx4GIYpGRf+x+c6mC3g8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xU/KVmkJMq46em5BM+/I/CK3N4XFzHOVcSyj2MjBPzsbv1qmypnmMu/5z/+PxGnwk
         7+6NgQyUUy+qfpe5wE5JXkNh7Bp46uuH6MtKLePn4XSRKAZ74gkEmu5GWRkPu9g0QY
         3W0pN05jhxFZYqcpGmM0q+sEM2i4ewPOYFX7JmvM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15ADPtxL086925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jun 2021 08:25:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 08:25:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 10 Jun 2021 08:25:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15ADPsD7015453;
        Thu, 10 Jun 2021 08:25:55 -0500
Date:   Thu, 10 Jun 2021 18:55:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: add schema listing slave-specific
 properties
Message-ID: <20210610132551.rqtswf7zend2f6xw@ti.com>
References: <20210609111707.9555-1-p.yadav@ti.com>
 <20210609111707.9555-2-p.yadav@ti.com>
 <CAL_JsqK5hu6NSVxiTpPvH_jHA97WTj3=DyJhDf5g1hwXXZ8MZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5hu6NSVxiTpPvH_jHA97WTj3=DyJhDf5g1hwXXZ8MZA@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/06/21 03:51PM, Rob Herring wrote:
> On Wed, Jun 9, 2021 at 6:17 AM Pratyush Yadav <p.yadav@ti.com> wrote:
> >
> > Many SPI controllers need to add properties to slave devices. This could
> > be the delay in clock or data lines, etc. These properties are
> > controller specific but need to be defined in the slave node because
> > they are per-slave and there can be multiple slaves attached to a
> > controller.
> >
> > If these properties are not added to the slave binding, then the dtbs
> > check emits a warning. But these properties do not make much sense in
> > the slave binding because they are controller-specific and they will
> > just pollute every slave binding. So this binding is added to collect
> > all such properties from all such controllers. Slave bindings should
> > simply refer to this binding and they should be rid of the warnings.
> 
> Thanks for working on this. I haven't thought of any better solution
> than this approach.
> 
> > There are some limitations with this approach. Firstly, there is no way
> > to specify required properties. The schema contains properties for all
> > controllers and there is no way to know which controller is being used.
> 
> If required properties are a function of the controller and not the
> controller+device, then the controller schema can list required
> properties for child nodes.

For the Cadence controller at least, these should be controller 
specific. Controller+device dependent properties might exist but I don't 
think we have to worry about them for now.

> 
> > Secondly, there is no way to restrict additional properties. Since this
> > schema will be used with an allOf operator, additionalProperties needs
> > to be true. In addition, the slave schema will have to set
> > unevaluatedProperties: false.
> 
> No issue there other than unevaluatedProperties is currently not implemented.
> 
> > Despite these limitations, this appears to be the best solution to this
> > problem that doesn't involve modifying existing tools or schema specs.
> >
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >
> >  .../bindings/spi/cdns,qspi-nor.yaml           | 33 ------------
> >  .../bindings/spi/spi-slave-props.yaml         | 52 +++++++++++++++++++
> 
> I think you need 2+ files here. A common one that's just an 'allOf' of
> all the controller specific schemas and then controller specific child
> node schemas.

Ok.

> 
> >  2 files changed, 52 insertions(+), 33 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > index 0e7087cc8bf9..0730e6a8dc4a 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > @@ -74,39 +74,6 @@ properties:
> >      items:
> >        enum: [ qspi, qspi-ocp ]
> >
> > -# subnode's properties
> > -patternProperties:
> > -  "@[0-9a-f]+$":
> > -    type: object
> > -    description:
> > -      Flash device uses the below defined properties in the subnode.
> > -
> > -    properties:
> > -      cdns,read-delay:
> > -        $ref: /schemas/types.yaml#/definitions/uint32
> > -        description:
> > -          Delay for read capture logic, in clock cycles.
> > -
> > -      cdns,tshsl-ns:
> > -        description:
> > -          Delay in nanoseconds for the length that the master mode chip select
> > -          outputs are de-asserted between transactions.
> > -
> > -      cdns,tsd2d-ns:
> > -        description:
> > -          Delay in nanoseconds between one chip select being de-activated
> > -          and the activation of another.
> > -
> > -      cdns,tchsh-ns:
> > -        description:
> > -          Delay in nanoseconds between last bit of current transaction and
> > -          deasserting the device chip select (qspi_n_ss_out).
> > -
> > -      cdns,tslch-ns:
> > -        description:
> > -          Delay in nanoseconds between setting qspi_n_ss_out low and
> > -          first bit transfer.
> > -
> >  required:
> >    - compatible
> >    - reg
> > diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> > new file mode 100644
> > index 000000000000..b2248e01dc43
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/spi-slave-props.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Slave-specific properties for a SPI bus.
> > +
> > +description: |
> > +  Many SPI controllers need to add properties to slave devices. This could be
> > +  the delay in clock or data lines, etc. These properties are controller
> > +  specific but need to be defined in the slave node because they are per-slave
> > +  and there can be multiple slaves attached to a controller.
> > +
> > +  If these properties are not added to the slave binding, then the dtbs check
> > +  emits a warning. But these properties do not make much sense in the slave
> > +  binding because they are controller-specific and they will just pollute every
> > +  slave binding. So this binding is added to collect all such properties from
> > +  all such controllers. Slave bindings should simply refer to this binding and
> > +  they should be rid of the warnings.
> 
> I don't think this paragraph belongs in the schema.

Ok.

> 
> > +
> > +maintainers:
> > +  - Pratyush Yadav <p.yadav@ti.com>
> > +
> > +properties:
> > +  # cdns,qspi-nor.yaml
> > +  cdns,read-delay:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Delay for read capture logic, in clock cycles.
> > +
> > +  cdns,tshsl-ns:
> > +    description:
> > +      Delay in nanoseconds for the length that the master mode chip select
> > +      outputs are de-asserted between transactions.
> > +
> > +  cdns,tsd2d-ns:
> > +    description:
> > +      Delay in nanoseconds between one chip select being de-activated
> > +      and the activation of another.
> > +
> > +  cdns,tchsh-ns:
> > +    description:
> > +      Delay in nanoseconds between last bit of current transaction and
> > +      deasserting the device chip select (qspi_n_ss_out).
> > +
> > +  cdns,tslch-ns:
> > +    description:
> > +      Delay in nanoseconds between setting qspi_n_ss_out low and
> > +      first bit transfer.
> > +
> > +additionalProperties: true
> > --
> > 2.30.0
> >

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
