Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0151F39DE0A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGNug (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 09:50:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48234 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFGNug (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 09:50:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157DmcDA069301;
        Mon, 7 Jun 2021 08:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623073718;
        bh=HGkB3N6wZim5Jz5vrC7ro/91fXnGzv4dfwqqAWDT120=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t8N9g8yVHxRUkW1gTUfz8cmafpC5knGJkz8m8lpDLwuwWfIj/kXHbNryWCXvnOLC8
         zLPzXnwEfU2BwiXdw6DVRXrl9UH4O/cPwYfyvw3IQ2SLL+sJwbJ7pSjOc9Kl1Bupd6
         9mWlFJbgadg4LKPZ8hWLfUNt8yR0mRLNMWoEDVYI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157Dmc8I017282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:48:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:48:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:48:38 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157DmUnt056871;
        Mon, 7 Jun 2021 08:48:32 -0500
Subject: Re: [PATCH 3/5] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in
 property with dt-shema
To:     Nishanth Menon <nm@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210602123416.20378-1-a-govindraju@ti.com>
 <20210602123416.20378-4-a-govindraju@ti.com>
 <20210607134047.isfuedgjxpubpcb5@ungloved>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <9e27bd14-e16a-4177-bba8-d5d0e5638f04@ti.com>
Date:   Mon, 7 Jun 2021 19:18:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607134047.isfuedgjxpubpcb5@ungloved>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nishanth,

On 07/06/21 7:10 pm, Nishanth Menon wrote:
> On 18:04-20210602, Aswath Govindraju wrote:
>> ti,pindir-d0-out-d1-in property is expected to be of type boolean.
>> Therefore, fix the property accordingly.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> No need for Fixes?
> 

Functionality wise this is not a bug as the driver only checks for the
presence of the property. This is the reason why I did not include fixes.

> Also please split up the patches per maintainer so that we are'nt
> confused on who should pick what etc..
> 

okay. Will be aware of this from next time.

Thanks,
Aswath

>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
>>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> index f4ec9ed52939..23d51b6a9cf2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -575,7 +575,7 @@
>>  
>>  	#address-cells = <1>;
>>  	#size-cells= <0>;
>> -	ti,pindir-d0-out-d1-in = <1>;
>> +	ti,pindir-d0-out-d1-in;
>>  };
>>  
>>  &tscadc0 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index eddb2ffb93ca..1b947e2c2e74 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -299,7 +299,7 @@
>>  	pinctrl-0 = <&main_spi0_pins_default>;
>>  	#address-cells = <1>;
>>  	#size-cells= <0>;
>> -	ti,pindir-d0-out-d1-in = <1>;
>> +	ti,pindir-d0-out-d1-in;
>>  
>>  	flash@0{
>>  		compatible = "jedec,spi-nor";
>> -- 
>> 2.17.1
>>
> 
> 

