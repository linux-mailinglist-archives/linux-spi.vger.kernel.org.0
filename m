Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958FB1DD298
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 18:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgEUQAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgEUQAO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 12:00:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C2C08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 21 May 2020 09:00:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so2556645pfn.3
        for <linux-spi@vger.kernel.org>; Thu, 21 May 2020 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jHirFrfUhrscDiyY19yFy1eojdIlJFYNDT0L5VP6NdE=;
        b=iyB4ngXROy5qTSwcL5Cvl5LAnn2U16sn3BZvQyGAClC2S6/xy2nQLtKiG2/8kwRklF
         WNVdSOimsudJuNLU7K5eiIGS5eRF8urxcHf9Ijf9Y2FlUwywDIWA9biynBY3D08eqBC4
         kFPQ845JNwI3HI41jDcvAJEOoi1G3+mRda/sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHirFrfUhrscDiyY19yFy1eojdIlJFYNDT0L5VP6NdE=;
        b=QL/SEGP6Nqneve8asm58kLIQYhAhud1aUYrbDwZXYbVWzI7J3j/AVwBkW0NyZ68Os9
         gjbYhy6SGevZbit0gL6s8xpANT7ROYcR+bYDsebSbfWOqukl+YCleHeJPJFR9Eqrmmyb
         sodzGyAApDVF6Y7GxzAXObC/sdi0a5HIm26Oi08tXe5dkf6nyBDZZEtUTvJzvQ9MOnxP
         KLsIwBMQyATIIxBaB+TehaAFpvNDJmPxdABCXVC0CjAMzDIT+yWOgc0Y0y68l+qkPZqe
         UvtSvWK8EaKMFSBHg7EihaQ3E+q9Y8JH58B51UrnMh/eCaTnzY0V4Lmg+tJchSiH6Jvp
         ypNg==
X-Gm-Message-State: AOAM5317+E2woZwyV8vQVCGZbwnhHYXFuYDNt00IEnfLZ/Q2QmDGM2ks
        dVCradxybKQeyuZ/cYxXp5Y7AA==
X-Google-Smtp-Source: ABdhPJyeSnrDAQNZVdUzm0V1yaYpL16GQlLMa/0trXnLiqwcmnp6adE8lFYQRNmL1AUSQvEq0E9O+Q==
X-Received: by 2002:a62:b402:: with SMTP id h2mr10334883pfn.221.1590076813529;
        Thu, 21 May 2020 09:00:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w12sm3948439pjn.21.2020.05.21.09.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 09:00:12 -0700 (PDT)
Date:   Thu, 21 May 2020 09:00:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        msavaliy@codeaurora.org, evgreen@chromium.org
Subject: Re: [PATCH V6 2/7] soc: qcom-geni-se: Add interconnect support to
 fix earlycon crash
Message-ID: <20200521160010.GB4525@google.com>
References: <1590049764-20912-1-git-send-email-akashast@codeaurora.org>
 <1590049764-20912-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590049764-20912-3-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Akash,

On Thu, May 21, 2020 at 01:59:19PM +0530, Akash Asthana wrote:
> QUP core clock is shared among all the SE drivers present on particular
> QUP wrapper, the system will reset(unclocked access) if earlycon used after
> QUP core clock is put to 0 from other SE drivers before real console comes
> up.
> 
> As earlycon can't vote for it's QUP core need, to fix this add ICC
> support to common/QUP wrapper driver and put vote for QUP core from
> probe on behalf of earlycon and remove vote during earlycon exit call.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Change in V3:
>  - Add geni_remove_earlycon_icc_vote API that will be used by earlycon
>    exit function to remove ICC vote for earlyconsole.
>  - Remove suspend/resume hook for geni-se driver as we are no longer
>    removing earlyconsole ICC vote from system suspend, we are removing
>    from earlycon exit.
> 
> Change in V4:
>  - As per Matthias comment make 'earlycon_wrapper' as static structure.
> 
> Changes in V5:
>  - Vote for core path only after checking whether "qcom_geni" earlycon is
>    actually present or not by traversing over structure "console_drivers".
> 
> Changes in V6:
>  - As per Matthias's comment removed NULL check for console_drivers global
>    struct, added NULL check for earlycon_wrapper in _remove_earlycon_icc_vote
>    API
>  - Addressed nitpicks from Andy.
> 
>  drivers/soc/qcom/qcom-geni-se.c       | 68 +++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/qcom_geni_serial.c |  7 ++++
>  include/linux/qcom-geni-se.h          |  2 ++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 0b2526d..ac16bb1 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/clk.h>
> +#include <linux/console.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> @@ -90,11 +91,14 @@ struct geni_wrapper {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +	struct geni_icc_path to_core;
>  };
>  
>  static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  						"qup-memory"};
>  
> +static struct geni_wrapper *earlycon_wrapper;
> +
>  #define QUP_HW_VER_REG			0x4
>  
>  /* Common SE registers */
> @@ -812,11 +816,38 @@ int geni_icc_disable(struct geni_se *se)
>  }
>  EXPORT_SYMBOL(geni_icc_disable);
>  
> +void geni_remove_earlycon_icc_vote(void)
> +{
> +	struct geni_wrapper *wrapper;
> +	struct device_node *parent;
> +	struct device_node *child;
> +
> +	if (!earlycon_wrapper)
> +		return;
> +
> +	wrapper = earlycon_wrapper;
> +	parent = of_get_next_parent(wrapper->dev->of_node);
> +	for_each_child_of_node(parent, child) {
> +		if (!of_device_is_compatible(child, "qcom,geni-se-qup"))
> +			continue;
> +		wrapper = platform_get_drvdata(of_find_device_by_node(child));
> +		icc_put(wrapper->to_core.path);
> +		wrapper->to_core.path = NULL;
> +
> +	}
> +	of_node_put(parent);
> +
> +	earlycon_wrapper = NULL;
> +}
> +EXPORT_SYMBOL(geni_remove_earlycon_icc_vote);
> +
>  static int geni_se_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	struct geni_wrapper *wrapper;
> +	struct console __maybe_unused *bcon;
> +	bool __maybe_unused has_earlycon = false;
>  	int ret;
>  
>  	wrapper = devm_kzalloc(dev, sizeof(*wrapper), GFP_KERNEL);
> @@ -839,6 +870,43 @@ static int geni_se_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +#ifdef CONFIG_SERIAL_EARLYCON
> +	for_each_console(bcon) {
> +		if (!strcmp(bcon->name, "qcom_geni")) {
> +			has_earlycon = true;
> +			break;
> +		}
> +	}
> +	if (!has_earlycon)
> +		goto exit;
> +
> +	wrapper->to_core.path = devm_of_icc_get(dev, "qup-core");
> +	if (IS_ERR(wrapper->to_core.path))
> +		return PTR_ERR(wrapper->to_core.path);
> +	/*
> +	 * Put minmal BW request on core clocks on behalf of early console.
> +	 * The vote will be removed earlycon exit function.
> +	 *
> +	 * Note: We are putting vote on each QUP wrapper instead only to which
> +	 * earlycon is connected because QUP core clock of different wrapper
> +	 * share same voltage domain. If core1 is put to 0, then core2 will
> +	 * also run at 0, if not voted. Default ICC vote will be removed ASA
> +	 * we touch any of the core clock.
> +	 * core1 = core2 = max(core1, core2)
> +	 */
> +	ret = icc_set_bw(wrapper->to_core.path, GENI_DEFAULT_BW,
> +				GENI_DEFAULT_BW);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: ICC BW voting failed for core :%d\n",

nit: " ... core: %d\n".

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
