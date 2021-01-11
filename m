Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2774F2F19D2
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbhAKPfh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbhAKPfg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 10:35:36 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32694C061786
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 07:34:56 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s2so20528824oij.2
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TzWprvP0E5iilUODRGt6CKDwV/2kCYGt43hwkGEjZBk=;
        b=j18QL97ZdXcR/1Wial7AoWPFyJjXMopmtHu33rDETf1iyeWOD6oVQT9p4VCRatNVT1
         xUOvXW6F/iyqr66IJQ6MgnpXo6l4M+p0POEb2ukFRsSVA3jPg8hJzBOL0bI2u6QGi9Ig
         myarg/62h+TM2cWpKt/zt9AcNN3R+t8ssnjJAiBrEGeU61aVbjDeoA7JV0AusyvbpV0v
         EJqf2oJNhxj+Rmrng5A+uaCoOs4VkcEyt2fUTArKugC/HhcC2rpN1Ra4aVdNbmz2CobJ
         CfUlRS0ed4OoikQFKHMmA1Taldgx62rUup6ak93Y4L40X+WQtoKasiKo9sSZ3Tg8qCFW
         R3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TzWprvP0E5iilUODRGt6CKDwV/2kCYGt43hwkGEjZBk=;
        b=cXHeMJaYgcwlQPsZFClyo2ZY2YTlW+MqK58/rwjMoGMfbblh9VU0Hfc50+aCLwxcpy
         faxe0wOI2J6CN4ZMZjtMNDXvytk8jCfhsyaL6349q7QVVXL/Hun3Ll7Q/1Au/EmURkaA
         P3/kxaFUQ7AtZgomaTNUYXETFUylY1SWBfUl6tHiIVDcJnNh7B9AHzfGlHNXSBvhuObt
         Bz7CrggmHh0dnGfY3oSiM2bX9uB9pf133UjuFGxF7zerGYxeyzC1MWVDmxRgKcjFr8FB
         E+wXsmxvXw1jz3C9jyBtuJ3La4cBc1jfJaalsTqZOShFdqqd8xnyHXAgxU9j0KoXiIaK
         IkSg==
X-Gm-Message-State: AOAM531FR2X9LXwV8fNZItLPeEyW/y5tCglpfeU/9rDh1JYfFXEvMeF6
        Z6oliWKuJ8/HkQXaMY3f9emdNQ==
X-Google-Smtp-Source: ABdhPJym+3NChkBHA8NS/z2uVQ6cUCMR1A3L+017mVCHLkPPcp9m2j9LWQAt7zUUBArLpZtVIYAzDQ==
X-Received: by 2002:aca:2807:: with SMTP id 7mr10727532oix.49.1610379295611;
        Mon, 11 Jan 2021 07:34:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p4sm14419oib.24.2021.01.11.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:34:54 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:34:53 -0600
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
Subject: Re: [PATCH 2/7] soc: qcom: geni: move struct geni_wrapper to header
Message-ID: <X/xwHeRAs4Cl/efj@builder.lan>
References: <20210111151651.1616813-1-vkoul@kernel.org>
 <20210111151651.1616813-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111151651.1616813-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon 11 Jan 09:16 CST 2021, Vinod Koul wrote:

> I2C geni driver needs to access struct geni_wrapper, so move it to
> header.
> 

Please tell me more!

Glanced through the other patches and the only user I can find it in
patch 5 where you use this to get the struct device * of the wrapper.

At least in the DT case this would be [SE]->dev->parent, perhaps we
can't rely on this due to ACPI?

Regards,
Bjorn

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 15 ---------------
>  include/linux/qcom-geni-se.h    | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 285ed86c2bab..a3868228ea05 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -79,21 +79,6 @@
>   */
>  
>  #define MAX_CLK_PERF_LEVEL 32
> -#define NUM_AHB_CLKS 2
> -
> -/**
> - * struct geni_wrapper - Data structure to represent the QUP Wrapper Core
> - * @dev:		Device pointer of the QUP wrapper core
> - * @base:		Base address of this instance of QUP wrapper core
> - * @ahb_clks:		Handle to the primary & secondary AHB clocks
> - * @to_core:		Core ICC path
> - */
> -struct geni_wrapper {
> -	struct device *dev;
> -	void __iomem *base;
> -	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> -	struct geni_icc_path to_core;
> -};
>  
>  static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  						"qup-memory"};
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index e3f4b16040d9..cb4e40908f9f 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -38,6 +38,21 @@ struct geni_icc_path {
>  	unsigned int avg_bw;
>  };
>  
> +#define NUM_AHB_CLKS 2
> +
> +/**
> + * @struct geni_wrapper - Data structure to represent the QUP Wrapper Core
> + * @dev:		Device pointer of the QUP wrapper core
> + * @base:		Base address of this instance of QUP wrapper core
> + * @ahb_clks:		Handle to the primary & secondary AHB clocks
> + */
> +struct geni_wrapper {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +	struct geni_icc_path to_core;
> +};
> +
>  /**
>   * struct geni_se - GENI Serial Engine
>   * @base:		Base Address of the Serial Engine's register block
> -- 
> 2.26.2
> 
