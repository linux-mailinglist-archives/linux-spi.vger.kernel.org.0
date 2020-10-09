Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25E12883E5
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgJIHtI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 03:49:08 -0400
Received: from mailout11.rmx.de ([94.199.88.76]:37357 "EHLO mailout11.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgJIHtI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Oct 2020 03:49:08 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout11.rmx.de (Postfix) with ESMTPS id 4C70ZS37KPz41X9;
        Fri,  9 Oct 2020 09:49:04 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4C70ZC5V9sz2TS5B;
        Fri,  9 Oct 2020 09:48:51 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.145) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 9 Oct
 2020 09:48:30 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Date:   Fri, 9 Oct 2020 09:48:29 +0200
Message-ID: <6367849.hfWVFoRi9M@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20201009073944.GA11648@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de> <20201009073944.GA11648@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.145]
X-RMX-ID: 20201009-094851-4C70ZC5V9sz2TS5B-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sascha,

On Friday, 9 October 2020, 09:39:44 CEST, Sascha Hauer wrote:
> On Fri, Oct 09, 2020 at 06:27:38AM +0200, Christian Eggers wrote:
> > This reverts commit 525c9e5a32bd7951eae3f06d9d077fea51718a6c.
> > 
> > If CONFIG_PM is disabled, the system completely freezes on probe as
> > nothing enables the clock of the SPI peripheral.
> 
> Instead of reverting it, why not just fix it?
I expect that 5.9 will be released soon. I think that in this late stage 
reverting is more safe than fixing...

> Normally the device should be brought to active state manually in probe
> before pm_runtime takes over, then CONFIG_PM disabled doesn't hurt.
> Using pm_runtime to put the device to active state initially has the
> problem you describe.
Thanks for the hint. I've no experience in runtime power management. If you 
could provide a patch against the current version, I can make a quick test. I 
can also try to fix it myself, but this will take until next week.

Best regards
Christian



