Return-Path: <linux-spi+bounces-7187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF27BA66BF1
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 08:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1641E17EBC4
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8091F4C93;
	Tue, 18 Mar 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGMtVzjB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3B1F17F7
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283326; cv=none; b=sjJJSR2reAopqAWMeYhbStTU6W41mDMRmTD/MWk8GL9dJyi9W3vZmGVrcymtG9R39sif6UYbSr0iERgAL5SkaYkkpngf4oF49z7PVgJeJ1P2axIluMnue9vaMG8RKPFIL1nzlkXj5/fctY8xeAHfm4Gr+iv057fpeR9bkhpWfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283326; c=relaxed/simple;
	bh=bT2WkAI4t1LM3JXg9m1Nj3B6KFZFFVc1xKtjtfEM7vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+uKf3XmA4WE+JgBYQXnfR7NJVaWF8ofSOa8Cz2Fokgd8JvEHn2L+8yFf/oneZ05UpyPGAVgTRzYCOjYLTjO57iye0hrC+g4AQSTvbL0H18/KD/fSBja5QOHMWMElmA9G5m4GAX9rwvGgvS+2pbtOLN1WApVoOVzV0lfr/1kxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGMtVzjB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22401f4d35aso98333635ad.2
        for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283324; x=1742888124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ti9mkkr8qvTbrEt9TTTW4ivjULJ5uCNkrYEb+oujtBo=;
        b=MGMtVzjBGvcgbTTagJpUCUqw0MQAxwa1eZ35tPIi2qRQ2dIr14Baz3PqJp2w8ZYhdW
         y4wNss2Z299JDVJPxcAPnDw1tjaWReMBE/PYh83etDMf5Ll1TTGdnVD2QTnuzpe81x6O
         tV5xe983f1Imxvw/Q5lvcDNgW0aFvrMtkt85nKNbXqLewbTPWZrxWQ/vjUMn8Q3SckAZ
         UQTx3wv3jr/7FdXPNoxvWb6ou6jcs1vgwT085R7dCC2BzttqxeN0hTKSQUE0CgzS8g8w
         7mvz/Udow/pakNIkPEJBf9YCekFf1lqbZ+LHRTCPB1dZMHjCyZZD4HTpQpFg1obXhUjP
         A00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283324; x=1742888124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti9mkkr8qvTbrEt9TTTW4ivjULJ5uCNkrYEb+oujtBo=;
        b=G6gDIHn+Io0QzZgqVKrWtkO42JXKQhlwU0tnmTChKO+obVL+bhlfHTDD1y8AQdkMHY
         Oe67OgIwiRolvxw07kO599jBGtZfP33ABi1T3Z7E6PDSCD5kb49DuySSfDaKqR2Rv2Zz
         DL5wZP/0QLj7NZJnW5jlT4dYGVTl3r/fMGSprI6+N8bnSjjoLrfNkRHhZC43nLRdG+dS
         k+7Pm0/iCHwrpKWOk6MMd+TuOYTSckTo4ljQ0fYWlzpmzoyacIzpq/WpGEfg2J1F8rhN
         cG9xljcHOmdyCCtKV6kZLjMQBE4zQqQt3X7FqAEcSLMzc0R0G9RUIcgN+NY5RDb3QCgN
         jonw==
X-Forwarded-Encrypted: i=1; AJvYcCXP9Y1SqGDe/pzmCnr/+8VwhIVeZXEeOwwfxC84pb/JOzcaoWO5GZQX2lEt/Zrnhcm37xO16S/s95U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsi7gHjF4su45eML1eKEZwOtOe04FpGup0v8AKeTMsHlYZM1NH
	dDRe61lHt12Sx34Avodlb/aronr4gjfhjbePMaAkemkhW2wHOrZPCABCAkk9mQ==
X-Gm-Gg: ASbGncvjWQq8OawK2I82wsxTU4cG9dVhDbpmVIw9elZr5aPLz2g1ewmxka8u+dwZWv8
	mWKCzU/8msjZTaT14VKpRBD1taPyD7VwYsjRo0MWtGe4YYsW43yNLqDnF3PwN8ACKepPKJal1HB
	m3OecvF6TMRU/JJ/rBgS0PWBKm8UCT1NEtOVZxG0mitY4UXZGWkTLCvL56xQZ0U+luNYzGbj3xP
	ZHH+vmyj3zlkQUc5l3I1LrtnCGThUFkjNIrMlZl2X09rDg3iDGPPBJWSpGD5/NKtgrroaShHclJ
	qkqdph6/P2tD5ir0oJivRtopB2fnA8nNcHU8DwOInAZYPH/3JjrPRXbz
X-Google-Smtp-Source: AGHT+IHmw89wtVmgBhfVxX9PTZBqglKeGhES/xurGrbMglniid1oBlbFanI6j4PT2q5RJtFbNqS0gg==
X-Received: by 2002:a17:902:ce81:b0:223:3ef1:a30a with SMTP id d9443c01a7336-2262c611213mr25670245ad.45.1742283324004;
        Tue, 18 Mar 2025 00:35:24 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3d5bsm87724655ad.217.2025.03.18.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:35:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:05:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
Message-ID: <20250318073519.pgise5vnlu2aha5u@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-5-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-5-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:06PM +0530, Md Sadre Alam wrote:
> The BAM block expects NAND register addresses to be computed based on
> the NAND register offset from QPIC base. This value is 0x30000 for
> ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
> appropriately.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Change in [v3]
> 
> * Added nand_offset for proper address calculation
>   for newer Socs
> 
> Change in [v2]
> 
> * This patch was not part of v2
> 
> Change in [v1]
> 
> * This patch was not part of v1
> 
>  drivers/spi/spi-qpic-snand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 8c413a6a5152..85a742e21cf9 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -1604,6 +1604,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
>  static const struct qcom_nandc_props ipq9574_snandc_props = {
>  	.dev_cmd_reg_start = 0x7000,
>  	.supports_bam = true,
> +	.nandc_offset = 0x30000,
>  };
>  
>  static const struct of_device_id qcom_snandc_of_match[] = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

