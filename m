Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECEB1310B4
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 11:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAFKkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 05:40:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57190 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFKkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jan 2020 05:40:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006Ae926063647;
        Mon, 6 Jan 2020 04:40:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578307209;
        bh=8c6+nL0sjGE+mUP74dPaw6GeeVNGbaLFurAs3499j/I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BfyEGs4vO6I/tb+2dG0m5Y826jIxvx1JS/nESh2b2osjlfLZJ1Xo49deXS31sPS9P
         xx8h47hhrfyNUqPl11uLdDpfmf2fnUJ/JTrM5kq52sXQJ72fLDoFPkN1VNWnCgZlv2
         bruqcfsapbOaVO2zZWxSuSUBm8GGQzx0BQNO1vE4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006Ae9mZ031981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 04:40:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:40:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:40:09 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006Ae6DC025983;
        Mon, 6 Jan 2020 04:40:06 -0600
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
X-Enigmail-Draft-Status: N11100
Message-ID: <e89cf037-217b-cd61-79ee-a11e2a118c01@ti.com>
Date:   Mon, 6 Jan 2020 16:10:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
[...]
> +static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
> +{
> +	unsigned int addr = 0;
> +	int i;
> +
> +	/* Invalid address return zero. */
> +	if (addr_width > 4)
> +		return 0;
> +
> +	for (i = 0; i < addr_width; i++) {
> +		addr = addr << 8;
> +		addr |= addr_buf[i];
> +	}
> +
> +	return addr;
> +}
> +
[...]
> +static int cqspi_apb_read_setup(struct struct_cqspi *cqspi,
> +				const struct spi_mem_op *op,
> +				const u8 *addrbuf)
> +{
> +	void __iomem *reg_base = cqspi->iobase;
> +	size_t addrlen = op->addr.nbytes;
> +	size_t dummy_bytes = op->dummy.nbytes;
> +	unsigned int addr_value, dummy_clk, reg;
> +
> +	if (addrlen) {
> +		addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
> +		writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
> +	}
> +

Why do you need to swap the address bytes to SPI bus order? You are
writing to a controller register that accepts 24 bit or 32 bit address.

> +	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
> +	reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
> +		CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
> +

This is wrong... op->data.buswidth's range is 1 to 8 whereas
CQSPI_REG_RD_INSTR_TYPE range is 0 to 3. I wonder whether you tested
dual/quad mode with this driver?

I am still unable to get this series to work on my platform. Will
continue to debug...

-- 
Regards
Vignesh
