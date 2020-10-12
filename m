Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBED28B3D7
	for <lists+linux-spi@lfdr.de>; Mon, 12 Oct 2020 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgJLLdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Oct 2020 07:33:40 -0400
Received: from mailout04.rmx.de ([94.199.90.94]:58043 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbgJLLdj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Oct 2020 07:33:39 -0400
X-Greylist: delayed 1955 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 07:33:38 EDT
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4C8whW66vqz3r0h8;
        Mon, 12 Oct 2020 13:00:59 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4C8whK1HBLz2TTNp;
        Mon, 12 Oct 2020 13:00:49 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.46) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 12 Oct
 2020 12:59:35 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Date:   Mon, 12 Oct 2020 12:59:34 +0200
Message-ID: <2670390.HS4A6M72fu@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20201009073944.GA11648@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de> <20201009073944.GA11648@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.46]
X-RMX-ID: 20201012-130049-4C8whK1HBLz2TTNp-0@kdin02
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
> 
> Normally the device should be brought to active state manually in probe
> before pm_runtime takes over, then CONFIG_PM disabled doesn't hurt.
> Using pm_runtime to put the device to active state initially has the
> problem you describe.

prior introducing runtime pm for spi-imx, the clock was "manually" enabled and 
disabled around each transfer (so the power usage should already have been 
optimal). If we would manually enable the clock in probe() as you suggested, 
for users without CONFIG_PM there would be a drawback compared with the 
previous state (as the clock will always be on now).

What is the benefit of controlling the SPI clock with runtime PM instead of 
doing it manually?

As I have no experience with runtime PM, hopefully somebody else can fix (or 
revert) this.

@Clark: I forgot to put you on CC on my initial message. You can find the full 
discussion here:
https://lore.kernel.org/patchwork/patch/1318736/

Best regards
Christian




