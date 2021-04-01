Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175EA3510D9
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhDAI20 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 04:28:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40816 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhDAI2B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 04:28:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1318RrkV054419;
        Thu, 1 Apr 2021 03:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617265673;
        bh=1YbiXVCeEYFqsRtESxaT0By+IL1CKNL6H/j7+kTcZyk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L0Lznd6Nv9f/Z0NB+E8jDqYi+x+tyoEOdC7YxCHYpPCgFPC8PIy4nthm6uo1ZqdGt
         p9/3/mdUREekCtiDMZPYYQkIXBLlgg0Sm251mpSVqZoN8nMdlnXrfiRX5lWdCtEi8v
         vdhdE2Kn0yzhMWFgzOKCy2XABLCbRAL7xFC62atg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1318Rrfg094811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 03:27:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 03:27:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 03:27:53 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1318RnZ2101922;
        Thu, 1 Apr 2021 03:27:50 -0500
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Pratyush Yadav <p.yadav@ti.com>, Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
 <20210327183628.GA345487@robh.at.kernel.org>
 <20210329182256.q4zhss6lezj3s44a@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1161dc3b-c889-c5d7-f7c8-baf5b7b79505@ti.com>
Date:   Thu, 1 Apr 2021 13:57:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329182256.q4zhss6lezj3s44a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/29/21 11:52 PM, Pratyush Yadav wrote:
>>> +  cdns,fifo-depth:
>>> +    description:
>>> +      Size of the data FIFO in words.
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +    enum: [ 128, 256 ]
>>> +    default: 128
>>> +
>>> +  cdns,fifo-width:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Bus width of the data FIFO in bytes.
>>> +    default: 4
>> I assume there's some constraints on this?
> IIUC this is a matter of how the peripheral is implemented and there are 
> no clear constraints. Different implementations can use different bus 
> widths for the SRAM bus but I don't see any mention of minimum or 
> maximum values. FWIW, all users in the kernel use a 4 byte bus.
> 

IMO a safe constraint would be to set a range of 1 to 4 (8/16/24/32 bit
wide) given this represents SRAM bus width. Binding can always be
updated if there exists an implementation with higher SRAM bus
width/fifo-width (although that's highly unlikely given there are no
such examples today).

But leaving it open ended with range of 0 to UINT_MAX sounds incorrect
to me.

>> With that,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> Thanks.
> 
