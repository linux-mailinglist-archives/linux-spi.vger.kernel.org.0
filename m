Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171573C967
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2019 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbfFKKyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jun 2019 06:54:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfFKKyg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jun 2019 06:54:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so1318918pfl.3
        for <linux-spi@vger.kernel.org>; Tue, 11 Jun 2019 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvQb/Ypyh9gRJDotT8x3V0sz3ecSdE5KFnzXB7OO8I8=;
        b=JV9Xb4IMUkhC6FXUs6jMr31zgd5bbZUP53i9LQXtxqqKDsyOstCFNthzz9ysHVltrG
         LQPzsJTYpuYoEjJUqF27NWTUxY00GzCfMVw2AwdBa/l+uVsVwIIfUvY/Na/9hqRyC4hm
         qA8IVyqs6a3XSSW7Mbzi0CcMh3MoLKRWZYJ/M6fAEOrHH3ZNmuDxJz+TI/1yAMW9n4tL
         g/utQBXLMp0f+tyzFpzt4ZdUlGRG6eDxQZo5tUvxsgYparDAbG+sfgL5NAnQWDFtiptC
         +hcShtjhUExJXJrKOnj0jx3m/sCaDSZxE7ayO+ffbwGhcKmSTG2S7S3CsidSQ3kx0fQA
         CJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvQb/Ypyh9gRJDotT8x3V0sz3ecSdE5KFnzXB7OO8I8=;
        b=o7mtaDtOgb/zZePkMKiqzRKGr9f7u5/JhgaZWoXy18iArN5/5/fOqS0GB6RHv06Ti8
         93uUjMWUN8SfSZ9j29Sugd/y4Vw5c5bd4mZnqraY5hQ6KqPqIReepPRDAdPGCB6+nsjx
         tfIga5JoQVucjhy1SFNH1afM/S3HCyVyFHteH9wlL4MppiQvUJS3a12h8FeK7xn4t7MD
         riiMU1oWhRpkYrXMh00Xfx9vF3ErxRFH0062F88aOVnHtiUKO/34wTXpUmSQ8fDCU5ga
         7g2ryhW/9SmZhr3v1XpQpjUF0xiV9+rQRCC92z4HV6mf9HBiGpV0l4n5n2FSulR/O52o
         KxXw==
X-Gm-Message-State: APjAAAXD21VleBiG3ETqK9/L5t0VsEEIXiY2EMo+1PahEL4SR2xOZHjf
        VsDFYqXookuGJoX0qujF0eL7Dg==
X-Google-Smtp-Source: APXvYqzpXvOcmG+jSmbuKUuB+pvnFdrAODCioPv9t90lRkGIWZkV0igtmbVR7Z0PzCmHelNYhJaqfA==
X-Received: by 2002:a62:bd11:: with SMTP id a17mr5606101pff.126.1560250476041;
        Tue, 11 Jun 2019 03:54:36 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j72sm2231266pje.12.2019.06.11.03.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:54:34 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:24:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Doing this allows us to call this API with any rate requested and have
> it not need to match in the OPP table. Instead, we'll round the rate up
> to the nearest OPP that we see so that we can get the voltage or level
> that's required for that OPP. This supports users of OPP that want to
> specify the 'fmax' tables of a device instead of every single frequency
> that they need. And for devices that required the exact frequency, we
> can rely on the clk framework to round the rate to the nearest supported
> frequency instead of the OPP framework to do so.
> 
> Note that this may affect drivers that don't want the clk framework to
> do rounding, but instead want the OPP table to do the rounding for them.
> Do we have that case? Should we add some flag to the OPP table to
> indicate this and then not have that flag set when there isn't an OPP
> table for the device and also introduce a property like 'opp-use-clk' to
> tell the table that it should use the clk APIs to round rates instead of
> OPP?
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0420f7e8ad5b..bc9a7762dd4c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -703,7 +703,7 @@ static int _set_required_opps(struct device *dev,
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>  	struct opp_table *opp_table;
> -	unsigned long freq, old_freq;
> +	unsigned long freq, opp_freq, old_freq, old_opp_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
>  	int ret;
> @@ -742,13 +742,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		goto put_opp_table;
>  	}
>  
> -	old_opp = _find_freq_ceil(opp_table, &old_freq);
> +	old_opp_freq = old_freq;
> +	old_opp = _find_freq_ceil(opp_table, &old_opp_freq);
>  	if (IS_ERR(old_opp)) {
>  		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
>  			__func__, old_freq, PTR_ERR(old_opp));
>  	}
>  
> -	opp = _find_freq_ceil(opp_table, &freq);
> +	opp_freq = freq;
> +	opp = _find_freq_ceil(opp_table, &opp_freq);
>  	if (IS_ERR(opp)) {
>  		ret = PTR_ERR(opp);
>  		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",

I see a logical problem with this patch.

Suppose the clock driver supports following frequencies: 500M, 800M,
1G, 1.2G and the OPP table contains following list: 500M, 1G, 1.2G
(i.e. missing 800M).

Now 800M should never get programmed as it isn't part of the OPP
table. But if you pass 600M to opp-set-rate, then it will end up
selecting 800M as clock driver will round up to the closest value.

Even if no one is doing this right now, it is a sensible usecase,
specially during testing of patches and I don't think we should avoid
it.

What exactly is the use case for which we need this patch ? What kind
of driver ? Some detail can be helpful to find another solution that
fixes this problem.

-- 
viresh
