Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6097A1D944F
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgESK0D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 06:26:03 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:14134 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgESK0D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 06:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589883962; x=1621419962;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=rt0ifteO2Q6DmuLLDH31oRBTPIJqimPHw4gnMaEY94M=;
  b=XX3ksfK61swSxk7LMN3CUZrvaY6rZn9wOcizo2zbnqLs9yukDaEf9ONp
   yzrCK3Qu9CchLM1oBUch0nYb7VMyYZJm64vxiYI1D6MOIZN7/O/1yl81e
   KR4unUuxgKF1AwO6gULYXIuQULDl8SnsA9yLj4FBCW/0myiYOruB/7MC3
   IS7u46vv4pbfNtficjITtI+x4jqpTuXT2Cq6+vgoAvD/zfWj7y8pjvqad
   aywIi6QVlht4B9CiZyPAtMrBNHZykFQaNQzGh5YhItlPwQMCulsp2O0Rf
   yemIRy44DuKFCdWvedKMGV/GYh7iDLEDB4m2Km+eRrHH7kHLuWvUJqU4V
   A==;
IronPort-SDR: LdawkTFAm4n+RjRpzDLC2tUtB0nKBzLCfIAS+HLACuFeo7EkFgeCPl1TGx7GUd8jVy5JPcJRoq
 h/N3cUP2rlzaCgREWQ6bhD/rT/bYVm0EJNb+aFMriMbVsT4nhQUVhsjy7FgtejdcKvlJvxaTOm
 nTA8KGU9DjkqTLHL12uyrW/QbJk+y8HTtedTDOG8Lqgv9CweSedF6YVOR6HMoBdmlw3T4fGhjq
 3Z5EcZAamvESE2WYI0ThqVgKztDp32U/40OiaTIh/vOaxaI6hotPkDE0d/m0S4Ln3AImXxlhYz
 bY4=
X-IronPort-AV: E=Sophos;i="5.73,409,1583218800"; 
   d="scan'208";a="77149472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 03:26:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 03:26:03 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 May 2020 03:26:01 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-2-lars.povlsen@microchip.com> <CAHp75VcA-oDboufsDNx1ZR4+HBwYt7LdLOpbfs7-bM9ByucKJA@mail.gmail.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no IRQ specified in DT
In-Reply-To: <CAHp75VcA-oDboufsDNx1ZR4+HBwYt7LdLOpbfs7-bM9ByucKJA@mail.gmail.com>
Date:   Tue, 19 May 2020 12:25:58 +0200
Message-ID: <87a724p6fd.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Andy Shevchenko writes:

> On Wed, May 13, 2020 at 5:03 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
>>
>> With this change a SPI controller can be added without having a IRQ
>> associated, and causing all transfers to be polled. For SPI controllers
>> without DMA, this can significantly improve performance by less
>> interrupt handling overhead.
>
> ...
>
>> +#define VALID_IRQ(i) (i >= 0)
>
> drivers/rtc/rtc-cmos.c:95:#define is_valid_irq(n)               ((n) > 0)
>
> Candidate to be in include/linux/irq.h ?
>
> ...
>
>> +       if (VALID_IRQ(dws->irq))
>> +               free_irq(dws->irq, master);
>
> Isn't free_irq() aware of invalid ones (not found IRQ in the tree or
> any other backend container won't do anything)?
>
>
>>  err_free_master:
>>         spi_controller_put(master);
>>         return ret;
>> --
>> 2.26.2

I'll rework this with Serge.

Thank you!

-- 
Lars Povlsen,
Microchip
