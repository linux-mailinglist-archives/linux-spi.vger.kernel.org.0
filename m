Return-Path: <linux-spi+bounces-4306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3595DF22
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D282E1F218BE
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657B364BA;
	Sat, 24 Aug 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/8Ua3Kt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30880B;
	Sat, 24 Aug 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724518938; cv=none; b=OqxqT6lVNzTBj/hMNuQLQNBImNkesqZM/Fz3clRjeLgeWGGg2UlBmApNbzYbkyPJzSa3uOlI7fInysEf3o70u8g/UKJrrTfdjlCHoS5D6BvsD3bDJLwtnZhCx4WqufwzCRnbbvlgU+HT2glqxq1UpuY5dupI7J1WnlqRAl0hDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724518938; c=relaxed/simple;
	bh=O6YtsrmcV9LjmB/0jvkq9TIOrLUCeCkBeZk7gfPmi1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIDEr05AhOVRDYAOao9sFJm5+V0tx0KOaSoVzA9a2g9oCCvER7DYIODCZhAEfSg1jUWy+sAJaC6+I4K3t3Ggaq7Sqo4TsVnx9VSKC8POAMeNjZ1ZcSvl/m0JfVTrW6MH2Rr+toNamK39YvqnrbJi6LkqjAeraPxdu83VnyOveYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/8Ua3Kt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71423273c62so2227121b3a.0;
        Sat, 24 Aug 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724518937; x=1725123737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKGkZIK8/SQfJAkw54UvP8vTb+4IEIpgWYhwn5J9iD0=;
        b=j/8Ua3Ktv5o3bw7xQ1mGj/EDj7qssmEiOsYwwtnjO9wAOVAhZqBYWttQRLe6sxHRaO
         UMOV+Mzec6DxaWL8rrIbV9RIvS6Akx1ZTLz/LzH343nL0eYhGvFyz8492jWB5UjdrPnT
         KB/jZm9V9atrLle0cvU2Fd8MbXg8j9CPHiWXYl26tz0sJml4+jA8j1XcKqXqySvjdIMl
         BEtl0Xz+vaTk52+aFkytPbU2TGeV+Hxsj+wxrZc7YWyuJUzOYb5msCNWXL71yZH00LP7
         zfrHdrjbHMHbqGRCoDqi85zmpdsVX0nAo5oPMOx9gUg/mR+3iOeTiLE7ny39ywxx62Bx
         0vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724518937; x=1725123737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKGkZIK8/SQfJAkw54UvP8vTb+4IEIpgWYhwn5J9iD0=;
        b=rgPqoomQ5Tyfpk6MZI/QQ9eCGXO91G8yJo5d6+V7OQW+Jqe2GNayk80Z7WKvoj89Eu
         RjeVSUDg8lL4xf0zkwujrzF8RMg+K328+pu44oJQnBaoABmbRvEF67zOkJYdNmT/5D2k
         irYkPXvLHCgJwsjgkdLoPRoqKANt6xSXafai5afdJFatHwbikltiV3NayoUd92haO7Q0
         4bPJNVvoO1ex+04F1eMTFacN/FLl2d4Jx6+CjVsfW6TC4hc4AgC0CVAyXPq9f0fWPe/D
         uPJoh+fC3N9AtS6JbD1F0yNpgYtrqfel2WzzuO+Vi1h6rJ8L2WPLg7heu+TRjKJ2w33N
         otqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUimVrfpvlUKldA8esgXIhSJKXgTtniYRZIP4HJ9HrXA1DxEUcqATLIST4NrwR9v4LtwS0qkm7VQc@vger.kernel.org, AJvYcCVdd7z7ZiTj4jssUOHuuhudXdo3XLrVpd1dyubU4+ghsEch5uOTH72kzQPJxovxIi0lilJRpMabhkh+Ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRhjx6LdK2OVz9DU+MF3StgTqvzPfhqRR5xAHCRXrQhycVoCd
	cMCLd6sMca6WjaZgAfevNGA7WPC9uGlZ9b9YZ5XMKpQL0q3EYsfz
X-Google-Smtp-Source: AGHT+IFNYqvo4YQ30dvxGyOotrvXcHIBWWeRuP1xnxTzOazp7HfQAjmpaLQ5fHI5e6aLNbzsGhkHLw==
X-Received: by 2002:a05:6a20:d49a:b0:1cc:9ff8:e76c with SMTP id adf61e73a8af0-1cc9ff8eb58mr1252206637.52.1724518936385;
        Sat, 24 Aug 2024 10:02:16 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55283sm5066256a12.74.2024.08.24.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 10:02:15 -0700 (PDT)
