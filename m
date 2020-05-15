Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF61D578C
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEORWB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 13:22:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38296 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgEORWB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 13:22:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 97B2780005C9;
        Fri, 15 May 2020 17:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9GksroUVuDzB; Fri, 15 May 2020 20:21:57 +0300 (MSK)
Date:   Fri, 15 May 2020 20:21:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/19] spi: dw: Clear DMAC register when done or
 stopped
Message-ID: <20200515172155.e4stpr7j66qp332a@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-4-Sergey.Semin@baikalelectronics.ru>
 <20200515164203.GJ5066@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515164203.GJ5066@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 05:42:03PM +0100, Mark Brown wrote:
> On Fri, May 15, 2020 at 01:47:42PM +0300, Serge Semin wrote:
> > If DMAC register is left uncleared any further DMAless transfers
> > may cause the DMAC hardware handshaking interface getting activated.
> 
> This and patch 4 look good as is but they don't apply against for-5.7
> due to context changes in -next, unfortunately everyone seems to have
> decided that now is the time to start working on this driver which makes
> combinations of new work and fixes awkward.  I'm going to apply these
> for 5.8 but it'd be good if you could send versions based on for-5.7 as
> well so I can apply there - I can sort out the conflicts with 5.8.
> 

Thanks. I'll send these two patches:
spi: dw: Clear DMAC register when done or stopped
spi: dw: Fix native CS being unset
rebased on top of the for-5.7.

-Sergey
