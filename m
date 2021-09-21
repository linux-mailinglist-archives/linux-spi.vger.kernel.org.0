Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB434134AF
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhIUNqU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 09:46:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhIUNqT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 09:46:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18LDigMU006925;
        Tue, 21 Sep 2021 08:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632231882;
        bh=9/0CIvgoXoNw6Uen/PE86wIdMfBIuYgmLDb8VlnIav0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BFJP5YFFVhDp+nh/dlHvCeL9SoaNRHQGefPUcH3JJS7HiTgVxTB250Ic1Elh/qwz7
         KUg18hW7VgHq+c4PdQJNJEVrpY6REIPjc0BLQwBxdOlYwsXCKlvNLUprkcqfa7SQT7
         kWwfMmllrMDxBGbggbxwVCR8JhF/a7yTwgHe2Zlc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18LDif9u079754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Sep 2021 08:44:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Sep 2021 08:44:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Sep 2021 08:44:41 -0500
Received: from [10.250.233.5] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18LDiapY003451;
        Tue, 21 Sep 2021 08:44:37 -0500
Subject: Re: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node
 name instead of 'spi-flash' in example
To:     Rob Herring <robh@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <michael@walle.cc>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-3-a-nandan@ti.com>
 <YUj6yUBx0xCY9QGj@robh.at.kernel.org>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <408954fa-aa71-6f35-3b02-0e7a078658f0@ti.com>
Date:   Tue, 21 Sep 2021 19:14:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUj6yUBx0xCY9QGj@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 21/09/21 2:49 am, Rob Herring wrote:
> On Mon, Sep 20, 2021 at 07:57:13PM +0530, Apurva Nandan wrote:
>> Change the nodename in the example with spi-nand from 'spi-flash@1'
>> to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
>> flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
>> so make the spi-nand examples in dt-bindings use it too for uniformity.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Fixes should come first. Maybe Mark can apply this before you respin.
>
> Acked-by: Rob Herring <robh@kernel.org>
Please tell if I need to re-roll this series for changing the order of 
the two patches.
>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> index ca91201a9926..d7e08b03e204 100644
>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> @@ -171,7 +171,7 @@ examples:
>>         cs-gpios = <&gpio0 13 0>,
>>                    <&gpio0 14 0>;
>>         rx-sample-delay-ns = <3>;
>> -      spi-flash@1 {
>> +      flash@1 {
>>           compatible = "spi-nand";
>>           reg = <1>;
>>           rx-sample-delay-ns = <7>;
>> -- 
>> 2.25.1
>>
>>
Thanks,
Apurva Nandan
