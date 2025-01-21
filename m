Return-Path: <linux-spi+bounces-6414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74BA17D6C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7640168F86
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579851B87D6;
	Tue, 21 Jan 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQhGRdll"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A93208;
	Tue, 21 Jan 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460839; cv=none; b=kWjDfaZexxkeKErG33aLY9B5iP27JQxPVxY02b7ItSXuXIMBrTCC1cF2V39l1vh1fUId88AxuEZzGuMYmCinm8ChCKE8gNp+UM74AG/i/uWEHsGvB6HJtnKyMPrtzvy+QxMWwU7kxh5JX+O5uxHa5wNx599W3a2yG3MK/nS6Y/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460839; c=relaxed/simple;
	bh=Cd24JJRLG1Hanb2hVCaYvnDD6TI+g7VUlINt6kpluNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEk9ldyJUJvNkw22WMLKzZ9/3F6rCMXlPvOc0iSlIrEE+Qk67pgUSUOpdgYS743MS5TtcsRbe5FydANTaYMSe6NsO26BtilZ/QKaPGSVK8uRhyPYhXWhW4laYddoFsaXb9KwevhGD9260xkWAzAh/G3EgMSg84+T5IC5Me86T2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQhGRdll; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab643063598so106845466b.2;
        Tue, 21 Jan 2025 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737460836; x=1738065636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gupmKlSP2brSsG+LeVGscmB6umxcZ/yktfD7J1Q+2nE=;
        b=jQhGRdllQDEEMOP95A0AXbQynEMbLi+310sqdgPtmfRPtdCcgcdCsatJVjo+fiU8t0
         a/rNr0bwd7mzjk+0jY/8peZGCcovGWBpPyVZE/T9IyFw0dOAf+aMRu6qzhHQ9c85YsFT
         IJHVGYwvBuwwO3V33veIqwoAE8y8cV0DDxdiQBHcbemnaaUzLOtll+r2Q9nOu4NpXDY5
         6d4S2v3l1HhXoOX2OHQ14789A0giwurK1O7gzR5WlhHoGI3/VCkiWcYKTP5xCjiaz6UL
         BT64s322p+6ZY7I5fr1yS6K0sy2D+KHA/9Iv+apR1Dg8Fmma1Mg7Gnqo5LgD8ErSW76v
         Cwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737460836; x=1738065636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gupmKlSP2brSsG+LeVGscmB6umxcZ/yktfD7J1Q+2nE=;
        b=bLlRGMCBQ2mVsCBaoZJjlpZbGRsKU/8RNCJbJVVTmakIVnYE/nXAt08siy1Ryb0x1c
         q+9qSLRWDlXkM/bCtg7fb/FgGZr4PtlJdWHqIT4tvWoeUmkFrwp5T6DxF4Fy+j8ckZ2R
         pFqx/k5se6KhprY4857ZHUggiAnX69LjfwbPwmpdaMq3FLkMAc4vhaRsiA+Y+C3OM1pE
         GTgrx6tLelCAfftmN9tpfGBsfZ44avCbQPdnmvk7hWt1xHkNSNn07L083pLd9Mg6jez/
         AUQnsqs5b02sfkfWUHqEy5C99RQgcWyY1bKuwdA+CYWYMyjRRHICBSisbf+Q864nQloS
         eMCA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkUfbERGsCRSqZ+RCM8DGvLfYJZovDq29TQeNBbIRVvnKN+BfKsixyc9bZweq25EmLrF0z3vThxP1@vger.kernel.org, AJvYcCVD2AtwE5mH7wN1uZ1Uneman1MUuVoq60184IiXwLM7IYnV0g15OePx3sSbTG06xEp78Y8nFkgrZvTHZqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWWdz9sM712YcypkyNCwow1DwaUE1KtldYBursgCT+XqgpAcn
	kBC4wR0ehx1GPSMNkftPfVs24E5LetvQf4R5GTLpSR2gP6Dt8dqwTb6dx+E+o7i5KoSGaK4xKIh
	NkOQqX8pJLcwqAkvd29ong3v45bk=
X-Gm-Gg: ASbGncufeR+R4XqAOWDZwUmVFHDLGSHzZZPVxbfGxZUXsDExoqwQH7GLCK3yaLR2P8g
	Rxz4rbjefeBWUAgLMc41sUvDjein+BbYMrat4TJxuXVH6cXF2aVU=
X-Google-Smtp-Source: AGHT+IES2JClzJDAtlqgPbILmRFaXFBfwTllECkgN7ythdeCTlotG28uN8TnMtqeBM1YPdXXMfgrj2SuIof4uxn25Ro=
X-Received: by 2002:a50:9357:0:b0:5db:e91a:6baf with SMTP id
 4fb4d7f45d1cf-5dbe91a6ce3mr716249a12.14.1737460835664; Tue, 21 Jan 2025
 04:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org>
In-Reply-To: <20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org>
From: Lars Pedersen <lapeddk@gmail.com>
Date: Tue, 21 Jan 2025 13:00:24 +0100
X-Gm-Features: AbW1kvZKmoVnWtDcgQVL5MkT8PnoDNdEndQb2O8P2ZJcTTTADfTwVxgJoSmYAkU
Message-ID: <CAKd8=GucMNr2s7ci7TbA7_kwQ8AwwNGWV-Aobeqa_anouEk=rA@mail.gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Correctly handle devm_clk_get_optional()
 errors
To: Mark Brown <broonie@kernel.org>
Cc: Purushothama Siddaiah <psiddaiah@mvista.com>, Corey Minyard <cminyard@mvista.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 17:16, Mark Brown <broonie@kernel.org> wrote:
>
> devm_clk_get_optional() returns NULL for missing clocks and a PTR_ERR()
> if there is a clock but we fail to get it, but currently we only handle
> the latter case and do so as though the clock was missing.  If we get an
> error back we should handle that as an error since the clock exists but
> we failed to get it, if we get NULL then the clock doesn't exist and we
> should handle that.

Hi Mark.

I have now tested the patch on our board and everything now works as
expected. Thanks!

Tested-by: Lars Pedersen <lapeddk@gmail.com>
>
> Fixes: 4c6ac5446d06 ("spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()")
> Reported-by: Lars Pedersen <lapeddk@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index add6247d348190452918900b145c3c5a00e409b3..29c616e2c408cf26b150a853f789128d003db1f0 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1561,10 +1561,15 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>         }
>
>         mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> -       if (IS_ERR(mcspi->ref_clk))
> -               mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
> -       else
> +       if (IS_ERR(mcspi->ref_clk)) {
> +               status = PTR_ERR(mcspi->ref_clk);
> +               dev_err_probe(&pdev->dev, status, "Failed to get ref_clk");
> +               goto free_ctlr;
> +       }
> +       if (mcspi->ref_clk)
>                 mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
> +       else
> +               mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
>         ctlr->max_speed_hz = mcspi->ref_clk_hz;
>         ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
>
>
> ---
> base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
> change-id: 20250116-spi-fix-omap2-optional-84aa541869e6
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

