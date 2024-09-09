Return-Path: <linux-spi+bounces-4734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B197144C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F8B267FF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1A1B3F1C;
	Mon,  9 Sep 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzDiPhRp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5A1B3B1A
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875237; cv=none; b=sNdxqtc+gcMt+ZM0dKoGqLPrt3qaFk7dy9w5TQKU0NU5WAAiZ0KWrm4PSOcuIr5lZ1tRpthwzHryUsdJxkkyOWDhYUO6AxDbr64CiDjXSli9F1n//0je1OIFvTAqBymB9fMuaNN2/AKojU1c/M/ZcVq3wW1FGpsiabw7L6neWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875237; c=relaxed/simple;
	bh=n4M+GovN7tZhfg+mdxK6bHXPPX2EsrI3HZxhNQ1buqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzmdQwC1DbxrweUugL6DP4DM8fgDuA14OE9Q/2pUz69zS3ZvXCrc8zND13ay5DdQb8JbDGVTsyV4unCVB/M2Gu3R6sCS5gAGs2ukBYiv4z7AXQaekQC0WyFXo0cDnXTJOSQ3lxbcQ1Hl8ek+u8Agijr72/Hk7K7muqucFuobiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzDiPhRp; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so20037151fa.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Sep 2024 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725875233; x=1726480033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAj1wvN+zxJHeEeDfh62ag2eR23Fcrip29/NVH4laPA=;
        b=CzDiPhRpruzs3scqGCBVKgoZQ7RzvKNsnCrzzHuEzu72TqXQP6DGQNKBOXPzF+NtNI
         BwC565ow9HN8I1O6tNnHtGHCY+bD0PGfOFaeUgxNtz5GUJlZbf9UWBh/dRDjGfyadpOf
         4MLzwJ6HeCYFFOlZyKwC02dWkx/r2j0bh00WLDwl2Q59CrYpzligsN/lAOpa3Y4AdqR8
         C0o23aBkR9gARJ4qoq9VEXNjnuVnjnGNnQNqm7Q5EDwEAFV/gnjkMXLFUtUk84Vc5Fnd
         wXyNzkSIdu7hh8tIfrjVkGITwZCzqHlNyZ4Ozd+MLucj8c16KVymodxsFau2DWuKCS4b
         1BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875233; x=1726480033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAj1wvN+zxJHeEeDfh62ag2eR23Fcrip29/NVH4laPA=;
        b=Y7YLrWq9dnCVP7PwymxePUDtOTR3/bFn702xbvvaHhUj/0l6cGhvc62eWbLmrKheIY
         5op0TpN5YxfqagyBT6eF7+pWX9/eBPSBymMFy5FfVRSQHDO9oH19vwLVD4BRC+ZLP6wr
         Na6Icmfj0hPI5FGo6AsizJX1l3BeWxRBkRWbQWxTnNVT5xygqz3oMd+ZUYff0SRgF8rr
         PrgE85dRHVAuV+IEkrToiV73DIwxF6BKHXBWst2fNqlSz3wIER7tPhuK5v2DHEcTCBx5
         u5S22BWZ5SZC/w74CPlhpk01cIp8aoUvu3QBfWv5sZ+AuT4HaXmUa0ohX3MgRTbremoR
         kOZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/BcXrsSVYKPn9/zOmGHAPMJuaS+d2iBQNuwZ30QqG7JY9YbSjEqY38ewCJ2XwBIlVuhdpLQpoXHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRN1RkfGzM/FOBdCDpC5FKpDWYE4dFy/saLam8Fj/9NNU/O3A
	YG5mIM8pJ1scr2qmxZMfmCU40C+dbDcxP1dcZbNfKHLxEgvCevWAghDswUr7MTQ=
X-Google-Smtp-Source: AGHT+IFZ64jJ5mD8lby7aJudxo1hABUCgb3NXgoVtTSzdGdQteWjQTiBrXa28ODVcj7A5bgcyzZiCg==
X-Received: by 2002:a05:651c:1991:b0:2ec:568e:336e with SMTP id 38308e7fff4ca-2f751eaee1bmr84195191fa.1.1725875232771;
        Mon, 09 Sep 2024 02:47:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bfe817asm7501321fa.23.2024.09.09.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:47:12 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:47:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, dianders@chromium.org, 
	vkoul@kernel.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: geni-qcom: Fix incorrect free_irq() sequence
Message-ID: <kmpyep53hlqavoipgvkab3d3xkg5dt7olsflveemkdwkekiajn@s6xrdddwpnqi>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909073141.951494-3-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 03:31:40PM GMT, Jinjie Ruan wrote:
> In spi_geni_remove(), the free_irq() sequence is different from that
> on the probe error path. And the IRQ will still remain and it's interrupt
> handler may use the dma channel after release dma channel and before free
> irq, which is not secure, fix it.
> 
> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Rebased on the devm_pm_runtime_enable() patch.
> - Update the commit message.
> ---
>  drivers/spi/spi-geni-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This matches the code in spi_geni_probe().


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

