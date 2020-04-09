Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66931A39BE
	for <lists+linux-spi@lfdr.de>; Thu,  9 Apr 2020 20:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDISU1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Apr 2020 14:20:27 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54583 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISUZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Apr 2020 14:20:25 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so1630213pjb.4
        for <linux-spi@vger.kernel.org>; Thu, 09 Apr 2020 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BeycGXQuoBVYG9ONaPHpfk62jXqpOs5+cJRriF7c/i8=;
        b=eiWw9hPGWIX/zUVRY9wkUwIv1FnbbBOrbahsPi5dTo5e/FwwwapcN5dyzIuiSgY9mp
         Ip1Ixj5snBlO6YG3cKudB8PLfCHgRRXnoRMswLYfbVE8jle0nx7NR5kBBGLjagEPSx9f
         koHAPmeN6wPc3hT3KTb+hLuL7RlUjRVgdH+Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BeycGXQuoBVYG9ONaPHpfk62jXqpOs5+cJRriF7c/i8=;
        b=AUNNk+CkRuga8OiQR73Njk4Xk5pXYJzmDhTSw3NynSFzW3XRczPWHzrpbkBNVA24mU
         3xHNXzCH8ujUJMvBRMtqafxkTwRyMWBnctkFtpsH6McX6jyMKglMvL8E7s/kNG0s8i8n
         biGYGs8iEmwqgXrzEl2OmR9ixnm1WMXa+qgEg6+7CIlILi38kikBd20MkQwcLQI13Vuj
         +nC7wSxtv4bT2p0t97PjxoZ4Sbr6lzjyWRmPv6axNoXWwj5UquxYNV8oNMd77lEFgBEi
         DLOd7mWmyk3NsjVACUTrcAq+MZpPrQDamJPy8CTbRwmF+i7Z4vuH2PvZW9IE1K76iIiW
         oXGw==
X-Gm-Message-State: AGi0PubY2vBN+xNR4WMVC7M3MI2s+Y5LTfLHhyNe6/UcUfwpYN6ALaNL
        WK7cobZ/WKpo8IbH2gSdSJJghQ==
X-Google-Smtp-Source: APiQypLNbNT42VEJbPyenbCADnqH7UTIDCwf3AhvZbUz4pn+NCvzf8moNTIgUtBVxtsTfY0oYZ7a9w==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr879240pji.23.1586456423630;
        Thu, 09 Apr 2020 11:20:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h13sm6213736pfr.1.2020.04.09.11.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:20:22 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:20:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 03/21] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200409182021.GT199755@google.com>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-4-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586353607-32222-4-git-send-email-rnayak@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rajendra,

On Wed, Apr 08, 2020 at 07:16:29PM +0530, Rajendra Nayak wrote:
> geni spi needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
>  drivers/spi/spi-geni-qcom.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c397242..ce387dc 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -7,6 +7,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spi/spi.h>
> @@ -95,7 +96,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  {
>  	unsigned long sclk_freq;
>  	unsigned int actual_hz;
> -	struct geni_se *se = &mas->se;
>  	int ret;
>  
>  	ret = geni_se_clk_freq_match(&mas->se,
> @@ -112,9 +112,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>  
>  	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
>  				actual_hz, sclk_freq, *clk_idx, *clk_div);
> -	ret = clk_set_rate(se->clk, sclk_freq);
> +	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
>  	if (ret)
> -		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
> +		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
>  	return ret;
>  }
>  
> @@ -553,6 +553,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	if (!spi)
>  		return -ENOMEM;
>  
> +
>  	platform_set_drvdata(pdev, spi);
>  	mas = spi_master_get_devdata(spi);
>  	mas->irq = irq;
> @@ -561,6 +562,8 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	mas->se.wrapper = dev_get_drvdata(dev->parent);
>  	mas->se.base = base;
>  	mas->se.clk = clk;
> +	mas->se.opp = dev_pm_opp_set_clkname(&pdev->dev, "se");

As commented on the serial patch, it seems an error check is needed
and the OPP table saved in 'struct geni_se' is never used.

> +	dev_pm_opp_of_add_table(&pdev->dev);

This function could also fail for multiple reasons, so the return value
should be checked.

From patch "[01/21] opp: Manage empty OPP tables with clk handle" it seems
ignoring errors is intended to be able to operate when no OPP table is
specified. But even with that you want to return in case of certain errors,
like an invalid OPP table, out of memory or -EPROBE_DEFER.
