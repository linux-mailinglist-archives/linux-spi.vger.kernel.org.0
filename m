Return-Path: <linux-spi+bounces-6834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE79A36199
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 16:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A4216ABBA
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029F4D8C8;
	Fri, 14 Feb 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qF8e0ZKg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEA264A61
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546766; cv=none; b=XkYSrBh9HY4KUUAYgw25AEQ5Pm5fP+pqZdW3m7XtR4QIZB/PzeuYfNcfMi2gUGJ9Fx2iGksDb476qd7Ec6MCiOBmplsEg4BVrOUHyKIYNgDHjuc8dgpf0jFsypQ2aAPAXHuDsGl0JJUNXm8aIc+ToMCmJorYsKAc/sOJ7yBj5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546766; c=relaxed/simple;
	bh=aTKpNIO8BVUvvqOEl+Eu3gFI8x59iG70MSZOgbD3qR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTi5FfUGW8MINnsSrT2sslEnI/tNneN1empRs/wcwo6PLnoSQdy2OoKdtrHYvbexEHqoRcN9aA/V12CftWG0AGWE/92HdVK0ncp7pp/kLNJBS0F10w3zt4Ut5MWNiJWyT3eA4Fc9GHlwg6BelGBEc/DaqDhjH660/Pi+IIeUdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qF8e0ZKg; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e589c258663so2510795276.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546764; x=1740151564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40kfap8VDfDH8hk27H/hMJFx9uMBhXw6N31yql9KOwE=;
        b=qF8e0ZKgKmi0OXccMLxqRLdA+6u/1IuSy8R8VEQ0riJkjbEm+SnlA/zsFux6EBxv1h
         Tp3qphAt9K6u/1kw49vt0sm5lF1uNIW81eH/uoJ0D4L7rOudT8brqQXhF/aRsc/5RFED
         1aFdSjLn3v8P9FZwsUnVgwV4V11ibOrUq8X6Q2Bt0UKcRPTd1dEqo6/4dJJTbHr9HAJX
         FwbIZNioJUuW7bVX0X60Vi9nsJUhdlLxKX59Ao41HdrVMwkuFfLzk2d0kOpI9m/rKnLA
         oYonzF1Pv528fog3d8/qf6P+3G1B+mi7aCNKit+d9LgrX7qMk4RWvbjJ6T48zLB1dSdD
         NMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546764; x=1740151564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40kfap8VDfDH8hk27H/hMJFx9uMBhXw6N31yql9KOwE=;
        b=rxC70UW0LYIPeCa85a3IFTprRTFBZ/lccZjoVtRNv/1OeF7MeHYsK6anmz+L/cbbQJ
         Az/mI1xQBk8AzxPi0RYryQ+9NlViwlnfonIfzKXp5i8zihBvGhVQWEo+cjJfsyUyu4Bw
         RSVMlVn/r9J+vckQWdBO3y9BruUZI1y+iEZY2ecrDKURfUb6XItFFF9SGqFQQbTHr0Ti
         Sq/aqDfjKCp2q0q1rNjOU1vEmMGHtlu9/djL9lswKj4uVNoPJe4dZfYLKUpYwQ7rwk2E
         kAy9G6VyS8D31N3sjZ94K6M6Z/f8yj3vEKyQ+WaXxyVAppSCMdxOt9KwqjZ8GcYZ9xTO
         wpdg==
X-Forwarded-Encrypted: i=1; AJvYcCUEnV2kvB1PCpY73sM+LOOs5sfeAC0rNbpbTXwI9WJfev6RZ15O7+DpH03TuqD6Np47+ijCY83fJYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTC4a2vClAfCetZ4ZL2HIcYAw/I92SwkMHp/UsS1ZQS7FbNSI
	MEc/5dPRfIeN9v/bOHAxbJwjehkltRH94QKB6IpQg5LV43h54EnWNuFkJWvLGZhWWXbU9wGn7UW
	Xn6pVmFeGBZHFxCoiuEHWfByC5671+GBQq23NNA==
X-Gm-Gg: ASbGncuxx6d9UH8gg5DBGxZTEl9DqEn9NjimM16slYMot34kOPlM49DdV9yH0aijJgH
	xVHt5p28n6Jw3IuYP40/UJnnOI3z/cWDbQ+2RBdkabS4O3guvJ8FwnOwf4rgYCikb2BqHLEChkE
	NSae1R9PUgk4RhPL2KcQT8ottHaLhlXs0=
X-Google-Smtp-Source: AGHT+IHZ2AvHwjAm58HmrUXzBfbtKaNh3ZhqjYj/r3cal992zurt7vRZq2oTP2grTR9IpbqtQfo+RsuwG6l/eqWLOA4=
X-Received: by 2002:a05:6902:270a:b0:e58:37fe:4a17 with SMTP id
 3f1490d57ef6-e5d9f1965cdmr11696325276.46.1739546763637; Fri, 14 Feb 2025
 07:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214043343.263-1-wachiturroxd150@gmail.com> <20250214043343.263-2-wachiturroxd150@gmail.com>
In-Reply-To: <20250214043343.263-2-wachiturroxd150@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Feb 2025 09:25:52 -0600
X-Gm-Features: AWEUYZm0a9iYbwJFulT6QDwvSZFUTkts4BDa7xViN-gwjOa66CO2DAjmCUVdtNI
Message-ID: <CAPLW+4miogww5cgf=Vd_A0dX0=JaH+CV2G8__3Nx6B-Wddu9PA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: samsung: add samsung,exynos990-spi
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:34=E2=80=AFPM Denzeel Oliva
<wachiturroxd150@gmail.com> wrote:
>
> Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
> on Exynos990 SoC. This ensures proper representation of the hardware
> in the device tree.
>
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>

If someone gives you any tags (like Reviewed-by, Acked-by, etc.)
during previous patch version review round, you should collect them
and add those around here. Only tags for the final patch series
version (which is picked up by a maintainer) will be handled by the
maintainer.

> ---

Please always add a change log for each patch version under "---"
line, it helps reviewers and maintainers understand what to look for
while reviewing. Something like:

Changes in v3:
  - none
Changes in v2:
  - changed this
  - changed that

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

