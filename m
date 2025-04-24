Return-Path: <linux-spi+bounces-7728-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DEFA9A2C2
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A553A9CB6
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8E199396;
	Thu, 24 Apr 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6LSBbTl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE82701C3
	for <linux-spi@vger.kernel.org>; Thu, 24 Apr 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478070; cv=none; b=RKtAW02euvcjSptvgS3N6mqfdN3DB8ZCFyl3P19MgolRtDfsVkHw38ySWVlM70No8kLDcMyyo5+ho05kq0WuL1wB0AuDYNM10GIdBZVCt1PO1R0xyQFUImmkowIMd4WNibFzAmhxWLwmGkjUe/l3x9PciUvp2cGgrDVbGYBhSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478070; c=relaxed/simple;
	bh=L3APaDNcpcKWy+ljj6wYw1aJYFyDyEbeFg9xBsk1Bwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFuIsIRzBt4EJyC7KX1JFHuOQ8M4aH+uPFUmAov2+mXS0nPnmCOfx4YUKPgYXIaHt+IwuXftlKNrtHyej1BZeL00v7VTHCTkucQA/KaGPhq+VdDSj5cYnmHvKmGKIz4agLGIJApCL8ef3wqIY9YcCu9EUW3SNS9C7/8pRJ16qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u6LSBbTl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso111417166b.1
        for <linux-spi@vger.kernel.org>; Thu, 24 Apr 2025 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745478066; x=1746082866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd6KF7qnJBjEfDBLcMQiy13vHf6l7mQMuJsOH543KwE=;
        b=u6LSBbTlQhU7mz7toADwhLtFhAiWw2+cePcyVPY3yXZQ2w93aFUK7rov6CuCfndUoM
         piAZ+Da5LEIRWWWRl3kSFx/WAnDzdj1ElmzXRuCmfY2NyGoOQR2govNEE7GTxJdFHwra
         ZeaH3r+GSgoOX0DrWeHA2xoQ5bDTcnpXKpT1Sdra4REaRPnfvwG1osPo8jFE4PjA0bPL
         Wbwm5cFQ2g/x+F+RVph9DyBhoj6EDsy9WMLdZkcoSaZqKC8D0EXiXnM5yFc1SLCogasF
         DEdAOwLYh3kdnS+nWajJ3W/CE+rrWKnZh4r2OAmz1HSLhuN0IjAGNS/PgQyTHAOMRPQv
         GkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478066; x=1746082866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd6KF7qnJBjEfDBLcMQiy13vHf6l7mQMuJsOH543KwE=;
        b=oaNxOtnh38GXsPYNFGGqzP/DPbmYzKgHfZb6XJovW/zbthh/hNoJIdkMGmLNL4R91s
         p3MTlJBlyB2d6/Ed50BXYGpYXSVzMrTRMWecPc5ceIVEeNp5hCPeuAymOK7qI7yFeg26
         DxTtFiJrtiQMkXQEnWoXAv1WWoy75BfNcLWloHW80wHljiN7lcP5tm34y/odTRlRHh24
         mYDl/LIsJt+XE5JdIou1mX0Kq+ZaLPrSb9JbO5cb+zFO4UYR0t4Q8pCQx1juDmCxrxZ9
         nteGR+G621W+465Cjq1EV0WJNNB2jGzfE8ypMt3CUjlCKPYS5VweB2w+durXpV/kSPfX
         mn0w==
X-Forwarded-Encrypted: i=1; AJvYcCXxTk1WU3Og6jLnDhp9qaOxx1meLLlr2Pkiy/YSBSe5uAF7VikMiE6TGNxhOTuH/nhCFnR5HCOxoPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32tX3lOeIoVQj/h1pDU+eTSql4GIwRWksSSqCoFwOURnwkOTr
	D2IbViOdgIcpkx36u9StBIG2m9p8H6stXhENLa+9cpPGElpqXrw20/cSBf5cwUR6/RKN/WEsrY3
	i
X-Gm-Gg: ASbGncvaVuv0iW2BD83dz95GHywHUHeyrkZ/jAAXlGuhQFKsJ3OmIPkGges41pqGEDO
	5GSrK8fswEnhTgUEP9/QPyctWcV8f4aX0CGdY0LY+nRBPE2t04FFyLELwN3JSyuGWcsTKhVZoHU
	FsocaGnjs6W928cqPcf6w34o+Vh/VDMM4fo18Q/UOmBbURuP+9snSTAPFKTvl3H73tZWbhT5jCh
	P+24NvFcGOprfCW9txNMNt91ajl6XP8nB0WDDAqb1ERiKm1QAt+Cz+pfdRnrNNDvzHCSf0S4/9V
	Tadb4gJGKRAp1c4HAdY2jcqWS6wL3Ds7yol2aA==
X-Google-Smtp-Source: AGHT+IGwr/WuZPUfvax9eIsb96aaCta/8FzIuwMP4WW4Ar2s0sxwfKKsr5uKtNR7HMl6jcdgRdFKDA==
X-Received: by 2002:a17:906:44e:b0:aca:a204:5df2 with SMTP id a640c23a62f3a-ace573a6ec3mr96658366b.49.1745478056074;
        Thu, 24 Apr 2025 00:00:56 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59830fe7sm59240666b.13.2025.04.24.00.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:00:55 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:00:53 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>, linux-spi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-qpic-snand: propagate errors from
 qcom_spi_block_erase()
Message-ID: <aAnhpVaVzn/G8TR3@linaro.org>
References: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com>

On 25-04-23 21:31:57, Gabor Juhos wrote:
> The qcom_spi_block_erase() function returns with error in case of
> failure. Change the qcom_spi_send_cmdaddr() function to propagate
> these errors to the callers instead of returning with success.
> 
> Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

