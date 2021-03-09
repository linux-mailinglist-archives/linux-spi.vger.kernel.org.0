Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CC332060
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 09:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCIIUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 03:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCIITp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 03:19:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87574C06174A
        for <linux-spi@vger.kernel.org>; Tue,  9 Mar 2021 00:19:45 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJXaR-0003CY-C9; Tue, 09 Mar 2021 09:19:27 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJXaQ-0007kf-1q; Tue, 09 Mar 2021 09:19:26 +0100
Date:   Tue, 9 Mar 2021 09:19:26 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] enable flexspi support on imx8mp
Message-ID: <20210309081926.aer6dgum7nljoc57@pengutronix.de>
References: <20210309053116.1486347-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309053116.1486347-1-hs@denx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:17:09 up 96 days, 22:23, 40 users,  load average: 0.04, 0.12,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Heiko,

On 21-03-09 06:31, Heiko Schocher wrote:
> 
> This series enables support for the SPI NOR on the
> imx8mp based phyboard-pollux-rdk board.
> 
> Patches new in v2:
> "spi: fspi: enable fspi driver for on imx8mp"
> which adds own compatible entry for imx8mp
> 
> and seperate in own patch the documentation entry in
> patch "dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller"
> as checkpatch says:
> 
> warning: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

Thanks for picking up the comments :) Did you missed to send them or did
you used an other Cc: and To: for the new patches?

Regards,
  Marco