Date: Sun, 25 Aug 2024 01:02:11 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: briannorris@chromium.org, broonie@kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm
 operation
Message-ID: <ZsoSEw9pTalRJBJS@visitorckw-System-Product-Name>
References: <20240824045702.3952922-1-jon.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824045702.3952922-1-jon.lin@rock-chips.com>

Hi Jon,

On Sat, Aug 24, 2024 at 12:57:02PM +0800, Jon Lin wrote:
> Fix WARN_ON:
> [   22.869352][ T1885] clk_spi0 already unprepared
> [   22.869379][ T1885] WARNING: CPU: 3 PID: 1885 at drivers/clk/clk.c:813 clk_core_unprepare+0xbc4
> [   22.869380][ T1885] Modules linked in: bcmdhd dhd_static_buf
> [   22.869391][ T1885] CPU: 3 PID: 1885 Comm: Binder:355_2 Tainted: G        W         5.10.66 #59
> [   22.869393][ T1885] Hardware name: Rockchip RK3588 EVB1 LP4 V10 Board (DT)
> [   22.869397][ T1885] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [   22.869401][ T1885] pc : clk_core_unprepare+0xbc/0x214
> [   22.869404][ T1885] lr : clk_core_unprepare+0xbc/0x214
> 
> Fixes:  ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")

Thanks for the patch. However, the fixes tag should include the 12
characters of SHA-1 ID. the corrected Fixes tag should be:

Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")

Regards,
Kuan-Wei

> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
>  drivers/spi/spi-rockchip.c | 57 +++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index e1ecd96c7858..043a7739c330 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -940,33 +940,24 @@ static void rockchip_spi_remove(struct platform_device *pdev)
>  	spi_controller_put(ctlr);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int rockchip_spi_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int rockchip_spi_runtime_suspend(struct device *dev)
>  {
> -	int ret;
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
>  	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>  
> -	ret = spi_controller_suspend(ctlr);
> -	if (ret < 0)
> -		return ret;
> -
>  	clk_disable_unprepare(rs->spiclk);
>  	clk_disable_unprepare(rs->apb_pclk);
>  
> -	pinctrl_pm_select_sleep_state(dev);
> -
>  	return 0;
>  }
>  
> -static int rockchip_spi_resume(struct device *dev)
> +static int rockchip_spi_runtime_resume(struct device *dev)
>  {
>  	int ret;
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
>  	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>  
> -	pinctrl_pm_select_default_state(dev);
> -
>  	ret = clk_prepare_enable(rs->apb_pclk);
>  	if (ret < 0)
>  		return ret;
> @@ -975,41 +966,45 @@ static int rockchip_spi_resume(struct device *dev)
>  	if (ret < 0)
>  		clk_disable_unprepare(rs->apb_pclk);
>  
> -	ret = spi_controller_resume(ctlr);
> -	if (ret < 0) {
> -		clk_disable_unprepare(rs->spiclk);
> -		clk_disable_unprepare(rs->apb_pclk);
> -	}
> -
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#endif /* CONFIG_PM */
>  
> -#ifdef CONFIG_PM
> -static int rockchip_spi_runtime_suspend(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_spi_suspend(struct device *dev)
>  {
> +	int ret;
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
> -	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>  
> -	clk_disable_unprepare(rs->spiclk);
> -	clk_disable_unprepare(rs->apb_pclk);
> +	ret = spi_controller_suspend(ctlr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Avoid redundant clock disable */
> +	if (!pm_runtime_status_suspended(dev))
> +		rockchip_spi_runtime_suspend(dev);
> +
> +	pinctrl_pm_select_sleep_state(dev);
>  
>  	return 0;
>  }
>  
> -static int rockchip_spi_runtime_resume(struct device *dev)
> +static int rockchip_spi_resume(struct device *dev)
>  {
>  	int ret;
>  	struct spi_controller *ctlr = dev_get_drvdata(dev);
> -	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>  
> -	ret = clk_prepare_enable(rs->apb_pclk);
> -	if (ret < 0)
> -		return ret;
> +	pinctrl_pm_select_default_state(dev);
>  
> -	ret = clk_prepare_enable(rs->spiclk);
> +	if (!pm_runtime_status_suspended(dev)) {
> +		ret = rockchip_spi_runtime_resume(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = spi_controller_resume(ctlr);
>  	if (ret < 0)
> -		clk_disable_unprepare(rs->apb_pclk);
> +		rockchip_spi_runtime_suspend(dev);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 

