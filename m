Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5E1CB7AF
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEHSxO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbgEHSxO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 14:53:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA2C061A0C
        for <linux-spi@vger.kernel.org>; Fri,  8 May 2020 11:53:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 207so1263752pgc.6
        for <linux-spi@vger.kernel.org>; Fri, 08 May 2020 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7cajeOI7t/O4BieeA4MfIrn4RGmhWaaIwirB4vXuQc=;
        b=aVLs5Fmu4qrpOaBYOgocdVnjGjVZbzjtw2eD0B09bZ2TwTqFF3YBdASmRvE2O6pXoI
         crpCPiiSVN9Yy1cl+mXSGnsyl/dPDHazS/n56/2bF5m3cBfNFEf+enwAl4YI/W6ZPiXO
         XNr/SnHsyQWRzBHlaJi4Is529BaSjn7Vekl0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7cajeOI7t/O4BieeA4MfIrn4RGmhWaaIwirB4vXuQc=;
        b=iv9E3VeiAN61h6dreWKMBDp7KobHlPMzMTVMXzju4nzJoNu48Q39FSnB4BqxTrWUGe
         sqfaeAqg2XC9Y7xqVhLWp81vYlHrSlmn1gDvjGrn/2X51p6ustDwyITKXJMEmvLde3oi
         Usw9HyiPawRnBUte4m3wGzDEh/OdxmTA4v05GLtIAbtZpxcjb3COSlzyEKtiPS1rrBx6
         XMgbZB3r0JF+3q764o9LrpgOzhsPcUYudB85fL+sZBTgDM8QgPNX6NQIPbA7KRq902qf
         pUjvxAR5xipk+m+kS6OcFtrut0Sv6aYPcBfVMc6ZtIb/lsxh+75OP/Aa9Rg9wldS0BHO
         AChg==
X-Gm-Message-State: AGi0PuZCwDWh3+uFOEklSs6V+6Qgiv1x/ljk28JZFcJsQZrc9uzcjPqb
        DGtzOCKrQvnbuNI0VHBwM5QBpA==
X-Google-Smtp-Source: APiQypKROAa/6+J17up8ZlBL6maJRsHFmxy82YxcjouGV6Krao/qBNGx9il4jK0PDfZp+LoO+4NjlQ==
X-Received: by 2002:a65:460f:: with SMTP id v15mr3259783pgq.24.1588963992211;
        Fri, 08 May 2020 11:53:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h15sm2498074pfr.161.2020.05.08.11.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 11:53:11 -0700 (PDT)
Date:   Fri, 8 May 2020 11:53:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org, georgi.djakov@linaro.org
Subject: Re: [PATCH V5 6/7] spi: spi-qcom-qspi: Add interconnect support
Message-ID: <20200508185310.GF4525@google.com>
References: <1588919619-21355-1-git-send-email-akashast@codeaurora.org>
 <1588919619-21355-7-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588919619-21355-7-git-send-email-akashast@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 12:03:38PM +0530, Akash Asthana wrote:
> Get the interconnect paths for QSPI device and vote according to the
> current bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comment, introduced and using devm_of_icc_get API for getting
>    path handle
>  - As per Matthias comment, added error handling for icc_set_bw call
> 
> Changes in V3:
>  - No Change.
> 
> Changes in V4:
>  - As per Mark's comment move peak_bw guess as twice of avg_bw if
>    nothing mentioned explicitly to ICC core.
> 
> Changes in V5:
>  - Add icc_enable/disable to power on/off call.
>  - Save some non-zero avg/peak value to ICC core by calling geni_icc_set_bw
>    from probe so that when resume/icc_enable is called NOC are running at
>    some non-zero value.
> 
>  drivers/spi/spi-qcom-qspi.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..6e299f4 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -139,7 +140,10 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> -	/* Lock to protect xfer and IRQ accessed registers */
> +	struct icc_path *icc_path_cpu_to_qspi;
> +	unsigned int avg_bw_cpu;
> +	unsigned int peak_bw_cpu;

There is no point in having two fields, 'peak_bw_cpu' is always assigned
to 'avg_bw_cpu' and passed to icc_set_bw(). Just make it a single field
'icc_bw_cpu'.

> +	/* Lock to protect data accessed by IRQs */
>  	spinlock_t lock;
>  };
>  
> @@ -241,6 +245,20 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>  		return ret;
>  	}
>  
> +	/*
> +	 * Set BW quota for CPU as driver supports FIFO mode only.
> +	 * We don't have explicit peak requirement so keep it equal to avg_bw.
> +	 */
> +	ctrl->avg_bw_cpu = Bps_to_icc(speed_hz);
> +	ctrl->peak_bw_cpu = ctrl->avg_bw_cpu;
> +	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, ctrl->avg_bw_cpu,
> +		ctrl->peak_bw_cpu);
> +	if (ret) {
> +		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu\n",
> +			__func__);

the logging in this patch is inconsistent. Here the error is not printed,
at all, in other cases it's "<error>, ret:-42" or "<error> ret:-42".
Please stick to a common format (unless there is no error). My
suggestion would be "<error>: -42", in my perception "ret:" just adds
noise.

> +		return ret;
> +	}
> +
>  	spin_lock_irqsave(&ctrl->lock, flags);
>  
>  	/* We are half duplex, so either rx or tx will be set */
> @@ -458,6 +476,29 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_probe_master_put;
>  
> +	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
> +	if (IS_ERR(ctrl->icc_path_cpu_to_qspi)) {
> +		ret = PTR_ERR(ctrl->icc_path_cpu_to_qspi);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get cpu path, ret:%d\n", ret);
> +		goto exit_probe_master_put;
> +	}
> +	/* Set BW vote for register access */
> +	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, Bps_to_icc(1000),
> +				Bps_to_icc(1000));
> +	if (ret) {
> +		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu ret:%d\n",
> +				__func__, ret);
> +		goto exit_probe_master_put;
> +	}
> +
> +	ret = icc_disable(ctrl->icc_path_cpu_to_qspi);
> +	if (ret) {
> +		dev_err(ctrl->dev, "%s: ICC disable failed for cpu ret:%d\n",
> +				__func__, ret);
> +		goto exit_probe_master_put;
> +	}
> +
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0)
>  		goto exit_probe_master_put;
> @@ -511,9 +552,17 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +	int ret;
>  
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>  
> +	ret = icc_disable(ctrl->icc_path_cpu_to_qspi);
> +	if (ret) {
> +		dev_err_ratelimited(ctrl->dev, "%s: ICC disable failed for cpu ret:%d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -521,6 +570,14 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = icc_enable(ctrl->icc_path_cpu_to_qspi);
> +	if (ret) {
> +		dev_err_ratelimited(ctrl->dev, "%s: ICC enable failed for cpu ret:%d\n",
> +			__func__, ret);
> +		return ret;
> +	}
>  
>  	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
>  }
