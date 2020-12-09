Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02892D3C24
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 08:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgLIHZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 02:25:08 -0500
Received: from mail.loongson.cn ([114.242.206.163]:33170 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgLIHZH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 02:25:07 -0500
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx73+fe9BfHPUaAA--.43847S3;
        Wed, 09 Dec 2020 15:24:16 +0800 (CST)
Subject: Re: [PATCH v2 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver
 support
To:     Mark Brown <broonie@kernel.org>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <20201208135644.GC6686@sirena.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <c916c525-7308-12a7-824b-7068fcead4cc@loongson.cn>
Date:   Wed, 9 Dec 2020 15:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20201208135644.GC6686@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx73+fe9BfHPUaAA--.43847S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45uF1fZF4xWr48WrW8tFb_yoWrZr4rpa
        yrWa1rKa1kXF4kZFWDJr4DW34rZw1SqryfGwn7t34xGas8ZF48GF1Fqr1FyrW3tFW7C3W7
        ZF1jq3yY9F45u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUffHUUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Brown,

Thank you for your suggestions, these are achievable, I will send v3 in 
the soon.

Before sending v3, I would like to trouble you to see if this is 
correct. It has been tested locally.

On 12/08/2020 09:56 PM, Mark Brown wrote:
> On Tue, Dec 08, 2020 at 03:44:24PM +0800, Qing Zhang wrote:
>
>> v2:
>> - keep Kconfig and Makefile sorted
>> - make the entire comment a C++ one so things look more intentional
> You say this but...
>
>> +++ b/drivers/spi/spi-ls7a.c
>> @@ -0,0 +1,324 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Loongson LS7A SPI Controller driver
>> + *
>> + * Copyright (C) 2020 Loongson Technology Corporation Limited
>> + */
> ...this is still a mix of C and C++ comments?
       Replace all with //

>
>> +static int set_cs(struct ls7a_spi *ls7a_spi, struct spi_device  *spi, int val)
>> +{
>> +	int cs = ls7a_spi_read_reg(ls7a_spi, SFCS) & ~(0x11 << spi->chip_select);
>> +
>> +	if (spi->mode  & SPI_CS_HIGH)
>> +		val = !val;
>> +	ls7a_spi_write_reg(ls7a_spi, SFCS,
>> +		(val ? (0x11 << spi->chip_select):(0x1 << spi->chip_select)) | cs);
>> +
>> +	return 0;
>> +}
> Why not just expose this to the core and let it handle things?
>
> Please also write normal conditional statements to improve legibility.
> There's quite a lot of coding style issues in this with things like
> missing spaces
     static void ls7a_spi_set_cs(struct spi_device *spi, bool enable)
{
         struct ls7a_spi *ls7a_spi;

         int cs = ls7a_spi_read_reg(ls7a_spi, SFCS) & ~(0x11 << 
spi->chip_select));

         ls7a_spi = spi_master_get_devdata(spi->master);

         if (!!(spi->mode & SPI_CS_HIGH) == enable)
                 val = (0x11 << spi->chip_select) | cs;
         else
                 val = (0x1 << spi->chip_select) | cs;

         ls7a_spi_write_reg(ls7a_spi, SFCS, val);
}

      static int ls7a_spi_pci_probe---->

      +master->set_cs = ls7a_spi_set_cs;

>
>> +	if (t) {
>> +		hz = t->speed_hz;
>> +		if (!hz)
>> +			hz = spi->max_speed_hz;
>> +	} else
>> +		hz = spi->max_speed_hz;
> If one branch of the conditional has braces please use them on both to
> improve legibility.
>
>> +static int  ls7a_spi_transfer_one_message(struct spi_master *master,
>> +                                         struct spi_message *m)
> I don't understand why the driver is implementing transfer_one_message()
> - it looks like this is just open coding the standard loop that the
> framework provides and should just be using transfer_one().

static int  ls7a_spi_transfer_one(struct spi_master *master,
                       struct spi_device *spi,
                                   struct spi_transfer *t)
{
     struct ls7a_spi *ls7a_spi;
     int param, status;

     ls7a_spi = spi_master_get_devdata(master);

     spin_lock(&ls7a_spi->lock);
     param = ls7a_spi_read_reg(ls7a_spi, PARA);
     ls7a_spi_write_reg(ls7a_spi, PARA, param&~1);
     spin_unlock(&ls7a_spi->lock);

         status = ls7a_spi_do_transfer(ls7a_spi, spi, t);
         if(status < 0)
                 return status;

         if(t->len)
         r = ls7a_spi_write_read(spi, t);

         spin_lock(&ls7a_spi->lock);
     ls7a_spi_write_reg(ls7a_spi, PARA, param);
     spin_unlock(&ls7a_spi->lock);

     return status;
}

   static int ls7a_spi_pci_probe---->

  - master->transfer_one_message = ls7a_spi_transfer_one_message;
  +master->transfer_one = ls7a_spi_transfer_one;
>
>> +		r = ls7a_spi_write_read(spi, t);
>> +		if (r < 0) {
>> +			status = r;
>> +			goto error;
>> +			}
> The indentation here isn't following the kernel coding style.
>
>> +	master = spi_alloc_master(&pdev->dev, sizeof(struct ls7a_spi));
>> +	if (!master)
>> +		return -ENOMEM;
> Why not use devm_ here?

- master = spi_alloc_master(&pdev->dev, sizeof(struct ls7a_spi));

   error:
- spi_put_master(master);

+ master = devm_spi_alloc_master(&pdev->dev, sizeof(struct ls7a_spi));

>
>> +	ret = devm_spi_register_master(dev, master);
>> +	if (ret)
>> +		goto err_free_master;
> The driver uses devm_spi_register_master() here but...
>
>> +static void ls7a_spi_pci_remove(struct pci_dev *pdev)
>> +{
>> +	struct spi_master *master = pci_get_drvdata(pdev);
>> +	struct ls7a_spi *spi;
>> +
>> +	spi = spi_master_get_devdata(master);
>> +	if (!spi)
>> +		return;
>> +
>> +	pci_release_regions(pdev);
> ...releases the PCI regions in the remove() function before the SPI
> controller is freed so the controller could still be active.

      static void ls7a_spi_pci_remove(struct pci_dev *pdev)
{
         struct spi_master *master = pci_get_drvdata(pdev);

      + spi_unregister_master(master);
         pci_release_regions(pdev);
}

Thanks,

-Qing

