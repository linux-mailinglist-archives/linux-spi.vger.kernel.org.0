Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E534BE0E2
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380800AbiBUQjK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 11:39:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380767AbiBUQiy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 11:38:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0021E1B
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 08:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 670C3B81250
        for <linux-spi@vger.kernel.org>; Mon, 21 Feb 2022 16:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9531EC340EC;
        Mon, 21 Feb 2022 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645461507;
        bh=S0vuWCfhz3A/on4oFbx7GpbLlEn+XARrIe3XdFnrEuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VhrVYESjuPf8VLMjLjlFDkZoflKjDn6PPZQfEmYYC2PpR8zSHtZJJxz7mgyuoQZLS
         HIg4Ns8PO4CEkByAMV0nL0ucgej/JiplHcKL2nW0I6BbGmP4U/uAfQi9wHMkkbFy1T
         1A0wMNUBR9hh6pSmePe6oCDQJVAoxIQnUEwnitt34e109ayFZx17UumryLD5rFTvqD
         jxYG5QeEdIJODwdvJNGm6dZo1PrIRiI33QsLLM4OWnuirASQJul620QcC7ZfrWORlf
         +EEVDsN0ebl/08oWfOc1fGqlsWrfQDbZIRnBVPZNRKhhGhpfh6VbnTSzKzrD147WCK
         UwTe58CFr7UrQ==
Message-ID: <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
Date:   Mon, 21 Feb 2022 10:38:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220221043238.295369-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/20/22 22:32, Marek Vasut wrote:
> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
> leads to data abort, disable DAC to avoid triggering it:
> 
> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
> [0400d3e9] *pgd=00000000
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Pratyush Yadav <p.yadav@ti.com>
> ---
>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index b808c94641fa6..65f2c2449be09 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
>   };
>   
>   static const struct cqspi_driver_platdata socfpga_qspi = {
> -	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
> +	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
>   };
>   
>   static const struct cqspi_driver_platdata versal_ospi = {

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
