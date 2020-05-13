Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C891D11A5
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgEMLnD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 07:43:03 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57712 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgEMLnC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 07:43:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C55B28030886;
        Wed, 13 May 2020 11:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aNaijVBmqsGE; Wed, 13 May 2020 14:42:59 +0300 (MSK)
Date:   Wed, 13 May 2020 14:42:58 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200513114258.ataikbtajhyty5y3@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508133336.GK4820@sirena.org.uk>
 <20200512200733.bdbbhkjkwjd5yzqq@mobilestation>
 <20200513102324.GB4803@sirena.org.uk>
 <20200513110407.uaosfxebsgnllsf4@mobilestation>
 <20200513112116.GE4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513112116.GE4803@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 12:21:16PM +0100, Mark Brown wrote:
> On Wed, May 13, 2020 at 02:04:07PM +0300, Serge Semin wrote:
> > On Wed, May 13, 2020 at 11:23:24AM +0100, Mark Brown wrote:
> 
> > > The conversion to YAML format should be the very last thing in the patch
> > > series,
> 
> > Hm, haven't heard about this requirement. Could you point me out to a doc or
> > some discussion concerning this for future reference? It's not a first DT
> > conversion patch I've submitted and non of them were addressed with such
> > request. I do understand that the order of DT concerning patches can be
> > important and agree to fix it by updating the original legacy binding first,
> > then perform a conversion. But placing the conversion in a tail of the series
> > just seems unnecessary. The patch can be dropped from any place of the series
> > if for some reason Rob would be late with review.
> 
> This is a practical observation based on the fact that there is a huge
> backlog of reviews of DT binding conversions and that those conversions
> typically go through several review cycles and that not everyone who's
> sending patches to the kernel is fully up to speed on processes or has
> strong English.  By telling people (including other people who find
> instructions on the list) to put the conversion right at the end of the
> series I am avoiding any ambiguity or confusion about ordering with
> regard to any other patches to the DT, including any new patches that
> get added to the series.
> 
> > Personally I prefer placing all DT changes in the head of the series, so Rob
> > wouldn't need to search through the whole patchset looking for the DT-related
> > patches.
> 
> Ideally the YAML conversions would be done entirely separately to other
> development rather than as part of a bigger series, they're pretty much
> orthogonal anyway.  Sadly there's obvious content collisions with any
> new development that adds DT stuff so that's not always the most
> practical thing.

Ok. I see your point. I'll move the conversion patch to the tail of the series
after rebasing the patchset on top of the spi/for-next branch. Thanks for
clarification.

-Sergey
