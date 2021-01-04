Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885202E90D4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbhADHTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbhADHTy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:19:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDBC061793
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:19:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lj6so9542187pjb.0
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vXX8xe2A/FeRiUPzOKt0JcPzE3KP7HXla4w8NsLDWnc=;
        b=YuGFCAwzc6s0ZWTmT9gJ9dm8xm/iUjFtuUFJRPZZY/029s2KACTxdL3ZqUZrKeogJd
         Ck/BTqRIjMB5kEpsoEnDNSlIu8hBVdh25KA2kWlSOtZFYtONWP6o3CVkb5qpfF4QvDQs
         2KANTHMNVLyC/f2JaJ5cZrDJAWRoXsbRxpH9aBuvbWlZ29OSySy90D7abge4FuootsRW
         WO3nv55h3wwq+1JvIQSL/NTB6Pq5v++NLIQBDpBwCAxWyT9uh0p0tan5aq359RYmBvW9
         H4ZJZnDoyu8st82avvR/1WjDPqeisur7dfMRBYvklu+jNS3TNFshPHX/wRWrZGdhzEtL
         hdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXX8xe2A/FeRiUPzOKt0JcPzE3KP7HXla4w8NsLDWnc=;
        b=YIInjxSHiRcBGVBwiexXkE+oNnF3pdnyaouAJDS7H9lAybzh+nSfXm8rVp7j6sbc2P
         Cll0P5X1yczVfx30DR8nead2KKhv31+gYmJ2Cni9rwpSkmMogTOoaROHNWQwrThUlwTd
         vcjj6sSR2liC+ZF1plRShwjM4GSaf9PikhJixKh5a+bUCAa2rahK8LJJ+fyBJdKKKDVU
         NZPpbzAb8KdP2E5RVLFK0Gg/7ZhE756CrB8YIb3tjhp6ylbSWcm1Tim8oq5zWW2ZmD7o
         i51xFlVcPNgslpx9fG/SWkc6CbOYL18IwRhN+bcRIV60HkgLqiTgNk7Puz423TQTBcqg
         8qyA==
X-Gm-Message-State: AOAM533YO57FC16fAJbJ+JT0wv8KEFCjzosYrPmpLhHNpZk9WZhJQPrr
        GrJuN1DJcrDGG6Lx+mTb5U5DDA==
X-Google-Smtp-Source: ABdhPJwvlRfdZmhb4sgIhlIMCp7GSIzc4CGLSDAZCiWizmME24cJXa5sePE9JLIPSO8GE4a2CzO61w==
X-Received: by 2002:a17:902:9f88:b029:dc:292d:37c5 with SMTP id g8-20020a1709029f88b02900dc292d37c5mr46034848plq.26.1609744753253;
        Sun, 03 Jan 2021 23:19:13 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id h12sm45986820pgk.70.2021.01.03.23.19.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:19:12 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:49:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, groeck@chromium.org, varar@codeaurora.org,
        mka@chromium.org, harigovi@codeaurora.org,
        rikard.falkeborn@gmail.com, natechancellor@gmail.com,
        georgi.djakov@linaro.org, akashast@codeaurora.org,
        parashar@codeaurora.org, dianders@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 07/31] serial: qcom_geni_serial: convert to use
 devm_pm_opp_* API
Message-ID: <20210104071910.2a2otwxyniu7c22z@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-8-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-8-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code, and we don't need
> to make opp_table glabal.
> 
> Let's remove opp_table from geni_se later.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 5aada7ebae35..36a92df8ec11 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1352,6 +1352,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	int irq;
>  	bool console = false;
>  	struct uart_driver *drv;
> +	struct opp_table *opp_table;
>  
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
>  		console = true;
> @@ -1433,13 +1434,13 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
>  		port->cts_rts_swap = true;
>  
> -	port->se.opp_table = dev_pm_opp_set_clkname(&pdev->dev, "se");
> -	if (IS_ERR(port->se.opp_table))
> -		return PTR_ERR(port->se.opp_table);
> +	opp_table = devm_pm_opp_set_clkname(&pdev->dev, "se");
> +	if (IS_ERR(opp_table))
> +		return PTR_ERR(opp_table);
>  	/* OPP table is optional */
> -	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	ret = devm_pm_opp_of_add_table(&pdev->dev);
>  	if (ret) {
> -		dev_pm_opp_put_clkname(port->se.opp_table);
> +		devm_pm_opp_put_clkname(&pdev->dev, opp_table);

We shouldn't be doing this here, i.e. put_clkname. Even when the OPP
table isn't present, this driver calls dev_pm_opp_set_rate() which
behaves like clk_set_rate() in this case and so the clk name is still
required by the OPP core.

>  		if (ret != -ENODEV) {
>  			dev_err(&pdev->dev, "invalid OPP table in device tree\n");
>  			return ret;
> @@ -1453,7 +1454,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  
>  	ret = uart_add_one_port(drv, uport);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
> @@ -1461,7 +1462,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
>  		uart_remove_one_port(drv, uport);
> -		goto err;
> +		return ret;
>  	}
>  
>  	/*
> @@ -1478,15 +1479,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  		if (ret) {
>  			device_init_wakeup(&pdev->dev, false);
>  			uart_remove_one_port(drv, uport);
> -			goto err;
> +			return ret;
>  		}
>  	}
>  
>  	return 0;
> -err:
> -	dev_pm_opp_of_remove_table(&pdev->dev);
> -	dev_pm_opp_put_clkname(port->se.opp_table);
> -	return ret;
>  }
>  
>  static int qcom_geni_serial_remove(struct platform_device *pdev)
> @@ -1494,8 +1491,6 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>  	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
>  	struct uart_driver *drv = port->private_data.drv;
>  
> -	dev_pm_opp_of_remove_table(&pdev->dev);
> -	dev_pm_opp_put_clkname(port->se.opp_table);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
>  	uart_remove_one_port(drv, &port->uport);
> -- 
> 2.25.1

-- 
viresh
