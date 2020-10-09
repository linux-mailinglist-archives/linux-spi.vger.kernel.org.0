Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576332883C8
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgJIHjw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgJIHjw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Oct 2020 03:39:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFFC0613D2
        for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2020 00:39:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kQn0E-0000mG-3U; Fri, 09 Oct 2020 09:39:46 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kQn0C-0006xe-TL; Fri, 09 Oct 2020 09:39:44 +0200
Date:   Fri, 9 Oct 2020 09:39:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Message-ID: <20201009073944.GA11648@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009042738.26602-1-ceggers@arri.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:30:15 up 232 days, 15:00, 151 users,  load average: 0.66, 0.48,
 0.40
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 09, 2020 at 06:27:38AM +0200, Christian Eggers wrote:
> This reverts commit 525c9e5a32bd7951eae3f06d9d077fea51718a6c.
> 
> If CONFIG_PM is disabled, the system completely freezes on probe as
> nothing enables the clock of the SPI peripheral.

Instead of reverting it, why not just fix it?

Normally the device should be brought to active state manually in probe
before pm_runtime takes over, then CONFIG_PM disabled doesn't hurt.
Using pm_runtime to put the device to active state initially has the
problem you describe.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
