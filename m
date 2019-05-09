Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7A18B01
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEINxq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 09:53:46 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:58684 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfEINxq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 09:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=BKEOvWIKzJQOoGnU6TZc4Dk3svFSx4QVf7c4qCPXG6E=;
        b=QYVyK5VAP5iIkGmIxa9SBNO3/tmNL2PQY+cwJD8HIyT+U5RKlXumGJnHccqBx6/VV6E/JlIY3m3LoY0r1xJQDcsETlqckF8Q0X+emwLjfo0BkRCMy+S9n/NBjgjQJkQnOdL/M1p+eNom0sDjEkFyqXTHbXAmRnbU75AwyHY3zcwua3w6w7OonLKABojPTfUFADgTTmnrpGkuPwrp8ipLnPjipKFzMzYW6rQDwuuZ1h8+R4CGPy5HpfjecD4uXkabo2wIV/fwMZflXdBYhkBZ/hLiGGT2G0O/Lf5hmtIWb37pOoxtdpZapdx5OwaNS4u1d0IqnxD5LKbRkqHKCqIQBw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52438 helo=[192.168.10.178])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hOjUV-0000Bw-FQ; Thu, 09 May 2019 15:53:43 +0200
Subject: Re: [PATCH V1 1/3] spi: core: resource: fix memory leak on error and
 place in "correct" sequence
To:     kernel@martin.sperl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org
References: <20190509105533.24275-1-kernel@martin.sperl.org>
 <20190509105533.24275-2-kernel@martin.sperl.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b7c2653b-a5a0-e525-85ea-efb01f53fc2b@tronnes.org>
Date:   Thu, 9 May 2019 15:53:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509105533.24275-2-kernel@martin.sperl.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Den 09.05.2019 12.55, skrev kernel@martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> When an error occurs in ctlr->prepare_message or spi_map_msg
> then spi_resources is not cleared leaving unexpected entries and
> memory.
> 
> Also there is an ordering issue:
> On ititialization:
> * prepare_message
> * spi_map_msg
> 
> and when releasing:
> * spi_res_release (outside of finalize)
>   -> this restores the spi structures
> * spi_unmap_msg
> * unprepare_message
> 
> So the ordering is wrong in the case that prepare_message is
> modifying the spi_message and spi_message.resources.
> 
> Especially the dma unmapping of all the translations are not done.
> 
> There is still an ambiguity where is the "best" place where to place
> spi_res_release - it definitely has to be after spi_unmap_msg,
> but if it should be before or after unprepare message is not well
> defined.
> 
> Ideally this dma unmap and unprepare_message would be executed
> by spi_res_release and thus in the guaranteed order they were applied.
> 
> This incidently implements a better way for the reverted
> commit c9ba7a16d0f1 ("spi: Release spi_res after finalizing message")
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---

Thanks for sorting this out Martin.

Tested-by: Noralf Trønnes <noralf@tronnes.org>

>  drivers/spi/spi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eb7460dd744..1dfb19140bbe 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1181,8 +1181,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>  	if (msg->status && ctlr->handle_err)
>  		ctlr->handle_err(ctlr, msg);
> 
> -	spi_res_release(ctlr, msg);
> -
>  	spi_finalize_current_message(ctlr);
> 
>  	return ret;
> @@ -1448,6 +1446,15 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
>  		}
>  	}
> 
> +	/* where to put the release is a slight nightmare because
> +	 * ctlr->prepare_message may add to resources as well.
> +	 * so the question is: call it before unprepare or after?
> +	 * for now leave it after - the asumption here is that
> +	 * if prepare_message is using spi_res for callbacks,
> +	 * then no unprepare_message is used
> +	 */
> +	spi_res_release(ctlr, mesg);
> +
>  	spin_lock_irqsave(&ctlr->queue_lock, flags);
>  	ctlr->cur_msg = NULL;
>  	ctlr->cur_msg_prepared = false;
> --
> 2.11.0
> 
