Return-Path: <linux-spi+bounces-1075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617084B1B5
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F166285C68
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0C12DDA8;
	Tue,  6 Feb 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EG9HtWog"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4312D759
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213453; cv=none; b=TZjeUNhkfLZ8JdveILbqHojK533l2gQRfFAxqvVyeG8EAY6tlak/sX9ypVE0Dw/Vd6wWO3r2FBL1A+8PowxComQKmLb3/Lgm6ZvHJjDDZmqqjoxTfAD1PMkb97IsdEBY3/0/IOdQNWnT7g5ahar8+bad1xKkNZL0E8za9fCxThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213453; c=relaxed/simple;
	bh=NpPH85owZ20SCl7gPDrD1ciS1nl+zM/WUwZ0z1dCHO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ETltSEOXKURX/4dWrATa9JeozimmedZhHzBOMpYz/YFySUbKWKt75+yhuzgd22aRuZawqYiBmMam4VqiorSiFTcByftNjw/P6H45MGHSHNQjlumauZovUaoaudgOvYtU3isVA/QZON3HuXVKo+CsmB6HLJIL7b88wgXOr748Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EG9HtWog; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6f6d10ea9so3555550276.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707213450; x=1707818250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq2wg0lmtUf7Y9KbMkjM4LSzECZ5og9xajY9d90SZeA=;
        b=EG9HtWogWkY3LttZ95TAM5ISxGu6ZbqC3fGmwfQAZQbpGGpXmIROgzJZcbqFzGPFlW
         3yVGcUt6o9UUa/LpB5o/WvUNqhlTLy+rMDzg5WjfJq6bYna/9JxiFxs1xkYeXm98mUB7
         RjOAI77umQ2omLoLOB+CKee5qFSxJ+ttbbIw6HH9SsneW6ZFTadO8Hdj/cpbZn+MR6Xq
         jioj6nuk9VvcBNRE8AqPFUyU7eQnDmzeg+FUZGIyKmfevtjbUDG3vGUAQPQ4ZJkhRpWy
         K9K+tGfvbSdxdWw66XsLf+DBaCaulj16nntdI4RBwt9VergnalW56yj9sU81mpkdOFy3
         BoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213450; x=1707818250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eq2wg0lmtUf7Y9KbMkjM4LSzECZ5og9xajY9d90SZeA=;
        b=eHETDR5K5xCvt8+NlgX11J5gebViDXEdoWUkDVNyAcDYImAayuKzmbEQSmMP4eei/D
         lgtuCqk56Q/JGFm+dwVnjvwUk+b+UCZ3QXRDD1FYOqIAmphNJ5rZW5ibf7KmQW7mynJ4
         tv5nZNqOxvq7uDi1QQO3DmA124fA1BfH8S/kU/v7lZWdjglHnRQSXwYcTMCvznvEGdOo
         4gXC3mFPUHrxSeKzjk2G9nhQvjfZ4xwhNv25hQEdQncwCafCEM2Y3iwFlPlnO4lhNxIE
         kIRZWSe3hq6bjei+w1SesyT9Ud+uQopecgAOZAPDiEPDxH67SZOL1f3eOdvT2AWmZVqk
         TL/g==
X-Gm-Message-State: AOJu0YyD6ZeQ8SegjC/B3aXOdsX5MsVcIEwr9Kkskx+6kdjAOsI50Ijw
	HhPbREU+rGxQHbEd3COVq1JhrTOrAabHvnF5OPJrZQoHAlldU+zuccXRiOfy9DPoiT7qUfjdP5Q
	YhG/bFhaIAyBjCqigZrcGZapFXYm50hdJSRXUWA==
X-Google-Smtp-Source: AGHT+IG5u0RUlCzKGSN5/5B0/qLQhE4mJ3srJl6aZpIRhRrSpKuDOaDOTP0OKh3xCd6YwxwgJxwWKTKO4NRUn/AvJf0=
X-Received: by 2002:a05:6902:102e:b0:dc6:83c:dce7 with SMTP id
 x14-20020a056902102e00b00dc6083cdce7mr1271773ybt.38.1707213450425; Tue, 06
 Feb 2024 01:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-3-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 09:57:19 +0000
Message-ID: <CADrjBPpLB0RJO6xH=0+jvc=EnaNX6eCg2JV2DNkDdFAoS1mJQw@mail.gmail.com>
Subject: Re: [PATCH 2/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 08:52, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add "google,gs101-spi" dedicated compatible for representing SPI of
> Google GS101 SoC.
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index f71099852653..2f0a0835ecfb 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - google,gs101-spi
>            - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
>            - samsung,s3c6410-spi
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
> --
> 2.43.0.594.gd9cf4e227d-goog
>

