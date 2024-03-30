Return-Path: <linux-spi+bounces-2130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16233892C2C
	for <lists+linux-spi@lfdr.de>; Sat, 30 Mar 2024 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D3A1F217B1
	for <lists+linux-spi@lfdr.de>; Sat, 30 Mar 2024 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8B33CC2;
	Sat, 30 Mar 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhdU/+3Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0EB3BB2A
	for <linux-spi@vger.kernel.org>; Sat, 30 Mar 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820537; cv=none; b=DTHJrAJxpSYv9OLPUy7fAABYgR3aITByVi0+E884s9FqC/ZxBDq1ttRiWAgK3HZbHafPlHm/3GlvTBxebJqbrOlqTojL6bbSVTipWSfxpSpB82J7O+TQyAIGCvyoZirJfPL0IzJVEzD16cv8+WCDfiAZzFatEYF71RkUn0lhHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820537; c=relaxed/simple;
	bh=Hen8PBpcINdNSOETmg/71zXMc6uXhIQgB0n1Ao46iQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wx/G/6eo51ssZ9fLs6Uh3rL32TdxmrtFauY5rcaxtOkjwDqe9yPO7sdPxuW9KP5mHkB5oZRz5SqTYOalFgGnvelyEmB5sg5AtIysvFrb76vxvP3zsbsg3DaPo1INJf32x6jOODznbUnI2e4G8GI4w/stJh56yM/5FYNU/ZtyiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhdU/+3Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4155271cb59so8670455e9.2
        for <linux-spi@vger.kernel.org>; Sat, 30 Mar 2024 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711820534; x=1712425334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lR35U1VOKNo+qXyf+JFRn0nMvSnOjECaN2wOLlcW09I=;
        b=lhdU/+3Z5fLCkB1uNOWamqWgQR4vB9b8+y6vMfYoIhgivIr50UqYKMttCIxiYMla0Q
         4aIAOEux7a672dg8suhQAVjjV7Ls1LffGvgUOLfq+5uNziQHS3dxmc07tKbS8b2/UoZJ
         h0LTxslSXRoUA6QtC7syLYWIKZQzwgCOTwftwyn42A1oKxbp04SKvQ/ArWgW5K7NPmIn
         Wo/xvgnyNx0DtjZjhj0DNcN1s+Yw1IGhywavXt3bOXU8DSeELzJ252WX8QevtQbkom1w
         Gt3z2mveryqyZGzB9Z/EKNWgjh6RrbucKuuILn0w738ijLc1HQbx+tzckwyGQcEXUCuZ
         KZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711820534; x=1712425334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR35U1VOKNo+qXyf+JFRn0nMvSnOjECaN2wOLlcW09I=;
        b=G/AwHHD+LtQ+pp/b/vIxKNvM2sivnvAk5ieB+wb0MN1+cds7W9xWpvLDIBc4btffkc
         WppOSAatp5KB0LOw2Zc+Y6nrPSGwCUbFeskYrdSd8yXJvq2O9u9JIecDYFUD0xTO5PS8
         wpQkUxbtW9i+6e7DWF3NF4VUlR4KUjNj2JfDKAkLWx2jBrPI8Vo624Iwo8BTDJuGXtcb
         VeJjSgyR2NT87j81vmUVvzWz3d9dq58ZMPwj/KIAZkobEm5XjNvxjx/NFCMXOSTW15aI
         A3LcPJkPCHEPDoVC7M7MYss5x5g4kIcH/hI7V7g1ZhFcrn+Sk1Vri5mCmXuJMW88AmaY
         X3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUkpcgpsROHFfwDeZ/6vnfb8Rsw0M/ljE7BQ6qNPDl6Lu+Gt0G7ToapTN8Q8Wd5PTeE1xq4ZDGGlRpbFyltDaYcsO5eEV1h6iP/
X-Gm-Message-State: AOJu0YzRi3+ZP5NC8VxUYcBf59hYDnCYnq082ztWlevbqy5F/Q99aFSD
	gnvSNQMJJnKhmkyvvJl75hxljDThPHn8AzRMEyq+HEzI3mn7d6hod85k1cHqRgI=
X-Google-Smtp-Source: AGHT+IHrkllIi5mfrByc8lYfWAk6qF11zUIMrepchS11JN8T6OjjsvcVCrT90r4/MQUrOkDxge05CA==
X-Received: by 2002:a05:600c:3502:b0:414:8e7:cd60 with SMTP id h2-20020a05600c350200b0041408e7cd60mr4238845wmq.8.1711820534042;
        Sat, 30 Mar 2024 10:42:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c00cf00b00414041032casm8567709wmm.1.2024.03.30.10.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 10:42:13 -0700 (PDT)
Message-ID: <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
Date: Sat, 30 Mar 2024 18:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI
 controller
To: Qingfang Deng <dqfext@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Qingfang Deng <qingfang.deng@siflower.com.cn>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329015147.1481349-1-dqfext@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329015147.1481349-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 02:51, Qingfang Deng wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> Add YAML devicetree bindings for Siflower Quad SPI controller.

Describe the hardware. What is this Siflower?
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  .../bindings/spi/siflower,qspi.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/siflower,qspi.yaml b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> new file mode 100644
> index 000000000000..c2dbe82affc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/siflower,qspi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/siflower,qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Siflower Quad Serial Peripheral Interface (QSPI)
> +
> +maintainers:
> +  - Qingfang Deng <qingfang.deng@siflower.com.cn>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: siflower,qspi

Except that this was not tested, aren't you adding it for some SoC? If
so, then you miss here SoC part.

Best regards,
Krzysztof


