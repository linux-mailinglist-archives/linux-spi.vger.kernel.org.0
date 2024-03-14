Return-Path: <linux-spi+bounces-1803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D572E87B83E
	for <lists+linux-spi@lfdr.de>; Thu, 14 Mar 2024 08:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64ED8B2165E
	for <lists+linux-spi@lfdr.de>; Thu, 14 Mar 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B70610E;
	Thu, 14 Mar 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnvOjuOQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FA539E
	for <linux-spi@vger.kernel.org>; Thu, 14 Mar 2024 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399943; cv=none; b=a0Y9Exqv+w6tfoAhU9ODWiAjKED99liSapV6sRpGeK3XKK+Mpz7s5P1p5XEg4MbQAKcGezR0+RpksRfEyWIO+wDnyATyOFt8Clrv8FHePFrG9YWdnKwY+fy+b8syV1osfA2SmgpEpIqleoBRJWqq39oHIbDkoFS4w+93f9D89vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399943; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcJic57regtKcA0vU5rfuDta+8ixUORkqQeSb1QXiiKUxHSG5mQ8diN4WuSNgRvZpBTFqwlEnemqawuiogoL3D4d9AajnsXa+wiL6h9cy2qPlcnmNBvd3isv5bAxTa+AXcUz049urGiXApqIdt4jEwgBavfAdjgZuRJI9w4Ehdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnvOjuOQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e39226efso637482e87.0
        for <linux-spi@vger.kernel.org>; Thu, 14 Mar 2024 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399940; x=1711004740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=XnvOjuOQMO5rm41/7v74x9amXbVw0dW/3YFEO0qvJ8bWUHLzMHs5G0O+oPeMsdYsXu
         kverySlewD4RBgA3+pDrlZIT3NzSN9b3jAkhkrNM1WONHCj5sRlEoQ5UvLkc/mNQX6EH
         Pj4yPjoDVNRDMzXOMm7JggdrGRmqhioakRxkHAHzo4m/SdcsRQkjghHZtBMFTmMoY7Xy
         Tf8knEZnacMzVYRqkHA6VEKc5rdSE74/GU1UjISZEUKQfnVvFuM+CfjsX1Bq0MhPTIFY
         9mxGFQwOyAGWE62aisMX106Cp1epRD5yj55HLeMjwVDp1vjwpT2JHprbs0y35r/LDDkF
         W02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399940; x=1711004740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=uDzaajGBL4Gi08kxYMchPXEZUZknyVPa8eSofIS+X/3yGKtqMhAxPY+x3dARWAtxyd
         8zan/OWBh3Id2erb6j65GNmtWtnBPcowZ88OKl9G6JbNuGptF4PW861EG3iTl/9pWIun
         Ma37YCEEXFC8xNGPvWOQSK1mik2WiKHqj8dlX8t2ujGb/3c9BBGU/tkpTa7gTqXyVbfn
         BQfoNXjy9lDL0Skwy3cvHr1+Xxwex6WXHYd93pvT+1VCTxbau5YLqYLHpcWJZo1/k7W8
         Ht8K6J/f6i/f6ma6k3Vxg21LFK7Jzr8oBNuTqf4PNuURxhspG2xpGJJZiszVAVJLIYnI
         vrZw==
X-Forwarded-Encrypted: i=1; AJvYcCXgJtR0XT7+6huCMkxJtz1VjYkLdICZHWJMpn/F5NGPqTW/cZJwKRhvkJcwMeTTXc06KcATkK2QWd8zOSGVUQYO9J9vwOK3sxwt
X-Gm-Message-State: AOJu0YxFsHUzzsVuFML4Q+ZsoQwHXd4Ii24K2tB3vB3UhkIubIFpVGIE
	3L3Bk1R0AqkyL7Zg/9jzxh10MZbQdtNmqADmyQN2Sj/ObUm2Cfq133fy16at+moHeong9LERssa
	e
X-Google-Smtp-Source: AGHT+IF6AKlpHi/SbY50G3BjSHsIPRHiOFvTYICSs7fONjFyEnVxxF2SrMSlne0E/phDX1Sflk2yAw==
X-Received: by 2002:a19:741a:0:b0:513:5c68:9646 with SMTP id v26-20020a19741a000000b005135c689646mr484483lfe.43.1710399940587;
        Thu, 14 Mar 2024 00:05:40 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id hg23-20020a170906f35700b00a4380e85e5csm391461ejb.202.2024.03.14.00.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:05:40 -0700 (PDT)
Message-ID: <a9c3ebb0-2ea2-47f6-b630-7f661d0bf33f@linaro.org>
Date: Thu, 14 Mar 2024 07:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-spi@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

