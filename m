Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC59D1CD242
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgEKHRg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 03:17:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28800 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKHRg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 03:17:36 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04B78D68004239;
        Mon, 11 May 2020 09:17:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=7EjOxTddIIOGD46hGzyLSFcZQlrJHNVdlCjYIFYnon4=;
 b=yxOsCse5c5VAFj9hUoZ/WDw5yoX4uYk9bARejnXCNca0T9dxLT/ZukAlETjjliEtMiRC
 v9GOvjRa2bZ0KbgBJeswfSRkCZC+yyIVW5WHWyzxEDIda6A+u+qnK0S9X++1VRTJvQ1p
 wdWuEkRuM9DU0L8SQdLCKnCmqQEL1BOn15XuZduKUAVv5cE9Ew2ddTIt+LvtdcYZa4iU
 xf8MuUntXrTgGc6YHIe+SJ4YyII+uXs3j16vXJb3NsPFhAD5QY71icyWZfxDdIrHjqkR
 7t35lFn/G2nAJI+5iNv7/uuP9/JuqCXFmMYz7EtpTBv7G3rbv1wC1+wMgXehEn/JVxhF qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30whn98tuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 09:17:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE992100034;
        Mon, 11 May 2020 09:17:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96B222AC585;
        Mon, 11 May 2020 09:17:11 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 May
 2020 09:17:06 +0200
Subject: Re: [PATCH 2/3] ARM: dts: stm32: enable l3gd20 on stm32429-disco
 board
To:     <dillon.minfei@gmail.com>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <dillonhua@gmail.com>
References: <1589007503-9523-1-git-send-email-dillon.minfei@gmail.com>
 <1589007503-9523-3-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <404e7f47-9c0f-44b1-aedb-a8d3af832d40@st.com>
Date:   Mon, 11 May 2020 09:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1589007503-9523-3-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_02:2020-05-11,2020-05-11 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

On 5/9/20 8:58 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Enable l3gd20 on stm32429-disco board.

You could add some words about l3gd20

> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>   arch/arm/boot/dts/stm32f429-disco.dts | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 30c0f67..d365358 100644
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
> @@ -127,3 +129,25 @@
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

Insert blank line here.

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
