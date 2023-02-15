Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53370697F78
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBOPYc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 10:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBOPYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 10:24:32 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA68684
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 07:24:31 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-15f97c478a8so23249539fac.13
        for <linux-spi@vger.kernel.org>; Wed, 15 Feb 2023 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TadElbv/yECNyRvG0Pa2vpl29upi4rkpMkJRcewsa7k=;
        b=suGbtRbva9mfsiS7LLNx13Qf0OsA9bc4rRjOkogLlK5PHAndCm/2000O593bVAfNf/
         xhOdda5c+ELAQMSxZTkfuSXJNR2+nRui+95nMQBWRQsz1Pi8XjPRsay1cW7L3ddi0x6N
         nfVr7EjSjgyyL/DdR2HlYEqRWaUGwit3MSkgYIDgXgBf+rb9zYfU5mBxMIVANBS/HjGT
         i9WzCuXmnCEJCv07wvufZUhXrFMu7OUSH9tWTM8KU+ykyrVa8OpBfXEjbEThDtys6Y87
         cli2MqN2J6bAscc++INea8g3hkk2xNtczFkn54zsnIZLswfmJiDuOSOc5QQn9f9Zigqw
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TadElbv/yECNyRvG0Pa2vpl29upi4rkpMkJRcewsa7k=;
        b=u/ZrJ0kuszGIcTDvgO0WK5uoqvZcEYd5Otqz3kGjFZHEthO4cdECfZ8ByxlcdDvPC0
         I49TYCFctTOTZmrv71n996HqOtdG1dP96Cgd8RnAIxVbetIEg5mQW/uth/wDXHDZ7tTM
         jt16tZYTENCOIYJjqAfzLcHSBx3BJOYfBhlbvD5pkSM8csoSknCvPvrgjbyxRsqBsIQ+
         0pIBkwki4LW3s84RCLk7i4PKtzQqAnvpSkFgMlGEkkUmEKrCFw9k45E1qIOlYMXmC3zj
         d2GBOdZ8keX7NqETnmt4k32HoVP3BMMYkBaDeFbDMtZgMKHUFU9BdsD3qxw61i5umKlz
         Hllg==
X-Gm-Message-State: AO0yUKWx0mBlGGiDjC5BKP/D4YMcKF924fHV+4fnfOBXfQPLTgpLKkQh
        ECdwhkGwk3WDHB46y9brnJ7CsJ+c9cz321mfDAsHnQ==
X-Google-Smtp-Source: AK7set89dOBFzBa3roM7yTkRgWk8K9U1srlYYE4cn1E4jBK5Jx6T2MYTeWX22QqOnM8AabgZmdbBdRcqAPmxGXlBDHI=
X-Received: by 2002:a05:6871:9a:b0:16e:44ad:c9fb with SMTP id
 u26-20020a056871009a00b0016e44adc9fbmr362093oaa.82.1676474670678; Wed, 15 Feb
 2023 07:24:30 -0800 (PST)
MIME-Version: 1.0
References: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c2040bf3cfa201fd8890cfab14fa5a701ffeca14.1676466072.git.christophe.jaillet@wanadoo.fr>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Wed, 15 Feb 2023 09:24:19 -0600
Message-ID: <CAJe_Zhf9E49MkySeqoSFsuy7=j8vmjngda60GEUzTTSNMjj0LA@mail.gmail.com>
Subject: Re: [PATCH] spi: synquacer: Fix timeout handling in synquacer_spi_transfer_one()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Feb 2023 at 07:01, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> wait_for_completion_timeout() never returns a <0 value. It returns either
> on timeout or a positive value (at least 1, or number of jiffies left
> till timeout)
>
> So, fix the error handling path and return -ETIMEDOUT should a timeout
> occur.
>
> Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/spi/spi-synquacer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> index 47cbe73137c2..dc188f9202c9 100644
> --- a/drivers/spi/spi-synquacer.c
> +++ b/drivers/spi/spi-synquacer.c
> @@ -472,10 +472,9 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
>                 read_fifo(sspi);
>         }
>
> -       if (status < 0) {
> -               dev_err(sspi->dev, "failed to transfer. status: 0x%x\n",
> -                       status);
> -               return status;
> +       if (status == 0) {
> +               dev_err(sspi->dev, "failed to transfer. Timeout.\n");
> +               return -ETIMEDOUT;
>         }
>
>         return 0;
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

thanks
