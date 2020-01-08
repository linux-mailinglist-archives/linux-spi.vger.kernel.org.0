Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE2133B59
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 06:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAHFok (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 00:44:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:47785 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgAHFok (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 00:44:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 21:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="215851240"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2020 21:44:37 -0800
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 2523058033E;
        Tue,  7 Jan 2020 21:44:34 -0800 (PST)
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <e89cf037-217b-cd61-79ee-a11e2a118c01@ti.com>
 <66b9f427-83c2-f56c-3d38-fa955429118d@linux.intel.com>
 <9b95a30f-6d2d-2202-248a-24186d5ddb2a@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <8b0816ba-f74f-6ed7-7a85-679031104568@linux.intel.com>
Date:   Wed, 8 Jan 2020 13:44:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9b95a30f-6d2d-2202-248a-24186d5ddb2a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 8/1/2020 1:14 PM, Vignesh Raghavendra wrote:
>
> On 06/01/20 4:49 pm, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>> Thank you for the review comments.
>>
>> On 6/1/2020 6:40 PM, Vignesh Raghavendra wrote:
>>> Hi,
>>>
>>> On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
>>> [...]
>>>> +static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32
>>>> addr_width)
>>>> +{
>>>> +    unsigned int addr = 0;
>>>> +    int i;
>>>> +
>>>> +    /* Invalid address return zero. */
>>>> +    if (addr_width > 4)
>>>> +        return 0;
>>>> +
>>>> +    for (i = 0; i < addr_width; i++) {
>>>> +        addr = addr << 8;
>>>> +        addr |= addr_buf[i];
>>>> +    }
>>>> +
>>>> +    return addr;
>>>> +}
>>>> +
>>> [...]
>>>> +static int cqspi_apb_read_setup(struct struct_cqspi *cqspi,
>>>> +                const struct spi_mem_op *op,
>>>> +                const u8 *addrbuf)
>>>> +{
>>>> +    void __iomem *reg_base = cqspi->iobase;
>>>> +    size_t addrlen = op->addr.nbytes;
>>>> +    size_t dummy_bytes = op->dummy.nbytes;
>>>> +    unsigned int addr_value, dummy_clk, reg;
>>>> +
>>>> +    if (addrlen) {
>>>> +        addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
>>>> +        writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
>>>> +    }
>>>> +
>>> Why do you need to swap the address bytes to SPI bus order?
>> Yes , you are right to align with spi bus order swap is done .
>>>    You are
>>> writing to a controller register that accepts 24 bit or 32 bit address.
>> 32bit address.
> There is no need to swap the address bytes. The current driver
> (drivers/mtd/spi-nor/cadence-quadspi.c) does not swap the address to SPI
> bus order, why does the new driver required to do so?
Thanks! for clarification, actually we are not swapping , just 
Converting address buffer into word format (MSB first).
>>>> +    reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
>>>> +    reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
>>>> +        CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
>>>> +
>>> This is wrong... op->data.buswidth's range is 1 to 8 whereas
>>> CQSPI_REG_RD_INSTR_TYPE range is 0 to 3. I wonder whether you tested
>>> dual/quad mode with this driver?
>> Yes I have tested with Quad mode since Cadence-IP supports dual/quad on
>> my platform, used to validate
>> before sending the patch that's  standard procedure here.
>> please let me know if you have any further queries.
>>
> Then I have no idea how it works on your platform..
while testing on my platform I have hardcoded to 4 instead of 8, for me 
it is working fine.
should be handled properly for OCTAL mode once your changes are ready

>   What you are
> programming above overflows the assigned bit fields for bus width, right?
yes, overflow should be handled
once started working on your platform with your changes, I will squash 
and send it back.
Thanks for your time.

Regards
Vadivel
>> ---
>> Best Regards
>> Vadivel
>>> I am still unable to get this series to work on my platform. Will
>>> continue to debug...
>>>
