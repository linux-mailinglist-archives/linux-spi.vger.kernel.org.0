Return-Path: <linux-spi+bounces-5802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684799D60DD
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D55A280D1D
	for <lists+linux-spi@lfdr.de>; Fri, 22 Nov 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C062AF04;
	Fri, 22 Nov 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XvSO/s0E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DC481C4
	for <linux-spi@vger.kernel.org>; Fri, 22 Nov 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287152; cv=none; b=oA6MAy9my/WlH9aoxGCRsPR0ctsgP6tfH1y1g6O3+ntkvv9srylPhmSZ+zm3CahhvDAiSqT4oxAgsdLb6Vt0+K8QBDi4QfIGJYfM+dZZw7UO8ynVGT+UJ5fwD/xVROR8IkFPLBy9LjrBubcMak+C6WJpELvDa677VobtZPp1S+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287152; c=relaxed/simple;
	bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Zt0YnJ38COZrXfql1yiTcmNfXzWGrWvCMeCSUzb3CqNXPSBBfAHWusQRdPA3LppFYID46JxHtdLiO1azKZv3DIDCdBG1e9uQrIVh1i2KIDVwYE+BeP0p4ZqOMzDoA6bvrm/Z+XqRlz0Jtjvqlxq6QZtauior/uPc0llZyZGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XvSO/s0E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43159c9f617so17965435e9.2
        for <linux-spi@vger.kernel.org>; Fri, 22 Nov 2024 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732287148; x=1732891948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
        b=XvSO/s0EPlECsMWkGQ016IS5liDiLHjDijux0bhHXPlmYfoT48u70KTid1ylKav4fD
         ZTeV9ycSog/w8X3wsx/DVPVL+f7/FDzGZXopb5GCt1AdB/CTDvNYhpnwTWcNnc8V97QH
         cEhwWoaBCs6OZ0/SRFM1wvuEXxTux+tqlArjN+Fpfw3Z3q1RCBMXrexGlW8eIrCT7juN
         8O4Ae7fV0Re6BMaVoTPQZl/Hc6U5Hl37W0D0lEK5kDvjQkxOsq4qOdkASUpnE+2ZactS
         jWpSNfZbL8QfnPhg7EXVYF/cqlAFcDcJjL+wt9jm9taXMtw9+Tb8zZ9jt9gVC5immPQp
         XXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287148; x=1732891948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZH4hse3qfhm3J5KjDY1bc57PZTgGnGOXIlR6oGR3g=;
        b=JZi/c5PTNoOG0rK3lFpx8zd0zwaVVav62jCrlhWnnQWnJSnGc3+Sq/1sPQEw492QBl
         hUbdPcWqp8lKj8tE1M6bsk2DR323YAu61s3JxBexIyZUnG+mfgXRPjY9I1/P4ox7mGj/
         V9txhs1lGdfJv4qIC2J2nRqriJ8627JX/yoq/qqJJ4UNUPxKc60DPZ5pMT62zEzQjytc
         acIYGwsw5sLUBNX71lliym3xIyMfWpRXuDcbVmUqOSV0Cbw23SXiWSjZTvTxrLhIKdPx
         +IoOh2uK28W1SaBC55XUkZEe7cS0ex8LmIUFIlEdL4wNBkm5B3UZUkrlOnnc4RuC9g4/
         rsGw==
X-Forwarded-Encrypted: i=1; AJvYcCX/EqhOxlxMnifxW7uFPU7YQ2nBcY9D9gj5O7LCfSlA7hIZ0qdKNi0e4ANh3KKZtviWrwGoShHr7kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSSrI2cE3ehfAU4C3z45CROJIUDbJKZGodgRrTP7p/UqCdOoh
	5jEr6ZnQAoFm6ZOu6+qVKTd20MFh0EKDeeCJJLcDdzMuxgmXsBFkenIwwVkUOxk=
X-Gm-Gg: ASbGncurqk1o5i6TlG6v8WCmN+dqBmqQuaQ+Vq7O0JPMKT2pmy43c9LCfCR8cbiVAmS
	ZTkuR2FkZx+7a6hYmy9wSocWbBFz9D+b5sLN7beHz8JXKeqWp7K7mk8Z/uOHuNYcW8CflyakF1a
	XL2f/h4+g60eH7uDtA/QrVUvgOv2BNF3DxgliKzHHex+TObaHvZ3ZTFcOhLeqSmYLSlztryXjYr
	zKOEX+eJUmVze0LoA1OnOt2ygM+NhlQOf2Zls52f1wPu3+v8j8+cEEENw==
X-Google-Smtp-Source: AGHT+IHsjxLFgEV15mKQiBicElXEUDVmwQhGml7xxTkNfAnsEvktBECCBV9Of39mNkEwnuKWhKEvsw==
X-Received: by 2002:a05:600c:34d2:b0:431:4f29:4a98 with SMTP id 5b1f17b1804b1-433ce4c2319mr24740675e9.20.1732287148506;
        Fri, 22 Nov 2024 06:52:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f642f15esm117534725e9.0.2024.11.22.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:52:27 -0800 (PST)
Message-ID: <a326f5ab-f36a-4210-83ff-0f2ae9fa830d@tuxon.dev>
Date: Fri, 22 Nov 2024 16:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Fix register name in verbose logging
 function
Content-Language: en-US
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20241122141302.2599636-1-csokas.bence@prolan.hu>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241122141302.2599636-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22.11.2024 16:13, Csókás, Bence wrote:
> `atmel_qspi_reg_name()` is used for pretty-printing register offsets
> for verbose logging of register accesses. However, due to a typo
> (likely a copy-paste error), QSPI_RD's offset prnts as "MR", the

s/prnts/prints ?

> name of the previous register. Fix this typo.

