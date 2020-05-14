Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31FC1D34C3
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgENPPB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 11:15:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgENPPA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 11:15:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EFCPsL032012;
        Thu, 14 May 2020 17:14:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DXcy1MTj2HjZebWARaLMtOPUytmDO38gw8qZM9TYdJk=;
 b=msQ4xxKCBfHwwsCI0M418ZXWCj/nELFaZan4ClSeir8qXib+bjaGK1834HhoN4xDaVWT
 4IMxO1mGyzhg22Sk76JtHn4tyWhZiONIAjVTAQRsvJkWgjUX6z6O4oaP701uy5xek3CQ
 s9FzdJP1x4nm1qE+En5a+Q4LW27Ui5vXUtU+ekOJZEuSFihqK+NF9gMFlXKVi1vlZmIo
 SqB7smQt744V+UX4OLWvwZqimvs1DugASuqTCNn8aU94qgfJzzfW9di0xX3URngifB1I
 f3S6RjnfJ/PF+pP4w3qFC6PH6IfYxn9Gvn8UVrs0XU6ySdsJselHg8KCbfq84Bb+a8kA YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vnc101-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 17:14:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88D9210002A;
        Thu, 14 May 2020 17:14:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7284F2CD9A3;
        Thu, 14 May 2020 17:14:38 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 17:14:32 +0200
Subject: Re: [PATCH v2 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco
 board
To:     dillon min <dillon.minfei@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>, <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Hua Dillon <dillonhua@gmail.com>
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
 <1589269010-18472-3-git-send-email-dillon.minfei@gmail.com>
 <da9fbb80-571d-1217-4028-e413a0c7db84@st.com>
 <CAL9mu0KJ0j6Rxf7YjKxVWKz_d+B6vrwqqxJM-fmzG=NonLeDYQ@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f3af6148-7b22-303b-aa72-996d061a3c78@st.com>
Date:   Thu, 14 May 2020 17:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0KJ0j6Rxf7YjKxVWKz_d+B6vrwqqxJM-fmzG=NonLeDYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 5/14/20 9:07 AM, dillon min wrote:
> Hi Alexandre,
> 
> Alexandre Torgue <alexandre.torgue@st.com> 于2020年5月14日周四 下午10:10写道：
>>
>> Hi Dillon
>>
>> On 5/12/20 9:36 AM, dillon.minfei@gmail.com wrote:
>>> From: dillon min <dillon.minfei@gmail.com>
>>>
>>> L3gd20, st mems motion sensor, 3-axis digital output gyroscope,
>>> connect to stm32f429 via spi5
>>>
>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>>> ---
>>>
>>> Hi Alexandre,
>>>
>>> V2:
>>>       1, insert blank line at stm32f420-disco.dts line 143
>>>       2, add more description about l3gd20 in commit message
>>>
>>> V1:
>>>       enable l3gd20 dts binding on stm32f429-disco
>>>
>>> thanks.
>>>
>>> dillon,
>>>
>>>    arch/arm/boot/dts/stm32f429-disco.dts | 25 +++++++++++++++++++++++++
>>>    1 file changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
>>> index 30c0f67..1bfb903 100644
>>> --- a/arch/arm/boot/dts/stm32f429-disco.dts
>>> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
>>> @@ -49,6 +49,8 @@
>>>    #include "stm32f429.dtsi"
>>>    #include "stm32f429-pinctrl.dtsi"
>>>    #include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>>
>>>    / {
>>>        model = "STMicroelectronics STM32F429i-DISCO board";
>>> @@ -127,3 +129,26 @@
>>>        pinctrl-names = "default";
>>>        status = "okay";
>>>    };
>>> +
>>> +&spi5 {
>>> +     status = "okay";
>>> +     pinctrl-0 = <&spi5_pins>;
>>> +     pinctrl-names = "default";
>>> +     #address-cells = <1>;
>>> +     #size-cells = <0>;
>>> +     cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>;
>>> +     dmas = <&dma2 3 2 0x400 0x0>,
>>> +            <&dma2 4 2 0x400 0x0>;
>>> +     dma-names = "rx", "tx";
>>> +
>>
>> You added this spi5 node in this patch but also in the display series. I
>> will have issue to merge. Even if I could fix it easily, as you are
>> going to resend, the good practice could be to have several patches in
>> one series: one patch for spi5 controller, another for gyro and another
>> for display.
>>
>> And also same remark than Linus did in display series move DMA to soc
>> dtsi file please.
> 
> Sure, how about this patch sequence:
> 1 add spi5 dma to soc (stm32f429.dtsi)
> 2 add pin map for spi5 (stm32f4-pinctrl.dtsi)
> 3 add spi5 controller with gyro (stm32f429-disco.dts)
> 4 add spi modification to support gyro (spi-stm32.c)
> 
> 5 add ltdc pin map for stm32f429-disco board (stm32f4-pinctrl.dtsi)
> 6 add ilitek-ili9341 dts bindings for disco (stm32f429-disco.dts,
> depends on above step 3)
> 7 add yaml document about ilitek-ili9341 (ilitek,ili9341.yaml)
> 8 add clk changes to support ltdc driver (clk-stm32f4.c)
> 
> so, i will combine gyro and display two patches to one patchset next
> time. right ?
> 

looks good

> thanks.
>>
>>
>>> +     l3gd20: l3gd20@0 {
>>> +             compatible = "st,l3gd20-gyro";
>>> +             spi-max-frequency = <10000000>;
>>> +             st,drdy-int-pin = <2>;
>>> +             interrupt-parent = <&gpioa>;
>>> +             interrupts = <1 IRQ_TYPE_EDGE_RISING>,
>>> +                             <2 IRQ_TYPE_EDGE_RISING>;
>>> +             reg = <0>;
>>> +             status = "okay";
>>> +     };
>>> +};
>>>
