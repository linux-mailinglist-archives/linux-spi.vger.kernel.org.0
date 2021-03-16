Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5233DC2E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhCPSIT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 14:08:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbhCPSHN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 14:07:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GI6xuZ071441;
        Tue, 16 Mar 2021 13:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615918019;
        bh=2r9YstoNEEa/M6gol0Amif0/Vm23LBs3Ked7QXVENQY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Nu54O/l0X+v6dYIjZoHxoOk2mNpYPd3via5MJmGXOj5YF/59/sPKbl3LOfSjO5ICF
         UiLY+O/cRXEpwpt9QfZR/oupLZg62Zxw8ZxNylFo/W4CXJvuY8PkDKVv8U1KTgab1j
         E0irDDFjZvwWdeLr3FMN5LA4iS7eAppnamVKi6z0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GI6xjn075564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 13:06:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 13:06:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 13:06:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GI6wdx045156;
        Tue, 16 Mar 2021 13:06:59 -0500
Date:   Tue, 16 Mar 2021 23:36:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Kuldeep Singh <kuldeep.singh@nxp.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210316180655.6oidvffum7yuwknr@ti.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
 <067c42f3726578ebe60d201a141dfdb6@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <067c42f3726578ebe60d201a141dfdb6@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/03/21 06:45PM, Michael Walle wrote:
> Am 2021-03-15 19:30, schrieb Pratyush Yadav:
> 
> ..
> > > +patternProperties:
> > > +  "@[0-9a-f]+":
> 
> Shouldn't this be "^.*@[0-9a-f]+$"?

The pattern has to match _anywhere_ in the string so both should match 
the flash node. Your pattern is more "strict" or "precise". See the note 
at [0].

[0] https://json-schema.org/understanding-json-schema/reference/string.html#regular-expressions

> 
> > > +    type: object
> > > +
> > > +    properties:
> > > +      fsl,spi-cs-sck-delay:
> > > +        description:
> > > +          Delay in nanoseconds between activating chip select and
> > > the start of
> > > +          clock signal, at the start of a transfer.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +      fsl,spi-sck-cs-delay:
> > > +        description:
> > > +          Delay in nanoseconds between stopping the clock signal and
> > > +          deactivating chip select, at the end of a transfer.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> ..
> 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
