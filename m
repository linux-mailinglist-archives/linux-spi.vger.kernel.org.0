Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFB13A7A1
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANKmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 05:42:40 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:42287 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgANKmk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 05:42:40 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5F75A240015;
        Tue, 14 Jan 2020 10:42:37 +0000 (UTC)
Date:   Tue, 14 Jan 2020 11:42:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        a.zummo@towertech.it, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Message-ID: <20200114104237.GM3137@piout.net>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14/01/2020 12:23:14+0200, Claudiu Beznea wrote:
> Remove chip whildcard and introduce the list of compatibles instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 699fd3c9ace8..778e8310606a 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -1,10 +1,9 @@
>  * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>  
>  Required properties for USART:
> -- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
> -  The compatible <chip> indicated will be the first SoC to support an
> -  additional mode or an USART new feature.
> -  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> +- compatible: Should be one of the following:
> +	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
> +	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"

All the uarts are not dbgus, so this need to be:

 - "atmel,at91rm9200-usart"
 - "atmel,at91sam9260-usart"
 - "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
 - "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"

Also, you need to update drivers/soc/atmel/soc.c

>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
