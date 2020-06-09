Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272401F378F
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgFIKEn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 06:04:43 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:34707 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgFIKEl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 06:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591697081; x=1623233081;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=ZmXV2xgrfpgFum+8pnc7CH3E62B5WGtZ4Qsdsa4m4hg=;
  b=VLf4hZGWUgBtNJpsQ6bhUyc28iOdO+x6nKaugzg4kCWL/jOig96lkkoX
   iZpQXXVji1a5mN1J4GaIeLyJJjaZ1IgQS50wUKIlLismV12Ff/Vvv3H6V
   LHOReb7yWAeK0xkz4Koxjqiy7d9WOonwIqbfmvIKNwXWGnlRl3JhCoSNs
   uAT6+l5ZN62sNp758+oAiqLFaAp9/mG7wArXQxGIOGCriHCZnRAEF54j2
   rQRIGmz9FZrG8+iCPABzSkKt4h/nF5pWE1heRrJKhzZVJ2Kqvy6du0i3K
   Gyk2e2xc98SUpOLNj3u8EaPUWWbzL94+HzTSE/orcUuUN3Mnoi8SXpsQV
   w==;
IronPort-SDR: YwfQayJCWJ5disVGuhwB4XgBX+zV/UTIpQhysY2EftvltOzRimEwGnDy+nJvg4FaXL9vJQMnsc
 ktp1x/nn09CZPLehYdvFL4WVtfV7y2ABqp9XNiZryYISfbPH88po1cGe/BbrTQ3zI3Ak12Nv5i
 kxx0bEYX8xoDsK+3WnyOrDZpiKp7a+VdMfwFrSzw/3kzHF2FdIJ2IHHF0wyBaAqgWKfHJSaNrT
 CTNV1D0DVAyrDjNYKu4fatvQkVC1YCHrmGiMYOS7DpHv6WCcxuyRcptny0Sj0N2S0b5D2pIMfG
 rTw=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="78721100"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 03:04:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 03:04:30 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 03:04:27 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-3-lars.povlsen@microchip.com> <20200602193931.vl36k3c6uyiaizah@mobilestation>
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
Subject: Re: [PATCH 02/10] spi: dw: Add support for RX sample delay register
In-Reply-To: <20200602193931.vl36k3c6uyiaizah@mobilestation>
Date:   Tue, 9 Jun 2020 12:04:26 +0200
Message-ID: <87k10gimhh.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Wed, May 13, 2020 at 04:00:23PM +0200, Lars Povlsen wrote:
>> This add support for the RX_SAMPLE_DLY register. If enabled in the
>> Designware IP, it allows tuning of the rx data signal by means of an
>> internal rx sample fifo.
>>
>> The register is located at offset 0xf0, and if the option is not
>> enabled in the IP, changing the register will have no effect.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/spi/spi-dw.c | 7 +++++++
>>  drivers/spi/spi-dw.h | 2 ++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index e572eb34a3c1a..32997f28fa5bb 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -81,6 +81,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
>>                       "DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
>>       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>>                       "DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));
>
>> +     len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>> +                      "RX_SAMPLE_DLY: \t0x%08x\n",
>> +                      dw_readl(dws, DW_SPI_RX_SAMPLE_DLY));
>
> debugfs_reg32 interface is now utilized in the driver to dump the registers
> state. So this will have to be converted to just a new entry in the
> dw_spi_dbgfs_regs array.
>

Ok, I'll have a look at this.

>>       len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>>                       "=================================\n");
>>
>> @@ -315,6 +318,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>>               spi_set_clk(dws, chip->clk_div);
>>       }
>>
>
>> +     /* Apply RX sample delay, iff requested (nonzero) */
>
> s/iff/if
>
>> +     if (dws->rx_sample_dly)
>> +             dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, dws->rx_sample_dly);
>> +
>>       dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
>>       dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
>>
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index 1bf5713e047d3..ed6e47b3f50da 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -31,6 +31,7 @@
>>  #define DW_SPI_IDR                   0x58
>>  #define DW_SPI_VERSION                       0x5c
>>  #define DW_SPI_DR                    0x60
>> +#define DW_SPI_RX_SAMPLE_DLY         0xf0
>>  #define DW_SPI_CS_OVERRIDE           0xf4
>>
>>  /* Bit fields in CTRLR0 */
>> @@ -111,6 +112,7 @@ struct dw_spi {
>>
>>       int                     cs_override;
>>       u32                     reg_io_width;   /* DR I/O width in bytes */
>
>> +     u8                      rx_sample_dly;  /* RX fifo tuning (option) */
>
> This doesn't seem like a good place for this parameter. The sample delay is
> SPI-slave specific. So as I see it, the parameter should be moved to the
> chip_data.
>

Yes, I got that in other comments, and you are right I guess.

I will apply that approach of having rx_sample_dly per SPI slave.

---Lars

> -Sergey
>
>>       u16                     bus_num;
>>       u16                     num_cs;         /* supported slave numbers */
>>       void (*set_cs)(struct spi_device *spi, bool enable);
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
