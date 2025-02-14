Return-Path: <linux-spi+bounces-6816-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B607A35273
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A61188E1A1
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8D275415;
	Fri, 14 Feb 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9tDXlms"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073617D2
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491796; cv=none; b=D9ct4fICC4sq3UZnJzy1uMQw4umn3JTpmE/lT9M2VzWekBStTt6HG6dznXlLNInEBAtiT09mil1HD1oMO3k0jB0zw5ksJDcElsJ0BQij/Yx/HI4vqht8zDeO4uCbysU8BYlfovyvWomTbs4WNKIZ9p55EAycKK1DL/yJuPtrHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491796; c=relaxed/simple;
	bh=lEZkR6Mx58pSq0zExuloJ9MtvWHa8LHWfZeVjgG9WZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPJtWXpap9TePvndZCq2Kpeo4SN4QCFRUeMWF/7bPWi3jI9O4W5gq1zGYz0MCaEY1gNiRRKEvKeuA9P2xFzHAx+LUOir8KxsfbeA94eIiiN2w9LZrl+MActh6CbFcqVS/xzg/sAEKXPH44SrzvGhIvX8G37ZOLw7wGVKhwsejvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9tDXlms; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5b29779d74so1373100276.2
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739491793; x=1740096593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqP9v9jg7baLiU2+93UgvbM9b74Tce3qrWwn1lgosFQ=;
        b=X9tDXlmsUsIQfkaNZDlkbTZOQ6yJZhTnEba9AZbqdWmtiAnd4eL5TS1OF04JD17+ea
         fOofewEVHOYcK02S5TygPLISQmY/3Uk4kcpGydKsR5TXMmFrvS7IrtDLD4vUFCTPH/F0
         PFOVKzmXj2kyXNCr2zvUlrRCHWY3AVzIos1Wif9ULHw/79JCkiQG+lqakWt9D/FyNM7l
         o+tExlNa0I7ciMuKBWs8Q4mxjQFiULrmRLSn8dKJ/qxM6IDnIzFDxL0mpoEpKtMtyKNl
         cdicpkLsAGQjNrIieya1OdDUovgu0jpQBKYWvOJTDaZ2ulvUuBZAG7hcvSX9e0cA3l05
         cXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739491793; x=1740096593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqP9v9jg7baLiU2+93UgvbM9b74Tce3qrWwn1lgosFQ=;
        b=dimrJIZuozbeFdffBOM8ni9MxbY8c8TFFnY/T3Zb2tRnSJpE0ENEHEbBRvAWvzTngH
         VGPCmW8wdDbshfGw+9F3nrVC05cVCgz8Bk6MU8zM4HIM4BadLM5UUw31P5tfK/Ko+UQL
         y/A81TFfqFw0ccNZnN4PbtPuSZp6L9MCQElT+dSQZjGdb+GHhWFr4g8SeBT1lMUJYYtc
         KQI4KQZVLE4ANDS15Et/BnNLphyXgPTOkkdDi7huI8Q1Fqg/AfVDAfnx2Zxr20jQ+4s+
         BgpdYAhZAPrTDJqJxwoGZVYww+tnnResqkHhPIznCmkDu2Be2UhGbCBfDduYMZON15iQ
         1hgg==
X-Forwarded-Encrypted: i=1; AJvYcCWdqgXXLjc2W7JaEaes7Q5bm9QRVaySyBR5Z1e8lFCDb1Q6ChBOaqwnRgFHEFu80nV6pIL0PWFF6QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBtfW92sywE86bT2PgzypM697ILYe/k+rAoY/+7mYfulxASac
	mM4X+NCXBk+wcWdUY8jq3GFtfNLXtTbQZAPC54tafx8w1PZemqVyYRkPuZ5sB3BzNVTOs3z/ysJ
	3qUnDvD3+nnxBXdR0U5pNj9bk/j3Mm89SEoavIA==
X-Gm-Gg: ASbGncvRHE2ZY/HA51aEj3P8SEpuvDzA40HXypIeJOCHZ3bfl0can/Jz4bZs0SD/sn8
	nE62IhO4da8wxMbHLLNI+EbesXxxp1DOAt2Qjxcrb28o/bCNvKkD6Kf7tjtkwYk3gRxKHOeFFfw
	mN45lqXiGxUOTCkVAHjv5xLDlCriXBe5A=
X-Google-Smtp-Source: AGHT+IFd1EJtDVBHgzWdjgXFsf5jdNOMTYWQT9HHkgAZZC7VuvxH9RsRYnYxxoGtNZLN5u0QJ7cWcZkPmK0FyJYTFow=
X-Received: by 2002:a05:6902:13c6:b0:e5b:3f8e:9e65 with SMTP id
 3f1490d57ef6-e5d9f0f9e38mr9401293276.12.1739491792768; Thu, 13 Feb 2025
 16:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213204044.660-1-wachiturroxd150@gmail.com> <20250213204044.660-2-wachiturroxd150@gmail.com>
In-Reply-To: <20250213204044.660-2-wachiturroxd150@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 13 Feb 2025 18:09:42 -0600
X-Gm-Features: AWEUYZnCMGwjd-AHWAZ_AQIcjbuE5HV5DBnJ9ZGUM8sZFqDGixnVhaKZX3Cd9ko
Message-ID: <CAPLW+4=STm0=K8s+BTxiHWP9F_waw2H=fQ4W9_NTm7a4JcFy=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: samsung: add samsung,exynos990-spi
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:41=E2=80=AFPM Denzeel Oliva <wachiturroxd150@gmai=
l.com> wrote:
>
> Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
> on Exynos990 SoC. This ensures proper representation of the hardware
> in the device tree.
>
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Doc=
umentation/devicetree/bindings/spi/samsung,spi.yaml
> index 3c206a64d..1d3c95bd2 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -24,6 +24,7 @@ properties:
>            - samsung,exynos4210-spi
>            - samsung,exynos5433-spi
>            - samsung,exynos850-spi
> +          - samsung,exynos990-spi
>            - samsung,exynosautov9-spi
>            - tesla,fsd-spi
>        - items:
> --
> 2.48.1
>
>

