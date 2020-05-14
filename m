Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A801D3244
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENOKV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 10:10:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENOKU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 10:10:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EE3BuV021940;
        Thu, 14 May 2020 16:10:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nGjr1Mu7bkzp2bxZhBiDxdZ++d1WWKpOhGKs+gral3M=;
 b=Tq5YkrOS4LSWphjCakeNMmmhH06rm4W1vFs1ggV9DtufKvfk5Y3v1ebF47urfBqaEIvu
 9EDT1fYMFH9XeMRHOXzXPmHi6DDs2PQjs50X46K8+dLT2aWJbrwtu41mpPkXTVspPwYY
 DvujEIxtq4i3el5pULfAP9w7oRlMpOd0hwg18pZ+1JXHfercoJ68fx+mUKzGE/vsJa0e
 hZcIqlP2wjlM0eVow+1OZi1f+ixVkUtXPxl8Z6dJ9eG8pDzWcs2CHJkzM0WepTJ8NpYn
 XgZVtwY3IioxxDIu+iiibtCPkpE/NqiBZN0k++bpODuRDykzg1hdj9F3pKJtV5EXcJF+ Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vykuda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 16:10:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD25210002A;
        Thu, 14 May 2020 16:10:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B967B2BF9CD;
        Thu, 14 May 2020 16:10:03 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 16:09:56 +0200
Subject: Re: [PATCH v2 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco
 board
To:     <dillon.minfei@gmail.com>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <dillonhua@gmail.com>
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
 <1589269010-18472-3-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <da9fbb80-571d-1217-4028-e413a0c7db84@st.com>
Date:   Thu, 14 May 2020 16:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589269010-18472-3-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_04:2020-05-14,2020-05-14 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dillon

On 5/12/20 9:36 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> L3gd20, st mems motion sensor, 3-axis digital output gyroscope,
> connect to stm32f429 via spi5
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> 
> Hi Alexandre,
> 
> V2:
>      1, insert blank line at stm32f420-disco.dts line 143
>      2, add more description about l3gd20 in commit message
> 
> V1:
>      enable l3gd20 dts binding on stm32f429-disco
> 
> thanks.
> 
> dillon,
> 
>   arch/arm/boot/dts/stm32f429-disco.dts | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 30c0f67..1bfb903 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -49,6 +49,8 @@
>   #include "stm32f429.dtsi"
>   #include "stm32f429-pinctrl.dtsi"
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "STMicroelectronics STM32F429i-DISCO board";
> @@ -127,3 +129,26 @@
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> +
> +&spi5 {
> +	status = "okay";
> +	pinctrl-0 = <&spi5_pins>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	cs-gpios = <&gpioc 1 GPIO_ACTIVE_LOW>;
> +	dmas = <&dma2 3 2 0x400 0x0>,
> +	       <&dma2 4 2 0x400 0x0>;
> +	dma-names = "rx", "tx";
> +

You added this spi5 node in this patch but also in the display series. I 
will have issue to merge. Even if I could fix it easily, as you are 
going to resend, the good practice could be to have several patches in 
one series: one patch for spi5 controller, another for gyro and another 
for display.

And also same remark than Linus did in display series move DMA to soc 
dtsi file please.


> +	l3gd20: l3gd20@0 {
> +		compatible = "st,l3gd20-gyro";
> +		spi-max-frequency = <10000000>;
> +		st,drdy-int-pin = <2>;
> +		interrupt-parent = <&gpioa>;
> +		interrupts = <1 IRQ_TYPE_EDGE_RISING>,
> +				<2 IRQ_TYPE_EDGE_RISING>;
> +		reg = <0>;
> +		status = "okay";
> +	};
> +};
> 
