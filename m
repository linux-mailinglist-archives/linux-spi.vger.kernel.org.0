Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A685602B0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiF2O3B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiF2O3A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:29:00 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BD1EC55
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=yW6dMsL7vMfnBpGRZIjua6Amskm3pneL3Ya0pmxQyh0=;
        b=tQsMduAsXg3n5Ydj6a80FFw8Bj9hIo14FjcYCxn7ij5Bc3lS8wAgwFASWe7EZshrW7R/UOVPlWYK/
         saI/J5YNI2/5jthMXk+MbYSYI0t7d/7S6AOOUAxWSz/WUVSF5Qq1jcWxXJ1nz14DWTiDEjX6jWy387
         h7swfczGYp7klP7+0/eQU9r1ywnl+i2ysoJGzkhdPxiB7j5IbZLrVFMiHb0fxzIDg1kF4YJmNcbZSQ
         7gNFQV7w6lVyI56mbO03Q1HdboZcsBkNa97L0CDCCloAjuJEjPMhFTwp202s+Smp/+Ohg0U2cKjYVO
         FY5BbeNGDek/TVv+yysknGOjnMutZLw==
X-MSG-ID: cfad7335-f7b7-11ec-9051-0050569d2c73
Date:   Wed, 29 Jun 2022 16:28:57 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] spi: spi.c: Remove redundant else block
Message-ID: <20220629162857.7cadc15e@erd992>
In-Reply-To: <20220629142519.3985486-4-david@protonic.nl>
References: <20220629142519.3985486-1-david@protonic.nl>
        <20220629142519.3985486-4-david@protonic.nl>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Jun 2022 16:25:19 +0200
David Jander <david@protonic.nl> wrote:

> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/spi/spi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 09d4959bc09c..dc1a324e3271 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1636,13 +1636,13 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
>  		dev_err(&ctlr->dev,
>  			"failed to transfer one message from queue\n");
>  		return ret;
> -	} else {
> -		WRITE_ONCE(ctlr->cur_msg_need_completion, true);
> -		smp_mb(); /* see spi_finalize_current_message()... */
> -		if (READ_ONCE(ctlr->cur_msg_incomplete))
> -			wait_for_completion(&ctlr->cur_msg_completion);
>  	}
>  
> +	WRITE_ONCE(ctlr->cur_msg_need_completion, true);
> +	smp_mb(); /* See spi_finalize_current_message()... */

Argh. Just noticed that this comment fix slipped into the wrong patch.
Do I need to re-submit, or is this acceptable?

> +	if (READ_ONCE(ctlr->cur_msg_incomplete))
> +		wait_for_completion(&ctlr->cur_msg_completion);
> +
>  	return 0;
>  }
>  

Best regards,

-- 
David Jander
