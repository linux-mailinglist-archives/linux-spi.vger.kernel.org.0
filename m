Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879582C7E65
	for <lists+linux-spi@lfdr.de>; Mon, 30 Nov 2020 08:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgK3HGm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Nov 2020 02:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgK3HGl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Nov 2020 02:06:41 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31DC0613CF;
        Sun, 29 Nov 2020 23:06:01 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so16109046lja.5;
        Sun, 29 Nov 2020 23:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hX8EE+fwO5ncx9Wyn/IKPP6lbbN9olmyACQVP9w9+R0=;
        b=s+h/HEPmytv0YUAEP3/Cy13IYOaF1KIZtNH6Ki8/tE8sP+e25LlfzODnHGUFL16StG
         F//Gszt3/iDe9XF9J47yITjkblQ0UzqnpSlsoXFBcTYXswrx0UztesAcsKdQkyCP1Ury
         hy1gvmwg0fXt6WnyFo56ohVePIa0f5Yig+j/PBHoboFoTDMEFaXpInoDjaYQgJX7fsb5
         IdrSu5nAl9ktXv/XmoTa1a/G0EnE8ZB5klJG2wUtQnrUfs7aWcM34Nya85CQVBr2699s
         xjvu7zIOhzPWOixvX1T0WfWAT3IZf/nULSsH1XXoXuJ/2YBJ2Oo+WZJ2+CVgHk977Ooy
         wGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hX8EE+fwO5ncx9Wyn/IKPP6lbbN9olmyACQVP9w9+R0=;
        b=PDXy/QItrqvYcLdYueh+OQbzS8vO4Hrn92PZjM2tt+hwdgdin2WsR37l6xRQMFCFj4
         EEq8zlhNyGV07QDQK3lF0FXnc+Kmnl9ljXQ3UfT7PTJ5395a0xPpkGXc7Xjq7jrzG8Bs
         vnbddeZAC8VVYC1yT9tdEsXAlyy4arLFm2YJ0Yr3MdY+egvfUoYLl6yxBA84PJDQkF7d
         QJftOwvxmv99iGUZM6zs6btLqt8cD/j4ZMZx8yZSfWfOW6kiCwuYamL1TuCgB2qf/kAH
         fy1ffC4mXqrPHwotVW1TWiVvtyN1XArL1utkqTNfnxuMo8qqXmgJZz4L8j8dqMuhQwwt
         RBEA==
X-Gm-Message-State: AOAM530wZXUfDOHjY5PhIixruFTjvcN8dEWlRl0bLaGXeXMOgrwRk0Bd
        9ebZ1E5ygWuf8VcwSagwobg=
X-Google-Smtp-Source: ABdhPJwpmXB7o6Z4Ym5ypk3Mi8OCrf36Yx1xJuvgQg5txlW8MdH0WNEcyzBKd6e+8bYzGZt/BsfrlA==
X-Received: by 2002:a2e:9dcd:: with SMTP id x13mr9104253ljj.147.1606719959798;
        Sun, 29 Nov 2020 23:05:59 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id t6sm2232606lfc.231.2020.11.29.23.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:05:58 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:05:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "seanga2@gmail.com" <seanga2@gmail.com>
Subject: Re: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Message-ID: <20201130070556.pyxv4opwtimojmyw@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-21-damien.lemoal@wdc.com>
 <CACRpkdZhOxz5NhrkFxZ5G4aOrmBoAcQodOvqzNROQtXpHVQGDQ@mail.gmail.com>
 <CH2PR04MB65228DE061918A4D2A08A0CFE7FB0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CACRpkdbA_JMiyraKC_3WT26mMUxfuLD=Q_HREmbEB=yNPpuHjw@mail.gmail.com>
 <b92c455b1db0f1b4a82d8cea0fbdebb47609bf42.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92c455b1db0f1b4a82d8cea0fbdebb47609bf42.camel@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Damien,
Just a tiny nitpick below.

On Mon, Nov 30, 2020 at 03:13:45AM +0000, Damien Le Moal wrote:
> [...]
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 2a9046c0fb16..4a801e83919b 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -617,8 +617,10 @@ static int dwapb_get_reset(struct dwapb_gpio *gpio)
>  
>         gpio->rst = devm_reset_control_get_optional_shared(gpio->dev, NULL);

>         if (IS_ERR(gpio->rst)) {
> -               dev_err(gpio->dev, "Cannot get reset descriptor\n");
> -               return PTR_ERR(gpio->rst);
> +               err = PTR_ERR(gpio->rst);
> +               if (err != -EPROBE_DEFER)
> +                       dev_err(gpio->dev, "Cannot get reset descriptor\n");
> +               return err;
>         }

There is a dedicated method to generically handle the PROBE_DEFER
error returned by functions like get(resource): dev_err_probe().
So here you'd just need to do:

-	if (IS_ERR(gpio->rst)) {
-		dev_err(gpio->dev, "Cannot get reset descriptor\n");
-		return PTR_ERR(gpio->rst);
-	}
+	if (IS_ERR(gpio->rst))
+		return dev_err_probe(gpio->dev, PTR_ERR(gpio->rst),
+				     "Cannot get reset descriptor\n");

-Sergey

> 
> and all drivers can now use builtin_platform_driver() declaration with a clean
> boot log. If you are OK with the above patch, I will send it.
> 
> Thanks !
> 
> > 
> > Yours,
> > Linus Walleij
> 
> -- 
> Damien Le Moal
> Western Digital
