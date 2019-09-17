Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336F3B4A4A
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfIQJX3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 05:23:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35817 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIQJX2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 05:23:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so2313418lfl.2
        for <linux-spi@vger.kernel.org>; Tue, 17 Sep 2019 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuVy/dTL0zVi8KB992cYfUvwyuZX5WJTHthmI6rNOT0=;
        b=Bg7owd06h9hLmdCxdxpcsTn4LUAfPv+Fcad1/azM2mPLlkqQ4BA424Bz+zbIl7/0Hs
         eKql7oCqUtjwx6PXZjoG/nwv5HrreuTAcvZ22zX5/ZSYJ3TM5Rinqf7M8W82SSWcvMWg
         YSLh9gDvs6Mqwvm5x9/8dVcbnvYrMQ/KeSV3CfLkQVfLHExiI3Dhk7e7l6N5u2Lz2//t
         7q9JTi9j2t3cIjkWN+E3eFFZgLeB1Z94tulowjh6MTjXFfEIUDCNsqWeDKB8Or4vFAv2
         0dohKXmgO1WZpJVIDpYo839ISYtq/0s54FIlTR+binuYt/vRVT5HXVG0FRBUr7DAK/JI
         IASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuVy/dTL0zVi8KB992cYfUvwyuZX5WJTHthmI6rNOT0=;
        b=H/xT+c7YeczeqV8FMpa8/b6hJaZNq7lipT3WWvZNiTTsZVX9+RIGr7JCWcd5OP1jQf
         BtHHOEfi6uZkvJMe5GKWGGXYCU7NY8+DvFo4haprmNJ1fGluYT1Ie5Kadt9bTfWeCyr5
         1SWA+0o6i215w9xT7j4asCZBSoRLvNTWBwUP4MzCxVucWXaGf46Pg+C8cpsDw79xqUf8
         EPCQMsaCs18NcrjF3PGFolmbTb6foFDyE3hYTqxOEjpqhZ9xMWiLJi97gquLBkSplGtc
         ok//3kpRom0uz7q5BuY/0kzqn1BC5hrg9kwo22K+CjVUGBDO0J0VKKJob+mj1klo2dsD
         voOQ==
X-Gm-Message-State: APjAAAUhTAfaoaLLXUka67+0EXAeTUDgamm8Er6SxSamWFV4IesPBZqB
        Jkz1AUda3eJnGMidTQJa5Ayzi1989VMmNRYFYp9HEQ==
X-Google-Smtp-Source: APXvYqyM4ltTpXf24i1Q7+nxADNrEfPqDVLlQFkkrDB0olL8Fa3A6yeao2uouudfGkdBTJevKJ2kRjPEu3NmeskBU6c=
X-Received: by 2002:a19:3f47:: with SMTP id m68mr1524926lfa.108.1568712205010;
 Tue, 17 Sep 2019 02:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190917085627.4562-1-mail@aurabindo.in>
In-Reply-To: <20190917085627.4562-1-mail@aurabindo.in>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 17 Sep 2019 17:23:13 +0800
Message-ID: <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Mark Brown <broonie@kernel.org>, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan <mail@aurabindo.in> wrote:
>
> platform_get_resource() may return NULL. If it is so, return -ENXIO
>
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> ---
>  drivers/spi/spi-sifive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 93ec2c6cdbfd..67485067a694 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, master);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "no IOMEM resource found\n");
> +               ret = -ENXIO;
> +               goto put_master;
> +       }

Seems unnecessary, the devm_ioremap_resource() already validated if
the resource is available.

-- 
Baolin Wang
Best Regards
