Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A192F1521B1
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBDVIK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 16:08:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43899 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVIK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 16:08:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id 7so12401267vsr.10
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NE9H4AjLU7qeu0mbmE//LIZqJwhQlWyPoAREOrQ5X8U=;
        b=P8+X/m92d/POWNkLsBIXlnVJT3dn0x9yNui8PIaNGXM+CoMBQXQPWGXteEZTY+ifc4
         ML3OR3zOQ6lT2Llny1GxwbTra+sPe66wTkGALKhQNs+nubwkebpQ2Puq96/KDFzvP4hm
         MwcYrKWgiq5MeuwjTV4klynvFSrSth4JsgO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NE9H4AjLU7qeu0mbmE//LIZqJwhQlWyPoAREOrQ5X8U=;
        b=o5U2Pe+F316HxD6xFZRTQVU4bn+F10zljUU9+fwLctODI+mVh4fB4gC0W8Y+fQktR6
         3/prmRQJkqNh8+Sg/RYM+zuCOvnaxA4+uL/39LP479jTbZDO6TcpqLLzSY6LYAtGSwGb
         hYZ0F6M5WMdoRZ79p9fdiEsPg4y39ZPMw0vizOZjrgBLdI8Jh7S7QYAb8PI2w1kPuyWj
         5EQjCCtS6Xhs+CI6dFHhvOBsU0BML5nrcJzSLgkO5y9rH1QqyobDQuodkne/bZq9Qeqn
         9hl2nnZct0K3TB28K+5FcljdhnLOe6evSf00nKTnL9X6aPmEfrlWRLxfx0XvryL49vdK
         +yCA==
X-Gm-Message-State: APjAAAXD2+2nMW9wkkFtDcC6p9cNsH6w3X401VNEeT6lzRANv26UybrG
        Z3sX8HZKbgEmmJaIaNjcSpNSfStzBj8=
X-Google-Smtp-Source: APXvYqwxqmYdrpnepPIKEhYxGzwXU0D/5Tld+4/3FhFAMj3a3tIGkFCSeYXhG1kpFBFMFmHZH5tYxA==
X-Received: by 2002:a05:6102:675:: with SMTP id z21mr19093225vsf.46.1580850489473;
        Tue, 04 Feb 2020 13:08:09 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id s123sm6843015vss.12.2020.02.04.13.08.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:08:08 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id v141so12380120vsv.12
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:08:08 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr21015690vsd.106.1580850488353;
 Tue, 04 Feb 2020 13:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-3-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:07:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com>
Message-ID: <CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Grow a dev pointer to simplify code
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some lines are long here. Use a struct dev pointer to shorten lines and
> simplify code. The clk_get() call can fail because of EPROBE_DEFER
> problems too, so just remove the error print message because it isn't
> useful.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 46e501fc87f3..f0ca7f5ae714 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>         struct spi_geni_master *mas;
>         void __iomem *base;
>         struct clk *clk;
> +       struct device *dev = &pdev->dev;
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
> @@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> -       clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
> -                                               PTR_ERR(clk));
> +       clk = devm_clk_get(dev, "se");
> +       if (IS_ERR(clk))

There could be other errors besides -EPROBE_DEFER and devm_clk_get()
won't have printed in all cases.  ...but I agree that it seems highly
unlikely we'd ever hit any of those but highly likely we _would_ print
out a needless shout about -EPROBE_DEFER, so this is fine:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
