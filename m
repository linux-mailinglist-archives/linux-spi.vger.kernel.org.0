Return-Path: <linux-spi+bounces-627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59280838F06
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C85F1C23D40
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155E5FB80;
	Tue, 23 Jan 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj4Z+Mdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885E5F85C
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014500; cv=none; b=J0wpoGSocMF5czEBCT72cpDMcNGuZ70TnqLuXvH7M0Bmb5CGcCyTx3u5Azn4VPuj/4W9s1HiI+af/hdjhauo5u1cnTZNHAvBVEqYiG6vOtJiZLjuzupfDayrB7MMvl6sJouedx0/7HM+lfyMzgqRN/C5/UbArbVgbYvFjQR4JwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014500; c=relaxed/simple;
	bh=pHJfpsGIA6DNYeLhapyaBucCSPrJ0XTjSqkBSTj1Kwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UyO2kHFThpr0AX0WbsoqRMnXK64jGhJvvipqzhXpZUYfVn5d8XMx05vjQuWNQ4tLLi7Y8Fka8D9eqoIUftfEGn2vXLEMbfZZaSzLg7wgYucEvSRBmOaDPyAkjLEUxBgutcTSPTxPNYezHAf1FLsoZmA4rd9KMqJEhWtONMR8ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nj4Z+Mdr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so3779706f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706014496; x=1706619296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79NZc0AP2mciPTr3QytFCn5kAzjJNvksJU9gtoVk85w=;
        b=Nj4Z+MdrTLzJg0NI2zbDzsx20oNmgU1JuCbg7TK3jApmQQkGBceDEvUJhhzpvzue4h
         I5U0KL36C6wD26iIS9redlpRGHxhJ9wrZbYaN882kCLp79UwZJ6nGEAg/FZNmJBap6AI
         7Q8+F5vl5JqWzIk+HEjDc/OMyGq4coPk7Uhyld8WvDAZ5OZN8UkaHkv+/9B6pt46cI3I
         xEwoicknWRIfGGbgVAG6Ujb1zqZf0CzOps/0S3XM0+bQEmovhsaNQ9gyx2eIWr43kQ5c
         P6T30YMsu4+tj5mBnMVcrbWF8OOS8C0HmhqjhKpIFDs8KUQzSEwwLwDFATiUDIMcBEkX
         EaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014496; x=1706619296;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79NZc0AP2mciPTr3QytFCn5kAzjJNvksJU9gtoVk85w=;
        b=QKFFt28TyG5GJEaZeFm7VOm4vw23hVQqufo5kaj5XyrK5oPsAsXUdUfe26OlrgbKhG
         WT4t4UShawVxwm5+ESF3YJMTZ55AwGo+4Z2jtI4JQbaj1dhF5nu8OxTQbbKMPLNAb0Ql
         yeCMj0TSKtwyC99Gh3nPTdcgkebB6bitlxYsnvOBmjt9/5ta9+fs8yMBAgsSV/nY+Zu+
         MBDIYhJhK6LIneTWMG4AmBvrrWt45GVmzlbcvKv/0W7Dpn96CorIQjb38uRWoPJrG/cI
         R68gQnljq0AXE5naD0GafQRIJIQiWmbJVG9ZXHUhxX20LzWIBZlaAXHXudSA1obe2KQ9
         2C3g==
X-Gm-Message-State: AOJu0Yy4ingBUxEbeLEJey7kCU0sZMfsrwa8EJ+hB/4bNq7C7eE4zsRi
	w18/Jb1DcYuHJQxUWlXJEYzioIyfRQ9G6vna1suLZffFT73wNkIMdi+yXKectmI=
X-Google-Smtp-Source: AGHT+IEzKIWC8YDnKYIuEjTcOpsBjrizfe0GD6ciUhggMbQXrUPMqM2FDKz0t5iQ+Ntt4wjoZOm4Rg==
X-Received: by 2002:a05:6000:402c:b0:339:358b:b857 with SMTP id cp44-20020a056000402c00b00339358bb857mr2232259wrb.94.1706014496785;
        Tue, 23 Jan 2024 04:54:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id d6-20020adff846000000b0033725783839sm16173587wrq.110.2024.01.23.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:54:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
In-Reply-To: <20240120012948.8836-4-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
 <20240120012948.8836-4-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH 3/7] clk: samsung: exynos850: Add PDMA clocks
Message-Id: <170601449519.48954.8617211132364348262.b4-ty@linaro.org>
Date: Tue, 23 Jan 2024 13:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 19:29:44 -0600, Sam Protsenko wrote:
> Add Peripheral DMA (PDMA) clocks in CMU_CORE controller:
>   - PDMA_ACLK: clock for PDMA0 (regular DMA)
>   - SPDMA_ACLK: clock for PDMA1 (secure DMA)
> 
> 

Applied, thanks!

[3/7] clk: samsung: exynos850: Add PDMA clocks
      https://git.kernel.org/krzk/linux/c/00e532cd023ccee170239360978c65eced06125a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


