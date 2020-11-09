Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8272ABF5D
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgKIPF7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:05:59 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:59717 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgKIPEl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:04:41 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 113422806980D;
        Mon,  9 Nov 2020 16:04:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D07775A48B; Mon,  9 Nov 2020 16:04:38 +0100 (CET)
Date:   Mon, 9 Nov 2020 16:04:38 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] spi: synquacer: Disable clock in probe error path
Message-ID: <20201109150438.GA28425@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
 <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
 <CAHp75Vc+Gi_+SAj93_Aj95R-1h=rbMH_==G9Pgg1fcp5uQQcfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc+Gi_+SAj93_Aj95R-1h=rbMH_==G9Pgg1fcp5uQQcfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 09, 2020 at 04:22:38PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 9, 2020 at 12:52 AM Lukas Wunner <lukas@wunner.de> wrote:
> > If the calls to platform_get_irq() or devm_request_irq() fail on probe
> > of the SynQuacer SPI driver, the clock "sspi->clk" is erroneously not
> > unprepared and disabled.
> >
> > If the clock rate "master->max_speed_hz" cannot be determined, the same
> > happens and in addition the spi_master struct is not freed.
> 
> Wouldn't be better to switch over devm_add_action_or_reset() in such cases?

I'd rather prefer a devm_clk_prepare_enable().  This is common enough
to merit a function of its own.

As for the spi_master struct being leaked:  I'm about to submit
a series which introduces devm_spi_alloc_master/slave() and uses
that to fix a use-after-free in 9 drivers and an spi_master leak
in 8 drivers.  Patches are on this development branch:

https://github.com/l1k/linux/commits/spi_fixes

I'm too busy with this series to also look into adding a
devm_clk_prepare_enable().  Hopefully someone else can do that.

Thanks,

Lukas
