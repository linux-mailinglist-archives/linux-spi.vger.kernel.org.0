Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCE13DCBC
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgAPN7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 08:59:16 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:48083 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPN7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jan 2020 08:59:16 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 94863240019;
        Thu, 16 Jan 2020 13:59:12 +0000 (UTC)
Date:   Thu, 16 Jan 2020 14:59:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        a.zummo@towertech.it, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 4/5] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and
 MICROCHIP_PIT64B
Message-ID: <20200116135912.GH100374@piout.net>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
 <1579085987-13976-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579085987-13976-5-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15/01/2020 12:59:46+0200, Claudiu Beznea wrote:
> Enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B. These are necessary
> for SAM9X60.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/configs/at91_dt_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
