Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F028D1F36B4
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFIJN6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 05:13:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52003 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgFIJN4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 05:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591694036; x=1623230036;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=4gmH4roZ31BbBtOY/irMvwRh3t1QNa19BtAidrntvuM=;
  b=I+/yrmE9DY6+aW85/yyKlTke2NVSHL6vRluht7C+jUG9f5Ov/0EeM5bE
   nwAWVJZCoFH4xJoGMZyDFtO2PvI7OzmJVvad9PwO3NKfr0dO+r7Lx7R9k
   neIYV9EkhbWNRZVk+EDF/mEYMSkMFbKYUBUrmwML5/CQ+2wuPAE9d7uRx
   XK/D57mQj9VKgQn9NGH3XErnwoOi636yu24a6ZXeUdq/FBBzE5emONI3V
   LoAmAGsLkEWjA7hZExXfoyWL33p4RZg1rZcNYHSEE6TUhGYglTpRiLxRR
   sALYQWvjpqgOlJfBMOTJbHD6dT5xzOblfdfI7dTlEqIIzXuwKKVnboEw1
   Q==;
IronPort-SDR: VLYk1EEpijJRleQur2LDMOMpKQMGgwyaEf7wD34q+JX5WGTUZUwOWjxi1cLyHnGwvqQoFh4znt
 PD+6Cs+FVj/7nqOT0IVwVhKO0jeEKt2j3QZuYWoTg1iFOzypxd7USwXd4V5ldslOQlNLyHq6xk
 Le8BwgbLtGkLpqFEganF8yy8QODIlPizMZRGBCHZZUdvU6TnU3/bRRw3RxY2GXrC9EhHh0/f4d
 fvPR/R+JWJRdv+ejB81eL7EBaC+/UZGSnEWyKC/ELrQMfqUhuCR+nOwMq623x15E2gS5XbewU6
 CGo=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="15071190"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 02:13:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 02:13:54 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3
 via Frontend Transport; Tue, 9 Jun 2020 02:13:51 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-2-lars.povlsen@microchip.com> <20200602191025.ywo77nslrgswh6sw@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no IRQ specified in DT
In-Reply-To: <20200602191025.ywo77nslrgswh6sw@mobilestation>
Date:   Tue, 9 Jun 2020 11:13:50 +0200
Message-ID: <87lfkwiott.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Wed, May 13, 2020 at 04:00:22PM +0200, Lars Povlsen wrote:
>> With this change a SPI controller can be added without having a IRQ
>> associated, and causing all transfers to be polled. For SPI controllers
>> without DMA, this can significantly improve performance by less
>> interrupt handling overhead.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/spi/spi-dw.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index 31e3f866d11a7..e572eb34a3c1a 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -19,6 +19,8 @@
>>  #include <linux/debugfs.h>
>>  #endif
>>
>
>> +#define VALID_IRQ(i) (i >= 0)
>
> Mark and Andy are right. It is a good candidate to be in a generic IRQ-related
> code as Anyd suggested:
>
>> > drivers/rtc/rtc-cmos.c:95:#define is_valid_irq(n)               ((n) > 0)
>> > Candidate to be in include/linux/irq.h ?
>
> So if you feel like to author additional useful patch integrated into the
> kernel, this one is a good chance for it.
>

Yeah, but with the poll_transfer() gone below, I think I'll settle on
just getting this into the current framework. Optimization (as this is)
has less priority. I'll put this on the back burner.

>> +
>>  /* Slave spi_dev related */
>>  struct chip_data {
>>       u8 tmode;               /* TR/TO/RO/EEPROM */
>> @@ -359,7 +361,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>>                       spi_enable_chip(dws, 1);
>>                       return ret;
>>               }
>> -     } else if (!chip->poll_mode) {
>> +     } else if (!chip->poll_mode && VALID_IRQ(dws->irq)) {
>>               txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
>>               dw_writel(dws, DW_SPI_TXFLTR, txlevel);
>>
>> @@ -379,7 +381,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>>                       return ret;
>>       }
>>
>> -     if (chip->poll_mode)
>> +     if (chip->poll_mode || !VALID_IRQ(dws->irq))
>>               return poll_transfer(dws);
>
> Please note. The chip->poll and the poll_transfer() methods've been discarded
> from the driver, since commit 1ceb09717e98 ("spi: dw: remove cs_control and
> poll_mode members from chip_data"). So you gonna have to get the
> poll_transfer-like method back.
>
> -Sergey
>
>>
>>       return 1;
>> @@ -487,11 +489,13 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>
>>       spi_controller_set_devdata(master, dws);
>>
>> -     ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
>> -                       master);
>> -     if (ret < 0) {
>> -             dev_err(dev, "can not get IRQ\n");
>> -             goto err_free_master;
>> +     if (VALID_IRQ(dws->irq)) {
>> +             ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
>> +                               dev_name(dev), master);
>> +             if (ret < 0) {
>> +                     dev_err(dev, "can not get IRQ\n");
>> +                     goto err_free_master;
>> +             }
>>       }
>>
>>       master->use_gpio_descriptors = true;
>> @@ -539,7 +543,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>       if (dws->dma_ops && dws->dma_ops->dma_exit)
>>               dws->dma_ops->dma_exit(dws);
>>       spi_enable_chip(dws, 0);
>> -     free_irq(dws->irq, master);
>> +     if (VALID_IRQ(dws->irq))
>> +             free_irq(dws->irq, master);
>>  err_free_master:
>>       spi_controller_put(master);
>>       return ret;
>> --
>> 2.26.2
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lars Povlsen,
Microchip
