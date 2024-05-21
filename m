Return-Path: <linux-spi+bounces-2966-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C368CAC47
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FE51C216D9
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC171754;
	Tue, 21 May 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAVizhNo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120C200C7
	for <linux-spi@vger.kernel.org>; Tue, 21 May 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287613; cv=none; b=IfHRjDVPneV0rBq/y1mKs6C9iM3nC/NaynMoSFOSE1JNS66molGciOmdBDG9dhPzrMXeVhdio9PQuXaioM9Jj0fO11ir3Qww7eK6EOPg5zDFht3LNzI0N5RmIPwogwVtEnyJ9gisl/WtKhmdcwnFoMyEwAdoMyf75kuHAVCvNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287613; c=relaxed/simple;
	bh=0u6UIM8iFaTpltzyLeJ8dCbbmFyKYz7mLy46mIHvJXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuJDzBHRL29Yd1Q4ZLZO2kE9N+CIsMaaqj1cq2A2WLoF5Gq25If9VvKHM/RY1NWYz/btT54WdhD9g7MkCcKG1l/hpJZEhKXic6ZkF1TADJNj24HDWlspkhTLKFJI4itUaF+5+Zb//AaPrljdb8yUZyJQY8BeiFQiFy3JjmQdvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAVizhNo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41fc5645bb1so26875575e9.1
        for <linux-spi@vger.kernel.org>; Tue, 21 May 2024 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716287610; x=1716892410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=niO9rrqulA3peI5oMcJVtaE2tFWL5PRxfv2nA9iXo6Y=;
        b=FAVizhNoNVwch90JutLVaE5an25GM301AYXPPMv5/LsQEBxo7d1S4l/y8ac74kKZji
         SerO4TO5SyANPxe2qTf6abvjxOGVt3z9M3HUQnk/rZp6GOKyZXvmljTHSZYQJ3z8h1bb
         upw+hNW7bU5nIM9q6Uxu4EbuiRURlKt203oWZxbB9/IO0T3SEr6uENHloWzDwvxJcDAt
         Eu+10hSnYOPyzR+7GwxoGGmHxKfkeRluMaDdySMDpAZEHND11D2PYtoanaZ275W1Of5z
         IvQW2BblMNnXE4MXLWkQ2wh19whaDBY/qAj9MYNNruEH1TUfPTCXJROmhltUC0MudVDH
         pZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287610; x=1716892410;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niO9rrqulA3peI5oMcJVtaE2tFWL5PRxfv2nA9iXo6Y=;
        b=C6BF5D5veKp4OpN2qdcs7bGZnBDC10DiTd5k521aK8ZXYaJJA75leAE54+hV8nZscy
         9AX9iiMthJTZpdcVA27Bqcww4iSvoOM1IO3KOzIJSipzSB1qCT4j4XtSKjWlccvGl0km
         Vif2X626FYn4vdWcq8tEZq1mu4tWWQdOINwqaFoyYtSPYsBMwl67koMCnzfFEZBzD08X
         srn7jMkVXAZ5EYLgskL+CZ93a8ifDpXKYIUIJsVYz4bfDJ7wK9xx6GdtboZEZxOr7tzm
         +zddkR6JPJ04pWDnX0jrC1alyuKPfUXAukVBlTAJUx6cp1iGqO9X+KSV4nP+q3U1uuBQ
         DyXw==
X-Forwarded-Encrypted: i=1; AJvYcCWmtsUXCtBidBOWptOm166a2M+I5wgz/CXgP6dcIBhsmOQu+3sYVZ8PpcwsflHfMNiTPUH8VR3F9Xd66F65qPNmXmNZNrpwq4da
X-Gm-Message-State: AOJu0YxXi83iVm9v0j6KXnH1bS1YDbKZAfAqdjRN2fQsMriyNfaUGjCI
	PXte0vvld62Xzll82EJwma6R78I4v1NbmpEIzVeJ2gkX7tpRHno8tTcj932hDzI=
X-Google-Smtp-Source: AGHT+IGfyH52F4fcYXiI9Q4662fyuZ+K/EqY+5Zz1wttYVlW9jxn1+zZzcq7olGpCU7w2v7tljZY3A==
X-Received: by 2002:adf:f4c8:0:b0:34f:10f6:b2ce with SMTP id ffacd0b85a97d-3504a73ec30mr22322588f8f.38.1716287610213;
        Tue, 21 May 2024 03:33:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd7asm31310240f8f.17.2024.05.21.03.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:33:29 -0700 (PDT)
Message-ID: <c3421a07-3373-4dc7-aa5d-0ce0d627b330@linaro.org>
Date: Tue, 21 May 2024 12:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] spi: cadence: Add MRVL overlay xfer operation
 support
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-6-wsadowski@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240509010523.3152264-6-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 03:05, Witold Sadowski wrote:
> MRVL Xfer overlay extend xSPI capabilities, to support non-memory SPI
> operations. Marvell overlay combined with generic command allows to
> create full-duplex SPI transactions. It also allows to create
> transaction with undetermined transaction length - with cs_hold
> parameter, and ability to extend CS signal assertion, even if xSPI block
> requests CS signal de-assertion.
> 


> +
>  static int cdns_xspi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -905,6 +1140,16 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  		return PTR_ERR(cdns_xspi->auxbase);
>  	}
>  
> +	if (cdns_xspi->mrvl_hw_overlay) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);

Use proper wrapper/helper for these two. This looks like you are working
on old, downstream kernel.

Best regards,
Krzysztof


