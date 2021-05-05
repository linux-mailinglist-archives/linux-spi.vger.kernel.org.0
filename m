Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849943735EE
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEEIAo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 5 May 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhEEIAn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 04:00:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A8C061574
        for <linux-spi@vger.kernel.org>; Wed,  5 May 2021 00:59:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1leCRW-0003vm-La; Wed, 05 May 2021 09:59:38 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1leCRT-0004SA-6P; Wed, 05 May 2021 09:59:35 +0200
Date:   Wed, 5 May 2021 09:59:35 +0200
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     broonie@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk
Subject: Re: [PATCH v2 2/8] spi: rockchip: Wait for STB status in slave mode
 tx_xfer
Message-ID: <20210505075935.GB10432@pengutronix.de>
References: <20210427073733.31419-1-jon.lin@rock-chips.com>
 <20210427073733.31419-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210427073733.31419-2-jon.lin@rock-chips.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:57:07 up 76 days, 11:21, 88 users,  load average: 0.04, 0.07,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon Lin,

On Tue, Apr 27, 2021 at 03:37:27PM +0800, Jon Lin wrote:
> +static inline void wait_for_tx_idle(struct rockchip_spi *rs, bool slave_mode)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(5);
>  
>  	do {
> -		if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
> -			return;
> +		if (slave_mode) {
> +			if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_SLAVE_TX_BUSY) &&
> +			    !((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
> +				return;

This doesn't compile. There is one opening brace too much before the
readl_relaxed.

Regards,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
