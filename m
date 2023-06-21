Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBC738A20
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jun 2023 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFUPvq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jun 2023 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFUPvq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jun 2023 11:51:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE2E2
        for <linux-spi@vger.kernel.org>; Wed, 21 Jun 2023 08:51:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso6013160f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 21 Jun 2023 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687362703; x=1689954703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC81hT2eRQBjkojJrQa9BM2dAGgpSMK2LXGRglIV5hw=;
        b=mqi7fm69G1L7cEB/FeYvXqf9QyhMh1oLHnDcNBlWVNoFnHegIYS+R+ecL+9SrnZdoJ
         omi7ZPmVm0NSXZXd2auduGsejwdcEGoF/3dwrmt9sc6SsMg0NEE0ef13Ov+KzxwA9cE3
         BIEYV/3eYIwoyofzhRYjkFpf7O/MjWlLsiEvBmpbdHRIHqUAS9PCe8IkwS8BkAz9+zaj
         ofXKscB/utGxvaGcm56qkL4yZUuTvE+JH827SzSlEKJTJbxtWWXbtcETz6PjMmg8gUSQ
         qGdzas3bkJeJR+DE/gBkYgcvmL5zQc6lpOeveBlRORqlxAnRrFfzonuo6PMlT1VpdLuJ
         ByNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362703; x=1689954703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC81hT2eRQBjkojJrQa9BM2dAGgpSMK2LXGRglIV5hw=;
        b=FHoHmsulMRWoMjuEzvPDjPmhPTRxjyGmwCg5KqLIm+ypKSEWuhMcHzR38YopJB41Ls
         44JZggY+gv9MosQICQylamJRP2X/P5eb6vyt5u0NqimSGpS6anqJV4x1PN295E/u+CnG
         asIsBgabYEBH6lM/kcMq83BjZWl2TLkkgLdmHzBuFlMN3kSaxQZfrgk8mOot/7XW9L38
         vip8Ai/2YRhZyz41i3d3hzGbzfiNovgg/Ke2ld/ZW2hM/BVQDUJn20tNYCDiN4UG1Swe
         fzqmyvnOusBf/9KmDXh5llQNVL0etoN6ERDezPSrMGUN70sr3pkhba3vxcX9i8HpqUtv
         t9Dg==
X-Gm-Message-State: AC+VfDw6k0gsasNIuOgp0nKahRc6+790oxwcHCvlG3O+POhwvVqYGWfd
        hcMsyNUBUh7YcvvCgFZhqek=
X-Google-Smtp-Source: ACHHUZ6mfiuUSKUL9T4FG0zO9eFCzfqn7gdQJ+UxFybrS+0IlVlSOIzIttkP0rZOt+iRNg6rGhm6KQ==
X-Received: by 2002:a5d:4bc1:0:b0:311:b8d:a63b with SMTP id l1-20020a5d4bc1000000b003110b8da63bmr11474994wrt.15.1687362702797;
        Wed, 21 Jun 2023 08:51:42 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d4441000000b00311d8c2561bsm4795824wrr.60.2023.06.21.08.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:51:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 3/3] spi: sun6i: Use the new helper to derive the xfer timeout
 value
Date:   Wed, 21 Jun 2023 17:51:40 +0200
Message-ID: <5683683.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20230619155349.3118420-4-miquel.raynal@bootlin.com>
References: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
 <20230619155349.3118420-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dne ponedeljek, 19. junij 2023 ob 17:53:49 CEST je Miquel Raynal napisal(a):
> A helper was recently added to the core to factorize common code between
> drivers, like the amount of time a driver should wait for a transfer to
> happen.
> 
> It is of course possible to use a default value (like eg. 1s) but it is
> way stronger to adapt this amount of time to the transfer. Indeed, long
> transfers (eg. 4MiB) on a slow single-spi bus might take more than the
> usual second of timeout and prevent lengthy transfers.
> 
> The core helper was heavily inspired by the logic applied in this
> driver, the only difference being the minimum amount of time which was
> enlarged from 0.1s to 0.5s.
> 
> Use this helper instead of open-coding it.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/spi/spi-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 23ad052528db..180094dfae19 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -422,7 +422,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
>  	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
>  
> -	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
> +	tx_time = spi_controller_xfer_timeout(master, tfr);
>  	start = jiffies;
>  	timeout = wait_for_completion_timeout(&sspi->done,
>  					      msecs_to_jiffies(tx_time));
> 




