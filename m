Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEC2B54B9
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 00:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKPXDp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPXDp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 18:03:45 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D94C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 15:03:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 97D98100E417A;
        Tue, 17 Nov 2020 00:03:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B956A870AC; Tue, 17 Nov 2020 00:03:39 +0100 (CET)
Date:   Tue, 17 Nov 2020 00:03:39 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH for-5.10] spi: gpio: Don't leak SPI master in probe error
 path
Message-ID: <20201116230339.GA25992@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
 <CAHQ1cqHs+jTzp2dYx0cAosLaoBWXpmBivW5bPKbckS=un9k9SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHs+jTzp2dYx0cAosLaoBWXpmBivW5bPKbckS=un9k9SA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 11:23:43AM -0800, Andrey Smirnov wrote:
> On Mon, Nov 16, 2020 at 12:44 AM Lukas Wunner <lukas@wunner.de> wrote:
> > If the call to devm_spi_register_master() fails on probe of the GPIO SPI
> > driver, the spi_master struct is erroneously not freed:
> >
> > After allocating the spi_master, its reference count is 1.  The driver
> > unconditionally decrements the reference count on unbind using a devm
> > action.  Before calling devm_spi_register_master(), the driver
> > unconditionally increments the reference count because on success,
> > that function will decrement the reference count on unbind.  However on
> > failure, devm_spi_register_master() does *not* decrement the reference
> > count, so the spi_master is leaked.
> 
> Not sure I fully understand this. On failure
> devm_spi_register_master() will return a negative error code which
> should result in probe failure and release of devres resource, right?

Yes, but that just decrements the refcount from 2 to 1:

    /* refcount initialized to 1 */
    master = spi_alloc_master(dev, sizeof(*spi_gpio));

    ...

    /* refcount incremented to 2 */
    return devm_spi_register_master(&pdev->dev, spi_master_get(master));

    ...

    /* on failure of devm_spi_register_master(), refcount decremented to 1
       by devres action */
    spi_gpio_put()


> > The issue was introduced by commits 8b797490b4db ("spi: gpio: Make sure
> > spi_master_put() is called in every error path") and 79567c1a321e ("spi:
> > gpio: Use devm_spi_register_master()"), which sought to plug leaks
> > introduced by 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO
> > descriptors") but missed this remaining leak.
> 
> That extra spi_master_get() that might be problematic was present in
> the code before 8b797490b4db ("spi: gpio: Make sure spi_master_put()
> is called in every error path") and I think was first introduced in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers?h=v5.9-rc4&id=702a4879ec337463f858c8ab467482cce260bf18
> 
> Or am I missing something?

The extra spi_master_get() was introduced by 79567c1a321e.
I don't see it in spi-gpio.c before that commit.

Its quite possible that I missed something myself, nobody's perfect.
But just from code inspection it seems wrong the way it is right now.

Shout if I failed to explain it properly and I'll try again. :)

Thanks,

Lukas
