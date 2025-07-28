Return-Path: <linux-spi+bounces-9197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBCB135C2
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819D7173979
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6011B4247;
	Mon, 28 Jul 2025 07:35:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43F17BB21;
	Mon, 28 Jul 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688147; cv=none; b=aryzz0wWG6WChoRcL9KF62A4I+i6Il4nCDz0lE0lDHm4uHdAaEbXaVUWmOM3gk+kRENgMhAC8nIVNnl3W2wtpCsIv/F1YY/fVxTs8QPYFdlSjZhGOy1vGGIhjwsvLxfYv9BjkNZDHmSJK/ojf9IJnLwb57P/hXJDv45Y1ptxeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688147; c=relaxed/simple;
	bh=vJ43hxkmq+IqW60mSuAluGl5gIQd04CjwteIziLQkVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9WVgpncUihkoScExm52pzqFNWPOpEJ3syt1NjL+O6i36xwVezX47jm3bB/mUzdaWTjusuv73WtNGngcKwblMsimRGSHgZEpv6jkLxOk018HA9EL61bKalatxMkl3tPB2VT4CYbVNHFvarBmwK9dAjdLXi6e7TpNXQAA7f/oez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-886b2fdba07so976524241.1;
        Mon, 28 Jul 2025 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753688144; x=1754292944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yy7tQfFoyKQwjK+j13jn45VoMDYFtFmw6yfK7gr2PM=;
        b=HFtPBygBr2XCHx5dcoWXV+05ZRBAFV6mqE7q55U/ZLfGEp/LBEqGEVOkN5CJpWHEhF
         l8XaLFEwUgARjM884OduF4hcRhbi9r39ZSQIPH+g7ufYJr/iuGTFDvcFKWAg16JG23Cu
         WZcpgEvT51VXlIjAGB/BkkhBVp1hm/zjz+ggKEgCoNDy6wGgbw3npbV2z9Yevltvw0YC
         AoQ9i0TC7l8f3s9wLc7+A4IHipMf6tmf87cd6EAL3q61aqB04J8vQpuxPXgqw6h7QkQt
         lNkoeegZ90Afo7NEGecVE4mSHA4di1KvUf7YLwDcJAn56k42oKXdJgDsqfHvLRAHuUqm
         xuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoMgvzBcqXrlOO8mOaM+/NOVSx5H9M/6N+jFHbMRSn6LkcaArkv1mdELbgs9R7tC7n2lTxL8gcYKh@vger.kernel.org, AJvYcCVxzGIJi6fJNx0rJI3eeqYvCv37d5o/8//fQntIezBBSu74l4t9NrTBl2pXb0z2id3eCQYkcV6t2Ayckkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywumufyfd7+sa6AdzI89Wa+C2j4ZkDmWI43m/KE2M0AX/t2aPBq
	Ix3hKb+PNKP7GwmnuxeLvleMNhE5ZAmi01T1FMwRvlXVbhM6icMtnaOrj5gVnZL7
X-Gm-Gg: ASbGnctfQts+mLTwXHXvD2/fUwn7IvJoL7QZc/hO0vvH+k9vH3NAQZH+n6QADoRhvRf
	uV0Hk2AH/7BYLQF3HVyqokzhNTd94L+1FKktkBHQIs/gmzDXsemdYfuskSbTk+HsbV2A7MHYyWq
	d6RA4Q/UPXXSF9mQP3C5viHPcvLAxdnzhNG5+9QiRW9uPubdKHbwcFXYBSiy5Gj0z72zJDZXFri
	wVz1jymKYmSQOhTUpnMme6UrFZToFrEhT+2hgTJfej5W9ejuF7ODeF5kr+UdDIK5LiLRFL26xWs
	ZKpQRyXE1Q+o6K1xA1kGkLR5Rd/jLIS+TDFb4woiHRWCST2D91r4qssnZWd9Io9u8kPgxAObxyz
	CYvbKqJ57BWFqsdfRZfbBFVBTLYh64zWclAyjrqmNrtPfQ7xHmxVnU5a3lKhL
X-Google-Smtp-Source: AGHT+IEdoQve0rFw1CYiVlb0NJxVQweN9gQcVuLZ1v1Asg7YfI6MF0UC0CCEg2iSaI0gvNibG3Xe6w==
X-Received: by 2002:a05:6102:6c3:b0:4e6:d94f:c197 with SMTP id ada2fe7eead31-4fa3fed06bamr3378470137.23.1753688143581;
        Mon, 28 Jul 2025 00:35:43 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538ec92c104sm900935e0c.1.2025.07.28.00.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 00:35:43 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-884f22f9c90so1039283241.0;
        Mon, 28 Jul 2025 00:35:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGwpuBU+jj4krjU8i/wD5bqjky4npP55OtMW/nvniEbZ8nwgzGHmKZtPCtsV/+Rk0VN+ZZTZXQ94pB5p0=@vger.kernel.org, AJvYcCV5V2ntbm/Cgg6STtSXuQfcvL02qV6b/VABRvvnTe1DOixxSzLmg4iq07wv45D/jk1bIf9fLgZiKvoh@vger.kernel.org
X-Received: by 2002:a05:6102:3e1a:b0:4e7:b893:fec7 with SMTP id
 ada2fe7eead31-4fa3f955291mr3902357137.5.1753688143125; Mon, 28 Jul 2025
 00:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
In-Reply-To: <20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jul 2025 09:35:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com>
X-Gm-Features: Ac12FXw4tDm6D72O3D-fUSIcFAmaJ67G-8rBDReDkZJ9r-6vkC22T-KdGmRYG6k
Message-ID: <CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com>
Subject: Re: [PATCH] spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Raphael,

On Tue, 10 Jun 2025 at 16:59, Raphael Gallais-Pou <rgallaispou@gmail.com> wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Thanks for your patch, which is now commit 7d61715c58a39edc ("spi:
rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()") in spi/for-next.

> --- a/drivers/spi/spi-st-ssc4.c
> +++ b/drivers/spi/spi-st-ssc4.c
> @@ -378,8 +378,7 @@ static void spi_st_remove(struct platform_device *pdev)
>         pinctrl_pm_select_sleep_state(&pdev->dev);
>  }
>
> -#ifdef CONFIG_PM
> -static int spi_st_runtime_suspend(struct device *dev)
> +static int __maybe_unused spi_st_runtime_suspend(struct device *dev)

The __maybe_unused can be removed, too...

> @@ -429,7 +426,6 @@ static int spi_st_resume(struct device *dev)
>
>         return pm_runtime_force_resume(dev);
>  }
> -#endif
>
>  static const struct dev_pm_ops spi_st_pm = {
>         SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)

... if you would update these, too:

    -    SET_SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
    -    SET_RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)
    +    SYSTEM_SLEEP_PM_OPS(spi_st_suspend, spi_st_resume)
    +    RUNTIME_PM_OPS(spi_st_runtime_suspend, spi_st_runtime_resume, NULL)

> @@ -445,7 +441,7 @@ MODULE_DEVICE_TABLE(of, stm_spi_match);
>  static struct platform_driver spi_st_driver = {
>         .driver = {
>                 .name = "spi-st",
> -               .pm = &spi_st_pm,
> +               .pm = pm_sleep_ptr(&spi_st_pm),

This should use pm_ptr() instead, as spi_st_pm defines not only system
sleep ops, but also Runtime PM ops.

>                 .of_match_table = of_match_ptr(stm_spi_match),
>         },
>         .probe = spi_st_probe,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

