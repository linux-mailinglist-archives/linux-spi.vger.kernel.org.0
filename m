Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDC1E5BE9
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgE1Jbd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 05:31:33 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54027 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgE1Jbc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 05:31:32 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 017B82800B1DD;
        Thu, 28 May 2020 11:31:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C9C5C18297B; Thu, 28 May 2020 11:31:27 +0200 (CEST)
Date:   Thu, 28 May 2020 11:31:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
Message-ID: <20200528093127.pjzvrqab6xvvcmgi@wunner.de>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com>
 <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
 <20200527122753.GN1634618@smile.fi.intel.com>
 <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
 <7e085731-a56f-07d5-3ad0-a8f7d0a93516@gmail.com>
 <CAHp75Ve6xUhic1g2A1cGoCOOom55Za=WXzR4C9o5=zMN80nFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve6xUhic1g2A1cGoCOOom55Za=WXzR4C9o5=zMN80nFdA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 28, 2020 at 11:41:21AM +0300, Andy Shevchenko wrote:
> Thank you very much for testing, I will figure out what can be done
> more there, but it's minor now.
> For input and touchscreen I guess you may ask Dmitry (input subsystem
> maintainer) and Benjamin (HID, but he might have an idea as well).

This might not be an input issue, perhaps the spi-pxa2xx.c driver
cannot cope with s2idle on this particular platform.

E.g., pxa2xx_spi_suspend() zeroes the SSCR0 register.  It seems this
disables or resets the controller.  But pxa2xx_spi_resume() isn't
touching the register at all.  Maybe the register contains crap when
coming out of s2idle, so needs to be set to a sane value on resume?

Tsuchiya Yuto says that reloading the SPI controller driver makes
the touch driver work again, so I'd check what's done on ->remove()
and ->probe() both in the touch driver as well as in the SPI controller
driver that fixes the problem.  The SSCR0 register is zeroed on
->remove() and re-initialized on ->probe(), so that register may
indeed play a role.

Since the SPI controller seems to be on a PCI device, I'd also check
if that PCI device has trouble coming out of s2idle.  If its BAR
isn't accessible (MMIO reads return "all ones"), then the SPI controller
and consequently the touch controller won't be accessible as well.

Thanks,

Lukas
