Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DA71D8A4D
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgERVzW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 17:55:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:50388 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVzW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 17:55:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6A1C1803080B;
        Mon, 18 May 2020 21:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KntM-jPn2GzF; Tue, 19 May 2020 00:55:18 +0300 (MSK)
Date:   Tue, 19 May 2020 00:55:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Baikal-T1 System Boot SPI
 Controller binding
Message-ID: <20200518215517.phusnx3llajik6sm@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-2-Sergey.Semin@baikalelectronics.ru>
 <20200518152659.GA2525@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200518152659.GA2525@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 09:26:59AM -0600, Rob Herring wrote:
> On Fri, May 08, 2020 at 12:36:20PM +0300, Serge Semin wrote:
> > Baikal-T1 Boot SPI is a part of the SoC System Controller and is
> > responsible for the system bootup from an external SPI flash. It's a DW
> > APB SSI-based SPI-controller with no interrupts, no DMA, with just one
> > native chip-select available and a single reference clock. Since Baikal-T1
> > SoC is normally booted up from an external SPI flash this SPI controller
> > in most of the cases is supposed to be connected to a single SPI-nor
> > flash. Additionally in order to provide a transparent from CPU point of
> > view initial code execution procedure the system designers created an IP
> > block which physically maps the SPI flash found at CS0 to a memory region.

BTW Rob, could you also provide your review for the next patch:
https://lore.kernel.org/linux-mips/20200515104758.6934-20-Sergey.Semin@baikalelectronics.ru/
?

We agreed with Mark to merge this driver into the generic DW APB SSI code so to
be available for another platforms. Since our DW APB SSI IP's got too many
peculiarities I'll have to provide a new compatible string. It would be great to
add it into the DW schema binding instead of currently available text-based
legacy binding file.

[nip]

