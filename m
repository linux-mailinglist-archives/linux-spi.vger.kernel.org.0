Return-Path: <linux-spi+bounces-4735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D487971457
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F9C1F2137E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A21B14F3;
	Mon,  9 Sep 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3UeIw3E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DF1B251C
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875375; cv=none; b=Qp3oogMshVn7GZlaIs+jF+G7j3IdNb2cAa6/C4Pjy4bIx4avRKZECKPoxXdx68dM9lsNM5emKHHsEwLqgjDJCTBkVs3L5b8x65Ph+/OTzJ/4APoD6ATiczLpqazPyxYUQ84z7PduacFn/ZWo1Li26PeELjS/DzvK3mwCOFS1C70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875375; c=relaxed/simple;
	bh=vki2Y1JuhrZvx8oy7PtFuodTPPD7UZ+8iVUI1oEeDQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIP0pJe4WJ1fxwy+m+XiTXmsKS0zTSMyEEt6o/ZBj3wu6H3sMS6iOR9aSILh5vxYtkt/Q5VJpWbWYYBTTGLmCaanAA3H/jodZ3CnVgxi9pqg4VPJanJxev3UpsQ4Nd7rQozUkaeA9v6i0evCpX+gtQ3XyN3wns1X+MntUdAnT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3UeIw3E; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75a81b6d5so20183971fa.1
        for <linux-spi@vger.kernel.org>; Mon, 09 Sep 2024 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725875372; x=1726480172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fJpkQ4NGa1bgFpFMHSwu4K3UNwOoPaOW+nseHRk3UA=;
        b=z3UeIw3E25mX3XopC0VIU+8DJCXfUU81tl7tD+x8gH3ZrtIgeqXdWYf1SXRvpaw34D
         WJFE4/PzSHqOIoykEGwb7arwrqCVKqy5haJ29W9jjfaZiPpEAlupSIHiHWsm3d3+e2Wd
         mKLan3xcXeMgIS+5HlhYnnVMeUGvQviRRq6nc2yXLzG0lq248m073W4+ulqTiB0JmLCa
         u95xsVS14P77Xu+/x8xLf7xyIcYHUF1tLAMwzJYVoBPvdT5a7LYn7uhzxQmq/Gyqi5sA
         m/vNFzzKoTuzZoGjQv2D1DhnxwQs8VHNx/Ye02ciMkZfA4IvZwb/FStuo3a0d8gbBZ4d
         cpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875372; x=1726480172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fJpkQ4NGa1bgFpFMHSwu4K3UNwOoPaOW+nseHRk3UA=;
        b=nKn8ElIMJtV2zPQTerThcsjH9kOP9AzM+kAryfb7d3NdS4KCRGfidoehd+LNWLZk7A
         fwbrJ1Fk3U5+6sjIbw+j98zxtphqK04tUU66GoF90X8JErYJYcHEfBwL1B0FEzRlECMX
         e5AcmxKoxK/QQRTpfuzkOYjKVA76OOwM5UwBu0aeflW8Nbgwf9jxVzKdbM2MGFqd3Iog
         t/W6KnBRrJENuSw9axjFnL+H6zAdYYEFGCGguz2CRfra2Ln+HBJ58iHWoqv5IG50+HmH
         gN7z4IVqqU4byvg4xKVUESOF+C4m47ML5NcbyF4jMid7DvXevG+oQE8qbN3JZFoY17vf
         B23g==
X-Forwarded-Encrypted: i=1; AJvYcCWsM+ouGiB99i7ezE0mpO1TiOyStFXdnerVW4ib3N+TAwh8g1WRcrdK9+TkGnU00UJO/dlzGc25zAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzilKwh94Yu9yqPcZrV1ulSs38E8QsSdP+QzqAyWoQ7IjKqOFpT
	qAgwOu/2vSiMt3QXce3f8IRVhJHKQVtUTKkQaxlfFQoE673f6/x/bpudazz5x9JeJBbrLViukoh
	6
X-Google-Smtp-Source: AGHT+IEhX51L9Cn1/nLKg5sz2hwS7NM5t471XcmkhHG/LrVXbxJuK0lh4JYejXlfYukaLJvpjtsvRw==
X-Received: by 2002:a2e:be1a:0:b0:2f7:6194:b716 with SMTP id 38308e7fff4ca-2f76194b7fcmr33513071fa.5.1725875371310;
        Mon, 09 Sep 2024 02:49:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c5a5sm7570341fa.97.2024.09.09.02.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:49:30 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:49:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, dianders@chromium.org, 
	vkoul@kernel.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: geni-qcom: Use devm functions to simplify
 code
Message-ID: <45m7oruivszoiesijmdr66oeatvr3ff6ores4lx4kbus2ti552@5sobv4hk7laa>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909073141.951494-4-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 03:31:41PM GMT, Jinjie Ruan wrote:
> Use devm_pm_runtime_enable(), devm_request_irq() and
> devm_spi_register_controller() to simplify code.
> 
> And also register a callback spi_geni_release_dma_chan() with
> devm_add_action_or_reset(), to release dma channel in both error
> and device detach path, which can make sure the release sequence is
> consistent with the original one.
> 
> 1. Unregister spi controller.
> 2. Free the IRQ.
> 3. Free DMA chans
> 4. Disable runtime PM.
> 
> So the remove function can also be removed.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Land the rest of the cleanups afterwards.
> ---
>  drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 6f4057330444..8b0039d14605 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
>  	return ret;
>  }
>  
> -static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
> +static void spi_geni_release_dma_chan(void *data)
>  {
> +	struct spi_geni_master *mas = data;
> +
>  	if (mas->rx) {
>  		dma_release_channel(mas->rx);
>  		mas->rx = NULL;
> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, spi);

This should be mas, not spi.

Doesn't looks like this was tested. Please correct me if I'm wrong.


-- 
With best wishes
Dmitry

