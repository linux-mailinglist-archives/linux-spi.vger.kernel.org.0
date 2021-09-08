Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06BE4038C5
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbhIHLdW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:33:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35164 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhIHLdV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:33:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 188BWBN8008178;
        Wed, 8 Sep 2021 06:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631100731;
        bh=AZVddGgyrMeNCeMAdzzk6hAXy8GcpJUdmlIjzPJCxT0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kto+A+tye33ToZTbvTZtwDalC974GvHFFU7GfUy+d1ggAkYK/mJJKdo6c8kbgmtIl
         PTbFqYJohfMl0PS9E1m64cksp+0rRF7vs9NjiMq3uDfqZA11y60wjLOZrRVrUvT9oa
         oUe1f9EugMLKxv3y40lV13qUHqw3lv3oKIqKuSJc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 188BWBwA026093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 06:32:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 06:32:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 06:32:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 188BWAgw044553;
        Wed, 8 Sep 2021 06:32:11 -0500
Date:   Wed, 8 Sep 2021 17:02:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Message-ID: <20210908113207.6y6h6l23htngrea2@ti.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499829-20059-1-git-send-email-pthombar@cadence.com>
 <20210903181722.ukarfanyew2b7yoz@ti.com>
 <CY4PR07MB2757DF7EFD862D67FBF648CBC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY4PR07MB2757DF7EFD862D67FBF648CBC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/09/21 06:52AM, Parshuram Raju Thombare wrote:
> >This needs to be a "subclass" of the spi-controller.yaml binding.
> >
> >allOf:
> >  - $ref: spi-controller.yaml#
> 
> Isn't stating that validation need against spi-controller.yaml as well as
> this schema sufficient ? Can you please point an example how to make
> controller binding a "subclass" of spi-controller.yaml binding ?

I just showed you. You need to add the below lines:

allOf:
  - $ref: spi-controller.yaml#

See cdns,qspi-nor.yaml or nvidia,tegra210-quad.yaml or any of the 
multiple controller bindings we already have.

By "subclass" I did not mean a programming construct, I just meant it 
should logically be a subclass of the spi-controller.yaml binding, which 
can be done by the allOf.

> 
> >Node name should be flash@0.
> 
> I think spi-controller.yaml uses wildcard for the name of a device node,
> so anything in string@hexvalue: should work.

Sure, but mtd.yaml (which the SPI NOR binding depends on) requires it.

> 
> >> +            compatible = "spi-nor", "micron,mt35xu512";
> >
> >These compatibles are arbitrary and undocumented. You probably just need
> >"jedec,spi-nor". If you need anything else, you need to justify why.
> 
> Although just "spi-nor" also works, I agree to use "jedec, spi-nor" and drop
> device name.

Does it? I see "jedec,spi-nor" compatible documented, but not just 
"spi-nor". And I don't see "micron,mt35xu512" compatible documented 
anywhere either.

Anyway, please just use "jedec,spi-nor".

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
