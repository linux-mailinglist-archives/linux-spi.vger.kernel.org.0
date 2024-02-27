Return-Path: <linux-spi+bounces-1518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EA868B50
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8346C1F25BC2
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BA130E48;
	Tue, 27 Feb 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa9A3cr1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D130E27
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024049; cv=none; b=CKPQMq4xO11dbefjEAstbsaOL6YYVCeflogKENC1xC1chMWTQi9jxl0GY/fjdTEXNQmWLANOr/xF9tPAB4reSKmP+3nA8XQGUn9K3psrHaz56cGuTniB4FqcWkVJp1BiMPL5Q61/yS+pZqny5vjh+Q8CNXv8OoagtVmysa6cnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024049; c=relaxed/simple;
	bh=/R2gt8FfMfgy+vk+46mAFR8jEJEX98suuabTB+H5F6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCX9ieFxA9852uzAxFPdWxLpyOvY8Or3CI+7TBjtqhavjzewr7NtFisqVyZXus8vZaRUq9QFI9S+Yr42Yj/jmT5yijZs/HCMdz9ADgvbmPJi4nZ1O27p0svm6HUEt1wO0JuYRhn7BNJadhH9pDXlN6wXdz2ilRCp+otAjrGBPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qa9A3cr1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4396b785b8so103877366b.3
        for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 00:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709024045; x=1709628845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R2gt8FfMfgy+vk+46mAFR8jEJEX98suuabTB+H5F6I=;
        b=qa9A3cr1+HhmJD2mOOVUHM7KtK5zfWiiR/NrXwu9MJYLNaXkOcWMooMcBb9GOySzA3
         L/wfHt8PRRMs/JaSuSUG32Uio5zI9T0MQREHK3z8QCzmvrhHt902/mAQGFTyL5DJdU0N
         FDsHdxWLKOytxne4dsRVSSNW/5nWH8XF1Gia/Nv94ahOTJoLFvSxIzgS7PGQGk07/Rh1
         409NnSi/pb+aD3jMTRf8WZ2Kdt/bH1QJA3xpbOo4nZt+wGkqCkKObQNA0NVZXcpD9PJ1
         I3gJD4kcMgyW6Bc+EXrlG9IHW6+I2GmP0lQNlS7SPHIdNCEqrxEa5q18sVRFYN5W11o3
         oMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024045; x=1709628845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R2gt8FfMfgy+vk+46mAFR8jEJEX98suuabTB+H5F6I=;
        b=l3cdJQFpctlHLb2mOCCv+XW36fTX4P9MHBzfez8sa+oyuFOVgdXaMMkpWWSPvFbd+I
         nTHT1nB/CgBu0vaMVfVIa/KsdSUC0+mPZQJXXHeIyHTERPdd6Jxvd4sIbb/FVXAA3/sW
         lHqMg/xJmspvc3ltI9hl6RvX7UptQs43wx1L2+C1/GSnrtZY4iutzZ5FGX+Nv43VGiOU
         kIAntu1F8yG2TimVTFvYxNtsG5+IHSaY0HZeo//WeklxYsgWPG4bQ5xr4AZ4XS0smff4
         cKEA9R9vzAK6UHdLJZVVZ0qae6W6ZlX9ShtUeytghqFwEacz6rNbJHAP44A3EuDR3ztB
         DhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Mu++m6Z2mSTyPIbI5fdifpBd00y6CXvu7eJWMQRCEbPr88WnaQF/U9lgIG87ZccZumK+6eVXxLK+fuRxCNSQ0aGfqpJEPPJ7
X-Gm-Message-State: AOJu0YykCNSknPtq7s9FlnTJb1gUGuEvW+6aXitjYt8y0AkSh4ruDBKd
	PnFrH9cldwE1OMsFGN/nsAwaDXIG90LFMKuYKL7zIeJEnWLHV3N9WNeXCO4tnvM=
X-Google-Smtp-Source: AGHT+IGfbz+zIwvGhump2k6nxmb7eLS31X0yw5cokND+hQ1oEsVFKJwBygsFR+WovIqEMi1tyrEUxA==
X-Received: by 2002:a17:906:6d8b:b0:a3f:dae9:1e88 with SMTP id h11-20020a1709066d8b00b00a3fdae91e88mr6406985ejt.37.1709024045603;
        Tue, 27 Feb 2024 00:54:05 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709063c5900b00a3f596aaf9dsm552002ejg.26.2024.02.27.00.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:54:05 -0800 (PST)
Message-ID: <0b29d980-b3b4-4437-be24-19f54b473224@linaro.org>
Date: Tue, 27 Feb 2024 08:54:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increasing build coverage for drivers/spi/spi-ppc4xx.c
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/27/24 08:46, Uwe Kleine-König wrote:
> recently the spi-ppc4xx.c driver suffered from build errors and warnings
> that were undetected for longer than I expected. I think it would be

long enough so that we remove the driver altogether?

