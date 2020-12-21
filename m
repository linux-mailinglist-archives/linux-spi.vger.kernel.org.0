Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602512DFC0A
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 13:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUMxl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 07:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgLUMxl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 07:53:41 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9980C0613D3
        for <linux-spi@vger.kernel.org>; Mon, 21 Dec 2020 04:52:45 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Czzr61JbYz1rtNH;
        Mon, 21 Dec 2020 13:51:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Czzr60gkWz1qr3y;
        Mon, 21 Dec 2020 13:51:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dtOigQ_gs3-J; Mon, 21 Dec 2020 13:51:48 +0100 (CET)
X-Auth-Info: 0Q2JADJuGAhSUwo3vzdkiMKE122vBn7kd+T9X9e6wfw=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 21 Dec 2020 13:51:48 +0100 (CET)
Subject: Re: [PATCH] spi: stm32: FIFO threshold level - fix align packet size
To:     Roman Guskov <rguskov@dh-electronics.com>,
        linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>
References: <20201221123532.27272-1-rguskov@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <524f6c50-b515-1f5e-8237-97e78c9875d8@denx.de>
Date:   Mon, 21 Dec 2020 13:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201221123532.27272-1-rguskov@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/21/20 1:35 PM, Roman Guskov wrote:
> if cur_bpw <= 8 and xfer_len < 4 then the value of fthlv will be 1 and
> SPI registers content may have been lost.
> 
> * If SPI data register is accessed as a 16-bit register and DSIZE <= 8bit,
>    better to select FTHLV = 2, 4, 6 etc
> 
> * If SPI data register is accessed as a 32-bit register and DSIZE > 8bit,
>    better to select FTHLV = 2, 4, 6 etc, while if DSIZE <= 8bit,
>    better to select FTHLV = 4, 8, 12 etc
> 
> Signed-off-by: Roman Guskov <rguskov@dh-electronics.com>

I think this should also have the following tag:

Fixes: dcbe0d84dfa5 ("spi: add driver for STM32 SPI controller")

> ---
>   drivers/spi/spi-stm32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 9d8ceb63f7db..417c40154477 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -494,9 +494,9 @@ static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi, u32 xfer_len)
>   
>   	/* align packet size with data registers access */
>   	if (spi->cur_bpw > 8)
> -		fthlv -= (fthlv % 2); /* multiple of 2 */
> +		fthlv += (fthlv % 2) ? 1 : 0;
>   	else
> -		fthlv -= (fthlv % 4); /* multiple of 4 */
> +		fthlv += (fthlv % 4) ? (4 - (fthlv % 4)) : 0;
>   
>   	if (!fthlv)
>   		fthlv = 1;
> 

Reviewed-by: Marek Vasut <marex@denx.de>
