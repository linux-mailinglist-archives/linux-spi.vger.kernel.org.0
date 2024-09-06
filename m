Return-Path: <linux-spi+bounces-4704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765896E811
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A931C2216C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421BB17BA0;
	Fri,  6 Sep 2024 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBUT6s8/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931A3BBEF
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592550; cv=none; b=mo+q4LPakrs8Fz/FRHVRxXPFHDYh13ss8fH6si4FTMr4nl/cyHTem2ZZXVgvQMt5YosGyRnNayhO4NhR8hpLWzi2LuKkWmo4lNPtSGIskC4alQG6dwmpTlpAZ6s4y7DIDc/SqFBllvt8E1YS9eEXBN9xIGQH+mzEtkzFjVcYcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592550; c=relaxed/simple;
	bh=pB+VC1h4yO8GwmTdyZ3PmyYN2qhDHr6PqJoy1/vMIUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLO/XlXNKclrN6npnFME+KZd2V9Y/TbnSkobTZ9K6LNyZisKNAxF6aDMuV1jDvDDunlCntkbhv9Xix6YZqirA2Wk142YCVXImvbOC3fMKUdCeiKS28W1FP1jMu/nKRvTpBQy7tfMZ9vYggUVdJoSomWw51PUadsa1NEJFVSChlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBUT6s8/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so1722498e87.3
        for <linux-spi@vger.kernel.org>; Thu, 05 Sep 2024 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725592546; x=1726197346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsOD3iArCgZZ77gXylmGUS+aqVsYDnNnCS0fEFsEB94=;
        b=KBUT6s8/ZEvK2UQBLFmikPB44LWoNh6lstyY+xhzQuWh+tuFVTAwWGRRX0i1B2dhY9
         BVqEBwONDM9Ha08MuGhQOth0y6z1uPz0E48+QWwl6h08uaH4pg3jZFg9Gl+B6qa91cvB
         +tQ03vGqbD6RxYxOgiOiURAnxyHAzmg8ELOgGQ4MuMCNR7jMn8mVnwPBvnSMSnUWPnx0
         QTZXGJpjVDntszQzVVu+0udDbVfMM5fYIn+zWL5y+sMwT1MuKm1E4U5YVrFM2h58TqQc
         R/ry7pvytAAXpelwt5gJqggYQb7L5Bl28/ZUaM4tXy/OaTbRrgYzBm4oEgsMdKO3nf67
         ZFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725592546; x=1726197346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsOD3iArCgZZ77gXylmGUS+aqVsYDnNnCS0fEFsEB94=;
        b=NPhutvv3RJ3RWI0VCWYpS+ayzZ1IBULncDsMu0W0rJZIj6HehVcBiUUTLdn3iC8App
         1hm5x2WWDhgQ67CtuiRBZRVHViBP8ZKVpeRenfdKS3qui12HltJMJFzWQKCcozupkrp0
         FZExmJtkh0fy25HsfmutTTHgeLO/rjkKqPGReSwMUgl098oUkbaJwuJ4GLGHM0ZoDc4N
         jeCtpqFVx9oKNbp15d3Bfww2nJtWQk9dVEgzzVWPx9xw7bQQGUiEMTKkMicuUs/w3128
         dJPZL5l/RNF7ltLT3rkRKxNYRfHBdZu/qY+qtoZfJ78h57PIjr4XiWq5Hv7CTjsspTOS
         +40A==
X-Forwarded-Encrypted: i=1; AJvYcCWdvF38Q2Ze0kJQASKL+0H5LdgyrXmZqs+quZvvYA644WYaV4dliNMG32HoW0HSyz0gnU/Q3q9kgsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeqiZCgLLXUbCROo+19Yr2Ctn6sT6lFyzqr9WPnJKPdy8nlpq
	VLb4uKLyq1ajoC0E2W+TdTZl5od7Wn/0/NYnKXMtacbhHeO+wj/oyE4MGAgOv9I=
X-Google-Smtp-Source: AGHT+IF4GNRqTJ/VZ/bkcy+j4piCgqi8x2edA29Dt0TGbBntqzcACyAsSucCg4Har0HjGhKj99iDYw==
X-Received: by 2002:a05:6512:2514:b0:536:5827:8778 with SMTP id 2adb3069b0e04-536588130d9mr512122e87.53.1725592545690;
        Thu, 05 Sep 2024 20:15:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b6absm2758776e87.52.2024.09.05.20.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 20:15:44 -0700 (PDT)
Date: Fri, 6 Sep 2024 06:15:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, vkoul@kernel.org, akashast@codeaurora.org, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Fix missing undo runtime PM
 changes at driver exit time
Message-ID: <hnos3f34ejabyw2yxtpxifskhklunvnufgsuilghjeuzipqkxi@udw5xfeum37a>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
 <20240906031345.1052241-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906031345.1052241-3-ruanjinjie@huawei.com>

On Fri, Sep 06, 2024 at 11:13:45AM GMT, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> initially enabled pm_runtime with devm_pm_runtime_enable()
> (which handles it for you).
> 
> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
> to fix it.
> 
> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
> ---
> v2:
> - Fix it directly instead of use devm_pm_runtime_enable().

Why?

> ---
>  drivers/spi/spi-geni-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index fc2819effe2d..38857edbc785 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>  spi_geni_release_dma:
>  	spi_geni_release_dma_chan(mas);
>  spi_geni_probe_runtime_disable:
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	return ret;
>  }
> @@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platform_device *pdev)
>  
>  	spi_geni_release_dma_chan(mas);
>  
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

