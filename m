Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1E2C1B11
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 02:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgKXBzE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 20:55:04 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42552 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgKXBzE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 20:55:04 -0500
Received: from [10.130.0.120] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxytHrZ7xfM7gVAA--.49338S3;
        Tue, 24 Nov 2020 09:54:53 +0800 (CST)
Subject: Re: [PATCH 1/3] spi: Loongson: Add Loongson 3A+7A SPI controller
 driver support
To:     Mark Brown <broonie@kernel.org>
References: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
 <20201123131023.GC6322@sirena.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <d86df590-0091-ea6b-eeaf-a310d5ef6843@loongson.cn>
Date:   Tue, 24 Nov 2020 09:54:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20201123131023.GC6322@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxytHrZ7xfM7gVAA--.49338S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr45trykKw17Kw1UXrykGrg_yoWruF4rpF
        WYya1jqr1fJF1UCrs0qFWDXF1YvryrJF9xJa93t3yUGa4DZw1xWry5WF15Cw4fAFW8AF17
        ZrW09rWkCF1rWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Cb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07besqAUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thank you for your suggestion, I will do it and send the v2  in the future.

Thanks,
Qing


On 11/23/2020 09:10 PM, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 05:19:06PM +0800, Qing Zhang wrote:
>
>> This module is integrated into the Loongson-3A SoC and the LS7A bridge chip.
> It looks like this needs quite a bit of update to fit into the SPI
> subsystem properly, fortunately most of that is cutting code out of the
> driver so you can use core features so it shouldn't be too bad.  There's
> also a bunch of pretty minor stylistic issues none of which look too
> difficult to address.
>
>> @@ -968,6 +968,12 @@ config SPI_AMD
>>   	help
>>   	  Enables SPI controller driver for AMD SoC.
>>   
>> +config SPI_LOONGSON
>> +        tristate "Loongson SPI Controller Support"
> Please keep Kconfig and Makefile sorted.
>
>> +        depends on CPU_LOONGSON32 || CPU_LOONGSON64
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Loongson3A+7A SPI driver
>> + *
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +#include <linux/pci.h>
>> +#include <linux/of.h>
>> +/*define spi register */
>> +#define	SPCR	0x00
> Missing blank line.
>
>> +#define	SPSR	0x01
>> +#define FIFO	0x02
> This indentation is unclear, also all these defines could use some
> namespacing to avoid collisions with anything that gets defined in a
> header.
>
>> +	hz  = t ? t->speed_hz : spi->max_speed_hz;
>> +
>> +	if (!hz)
>> +		hz = spi->max_speed_hz;
> Please write normal conditional statements to improve legibility, and
> note that the core will ensure that the transfer always has a speed set.
>
>> +	if ((hz && loongson_spi->hz != hz) || ((spi->mode ^ loongson_spi->mode) & (SPI_CPOL | SPI_CPHA))) {
> Please try to keep your lines less than 80 columns (there's not a hard
> limit here but it helps legibility).
>
>> +		bit = fls(div) - 1;
>> +		if ((1<<bit) == div)
> 1 << bit
>
>> +static int loongson_spi_setup(struct spi_device *spi)
>> +{
>> +	struct loongson_spi *loongson_spi;
>> +
>> +	loongson_spi = spi_master_get_devdata(spi->master);
>> +	if (spi->bits_per_word % 8)
>> +		return -EINVAL;
>> +
>> +	if (spi->chip_select >= spi->master->num_chipselect)
>> +		return -EINVAL;
>> +
>> +	loongson_spi_update_state(loongson_spi, spi, NULL);
>> +	set_cs(loongson_spi, spi, 1);
> The setup() operation shouldn't configure the physical controller state
> unless there are separate configuration registers per chip select -
> another device could be active when setup() is called.
>
>
>> +static int loongson_spi_write_read_8bit(struct spi_device *spi,
>> +		const u8 **tx_buf, u8 **rx_buf, unsigned int num)
>> +{
>> +	struct loongson_spi *loongson_spi;
>> +	loongson_spi = spi_master_get_devdata(spi->master);
>> +
>> +	if (tx_buf && *tx_buf) {
>> +		loongson_spi_write_reg(loongson_spi, FIFO, *((*tx_buf)++));
>> +		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) == 1);
>> +        } else {
>> +		loongson_spi_write_reg(loongson_spi, FIFO, 0);
>> +		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) == 1);
>> +        }
> The indentation is messed up here, looks like you have some kind of
> tab/space confusion.
>
>> +	count = xfer->len;
>> +
>> +	do {
>> +		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
>> +			goto out;
> This is the only caller of _write_read_8bit(), may sa well inline it?
>
>> +static inline int set_cs(struct loongson_spi *loongson_spi, struct spi_device  *spi, int val)
> Why is this static inline?  This should be an operation provided to the
> SPI core.
>
>> +{
>> +	int cs = loongson_spi_read_reg(loongson_spi, SFCS) & ~(0x11 << spi->chip_select);
>> +
>> +        if (spi->mode  & SPI_CS_HIGH)
>> +		val = !val;
>> +	loongson_spi_write_reg(loongson_spi, SFCS,
>> +                        (val ? (0x11 << spi->chip_select):(0x1 << spi->chip_select)) | cs);
> There's mult
>
>> +static void loongson_spi_work(struct work_struct *work)
>> +{
> Drivers shouldn't be open coding a message queue, implement
> transfer_one_message() and let the core handle it for you.
>
>> +static const struct of_device_id loongson_spi_id_table[] = {
>> +	{ .compatible = "loongson,loongson-spi", },
>> +	{ },
>> +};
> This is introducing a new DT binding, there should also be a new binding
> document added.
>
>> +static int loongson_spi_pci_register(struct pci_dev *pdev,
>> +		const struct pci_device_id *ent)
>> +{
>> +	int ret;
>> +	unsigned char v8;
> I would expect the PCI device to be a separate module with a dependency
> on PCI, I'm kind of surprised that this builds on !PCI systems but I
> guess it's possible there's stubs.

