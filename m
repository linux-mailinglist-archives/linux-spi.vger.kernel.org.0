Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E14A1D4929
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgEOJL4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 05:11:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:3742 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgEOJLz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 05:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589533914; x=1621069914;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=wmtlMa/ByzxofhuCC0VPeSnxK6BCfzWRYql8RxVBaqc=;
  b=y7KyQS0mKcN2rFGxAMJaAIlyjPJAAgA/EqNDb45NmLVoJ5vX/5DDw9Iv
   5jcdFHSx0rb0+y2f0gXb+G8Nn9Bon0BLqecFg5CMOdB8s2JIftAGoutfh
   FoK8F3/fMZLIf6337zaLKxJI6hgAUMuqxLl90CMsWea4bLbOhnnW7Cqlg
   phMynerm6SquNAwGZ17jESdVZWf4TUfP69HsUZBjxLFwh69s1jCljQIio
   L4s9iefzMVLrJGyVxdiqDgyrERV9JWKVI+YLjwbMC62vSteGqAl4xOo7T
   ZYHaa9OFmrSyCOnUoy3aESAnffn8pHFsG93SEdc/zTtRu9qu7dyxA7ovy
   w==;
IronPort-SDR: DiM+U75P+/Md9FzuxnzG9/z0ceXFZvbHHtzFIn11OpL0g9Q1x1Uby3/VZY5m1NeVYWhvUBPmE+
 fgXUBBDmoZtQ367KyOjQZknEXfD5iM3FrLkBAERTap365oNNgrj1v8ezcplKZf610CTi+9QIoE
 o5MSEPl/7koBuzmySNOL7Y4LO3u9rXNzVcL3jJlTliM6j+9gKvuMN9IwP6het51vlvoYSL5FN4
 fOUTEcECWvT0h+Gp2PovBvNtR1UGsmCCQYbZxYGTpCE4WgWkOBOKcEjLw/SxtEbpYrTSxwouNm
 V6c=
X-IronPort-AV: E=Sophos;i="5.73,394,1583218800"; 
   d="scan'208";a="79762318"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 02:11:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 02:11:52 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 May 2020 02:11:49 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-2-lars.povlsen@microchip.com> <20200513142050.GH4803@sirena.org.uk> <20200514130407.guyk3r4ltjvszy5s@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no IRQ specified in DT
In-Reply-To: <20200514130407.guyk3r4ltjvszy5s@mobilestation>
Date:   Fri, 15 May 2020 11:11:48 +0200
Message-ID: <874kshpnor.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> Hi Mark
>
> On Wed, May 13, 2020 at 03:20:50PM +0100, Mark Brown wrote:
>> On Wed, May 13, 2020 at 04:00:22PM +0200, Lars Povlsen wrote:
>> > With this change a SPI controller can be added without having a IRQ
>> > associated, and causing all transfers to be polled. For SPI controllers
>> > without DMA, this can significantly improve performance by less
>> > interrupt handling overhead.
>>
>> This overlaps substantially with some work that Serge Semin (CCed) has
>> in progress, please coordinate with him.
>
> Thanks for copying me these mails. I haven't been Cc'ed in the series and
> hasn't been subscribed to the SPI mailing list, so I would have definitely
> missed that.
>
> I would like to coordinate my efforts with Lars. I'll have the patchset reviewed
> soon in addition providing my comments/suggestions of how to make it useful for
> both mine and Lars solution.

Serge - thanks for taking on this.

Note that my primary concern now is to get Sparx5 upstreamed. The
mem_ops (or dirmap) and polled mode are both performance enhancements,
which can be pulled from my series if it creates too much noise. I can
then add the necessary on top of your work/current kernel at a later
time.

> One thing I can tell about the mem_ops he implemented, is that they aren't
> mem_ops, but dirmap (as you remember it's also implemented in my code, but with
> alignment specific), and the exec_mem_op partly consists of a code, which belong
> to the supports_op() callback. The rest of my comments will be inlined in the
> patches.
>
> -Sergey

-- 
Lars Povlsen,
Microchip
