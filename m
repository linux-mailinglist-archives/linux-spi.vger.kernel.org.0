Return-Path: <linux-spi+bounces-8911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A4AEDD98
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE25167F65
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C8235074;
	Mon, 30 Jun 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+73O+uH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAC27E07E
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288087; cv=none; b=shfltZ7eQ/cbsrGb2iB2VPibodloZoAfjSdAHRK4kTjA2ZFEaAXnBHyByqg1NcucDlzKzw1WhAQGAWxdH6zP7w8RMLFXN77HFCz0JTm3xS3/GYv4WShnv1MwWcR3ipcgrKTltjXzkXXNeuOeJpHZR9aFFhYtDvFSuZY67oljGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288087; c=relaxed/simple;
	bh=dFUfA59cZPhURFeCuho8nEpvNW1tRPC7vIft9cBn9oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGYLy0MtMO9/a2S0ocdxwFWPZ8aiv6jz/BDNFDqHPbS8gu92oitZe4LM6/M4EhfSy7XII1b5MqUYkrnHhnbj5/QuK0SOj9XK12U/SLbv88KMGgMpsNE03GrB6H3+bkn85yrAsyD/CDK4xbErhKCqjfwL/FWGNahk6Y23Yp20u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+73O+uH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3775863f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751288085; x=1751892885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6LLhW0l1DwH7atSswhul01kdjels/mjiCnzYleUxWc=;
        b=R+73O+uHqcbAp5zK871JbSGR5idK+6Fw1kZbydJbrvh51xZW+IfTonrgCMQWPPAz+R
         dOQB08F4cjT8Y505YGGIFHAa1LAxXbjxmVym1C0/7mQC3xT18eaT4gMklU7fhxCI3kAz
         vH0ZMpQ7/i6HRkVk2PgXmmGoox9/khzGoSO/LG9G9tsNQglMCSjogpHf4jmnAAnNam3N
         tdadz6ilBd+goYmphFQA3jqKaDhKbF0eENBxiOOLZOZSk9nnTUIFyt/znUznkJ3xVYng
         yT2qUrVcaLnJIw4gQKep24ItxO6tKI4JHEt4AEdfupegANLOJbPcTWfMWNBx98IBpNpQ
         Vy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288085; x=1751892885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6LLhW0l1DwH7atSswhul01kdjels/mjiCnzYleUxWc=;
        b=N+nbH+wdg248ueyPplKFfltC7QEgGYCCEB5bI7PI4M+MxL+1iyOkatzt/fuANVMsoQ
         w2vOnRVfFtxc9N6eXpL6hW3AuXgdmpB0jiqWcC938/taA95kJjRVN2kh1UdXhdaV6Bt0
         fE/eadOYBHmxE+Yup3lONvxcA73F5a5TYS4U2kJ4x6NdeZnrTw9yuCQHmSn7EgJm6Q1e
         Q+6nE60Ewq1PwzF4FcpEcMMRf6jCqk4mrw8seSBsBYR02cJyihcxo84jqzsDSkzPH0RP
         p8IZ7QgwM5XTdsLS+sd7ttvJY6qCS0pZIIsLaQrdhHmWzvC0LSQwFVH0BJYxfkgj2I9f
         JYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpAiSYU8MPyw8aV2iEh6QigMdcls4SwQobB9W00DBBqrgE4k3NVYQO7NL/jVzLUCAPHbYON4omO10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4WUuPL/bK+x/5rx1V3WWtZdOp5cdtpd8uGWET6ybqux4TE6C
	niKvZ8lY86rQni62qrgRT9Uj3aiQQ230CfV3/Hzjm733gCDUAis2WfMK8z9R6gU4izk=
X-Gm-Gg: ASbGncvc06s8sAJzZMDL1BU1NF/GRC7M1remkqScACnoIe96LWLDyNn3Ur1qhEC/tMu
	n5fP+dcfRro/SYlih+5OVhzsNYIfRovMB5Tun7zTgORTM5pE5Y1AxRB5zYpdfriPM9BB6dNdlGB
	BZIWgm1G5ZbxPXcjqPhR+I0BCBmAt+Q2XLyXqGpxVe5TVyhhha9mBPZ99tbtr9CdtTx1PDfcFAY
	I4jW9wyLy8C5/bSBITGiPQozbL1w9Mvrg9C2CLcSMboZXVlUA2hsqf74r4cZdMJknET6NHwGDzr
	tQEpknGKmCUa7Qrg39KK9Hn1U1yd5IEjh5+AYgCw7XTVyc7jI7oYh6XPsEizK1ku7Qk=
X-Google-Smtp-Source: AGHT+IEOf3lWnYoS17T+S9usuCMf7ZAOx76NQaH3qOvK0doAAUlbSt9hmIVQE6Nph3hAnN/TUv8l9g==
X-Received: by 2002:adf:fdca:0:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a90d5a7cfemr10289035f8f.15.1751288084621;
        Mon, 30 Jun 2025 05:54:44 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453888886ddsm95050155e9.0.2025.06.30.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 05:54:44 -0700 (PDT)
Message-ID: <e7a7dbc6-c423-44e0-95c0-5b3323f83c8b@linaro.org>
Date: Mon, 30 Jun 2025 13:54:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <175128365072.28911.16806664823646528710.b4-ty@kernel.org>
 <9f707fd9-a9f0-45d3-aaec-e20bad4c4f76@linaro.org>
 <e5dabc83-eb1c-46eb-b24e-6dc8b19c4ff7@sirena.org.uk>
 <d86c48f4-fa10-4205-b0de-43fc8be0c848@linaro.org>
 <a164abb4-0863-4a0b-b2f5-f7c1b36e408b@sirena.org.uk>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <a164abb4-0863-4a0b-b2f5-f7c1b36e408b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/06/2025 1:40 pm, Mark Brown wrote:
> On Mon, Jun 30, 2025 at 01:36:17PM +0100, James Clark wrote:
> 
>> I was a bit confused to see this notification on both V1 and V4. Maybe an
>> artifact of the first commit that was applied being the same?
> 
> The tooling remembers if I ever downloaded any of the versions and
> didn't explicitly delete them, if it sees a patch that it remembers
> it'll report that it was applied.

Got it, thanks


