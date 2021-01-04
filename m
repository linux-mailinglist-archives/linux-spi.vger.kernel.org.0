Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A22E90B3
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhADHDW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbhADHDV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:03:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B7C061796
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:02:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n3so4849517pjm.1
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dlLWZrIy6R69T+0RxdKISUof18f+oj7qL0+rpwclI9Q=;
        b=RWiath2GV29Ceq29YV4Eo/YDxoleBkI6KhvmDVrM13P6i6WvXBHLB3NL03EuF0d5Ig
         k3jN3V9R8TYaSIt0OajxpW6UaB9wqaf4kbP7YRvdeIkVNd/vE7mO5sxPJfWGQEcfV0TJ
         gZMIffKXxGkcLQZpqzBpYXnzYhYnVd/wNwl9DW3PspXwbZWlquvU8ndq1l6zzm/9Z2Ms
         jHlU/V+Cj9z2qjgPbAipggERD7vN+mLZJD88oCTUGrPBT9eVKuPbKuZBrtt01Y1UYPbg
         OtJCP+3nernL266el36h94jVbwk98vXd2vQnjhu4QVdYXhTe+6c+dYRx2+Up2YsN7xvd
         a9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dlLWZrIy6R69T+0RxdKISUof18f+oj7qL0+rpwclI9Q=;
        b=fuZe6xlRnwfBKXz1rX4tKZhdm7j3TQKXZ90HQRjlRBUqj9oCM7UnT2ffrmpsyXSApv
         K28Gnu+9j7QugUqSyl4Gf5AYRv9D6PQ9CAdxkGdifhhrxP2kmolszkPPHkAeg9/J1qmS
         VFlKy2/y7aHWcrc083LKAcyt/BiMUyriWwCZfR1gD+dsdnPLv78w/C4M0jEjOBLLlQBB
         Q9tmYkI5LPSlJr4/6PX0KD+JOn98oPPTzHrPWjhhNF6Kg7nUSe9HpRqqtY56bzOJnAeW
         1vnGGPB5gwgwag+/ML+StbvB2w4ANdHcq8YRyfMsJQpEKciuY3nk/rVuserR1ogS0YZv
         fIuA==
X-Gm-Message-State: AOAM531Ec57gDr3wewaJEoxfp1FdJN7j+3aFnIBBNrZuIMeYAf9h5Ztk
        corNIpx0kdSXioB1nA7d7PWWCg==
X-Google-Smtp-Source: ABdhPJxTIG1l0JLV+LUHEFjwB/9ntN9aIbvjRCJKn3vjHJRyQgMGHUy/WB5LS59Xy8aTKPshWnMfsA==
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr28643076pjb.196.1609743760002;
        Sun, 03 Jan 2021 23:02:40 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id n195sm55117950pfd.169.2021.01.03.23.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:02:38 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:32:36 +0530
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
Subject: Re: [PATCH 06/31] serial: qcom_geni_serial: fix potential mem leak
 in qcom_geni_serial_probe()
Message-ID: <20210104070236.mnnj3frjtxka7emu@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-7-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-7-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> We should use dev_pm_opp_put_clkname() to free opp table each time
> dev_pm_opp_of_add_table() got error.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 291649f02821..5aada7ebae35 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1438,9 +1438,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  		return PTR_ERR(port->se.opp_table);
>  	/* OPP table is optional */
>  	ret = dev_pm_opp_of_add_table(&pdev->dev);
> -	if (ret && ret != -ENODEV) {
> -		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> -		goto put_clkname;
> +	if (ret) {
> +		dev_pm_opp_put_clkname(port->se.opp_table);
> +		if (ret != -ENODEV) {
> +			dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +			return ret;
> +		}
>  	}
>  
>  	port->private_data.drv = drv;
> @@ -1482,7 +1485,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	return 0;
>  err:
>  	dev_pm_opp_of_remove_table(&pdev->dev);
> -put_clkname:
>  	dev_pm_opp_put_clkname(port->se.opp_table);
>  	return ret;
>  }

Since put_clkname is always done in remove(), I don't think there is
any memleak here. Over that with your patch we will do put_clkname
twice now, once in probe and once in remove. And that is a bug AFAICT.

-- 
viresh
