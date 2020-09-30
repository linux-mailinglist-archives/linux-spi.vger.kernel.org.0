Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24CE27EB5C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgI3Oul (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 10:50:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37093 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgI3Oul (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 10:50:41 -0400
X-Greylist: delayed 3535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 10:50:40 EDT
X-Originating-IP: 86.206.245.199
Received: from windsurf.home (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0A1071BF20B;
        Wed, 30 Sep 2020 14:50:37 +0000 (UTC)
Date:   Wed, 30 Sep 2020 16:50:37 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: rework RX interrupt handling
Message-ID: <20200930165037.77813365@windsurf.home>
In-Reply-To: <CAHp75VccK7hu51qCdRC4GaTO3XaSaYLD6TeuuqHLY9Tf1Tb67A@mail.gmail.com>
References: <20200930135137.197592-1-thomas.petazzoni@bootlin.com>
        <CAHp75VccK7hu51qCdRC4GaTO3XaSaYLD6TeuuqHLY9Tf1Tb67A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On Wed, 30 Sep 2020 17:24:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > On a Microchip SAMA5D3 platform that is receiving 20 bytes every 16ms
> > over one MAX310X UART, this patch has allowed to reduce the CPU
> > consumption of the interrupt handler thread from ~25% to 6-7%.  
> 
> Was it always like this?

As far as I can see, yes. I guess you were thinking about a Fixes: tag
perhaps? I don't think a Fixes: tag really applies here, as we're not
fixing a performance regression.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > -       /* Configure MODE2 register & Reset FIFOs*/
> > -       val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
> > -       max310x_port_write(port, MAX310X_MODE2_REG, val);
> > +       /* Reset FIFOs*/  
> 
> Add a space before the asterisk.

Indeed. Let me know if a v2 is needed, or if this small typo can be
fixed when applying.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
