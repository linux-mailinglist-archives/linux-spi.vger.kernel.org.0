Return-Path: <linux-spi+bounces-9676-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBBB38131
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F6E161FE5
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29E2F0C66;
	Wed, 27 Aug 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeKwvRDT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A82FE58D
	for <linux-spi@vger.kernel.org>; Wed, 27 Aug 2025 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294588; cv=none; b=bU1oc4mkXuIgjy7g+hvE+JeXv6Nw1a14hGISUzZf1HimyzzbOjWlCPoYJxlh1+jCnKWYRCNUTg5dCDljguXepss2TqKh4flra1JMsdG83t3y4fNLVVhYoTZIqi5QZ5+r+yqmX2a3bf1kZ1q/COEX0bheVaD/b9+bGiKNjEsiI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294588; c=relaxed/simple;
	bh=7DgWi9Ar+muJh7bUEGthi/goU1MbjaIxX928e0R2ZyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1KrGUjwgqFWFXeBN2DcwwYSYcJGDydmVRscLkPXnQGlD94l2ZkcYHzS4DxdMVudIANqJ3/Ihl4eqepxt0nDwBEyBMvGCoHaw5rpbbdPwab9L6pwsebXvwRMKDnZGtZG029Vc82C0gPCIc25mcOJTqOX7OWAio8QflGktjhsDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UeKwvRDT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso885437276.1
        for <linux-spi@vger.kernel.org>; Wed, 27 Aug 2025 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294586; x=1756899386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GshhcYtt+o3ZDmIcVaau5etE7AshjqQLUOLJ46sR/Z0=;
        b=UeKwvRDT2oRFHLNUWCjPWr7frmH9RCtwRGfpX3jS8x/OZXj+vFkDmXHLeKdi/2OWL3
         ll+zInzmqzlrfNbM+Okov4Kxc2QS4hxm9lzG0DM737NRsjvhCew46n/Ii6749na/3rGP
         8gmtmEK2yvhnYFlSIOpH6aa4XASNTwsz+TjcHhfThDw8wK/wFQK++4xCJf2sS9MYzCwO
         UAYWuTfGNuSN5izqp+VuJYtdPvgeMS/x3lKsWYmTmhA5j6Wjl++EV9narUTvWYZ/tDOR
         jvNUmNnAPnH6x8QoZGA/l9OG++GQsv6H7MfD9pM+bEZ2G56Hbcu0tw2BlHvbwmf/afcv
         2I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294586; x=1756899386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GshhcYtt+o3ZDmIcVaau5etE7AshjqQLUOLJ46sR/Z0=;
        b=AvKaHhmkg+qYPRyyQN/8Mv6pvvpDg75bZKFpkRK7Y6y3LVOCu9D01FlHMtIHI/Sk+r
         +4bUrX6G0TinxwcgtisC477aQLLo/UFpmdIu8rcybk1E4ABkVdPur+ExRb3hMonjDfmz
         4Zp2w7j9Xm21csbQ2cCrq1wF4ZzrKm+3HsIxomWxiiTYeSfr5+2YLehjObS8+Q8rIosI
         Dhek1Qeoz4xl1DLmomGuK2xGoaKuqVqcfQosyAF+yv+5qR3L2rp8Ng5BOc+QihASyQLc
         UQ6GHMGKOkZLQ1vg5xCdAqQTV6R76MLIqJEO6uggPCk84SrAmOJ0/YQPeFxAoDP5H25Z
         zufg==
X-Forwarded-Encrypted: i=1; AJvYcCVfqY+E03ETo40flic0nxw7jeWOdjP9+ZumW8zlfnbgEIzfH/5bckOleGHHLd3dLgkI5Eh0EpintRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZNlOwFPQrtibABjjCfCrP8ZTRw1ZHdCyx51orH2H2h+1ERU7
	C9AtTvHqsvNhT1cuG2hHS2bHjC/xAwtjB0PPGb7zmW1KSEuwbmiVg8qOylKNwETy2bTk4QfUTjP
	OHbxAGzhhys/U8sC7DpA5fKSyYS3Ngu9Cr2KEyCR4BA==
X-Gm-Gg: ASbGncs1mqbUgKWrwECotJXHj0W4SZvqkOuworx1CeyiUJnjqEtBYloApeMG+nhaKWC
	8Ma6QxJnfyw+oesgFMEVI6ysIC7JgB+kMQT899JS5nVy3sOsJkuZ0G2VcpqMNnt82WtHdtqUDy4
	7odV7tc8e5lgfN5+/ZTuJeAUFdmbtcRoGIMPTut76i4PYikpzTAMbw7J5ifAfdmNQD8gBjmEIz/
	09oQvw=
X-Google-Smtp-Source: AGHT+IEwpDhJVx3Yl2d4M0O6aQEx5FPVAE8W+0jG/YLPEbLIVnOLY5mPjFCLx+9t9be+kKBCeaxYCmRkzaS3+hd6ajY=
X-Received: by 2002:a05:690c:9502:b0:71b:9230:1bc3 with SMTP id
 00721157ae682-72132cd7acamr49387147b3.19.1756294585993; Wed, 27 Aug 2025
 04:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:50 +0200
X-Gm-Features: Ac12FXyr06qQfHVq879XFdF-xg_WMRp0LQVO_ATADMZ9_YryOAf4pgR4STFneVc
Message-ID: <CAPDyKFq7xLJfFBZe2UPfErmntfSSo5kt6UpNQs4+vjWFcMK9rA@mail.gmail.com>
Subject: Re: [PATCH] spi: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: broonie@kernel.org, rafael@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:16, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
>
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/spi/spi.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index a388f372b27a..f95c4304df8e 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -427,15 +427,13 @@ static int spi_probe(struct device *dev)
>         if (spi->irq < 0)
>                 spi->irq = 0;
>
> -       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (ret)
>                 return ret;
>
> -       if (sdrv->probe) {
> +       if (sdrv->probe)
>                 ret = sdrv->probe(spi);
> -               if (ret)
> -                       dev_pm_domain_detach(dev, true);
> -       }
>
>         return ret;
>  }
> @@ -446,8 +444,6 @@ static void spi_remove(struct device *dev)
>
>         if (sdrv->remove)
>                 sdrv->remove(to_spi_device(dev));
> -
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  static void spi_shutdown(struct device *dev)
> --
> 2.43.0
>

