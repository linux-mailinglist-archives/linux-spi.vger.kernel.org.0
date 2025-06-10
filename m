Return-Path: <linux-spi+bounces-8423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3BAD311C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E78418928CD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012028A3E1;
	Tue, 10 Jun 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0RMF03W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89728A1FD
	for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546203; cv=none; b=B6U9HU0k6CRXksSdN5JyS72uJ9DwuODj/Z68kY/wNa6pI+Hys/YCFST38PwZG3p4oqPArUo3X1IvFBiTNXJqxjKO0BfX2s/+H2ITYRB2sk+/zX5b6n/VINxg9dx3r3IiTikbee/S9qFHEuJiCL0dGvJfXNl+YqEdLJ+hKeXHcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546203; c=relaxed/simple;
	bh=jQuhSajM/eKNYIy+lnEsFf+cKW6Vn57R891VHKHU15Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEyBc6s3ZO8vXdtNhabFz4TiW138oOIXr18gCHWETwH8I1/HpuRnZrMl1VbwSEMa/FHF2bxgcuojDgsv+g2N1wZn2gXZ19NdF3bPdRxZWgf/8aG1IzU73mPcyF8Rc7KDUeHaUaYREiQoMyskcVtncOwUNt82qtv5Q4uRbXZ/MiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0RMF03W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450dd065828so34932795e9.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546199; x=1750150999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPqK+7Pme+jXJ4ncyLUwgWNNufzulUH6kf6Ic21uOPk=;
        b=P0RMF03WSisK/xP7ix41vaM4/M6uSwPIakViqd3QtA9WQXzi1Q+Z1X3LD9VVbvWP5+
         3rvCk90v2eSnpCf833HTItZH50ezlXmwOyboR53hfYDSQyfVtIIbaXKaMZo1tLvxjkoH
         0T78cAQUQTloplKFVV1KD4yS5WjzyENkGXX1wbwGXEOE0qswBluRYc1e+emrksT4Ik7O
         2N/4mneOS/6EFwsOyFEomMosdCMs0T2NVmIOUS31btFTmtRSEtodSqA4hEIgY447L2Qe
         h6q3+9GNuYg+QZ1cFTcGIbeiJwiC8EOYIa0lvHzffSjHyxls/nPxGw7nmhYcMHr1bpEh
         HrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546199; x=1750150999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPqK+7Pme+jXJ4ncyLUwgWNNufzulUH6kf6Ic21uOPk=;
        b=IBfq+XKzgb5/+CXzeosyVgftdfkPUDS6aRk6I73rMslERANOlncr8tQRdUTr1uSkpR
         AWUru7C64q7kv9t4j5CTeHJxye9BMLB40L1etAUtyfEBQCCGzi+l+5f+WC3IJm6WCE3M
         aGULibd4fTrudHHXahE8dxF2LciE5+rzWu9gRS7WnUsKh3lvyPrNMWioFp8kCb/2D9jV
         Z7cx4UfNb/qRVkMrDelChoDq/tFqgXED7mwRRAoGFitao6jBawEC0MVJD2wNaWYU+HPF
         FEufuYM+Tv2RfbZO1YGR2bbYv1g0dMHmYV5k3NPM2x8zGYldhEa4fN4hOWg1ZDfympTh
         ufhw==
X-Forwarded-Encrypted: i=1; AJvYcCVeWbTbGXFxq5mW3FMDzvVZgPu6rS+cKgfcoH8CM0lmZSoiXdpgSGgdDFMQQezrw46Wqh7mDFRQ6N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZjQwWee1nFSv36zbSUTIaLJnVqvNvNmjEGl2y/bl3VEjtn/O
	SdrkDB6pXUOu1B/Tm7es+0UIzeXK6absK0YWiMdHvV7SesHYLfYtUG9TUKD+/PyOOV0=
X-Gm-Gg: ASbGncuFKs0Lwma3+YqR/P/87CZFQbVSpjWN8TOFY66vqEQkhQ3x5ldnf956sFYWIOt
	Taw1442IzkIEGJgh/m+X8ItXjUE4YQIwBj9rpOVAt7sRn+0s/G7eQXjNUFZ2U6GfjSTg6TM0eVN
	16AZ/Hy7J0lAtJkyUf9ZxTJMjSyEKskbD0K6e6MbBfC/TLrHsy6UwMNEgT2SneivWo2zjIcdM1c
	6I5sHzLm4/RrLF51JParhkRqUtdYLlzT8Z7YTSbmLsUzXIJEwPVkgzt7GQqbuVaO7Ovuz2cX7AI
	BWmyNLWSImpPdvGxtnL3rTn/BMQL4dezumdFBKHfpswUTnjzmOJg/RnZhqylB7NBwSk=
X-Google-Smtp-Source: AGHT+IENhfICQtVFbADftr85Dr5PIfBzTkNl7ToSjNkBgjBnd+DfSLsY1NJ+qsOdHIdVQA5u4x1ouQ==
X-Received: by 2002:a05:600c:83cf:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-452014146bamr149777785e9.11.1749546199567;
        Tue, 10 Jun 2025 02:03:19 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229dc33sm11573487f8f.20.2025.06.10.02.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 02:03:19 -0700 (PDT)
Message-ID: <e78107ae-e2d9-4ffb-9a2a-bc04426e2a75@linaro.org>
Date: Tue, 10 Jun 2025 10:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <1c579729-4461-4666-ab1a-77f17a320ee9@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <1c579729-4461-4666-ab1a-77f17a320ee9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2025 9:26 am, Arnd Bergmann wrote:
> On Mon, Jun 9, 2025, at 17:32, James Clark wrote:
>> Using coherent memory here isn't functionally necessary. Because the
>> change to use non-coherent memory isn't overly complex and only a few
>> synchronization points are required, we might as well do it while fixing
>> up some other DMA issues.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> This version looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had reviewed an internal version originally and had some comment
> on that, all of which are addressed now. You did not Cc me on the
> other patches, so I looked them up in the archive, Patch 3 also

Yes sorry about that. I've just started using "b4 send" and I was under 
the impression that it would automatically CC all patches the same way, 
but apparently not. Maybe I'm holding it wrong.

> looks good to me and complements this one (i.e. you really want
> the combination). I did not understand the logic in patch 4,
> and it would be good if someone else can take a closer look
> at that in order to Ack that.
> 
>        Arnd


