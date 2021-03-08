Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE63315C0
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHSTO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 13:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHSSr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 13:18:47 -0500
X-Greylist: delayed 99728 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Mar 2021 10:18:47 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F2C06174A
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 10:18:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5E556100D9419;
        Mon,  8 Mar 2021 19:18:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2E21F1F80A8; Mon,  8 Mar 2021 19:18:39 +0100 (CET)
Date:   Mon, 8 Mar 2021 19:18:39 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210308181839.GA6444@wunner.de>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
 <20210307144313.GA15472@wunner.de>
 <20210308141101.GC4656@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308141101.GC4656@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 08, 2021 at 02:11:01PM +0000, Mark Brown wrote:
> On Sun, Mar 07, 2021 at 03:43:13PM +0100, Lukas Wunner wrote:
> > Transfers may still be ongoing until spi_unregister_controller() returns.
> > (It's called from devres_release_all() in this case.)  Since the IRQ is
> > presumably necessary to handle those transfers, freeing the IRQ after
> > unregistering is actually correct.  So the code looks fine in principle.
> > However, because the IRQ is requested with IRQF_SHARED, the handler may
> > be invoked at any time, even after the controller has been unregistered.
> > It is therefore necessary to quiesce the SPI controller's interrupt on
> > unregistering and it is also necessary to check in the IRQ handler whether
> > an interrupt is actually pending (and bail out if not).
> 
> It's also important and even more of a concern that even if there is a
> valid interrupt the handler doesn't try to use structures that might
> have been deallocated before the handler uses it as this controller
> does, that will segfault which is more serious.

At least struct spi_controller and struct hisi_spi are allocated with
devm_*() before the call to devm_request_irq(), hence those two
are always accessible from the IRQ handler AFAICS.

Thanks,

Lukas
