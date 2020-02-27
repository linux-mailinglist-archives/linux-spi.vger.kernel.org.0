Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8078F17101D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 06:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB0FXe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 00:23:34 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51936 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB0FXe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 00:23:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01R5NOYs051937;
        Wed, 26 Feb 2020 23:23:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582781004;
        bh=aueWvRhnsk1j4ISudSz1dpXEuMjP+6yX/doVizEUsGg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DcZrrui05UVXJhq5ttuBOdcJZ9V4MUo4NNbW1abN3yUPkazQZ2qn1vJllgNJzaext
         PyvSw+z5faVoajMlOAyg7iVQTTBb2z2nc8VjEVyS6iwzdCyMc+ZzPRvKfEc0KMc95P
         KRFnHL0DsNMWYgfNgl8FY9XQNTuTURnfzFAeOojI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01R5NOXH043480;
        Wed, 26 Feb 2020 23:23:24 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 23:23:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 23:23:24 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01R5NJV0001472;
        Wed, 26 Feb 2020 23:23:21 -0600
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>, <tien.fong.chee@intel.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
 <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
 <85178128-4906-8b1a-e3f1-ab7a36ff8c23@ti.com>
 <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
 <8c329860-84fd-463b-782f-83a788998878@ti.com>
 <98c90f35-297b-a13c-61ad-ce7a7f1d650f@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <22bb0c6c-db03-dee5-eccf-84b00216308f@ti.com>
Date:   Thu, 27 Feb 2020 10:53:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <98c90f35-297b-a13c-61ad-ce7a7f1d650f@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 26/02/20 7:02 am, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 25/2/2020 7:00 PM, Vignesh Raghavendra wrote:
>>
>> On 25/02/20 1:08 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>>>>> +
>>>>>>> +  cdns,fifo-depth:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description:
>>>>>>> +      Size of the data FIFO in words.
>>>>>> A 4GB fifo is valid? Add some constraints.
>>>>> 128 is valid, will update.
>>>> Nope, the width of this field is 8bits -> 256 bytes
>>> correct me if I am wrong, the width of this field is 4bits -> 128 bytes
>>> (based on QUAD mode) .
>> This has nothing to do with quad-mode. Its about how much SRAM amount of
>> SRAM is present to buffer INDAC mode data. For TI platforms this is 256
>> bytes.
>> See CQSPI_REG_SRAMPARTITION definition in your datasheet.
> Agreed, Thanks!
> Yes , I have gone through it , Intel and Altera SoC's SRAM(act as
> FIFO)size is 128 bytes and TI has 256 .
> BTW old legacy DT binding mentioned size is 128, as per your earlier
> suggestion you have mention that
> keep the contents from old dt bindings as it is, so shall I keep 128/256?

Old bindings does not impose a restriction that this needs to be 128
bytes always (Its just the example that shows this property to be set to
128)

What Rob is asking for is to add range of values that is valid for this
field and not single value. So, both 128 and 256 bytes should be allowed
as valid values for this property.


-- 
Regards
Vignesh
