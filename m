Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C05161F2B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 04:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRDEG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 22:04:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43218 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgBRDEG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Feb 2020 22:04:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so9880957pfh.10
        for <linux-spi@vger.kernel.org>; Mon, 17 Feb 2020 19:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nal0vSzhjUSXQw3+qOaARWHAXZZO2AG5fTqWso3rl90=;
        b=rqM9lTbWSK9RFXvsnXFktoJg33+bNVjzY48a7L97Xs3MMA9r7tjsSNF6bUPtXYgt+B
         CKV/AxGQBAXG2LXYcc0uqXhMGV2MGB8B/9Rf2R9sFLneI7/DQgHZ0i8mRabQbSEwG7n7
         2S3WhLg+oYRcA3lONEvY7P0UfLWAwrlq73hWe12O7aGx13kOvV1/XBimMwL3+1D/QzPY
         0aidEeMR5dA83cEi39H2tVZAS29/EENQUKIdMYSCz5QVY+PHuR3UH0HQGeNEL7K3WYpP
         YviElr5VQ2xssxGHZrfBMXqgCcFGSwlmpqnW2ENjNH84GNWbhCsuiNfSxL8zlATJCMjN
         BOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nal0vSzhjUSXQw3+qOaARWHAXZZO2AG5fTqWso3rl90=;
        b=dS0W5/QUnJcxzk18kRqSSXWk8vnk7RCpN1jChEo/B5HiUhmtXEeApN69VEVyrwNbNH
         snwCc+ZbHgAW6mJtuY4vqlj/UQ2C5P5bedBYt1grQz92pajoI4i3KZ/kLUJBquMQ80Tq
         l2k2o0eGS/js3yP5aWD25STBK4QDEd5QVfqf22tnNH1tR0ATtciQZ36e6qJldymcIbxx
         l/W1+f+GMLvc/gRbZnfyKiyYgALRj+y5g8ks2zgRmn7PcU3Ek3nFqvBGp0DIm6G4bxEQ
         EbOS/gkuWYA6UK58OmxAwrA8vbqc9WSjcTZ1nFHYdlc+b3Cl/+VqUHuR7RI4p28R/OuP
         0eRw==
X-Gm-Message-State: APjAAAVn4JpWjl7O/xV0i97jf1bYgH2/P4L9CVJunVu81jKiZu7ZE67w
        xt02tznGpCbZ7VXCmwwWJd0X9g==
X-Google-Smtp-Source: APXvYqzs4TcpmPL75g6Tz+Iv5FmPwMFXlHkNOa2hgrWXMyxEyi4CmkdcaWQDyM+DbzzxqPiDO9dtqQ==
X-Received: by 2002:a63:ba03:: with SMTP id k3mr21562028pgf.52.1581995045220;
        Mon, 17 Feb 2020 19:04:05 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h3sm792028pjs.0.2020.02.17.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:04:04 -0800 (PST)
Date:   Mon, 17 Feb 2020 19:03:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH 1/6] soc: qcom: geni: Support for ICC voting
Message-ID: <20200218030310.GV955802@ripper>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon 17 Feb 05:30 PST 2020, Akash Asthana wrote:

> Add necessary enums, macros and structure variables to support ICC BW
> voting from individual SE drivers.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  include/linux/qcom-geni-se.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index dd46494..b0adbfb 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -6,6 +6,8 @@
>  #ifndef _LINUX_QCOM_GENI_SE
>  #define _LINUX_QCOM_GENI_SE
>  
> +#include <linux/interconnect.h>
> +
>  /* Transfer mode supported by GENI Serial Engines */
>  enum geni_se_xfer_mode {
>  	GENI_SE_INVALID,
> @@ -22,6 +24,13 @@ enum geni_se_protocol_type {
>  	GENI_SE_I3C,
>  };
>  
> +/* Interconnect paths for GENI */
> +enum geni_se_icc_path {
> +	GENI_TO_CORE,
> +	CPU_TO_GENI,
> +	GENI_TO_DDR
> +};
> +
>  struct geni_wrapper;
>  struct clk;
>  
> @@ -33,6 +42,13 @@ struct clk;
>   * @clk:		Handle to the core serial engine clock
>   * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
> + * @icc_path:		Array of interconnect path handles
> + * @avg_bw_core:	Average bus bandwidth value for QUP core 2x clock
> + * @peak_bw_core:	Peak bus bandwidth value for QUP core 2x clock
> + * @avg_bw_cpu:		Average bus bandwidth value for CPU
> + * @peak_bw_cpu:	Peak bus bandwidth value for CPU
> + * @avg_bw_ddr:		Average bus bandwidth value for DDR
> + * @peak_bw_ddr:	Peak bus bandwidth value for DDR
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -41,6 +57,13 @@ struct geni_se {
>  	struct clk *clk;
>  	unsigned int num_clk_levels;
>  	unsigned long *clk_perf_tbl;
> +	struct icc_path *icc_path[3];

In all cases you refer to icc_path[IDENIFIER], so just give the three
paths individual members and drop the enum above.

Reards,
Bjorn

> +	unsigned int avg_bw_core;
> +	unsigned int peak_bw_core;
> +	unsigned int avg_bw_cpu;
> +	unsigned int peak_bw_cpu;
> +	unsigned int avg_bw_ddr;
> +	unsigned int peak_bw_ddr;
>  };
>  
>  /* Common SE registers */
> @@ -229,6 +252,14 @@ struct geni_se {
>  #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
>  #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
>  
> +/* Core 2X clock frequency to BCM threshold mapping */
> +#define CORE_2X_19_2_MHZ		960
> +#define CORE_2X_50_MHZ			2500
> +#define CORE_2X_100_MHZ			5000
> +#define CORE_2X_150_MHZ			7500
> +#define CORE_2X_200_MHZ			10000
> +#define CORE_2X_236_MHZ			16383
> +
>  #if IS_ENABLED(CONFIG_QCOM_GENI_SE)
>  
>  u32 geni_se_get_qup_hw_version(struct geni_se *se);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
