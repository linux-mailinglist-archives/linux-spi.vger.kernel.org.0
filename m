Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F166727E93D
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgI3NLW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 09:11:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40424 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3NLV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 09:11:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DE6D0803086A;
        Wed, 30 Sep 2020 13:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BmkIdQhB9nTu; Wed, 30 Sep 2020 16:11:17 +0300 (MSK)
Date:   Wed, 30 Sep 2020 16:11:15 +0300
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
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-ID: <20200930131115.2lizge2ff64jbgpn@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200929144351.GH4799@sirena.org.uk>
 <20200929224303.65awobe5dzwc2p4f@mobilestation>
 <20200930110403.GD4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930110403.GD4974@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 30, 2020 at 12:04:04PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 01:43:03AM +0300, Serge Semin wrote:
> > On Tue, Sep 29, 2020 at 03:43:51PM +0100, Mark Brown wrote:
> 
> > > This is a *huge* patch series which is a bit unweildy to review
> > > (especially given the other 10+ patch series you sent at the same time),
> 
> > Yeah, sorry about the bulky series. If most of the changes have been more
> > complicated than that, less inter-dependent and less directed to having the code
> > prepared for the main alterations I would have definitely split them up in
> > different series. But the biggest part of the patchset is just a preparation
> > before adding the mem-ops, poll-based transfers and Baikal-T1 SPI support. So
> > having them submitted without the main part of the patchset would be just weird.
> 
> One option with things like this is to just not send everything at once
> - even when split into multiple series it's a huge bulk of patches in an
> inbox.  Unless the patches are obviously from their subjects repetitive
> people probably aren't getting far enough in to look at the actual
> patches or even their sizes before deciding it looks like a lot of work
> and putting things off for later.
> 
> > I see you have already merged in the first nine patches. So would you like me
> > to split the rest of them up into two series or it would be ok to resend (if
> > required) them as one series seeing it's not that bulky anymore?
> 

> Not all of the first 9, IIRC I skipped one I had comments on.

Yes, you skipped one and I've already given you my response on your comment
about it: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
So have I responded to your comment on another patch:
[PATCH 11/30] spi: dw: Add DWC SSI capability .

I will need a response from you about them to go further with this patchset.

> If they
> can be split that would probably be helpful, if there are dependencies
> then it's not going to buy too much.

Well, all later patches depend on the changes introduced in the previous ones in
one way or another. So in any case that will be an incremental series of patchsets
otherwise they most likely won't get applied cleanly on the driver source code.
For now we have got 21 patch left to review:
I) First two ones you've given your comments on and are mostly related to the
patches you have already merged in.
1. 688c17cad5c2 spi: dw: Use ternary op to init set_cs callback
2. 17d0b3abc03d spi: dw: Add DWC SSI capability

II) Refactor the DW APB SSI controller config procedure.
3. 6a436c824961 spi: dw: Detach SPI device specific CR0 config method
4. 47614d60e44c spi: dw: Update SPI bus speed in a config function
5. df64a4961801 spi: dw: Simplify the SPI bus speed config procedure
6. 1a583b130bab spi: dw: Update Rx sample delay in the config function
7. 9f205a8939a2 spi: dw: Add DW SPI controller config structure

III) Refactor IRQ-based SPI transfer procedure.
8. d4fa973a3f7c spi: dw: Refactor data IO procedure
9. d998b98e3d93 spi: dw: Refactor IRQ-based SPI transfer procedure
10. 7fc419af6e67 spi: dw: Perform IRQ setup in a dedicated function
11. d3dfd997379a spi: dw: Unmask IRQs after enabling the chip
12. 6ecf589320f3 spi: dw: Discard chip enabling on DMA setup error

IV) Final preparation before adding the memory operations.
13. 84a03fad452c spi: dw: De-assert chip-select on reset
14. dd0212eb5738 spi: dw: Explicitly de-assert CS on SPI transfer completion
15. d1eea0f556cf spi: dw: Move num-of retries parameter to the header file
16. 3e70e5a6c1d9 spi: dw: Add generic DW SSI status-check method

v) Introduce memory and poll-based operations.
17. 52d733f30464 spi: dw: Add memory operations support
18. c2f45eb3d662 spi: dw: Introduce max mem-ops SPI bus frequency setting
19. ccf08869b6bd spi: dw: Add poll-based SPI transfers support

vI) Add Baikal-T1 glue-driver
20. a536c408f7aa dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
21. 791e68755ead spi: dw: Add Baikal-T1 SPI Controller glue driver

If you want I can resend the series split up as I described above. Alternatively
I can collect I) - III) into a one patchset and IV) - VI) into another one.
So to speak I'll do in whatever scenario you prefer. Just tell me which one is
more suitable for you to review.

In anyway we need to settle the issues regarding the first two patches. Please give
me your answers on the comments I've left there in response to your comments.)

-Sergey
