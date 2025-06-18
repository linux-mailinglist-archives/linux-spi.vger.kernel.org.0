Return-Path: <linux-spi+bounces-8663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE5ADF5D7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005BF188D82D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39B53085AF;
	Wed, 18 Jun 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vd2WvKgj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A652F3C33
	for <linux-spi@vger.kernel.org>; Wed, 18 Jun 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271259; cv=none; b=XB03CxU5ZFzDMAsVpdgROq6D3FhpngzwXzQtNaCpD7USr4oU3dSGbkQs2nR+bcpWHomumkurLlbGiaErtR3vlBJMg4OPSwbLU7zjXTwij3gvuExvFpWqRpGcV1aqf6+7rtM/87/vZQy3YOrR1TxLEwLXMextfCDU+fJgD/EzQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271259; c=relaxed/simple;
	bh=8erTa4lex0kgWaCiz++yqQTutSRNZ0et/sDqzyR34Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSrJVPqIaRuyzCjLTZmRnMEwzVaPsA398goe8sVEBa6TSfXHr3kyWSqfuW4fM5khDWi1YojvKJavnerj0Z/F6BZB1wvtsAGbI0BedoDVnew7XN4Y6la725s78cl6IKQqaTj7tYM3q9tQ0XgSPyuNEmrfmbqiWfwFPZiHnlYUkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vd2WvKgj; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40669fd81b5so4374606b6e.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Jun 2025 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750271256; x=1750876056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YBYuQYbzLC80oZvh7S2m5LwCzlb8lJZIkclLoGPtU8=;
        b=Vd2WvKgjICOoIyD3DUGFwVR0jICN8GM8IOCFL1VOC93a/lKI/F+L4qLfEiWuUTxAbU
         FMfHcGhW5FnTbgPSspLrz/nDVHrVXjvXxrQofbX9HqUTpPpDR4jgMRmDY4YUAFRjN0Hy
         AMHKmhzmsYckUnfZnuoc9aY/wLJ0q8gkoSgs6F122yoA70VAAFdmjJKWtfe0o8hQORE2
         PxRYzuL+8lrRjovbhLgtZ8rzsPntfp6AaRxBQbn6yo7CRlSviky46p/Bxl26gFKyJ/A5
         oKy96jDoIeE1v5EoFTuqZFEiL8y8pdvtv/JaOh83Tx1c24RCwYCj8WAwhiBEO0AfobZD
         Tb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271256; x=1750876056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YBYuQYbzLC80oZvh7S2m5LwCzlb8lJZIkclLoGPtU8=;
        b=QKhmvJwfyC3IdVv86a9YmORvhTl/YZmwknILEoLdHK+Z3iUjgXTz1iFkbNTr5RGsP0
         /7iClU7XbP69Kkz0puB9CCjO+2HAX34puj+EwLb6cDuUBNlmrXMxsMN8i9LniR+WmoCY
         MMZuUtuUwVzeFJPemnNynypNDun04ras14gCzmGE+4H6r0r0YOcqiqqdEp2VZ/OoiiXd
         zVeja1UrMJ7TKI1TzuHbnHHnw4SbaXPlsOB1Bk3+LuQn7so/LPTyIZwUZzdB71w1jZqQ
         ZNoprFCrzzfO7vwHIAAmBXkhNhDdQoIoG9DaZ9owGbP9Vyp8OQgrKZ6KIWvbMADJgzwV
         bHmA==
X-Forwarded-Encrypted: i=1; AJvYcCUkAS8o73bjlmnF2O9PIXI1Dl9Z8z4r0oPWwX1sESy/mnARO5ahDP7wtlzVtmb6tpmmcpNVP7M+xIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDJTAUQh3fpcAetOzB7aWwGUrh2E8Y2BpnB9Cc8nQTDHDAEaf
	L0kQmKdXfLIGbHeFWmA3gHB87NRIw9EUK6D3klx1SaCFn4ijC1WCsTTvQA18HQhu+tQ=
X-Gm-Gg: ASbGncsQWvzzAOnlcYexqw94lWEqCSTkwuB5IxPceLm09P87ICJqyy16IrzVMO+wREJ
	7oQPLeMRinAHKseMievAc9YkJ2Q+P9/K263X8NxjIXjmSAlJV2OKqAdw9lY4RsH/vdK17//n+qT
	mRJYl1YC+JKO2aU5zG8U09ipRc2b9VgSRqGycV0l4tz5hRcJXABR/2M9CV/p+iXXfNSiG/gqi6M
	fb6BlGMTttk1EP5SnNX8J5AinBpVssvCgwDQFANxWKG1pIKyTLnvHfhTA0ZtDOEyaW8wFpxMYb8
	gpvHxjbZFZVABURK83BQ5HQW1PfrenvW7VPyzC7AeKezNtcJeigIzWtNdZvMR1eUXsAstu62oRg
	P3I0/lIJF6puvy32YMF/zFD2tlv2fJZM85SU+t/c=
X-Google-Smtp-Source: AGHT+IGfYT6pTX84G34dN1v1rA2QrNVoZ5Qci8skHuTcu6xXSLE5XMAg/YdsULkFqRm5674RrJMxag==
X-Received: by 2002:a05:6808:13c7:b0:403:3fb7:3870 with SMTP id 5614622812f47-40a7c1cbe28mr10969858b6e.10.1750271256246;
        Wed, 18 Jun 2025 11:27:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9583:1e37:58ed:10ae? ([2600:8803:e7e4:1d00:9583:1e37:58ed:10ae])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a740c2748sm2437844b6e.18.2025.06.18.11.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 11:27:35 -0700 (PDT)
Message-ID: <2588bb7f-2a3a-4001-ab1b-6d9bd57b545b@baylibre.com>
Date: Wed, 18 Jun 2025 13:27:35 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: zynqmp-qspi: Add example dual
 upper/lower bus
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-3-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> Add an example of the spi-buses property showcasing how to have devices
> on both the upper and lower buses.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>  .../bindings/spi/spi-zynqmp-qspi.yaml         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index 02cf1314367b..c6a57fbb9dcf 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml


In addition to changing the example, we could also extend the
spi-buses property for this controller since we know this controller
has 2 buses.

  properties:
    ...

    spi-buses:
      description: 0 is the "lower" bus, 1 is the "upper" bus
      maxItems: 2
      items:
        enum: [0, 1]

Not sure what to do about the default though since as discussed elsewhere,
this controller needs the default bus number to be the CS number for
backwards compatibility rather than `default: [0]` as is specified in the
previous patch.

I suppose we could leave default out of the generic binding and leave it
up to each individual controller to decide how to handle that.

> @@ -69,7 +69,7 @@ examples:
>        #address-cells = <2>;
>        #size-cells = <2>;
>  
> -      qspi: spi@ff0f0000 {
> +      qspi: spi-controller@ff0f0000 {

It seems more common to have spi@ rather than spi-controller@.
Is there a push to change this in general?

>          compatible = "xlnx,zynqmp-qspi-1.0";
>          clocks = <&zynqmp_clk 53>, <&zynqmp_clk 82>;
>          clock-names = "ref_clk", "pclk";

