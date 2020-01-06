Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44313114B
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFLTb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 06:19:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:23966 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAFLTb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jan 2020 06:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 03:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="232798628"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2020 03:19:31 -0800
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 2907E580297;
        Mon,  6 Jan 2020 03:19:28 -0800 (PST)
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <e89cf037-217b-cd61-79ee-a11e2a118c01@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <66b9f427-83c2-f56c-3d38-fa955429118d@linux.intel.com>
Date:   Mon, 6 Jan 2020 19:19:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e89cf037-217b-cd61-79ee-a11e2a118c01@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Thank you for the review comments.

On 6/1/2020 6:40 PM, Vignesh Raghavendra wrote:
> Hi,
>
> On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
> [...]
>> +static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
>> +{
>> +	unsigned int addr = 0;
>> +	int i;
>> +
>> +	/* Invalid address return zero. */
>> +	if (addr_width > 4)
>> +		return 0;
>> +
>> +	for (i = 0; i < addr_width; i++) {
>> +		addr = addr << 8;
>> +		addr |= addr_buf[i];
>> +	}
>> +
>> +	return addr;
>> +}
>> +
> [...]
>> +static int cqspi_apb_read_setup(struct struct_cqspi *cqspi,
>> +				const struct spi_mem_op *op,
>> +				const u8 *addrbuf)
>> +{
>> +	void __iomem *reg_base = cqspi->iobase;
>> +	size_t addrlen = op->addr.nbytes;
>> +	size_t dummy_bytes = op->dummy.nbytes;
>> +	unsigned int addr_value, dummy_clk, reg;
>> +
>> +	if (addrlen) {
>> +		addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
>> +		writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
>> +	}
>> +
> Why do you need to swap the address bytes to SPI bus order?
Yes , you are right to align with spi bus order swap is done .
>   You are
> writing to a controller register that accepts 24 bit or 32 bit address.
32bit address.
>> +	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
>> +	reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
>> +		CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
>> +
> This is wrong... op->data.buswidth's range is 1 to 8 whereas
> CQSPI_REG_RD_INSTR_TYPE range is 0 to 3. I wonder whether you tested
> dual/quad mode with this driver?
Yes I have tested with Quad mode since Cadence-IP supports dual/quad on 
my platform, used to validate
before sending the patch that's  standard procedure here.
please let me know if you have any further queries.

---
Best Regards
Vadivel
> I am still unable to get this series to work on my platform. Will
> continue to debug...
>
