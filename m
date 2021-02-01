Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C694B30A81F
	for <lists+linux-spi@lfdr.de>; Mon,  1 Feb 2021 13:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhBAM4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Feb 2021 07:56:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11666 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBAM4O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Feb 2021 07:56:14 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTnv505rhzlDr8;
        Mon,  1 Feb 2021 20:53:53 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 20:55:23 +0800
Subject: Re: [PATCH 1/2] mtd: spi-nor: check 4-byte address support when
 parsing 4bait
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <john.garry@huawei.com>, <linuxarm@openeuler.org>,
        <prime.zeng@huawei.com>
References: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
 <1611740450-47975-2-git-send-email-yangyicong@hisilicon.com>
 <20210129111649.jypytpp7dkywthwh@ti.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <28c3dacb-e222-8d5e-b795-947b555551bf@hisilicon.com>
Date:   Mon, 1 Feb 2021 20:55:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210129111649.jypytpp7dkywthwh@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

Thanks for the comments. Some replies below.

On 2021/1/29 19:16, Pratyush Yadav wrote:
> Hi Yicong,
> 
> On 27/01/21 05:40PM, Yicong Yang wrote:
>> The spi-nor core will convert the address mode to 4-btye,
>> without checking whether 4-byte address is supported or not.
>> For example, the 16M s25fs128s1 can work under both 3-byte
>> and 4-byte address and provides a 4bait table. The spi-nor
>> will drive the flash under 4-byte address mode after parsing
>> the 4bait and will cause it unusable on platforms doesn't
>> support 4-byte.
> 
> Another problem caused by 4BAIT parser prematurely selecting the address 
> width. See [0].
>  
> Let's fix this 4BAIT problem once and for all. Instead of setting 
> nor->addr_width to 4 in spi_nor_parse_4bait(), just set SNOR_F_HAS_4BAIT 
> (which is already being done). Then in spi_nor_default_setup(), use this 
> information when negotiating the read/write/program commands with the 
> controller to determine the correct address width to use.

The idea is great. ideally we should check the buswidth and commands in
spi_nor_default_setup() and finally set address width in
spi_nor_set_addr_width().

> 
> This refactor is easier said than done. We don't associate address width 
> information with a command. Just protocol, opcode, and dummy cycles 
> (only for read commands). A new mechanism needs to be added where we 
> associate a set of supported addresses with a command and then the 
> command negotiation can use all this information to arrive at the 
> optimal set of commands.
> 
> With this in mind, it would be great if you can come up with a patch to 
> add such a mechanism. But I would also be OK with this fix with the 
> condition that it is clearly marked as a temporary fix, and mentions 
> what should ideally be done.
> 

i'd like to get this issue fixed first to make the flash work properly,
if possible. then to do the refactor as it may take me sometime.

>> Add checking of 4-byte address support when parsing the 4bait
>> table, stop converting the address mode if it's not supported.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/mtd/spi-nor/sfdp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>> index 6ee7719..fdafc9b 100644
>> --- a/drivers/mtd/spi-nor/sfdp.c
>> +++ b/drivers/mtd/spi-nor/sfdp.c
>> @@ -940,6 +940,27 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
>>  	return ret;
>>  }
>>  
>> +static int spi_nor_spimem_check_4byte_addr(struct spi_nor *nor,
>> +					   const struct spi_nor_read_command *read)
>> +{
>> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(read->opcode, 1),
>> +					  SPI_MEM_OP_ADDR(4, 0, 1),
>> +					  SPI_MEM_OP_DUMMY(0, 1),
>> +					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
> 
> Set buswidths to 0 here...

ok.

> 
>> +
>> +	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
>> +	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
>> +	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
>> +	op.dummy.buswidth = op.addr.buswidth;
> 
> ... and use spi_nor_spimem_setup_op() to do this. It will also take care 
> of setting up DTR ops.

will change to the new function, i didn't notice it. :)

Thanks,
Yicong

> 
>> +	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
>> +			  op.dummy.buswidth / 8;
>> +
>> +	if (!spi_mem_supports_op(nor->spimem, &op))
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * spi_nor_parse_4bait() - parse the 4-Byte Address Instruction Table
>>   * @nor:		pointer to a 'struct spi_nor'.
>> @@ -1061,6 +1082,33 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>>  		goto out;
>>  
>>  	/*
>> +	 * Check whether the 4-byte address is supported before converting
>> +	 * the instruction set to 4-byte.
>> +	 */
>> +	if (nor->spimem) {
>> +		bool support = false;
>> +
>> +		for (i = 0; i < SNOR_CMD_READ_MAX; i++) {
>> +			struct spi_nor_read_command read_cmd;
>> +
>> +			memcpy(&read_cmd, &params->reads[i], sizeof(read_cmd));
>> +
>> +			read_cmd.opcode = spi_nor_convert_3to4_read(read_cmd.opcode);
>> +			if (!spi_nor_spimem_check_4byte_addr(nor, &read_cmd)) {
>> +				support = true;
>> +				break;
>> +			}
>> +		}
>> +
>> +		/*
>> +		 * No supported 4-byte instruction is found, stop parsing the
>> +		 * 4bait table.
>> +		 */
>> +		if (!support)
>> +			goto out;
>> +	}
>> +
>> +	/*
>>  	 * Discard all operations from the 4-byte instruction set which are
>>  	 * not supported by this memory.
>>  	 */
> 
> [0] https://lore.kernel.org/linux-mtd/20201212115817.5122-1-vigneshr@ti.com/
> 

