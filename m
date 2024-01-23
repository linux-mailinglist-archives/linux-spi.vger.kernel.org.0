Return-Path: <linux-spi+bounces-619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D6838A1A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 10:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796441C2368B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7156B78;
	Tue, 23 Jan 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCZF2YVT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15045A0F8;
	Tue, 23 Jan 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001463; cv=none; b=tAcydVy+VqiBW5WYHCsWlxtFXlA7RWXzbcsHhHKNt9RFoLQwVkP9QSpUB8DiivccwkWGEzetqUWXveFk8UQ0U591RM+W3IWXASh/SovoBxP4Fi3nfFbZtst6GmA0bXZ1Vn39XUEzs75571AHKZ6twZbhgYBpFfz7yl3EfJvJbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001463; c=relaxed/simple;
	bh=MkzCPoQYH+JjPkMi90nDIs+/b6/MWMAdCszcENwKe6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHROaHBcb/Kbjwtg1P2ZVlLxSSNBwzjb4mPn716UEkkeRno04UxSLmxYI3NMPKjkj1dEb3e2fULHM+sHiPxDyJSiDLtDha1jzIM3o69ZFh/sDOymApxnWPpMjmKcRDfMcYhwmDQNsAy4Y9ETJIOBewfkh1A/gT9ykPqnswgR/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCZF2YVT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429915eefa5so28890061cf.1;
        Tue, 23 Jan 2024 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706001460; x=1706606260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzglcH35XgEgzjcM+iTOVxrutqyTzniZylIALLpAyoM=;
        b=jCZF2YVTbYq1bwPD8Ae4dfOsbzGpLmhDuO2bUTGjjnd2XWQHRnezDD2tJ385aFbswj
         ayqR7wyFvUTCip97NOnQMdFmbMC4vNqdIIt2rIJVbUGuESIscm9zRxxEtWPZQtD3onh7
         2GUJNpwvJTFTr5X+AzoD6I7OjGtfvQXoHviuoXVGxh/Wgj8eSEZFvEB9Co7bdtNmm9rp
         q8DwMUF9X/xXcznC2VYby2/dTKhtIigGrv/YFU4BJd3opTdNQSvheabIGV9ewX6p2ZX+
         sRLPSR0ZkisKAIMOEQWw/GP7uquzIm8V/V58UxD9DqhHgCNdLTwDuLd8ou5RDxRUjIjC
         8xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001460; x=1706606260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzglcH35XgEgzjcM+iTOVxrutqyTzniZylIALLpAyoM=;
        b=ZfmQMu3Wr4OXJFC7gOvHjpZinK11EYJWsnkNTGsYX5Yj4D9Z3mmNlsjT9NIpXsT+6E
         cdG9xZ2LwBvJmz6rMEa+AnQFTq26rQ4u9C3LGPXPSI2/llC+crvi/T8Ua4J++ATE9kCs
         3kve05Hs8ACcydDLsK/8FFW8My1HBb9y0QEwSuEcx3eUhp5KKERgm8WZuJP5rkCyd+/Z
         jj7uG69ZnOrIoSf9We+6s2JSQY0DvjtpYSNlXYB7vG+2XRoRlAG82lrxUj+DOEZ7KMuC
         dqqTylQbsJFfWXAjbl3tQn1cTQigZadSYAPsuEGo4OSqJjHtzSXI63GrBgz4SNpjVGJ/
         KEMg==
X-Gm-Message-State: AOJu0YxTUWTWGO/XC/wNWpm03vp94UErN8PEkXIW4PYpUmpg1V5sKY8O
	Oz5W23k9Xc65Py5Rpo6/W6uFxz72x1FTUZe/GsIXzH0QuQn0cE5v
X-Google-Smtp-Source: AGHT+IFP99noVGNs5k8x7SiXWDJAZps1vtBb7C4YIjCpzV+1Xr4g+TxvvaMFFiTEe9cvFfjnAEkZYQ==
X-Received: by 2002:a05:622a:15cf:b0:42a:54cc:dc45 with SMTP id d15-20020a05622a15cf00b0042a54ccdc45mr44481qty.50.1706001460373;
        Tue, 23 Jan 2024 01:17:40 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id dn9-20020a05622a470900b00429d03916b3sm3347150qtb.76.2024.01.23.01.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:17:40 -0800 (PST)
Message-ID: <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
Date: Tue, 23 Jan 2024 10:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>, broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
From: Luis de Arquer <ldearquer@gmail.com>
In-Reply-To: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 23:59, Johan Jonker wrote:
> In the driver spi-rockchip.c max_native_cs is limited to 4 and the
> default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.
>

Doesn't num-cs include gpio chip selects too?
I have a setup with num-cs = <12> which uses non-native cs-gpios just fine

Luis

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> index e4941e9212d1..00d555bcbad3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> @@ -65,6 +65,11 @@ properties:
>         - const: tx
>         - const: rx
> 
> +  num-cs:
> +    default: 1
> +    minimum: 1
> +    maximum: 4
> +
>     rx-sample-delay-ns:
>       default: 0
>       description:
> --
> 2.39.2
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


