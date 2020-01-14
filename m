Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA01813ACF9
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgANPD6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 10:03:58 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33093 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgANPD6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 10:03:58 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AB6C520000A;
        Tue, 14 Jan 2020 15:03:53 +0000 (UTC)
Date:   Tue, 14 Jan 2020 16:03:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        a.zummo@towertech.it, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Message-ID: <20200114150353.GP3137@piout.net>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
 <20200114104237.GM3137@piout.net>
 <f3c4d460-cff6-2e14-428a-a732a6bffe38@microchip.com>
 <20200114111704.GN3137@piout.net>
 <a7f9f8c6-7636-6c1d-ecd8-39e5a956b85a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f9f8c6-7636-6c1d-ecd8-39e5a956b85a@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14/01/2020 14:58:23+0000, Claudiu.Beznea@microchip.com wrote:
> > Then, what is the point of adding microchip,sam9x60-dbgu ?
> 
> Different meaning for CIDR register bits. Version is kept on bits 4 to 0
> but not documented in public datasheet, so version displayed by
> drivers/soc/atmel/soc.c should work.

But at91_get_cidr_exid_from_dbgu will not find the node unless you use
two fallbacks.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
