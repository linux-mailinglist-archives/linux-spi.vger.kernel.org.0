Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6C2F19B6
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbhAKPb7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbhAKPb6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 10:31:58 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71691C061794
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 07:31:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b24so60462otj.0
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0ntm2t5I/I58bNqFBYR9s8vSME+9oFSHFOgNzLSJkk=;
        b=bkjYqS4TxRHf9WHJd/jqSuyWxL70FdCUNm5YHaT1NJldgV+1+DRDsOE/rF9PIQsXO0
         QnS7YCswiew67X9qVxQttkoQ7Z4UaTKfbRTusHbxvChJJCq6lG/dnwA228z3tb23wqeE
         NzaU7mPjZmAOOOfgAF35MrJ/Z+GU3FKyVGIXbCEQ4lwhJeVcvan2OhyrI9uinNjzgKjQ
         iO33sU6ewXO5/KHCNUiYmUL5xsTjDYCDZJrE02EQOXVZis+hpyKgZNL/4hXBgB7IZ5wY
         apkuhhsZF8Q4+KOrh/QzIBoDf8ZKUf7l7PBFhpup+tIN7/hMsApmgee1cX49OkRqEh41
         KE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0ntm2t5I/I58bNqFBYR9s8vSME+9oFSHFOgNzLSJkk=;
        b=YgfpAnYYNOT/TvbQSoiSNahIp5aodgaitzp+0oPckVSlw0b0tNqvQzm/yiuDAf/GkR
         D/BDmpwpB9PjUy8ZBM3bMhqd9biCCi4QdYl8K9y5YYb8J79Xwllow2rihXkhElMOZIVx
         D3J5rjTkOVkVhVgZV4sKr0ewRmMgpbE8oRgnYMcz3dfxpZE2yLnN9H69pSz3kVuu51mK
         yQkfmiiSvqdATiGSK7OPMRdGszzOAFnvNzyvtZ4dDF3JoRrXjOZJjCYJolou80qd6Sc/
         UOBAed+NsRkyxIKlDlQ+JNMxwzwXmdX6jMRCDnGMIrOZXQ6PsM1ade9SwLV9JSiBRyqv
         1QiQ==
X-Gm-Message-State: AOAM53041YqrlX4Os4uvgDiLTtJRFB8DOsRSz3/BtPCLkF5YoN43oa6v
        E+Xi9D1DqlMy9lXT0n9ZUJhIFw==
X-Google-Smtp-Source: ABdhPJxAun/H9kOvpHpU39fZrdU4wkgEXkwXIJh6W1qnIBT830eXJ8FCj7sXKulUqqyNYY6lEuikoA==
X-Received: by 2002:a9d:4e87:: with SMTP id v7mr11055840otk.302.1610379077753;
        Mon, 11 Jan 2021 07:31:17 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f201sm13267oig.21.2021.01.11.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:31:17 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:31:15 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] soc: qcom: geni: move GENI_IF_DISABLE_RO to common
 header
Message-ID: <X/xvQ4BscVREG6yp@builder.lan>
References: <20210111151651.1616813-1-vkoul@kernel.org>
 <20210111151651.1616813-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111151651.1616813-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon 11 Jan 09:16 CST 2021, Vinod Koul wrote:

> GENI_IF_DISABLE_RO is used by geni spi driver as well to check the
> status if GENI, so move this to common header qcom-geni-se.h
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 1 -
>  include/linux/qcom-geni-se.h    | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index f42954e2c98e..285ed86c2bab 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -108,7 +108,6 @@ static struct geni_wrapper *earlycon_wrapper;
>  #define GENI_OUTPUT_CTRL		0x24
>  #define GENI_CGC_CTRL			0x28
>  #define GENI_CLK_CTRL_RO		0x60
> -#define GENI_IF_DISABLE_RO		0x64
>  #define GENI_FW_S_REVISION_RO		0x6c
>  #define SE_GENI_BYTE_GRAN		0x254
>  #define SE_GENI_TX_PACKING_CFG0		0x260
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index ec2ad4b0fe14..e3f4b16040d9 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -65,6 +65,7 @@ struct geni_se {
>  #define SE_GENI_STATUS			0x40
>  #define GENI_SER_M_CLK_CFG		0x48
>  #define GENI_SER_S_CLK_CFG		0x4c
> +#define GENI_IF_DISABLE_RO		0x64
>  #define GENI_FW_REVISION_RO		0x68
>  #define SE_GENI_CLK_SEL			0x7c
>  #define SE_GENI_DMA_MODE_EN		0x258
> -- 
> 2.26.2
> 
