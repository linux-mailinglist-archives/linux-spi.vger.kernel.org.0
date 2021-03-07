Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1951033022F
	for <lists+linux-spi@lfdr.de>; Sun,  7 Mar 2021 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCGOnY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 7 Mar 2021 09:43:24 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:43365 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhCGOnP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 7 Mar 2021 09:43:15 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8D60C2800B3CA;
        Sun,  7 Mar 2021 15:43:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 81C951AF2E; Sun,  7 Mar 2021 15:43:13 +0100 (CET)
Date:   Sun, 7 Mar 2021 15:43:13 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210307144313.GA15472@wunner.de>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301135405.GC4628@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 01, 2021 at 01:54:05PM +0000, Mark Brown wrote:
> On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
> > +	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
> > +				dev_name(dev), master);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
> > +		return ret;
> > +	}
> 
> This will free the IRQ *after* the controller is unregistered, it's
> better to manually free the interrupt

Transfers may still be ongoing until spi_unregister_controller() returns.
(It's called from devres_release_all() in this case.)  Since the IRQ is
presumably necessary to handle those transfers, freeing the IRQ after
unregistering is actually correct.  So the code looks fine in principle.

However, because the IRQ is requested with IRQF_SHARED, the handler may
be invoked at any time, even after the controller has been unregistered.
It is therefore necessary to quiesce the SPI controller's interrupt on
unregistering and it is also necessary to check in the IRQ handler whether
an interrupt is actually pending (and bail out if not).

Thanks,

Lukas
