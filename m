Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E0133AB9
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 06:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAHFOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 00:14:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33656 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFOT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jan 2020 00:14:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0085Dvka049180;
        Tue, 7 Jan 2020 23:13:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578460437;
        bh=Mb7vSu5SwXyQoADual+mvyMlpY3gaRx9V8vlUS65Wm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IrNvkfkpk5HZrLK4JaQmQQ4+d8+xJkTQRikrpcb0cP56L54tB/sstNzk1axIhXs4g
         oRFluezBSTo8CcnCW7lQXm1UxepVTHLK9Dzl3CF9YQhQ0JH+HCCN/mJAH4EyMJ0VI+
         RCt4n7iuSGJGcVMPbL77ws2hdMvyvvHgxtyCiqj8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0085Dvv9123825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 23:13:57 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 23:13:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 23:13:56 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0085Drsr127969;
        Tue, 7 Jan 2020 23:13:54 -0600
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <e89cf037-217b-cd61-79ee-a11e2a118c01@ti.com>
 <66b9f427-83c2-f56c-3d38-fa955429118d@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9b95a30f-6d2d-2202-248a-24186d5ddb2a@ti.com>
Date:   Wed, 8 Jan 2020 10:44:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <66b9f427-83c2-f56c-3d38-fa955429118d@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 06/01/20 4:49 pm, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> Thank you for the review comments.
> 
> On 6/1/2020 6:40 PM, Vignesh Raghavendra wrote:
>> Hi,
>>
>> On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
>> [...]
>>> +static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32
>>> addr_width)
>>> +{
>>> +    unsigned int addr = 0;
>>> +    int i;
>>> +
>>> +    /* Invalid address return zero. */
>>> +    if (addr_width > 4)
>>> +        return 0;
>>> +
>>> +    for (i = 0; i < addr_width; i++) {
>>> +        addr = addr << 8;
>>> +        addr |= addr_buf[i];
>>> +    }
>>> +
>>> +    return addr;
>>> +}
>>> +
>> [...]
>>> +static int cqspi_apb_read_setup(struct struct_cqspi *cqspi,
>>> +                const struct spi_mem_op *op,
>>> +                const u8 *addrbuf)
>>> +{
>>> +    void __iomem *reg_base = cqspi->iobase;
>>> +    size_t addrlen = op->addr.nbytes;
>>> +    size_t dummy_bytes = op->dummy.nbytes;
>>> +    unsigned int addr_value, dummy_clk, reg;
>>> +
>>> +    if (addrlen) {
>>> +        addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
>>> +        writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
>>> +    }
>>> +
>> Why do you need to swap the address bytes to SPI bus order?
> Yes , you are right to align with spi bus order swap is done .
>>   You are
>> writing to a controller register that accepts 24 bit or 32 bit address.
> 32bit address.

There is no need to swap the address bytes. The current driver
(drivers/mtd/spi-nor/cadence-quadspi.c) does not swap the address to SPI
bus order, why does the new driver required to do so?

>>> +    reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
>>> +    reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
>>> +        CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
>>> +
>> This is wrong... op->data.buswidth's range is 1 to 8 whereas
>> CQSPI_REG_RD_INSTR_TYPE range is 0 to 3. I wonder whether you tested
>> dual/quad mode with this driver?
> Yes I have tested with Quad mode since Cadence-IP supports dual/quad on
> my platform, used to validate
> before sending the patch that's  standard procedure here.
> please let me know if you have any further queries.
> 

Then I have no idea how it works on your platform.. What you are
programming above overflows the assigned bit fields for bus width, right?

> ---
> Best Regards
> Vadivel
>> I am still unable to get this series to work on my platform. Will
>> continue to debug...
>>

-- 
Regards
Vignesh
