Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42401ECBC6
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2019 00:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfKAXHe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Nov 2019 19:07:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKAXHd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Nov 2019 19:07:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so4983330plq.5
        for <linux-spi@vger.kernel.org>; Fri, 01 Nov 2019 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xp3A8vdh1NO+887OUg4MRpz1hgoXlnInMjaDscwcRX4=;
        b=yYriT6h58xv7hTXRzRB5iUZbmOc5hfCHewM2Mn+UNE2HN6q4ot/vtr6GVE9xr9Jq7v
         rTmrjCeexwllHIjaJ0T9qdR+VD4y89F7Zd1DNeouk0nXPojIgyGe4P9Jkb1L01bZk0Br
         MBif6u0NSdZpeTSvrepGMxTj5dlUg8gB2hYfkF4XDyPXffagLnSq9b66FkDavj5E4gsG
         WeworxdV9zPAcmnaMW6Bwwy+zXiFrtoHAytsvZ9iQNf5LVCBgJd+DxxwHjuJ2FjllLQc
         WHjW27/Vg4xxU7lMx4LeqLGpmdqnmy9VnqNtQRCld93taP9KRm5poqrJpna8obEFlAhy
         QKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xp3A8vdh1NO+887OUg4MRpz1hgoXlnInMjaDscwcRX4=;
        b=UO6y20ZyF2+m/7tvd0UAZ3pVdrrm2rJydVy7NIzv7yo+6ohQF+H6du0EEaBZdp21M1
         tlOe4rEm7HYKa9cbXl0vD9ui1rfPL8uncEU8fqIel9nnbAAZkemcQp1eidraLyYr0yej
         k85UnkD3GKx4JjwufDAC2N6alQS/kWqlRsl6sQ9v3NVwtp9YKsct7sQisVGIdcS3tk5q
         XS+DwKmBSMZ7d/+Sg67OXlKPwGYcqu4p/YxKe7gBv8m9yRErIorMpUasf+diM9r3zFB9
         oaYfNRBeJvhYjJQZsaG4Iqv6v5GG09sQCrVZ/5hBibahLqJgF+UbTI2NuEAEVPvXab53
         3M9Q==
X-Gm-Message-State: APjAAAXdKqVXRIWqvqDMT3V2/R3Yhy5ssoPfi8UaXw/qtywvF5Oi4ctF
        hmATuppP2BGIZ60hmdsxjBUR7w==
X-Google-Smtp-Source: APXvYqxnsTZAEt4O+FvzghWOLNmYefTtpIpLZBMMy0wB7jnrlC85ie0yvSHdvkcDZFGQbFUhj+6ObQ==
X-Received: by 2002:a17:902:349:: with SMTP id 67mr2206815pld.221.1572649651082;
        Fri, 01 Nov 2019 16:07:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v15sm8798149pfc.85.2019.11.01.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:07:29 -0700 (PDT)
Date:   Fri, 01 Nov 2019 16:07:29 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Nov 2019 15:53:59 PDT (-0700)
Subject:     Re: [PATCH] spi: sifive: disable clk when probe fails and remove
In-Reply-To: <20191101121745.13413-1-hslester96@gmail.com>
CC:     broonie@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hslester96@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hslester96@gmail.com
Message-ID: <mhng-3be3dc4e-15f2-4ad2-b156-ea5439e729bd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 01 Nov 2019 05:17:45 PDT (-0700), hslester96@gmail.com wrote:
> The driver forgets to disable and unprepare clk when probe fails and
> remove.
> Add the calls to fix the problem.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/spi/spi-sifive.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 35254bdc42c4..f7c1e20432e0 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -357,14 +357,14 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	if (!cs_bits) {
>  		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	num_cs = ilog2(cs_bits) + 1;
>  	if (num_cs > SIFIVE_SPI_MAX_CS) {
>  		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
>  		ret = -EINVAL;
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	/* Define our master */
> @@ -393,7 +393,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  			       dev_name(&pdev->dev), spi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
> @@ -402,11 +402,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "spi_register_master failed\n");
> -		goto put_master;
> +		goto disable_clk;
>  	}
>
>  	return 0;
>
> +disable_clk:
> +	clk_disable_unprepare(spi->clk);
>  put_master:
>  	spi_master_put(master);
>
> @@ -420,6 +422,7 @@ static int sifive_spi_remove(struct platform_device *pdev)
>
>  	/* Disable all the interrupts just in case */
>  	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
> +	clk_disable_unprepare(spi->clk);
>
>  	return 0;
>  }

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
