Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4F27DB5E
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 00:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgI2WFD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 18:05:03 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36946 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgI2WFD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 18:05:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5E4DC803086A;
        Tue, 29 Sep 2020 22:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_FOu9bKCGmW; Wed, 30 Sep 2020 01:05:00 +0300 (MSK)
Date:   Wed, 30 Sep 2020 01:05:00 +0300
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
Subject: Re: [PATCH 03/30] spi: dw: Initialize n_bytes before the memory
 barrier
Message-ID: <20200929220500.eyudpthwtnedjtz6@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-4-Sergey.Semin@baikalelectronics.ru>
 <20200929131225.GE4799@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929131225.GE4799@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 29, 2020 at 02:12:25PM +0100, Mark Brown wrote:
> On Sun, Sep 20, 2020 at 02:28:47PM +0300, Serge Semin wrote:
> > Since n_bytes field of the DW SPI private data is also utilized by the
> > IRQ handler, we need to make sure it' initialization is done before the
> > memory barrier.
> 

> This looks like a fix so should have been before any cosmetic cleanups.

Ah, sorry about that. I had that in mind, but have just forgotten to move it
to the series head.

-Sergey
