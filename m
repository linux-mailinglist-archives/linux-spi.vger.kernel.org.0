Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C313DDA5F
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhHBONn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhHBOMn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 10:12:43 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77DC01B0A1;
        Mon,  2 Aug 2021 06:57:44 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so416850oop.0;
        Mon, 02 Aug 2021 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4innsOL2Q3KWcAqQhqXiBn1f8Lxu8dmaKQoSumnZeAQ=;
        b=baBe0MLf4OGBzPDNUbm3SqMz8awtAC42JZbCrY8lNcgy+SIKA3mV20Sabr85Uclj1t
         ulimS87lHCCYqmtw3yI1mXPXnA+HyXbwamwWqeOtNxnw/sHUQzGOUZ7pUw7Tg9FlS3fM
         moMSkGtSAxBNug0WN0qY9P8SMJcoZA4wQeHLDyUx7u2OmM0QiCrkogZLKgUJZvjcN2bD
         iyJOFJCxjaU0igeXBbEK3p/KbZpIV4da91luDcGi8U0QbdcKf/9Z1jkcb3Nrwb2l0Ltx
         fMc4u3KA+7u+8bOdlJ7BaO+AdRxFIlN17MaeW4hd12cU6sQtwvXcnlyr28TR+wbFN99z
         dDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4innsOL2Q3KWcAqQhqXiBn1f8Lxu8dmaKQoSumnZeAQ=;
        b=i9cMvTNU/zEQmdHiihcSKSESc/cBwJHVmNIHmvWXAgYRzjoWOzpXcQrcLYg4OUO/yz
         0n0HC4HxTtxd2rbCv3FkS3kfx8bMPLhTNbfECg6mqNnfO12EbTFhgCGCdkZIPOlRJccG
         Bzm7JG41PhDXhDlDZ2A4zasxldKJcEsuVau0R+fj59FOJsLvv7JK16iKjKtZDVYY3UCI
         HHoVZEA1EEqSR0jaxV4kZRR1jHkafX2fY4Qz5mzm7PzvYIDoXcdxvMKzCmcdsxxGpxz/
         aL6oRAOSYNNRlGEhJf/FV+FU/QarDK2QgsmtGzXy6Ik5zi9xjKtHwr3w3giQKC40X17E
         oWrg==
X-Gm-Message-State: AOAM533VM2m/mivfQPtwM9WItZUEWtD2Ke/5swP5PJ43DV1fd0Xo7+Q8
        K+32yBMjEjY7pnGWJa1w7ok=
X-Google-Smtp-Source: ABdhPJyiMuR6up32Ii8P3kcZU8ODU5bQh+TRUkFM/vZhIPbYC7x5JcFxqU3XUxk69wOs4DetH5ciig==
X-Received: by 2002:a4a:ca8b:: with SMTP id x11mr10773342ooq.16.1627912663328;
        Mon, 02 Aug 2021 06:57:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24sm1793012oic.23.2021.08.02.06.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 06:57:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] spi: mediatek: Fix fifo transfer
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Hess <peter.hess@ph-home.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@google.com>
References: <20210802030023.1748777-1-linux@roeck-us.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <836776f1-5b8d-ba18-2bd7-3b21673a8b82@roeck-us.net>
Date:   Mon, 2 Aug 2021 06:57:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802030023.1748777-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 8/1/21 8:00 PM, Guenter Roeck wrote:
> Commit 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode") claims that
> fifo RX mode was never handled, and adds the presumably missing code
> to the FIFO transfer function. However, the claim that receive data
> was not handled is incorrect. It was handled as part of interrupt
> handling after the transfer was complete. The code added with the above
> mentioned commit reads data from the receive FIFO before the transfer
> is started, which is wrong. This results in an actual transfer error
> on a Hayato Chromebook.
> 
> Remove the code trying to handle receive data before the transfer is
> started to fix the problem.
> 
> Fixes: 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode")
> Cc: Peter Hess <peter.hess@ph-home.de>
> Cc: Frank Wunderlich <frank-w@public-files.de>
> Cc: Tzung-Bi Shih <tzungbi@google.com>
> Cc: Hsin-Yi Wang <hsinyi@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

I should have added here: If this patch isn't acceptable for some reason,
commit 3a70dd2d0503 should be reverted because it is obviously wrong
and introduces a severe regression.

Thanks,
Guenter

>   drivers/spi/spi-mt65xx.c | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 68dca8ceb3ad..7914255521c3 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -426,24 +426,15 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
>   	mtk_spi_prepare_transfer(master, xfer);
>   	mtk_spi_setup_packet(master);
>   
> -	cnt = xfer->len / 4;
> -	if (xfer->tx_buf)
> +	if (xfer->tx_buf) {
> +		cnt = xfer->len / 4;
>   		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
> -
> -	if (xfer->rx_buf)
> -		ioread32_rep(mdata->base + SPI_RX_DATA_REG, xfer->rx_buf, cnt);
> -
> -	remainder = xfer->len % 4;
> -	if (remainder > 0) {
> -		reg_val = 0;
> -		if (xfer->tx_buf) {
> +		remainder = xfer->len % 4;
> +		if (remainder > 0) {
> +			reg_val = 0;
>   			memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
>   			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
>   		}
> -		if (xfer->rx_buf) {
> -			reg_val = readl(mdata->base + SPI_RX_DATA_REG);
> -			memcpy(xfer->rx_buf + (cnt * 4), &reg_val, remainder);
> -		}
>   	}
>   
>   	mtk_spi_enable_transfer(master);
> 

