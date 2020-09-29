Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049A27DB32
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgI2Vz7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 17:55:59 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36874 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgI2Vz7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 17:55:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4F715803086A;
        Tue, 29 Sep 2020 21:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QWhRIYSAoSry; Wed, 30 Sep 2020 00:55:55 +0300 (MSK)
Date:   Wed, 30 Sep 2020 00:55:53 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
Message-ID: <20200929215553.xgst2v5ssweymlpw@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
 <20200929131153.GD4799@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929131153.GD4799@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 29, 2020 at 02:11:53PM +0100, Mark Brown wrote:
> On Sun, Sep 20, 2020 at 02:28:46PM +0300, Serge Semin wrote:
> > Simplify the dw_spi_add_host() method a bit by replacing the set_cs
> > callback overwrite procedure with direct setting the callback if a custom
> > version of one is specified.
> 
> > -	master->set_cs = dw_spi_set_cs;
> > +	master->set_cs = dws->set_cs ?: dw_spi_set_cs;
> 
> > -	if (dws->set_cs)
> > -		master->set_cs = dws->set_cs;
> 

> This doesn't look like a win for legibility or comprehensibility.

Assigning a default value and redefining it way later doesn't look legible
either, because in that case you'd need to keep in mind, that some callback has
already been set. Moreover it does one redundant assignment. That's why I
decided to implement the setting up by means of the ternary op.

If you don't like the ternary op, then we could use an explicit if-else
statement here. But I'd insist on implementing the assignment in a one
place of the function instead of having it partly perform here and partly there.
Like this:

--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -477,7 +477,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
 	master->cleanup = dw_spi_cleanup;
-	master->set_cs = dw_spi_set_cs;
+	if (dws->set_cs)
+		master->set_cs = dws->set_cs;
+	else
+		master->set_cs = dw_spi_set_cs;
 	master->transfer_one = dw_spi_transfer_one;
 	master->handle_err = dw_spi_handle_err;
 	master->max_speed_hz = dws->max_freq;

Personally I prefer the ternary op in such situations. The operator provides an
elegant small well known solution for the default-assignments. I don't see it
as non-legible or incomprehensible. (I don't really understand why you and
Andy don't like the operator that much =))

-Sergey
