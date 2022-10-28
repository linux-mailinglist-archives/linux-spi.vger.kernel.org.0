Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04371610A14
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJ1GMr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1GMq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 02:12:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA61AA250
        for <linux-spi@vger.kernel.org>; Thu, 27 Oct 2022 23:12:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S6CCvc036643;
        Fri, 28 Oct 2022 01:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666937532;
        bh=9nFeW1pSbtU6BVaIhLaHqDzIMpPPCpeKy0T9hSy+0L0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VoPJoI2caiMF7USu+qlInbk9hIhEXwfXfI8xbLTk9NAiwuvkjqJM881M5zXJZ1Fep
         3VJwohJC1GyGC55ezMvP7v56pjQ62VfIfCqsJf8BASi9GfoWp5QNb+/dhvxeEXL1pt
         tuq57ixdJJMoNzcomDKDEsMs1mJ+7FxMhuHfbOOo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S6CCsU052427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 01:12:12 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 01:12:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 01:12:12 -0500
Received: from [10.250.234.138] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S6C9Xi002888;
        Fri, 28 Oct 2022 01:12:10 -0500
Message-ID: <99f962a4-0101-b040-17dc-cec3d877dba8@ti.com>
Date:   Fri, 28 Oct 2022 11:42:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/4] spi: intel: Implement adjust_op_size()
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
 <20221025064623.22808-3-mika.westerberg@linux.intel.com>
From:   "Gole, Dhruva" <d-gole@ti.com>
In-Reply-To: <20221025064623.22808-3-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mika,

On 10/25/2022 12:16 PM, Mika Westerberg wrote:
> This allows us to get rid of the checks in the intel_spi_[sh]w_cycle()
> and makes it possible for the SPI-NOR core to split the transaction into
> smaller chunks as needed.

If I understand correctly, the controller ops are called from spi-mem.c, 
and

spi_mem_adjust_op does exist and on it's own does "split a data transfer
  operation into multiple ones"

So is this really something that you require the controller to do and

can we not rely on spi-mem.c to do it's thing instead?

I would like to point you to another controller spi-cadence-quadspi.c

that also doesn't have it's own adjust_op_size but I haven't seen any 
issues as such

inspite. This is because everything first goes through spi-mem.c then 
onto the controllers drivers.

This atleast is my understanding, please correct me if I am mistaken.

>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/spi/spi-intel.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
> index b3685460d848..13a3a61239d2 100644
> --- a/drivers/spi/spi-intel.c
> +++ b/drivers/spi/spi-intel.c
> @@ -363,10 +363,6 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi,
>   
>   	val = readl(ispi->base + HSFSTS_CTL);
>   	val &= ~(HSFSTS_CTL_FCYCLE_MASK | HSFSTS_CTL_FDBC_MASK);
> -
> -	if (len > INTEL_SPI_FIFO_SZ)
> -		return -EINVAL;
> -
>   	val |= (len - 1) << HSFSTS_CTL_FDBC_SHIFT;
>   	val |= HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
>   	val |= HSFSTS_CTL_FGO;
> @@ -397,9 +393,6 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
>   	if (ret < 0)
>   		return ret;
>   
> -	if (len > INTEL_SPI_FIFO_SZ)
> -		return -EINVAL;
> -
>   	/*
>   	 * Always clear it after each SW sequencer operation regardless
>   	 * of whether it is successful or not.
> @@ -704,6 +697,12 @@ static int intel_spi_erase(struct intel_spi *ispi, const struct spi_mem *mem,
>   	return 0;
>   }
>   
> +static int intel_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	op->data.nbytes = clamp_val(op->data.nbytes, 0, INTEL_SPI_FIFO_SZ);
> +	return 0;
> +}
> +
>   static bool intel_spi_cmp_mem_op(const struct intel_spi_mem_op *iop,
>   				 const struct spi_mem_op *op)
>   {
> @@ -844,6 +843,7 @@ static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs
>   }
>   
>   static const struct spi_controller_mem_ops intel_spi_mem_ops = {
> +	.adjust_op_size = intel_spi_adjust_op_size,
>   	.supports_op = intel_spi_supports_mem_op,
>   	.exec_op = intel_spi_exec_mem_op,
>   	.get_name = intel_spi_get_name,
