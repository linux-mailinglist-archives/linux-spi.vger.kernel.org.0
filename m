Return-Path: <linux-spi+bounces-4364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E389630B7
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 21:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6867B2111F
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4E1AB53B;
	Wed, 28 Aug 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pjc+wAOP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21161AAE19
	for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872080; cv=none; b=CFEVoMFeuD+vrtt9Nn9OAYiM0aOF+p/cJ6nEUQ6UgJ1S9LJAK/XlEbeaHtXsN4g6mbw7j2fcWLf+KpI7rJgWPW4PtHyglg/0/7Im6OPXO8mGIGidhRNJRRKuYLeOL6txzPzfZR56qr6+Wh76mvlm5iE+PqFeWEA1UiWyyQiMe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872080; c=relaxed/simple;
	bh=nZitslHaYDVf8FwW9MozbVINpOneFfBfmwCvDGGXqMQ=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=TKT6xK3hyixvDXemtPS6HZinlNRUJA5AtC/YkVQFx3nr8WxRUq4ZehgGkPUMR5afSzZCxNrdrx+dLG7W9kIBZceLtU+/EzDp/DMV5UqRQbzuHql88hALQYSL0vOaXGaETx4DWsHRLZjtynRlfjbEhL2a6iSMxjAxRBjA2BUgcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pjc+wAOP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db14930a1aso1412001b6e.3
        for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724872076; x=1725476876; darn=vger.kernel.org;
        h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ8TyfuTYYqkP60YTzwN+GonCE15n4L/jRNq3GxsJPE=;
        b=Pjc+wAOPmfHx/t/2rZw0kLeh+z5dUejxBzVHUXDfhOWIxK1J7WrA2KkHa5vJyX6tgQ
         Uquuc368L+HZqTGHKsGxKfGrsotxwwdMExEJ25nkYcnsxZ5jLi2U4T7WBjtco7ZBP5gM
         5oD7TZ3fOJ1LqTxbGjLcmOAgcGnCnMzTkntpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872076; x=1725476876;
        h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ8TyfuTYYqkP60YTzwN+GonCE15n4L/jRNq3GxsJPE=;
        b=VG7mX16ZDK4Yuj6XXjRKA7B2sf2ZEHUPRfVXP25sVRYlCWAcUgjpe5i2WL8FrVYyUh
         oNLTT8cGCJ/YtT9pbF4tW+tEoHAX0vdiGvuPlS2DdjLjaYfjqDPFx01LOOvrMEmON4hW
         kx9W7TKq8lHUe+ipQD95wddmAbU0g/gDnHQZbx81ATUCkEvnpT1X9FJqw3t+XBfrzzxv
         IgYzzcmOGnfB8lCqhEHOjRFo6J5Lgo57Uq5t+WVcNDyS1lG+1vvQxTYyTiZ/sGQmgRQ8
         8qy/+xgUpIjD93kfDmWXRlQKIC1k+lrCBtETdeHerIXaq5zcMGBYosGno2u2auqLZdD9
         14Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUSCMr+r1NTkKcRg24u9ezJpt3fJEshc2X0c6b3omh2Hdt4nu6Tg98lAQyol0bl17moHdRC53WoQvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+5vCnk/dmaMBYGRBgeRgA527VE1ssxQyyFXFbCqTX+WqtrT3
	pvudaft80hZg9ErnKZK9zmiTI6wwsHs3xcr8uVAKB1lw/4kKxmlX81ZqQelxxR3bMlPOsVrZT19
	zpT1y4ECcvoRWm3eGQgUHd7aiKO5I0j5tZbTJ
X-Google-Smtp-Source: AGHT+IHLCYdMrO9c0gOVB2sF4pbjcmKPoTRikNUdARtsDLKI3DGPC+KNsXUFbLEDk4+llPdG5PeN3j3j74FJkMQncBs=
X-Received: by 2002:a05:6808:ecb:b0:3d9:39e2:24f6 with SMTP id
 5614622812f47-3df05c4da57mr423861b6e.5.1724872075988; Wed, 28 Aug 2024
 12:07:55 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240826124903.3429235-1-ruanjinjie@huawei.com> <20240826124903.3429235-2-ruanjinjie@huawei.com>
In-Reply-To: <20240826124903.3429235-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKfJvZGueGQZlKs7jz0fDUJQJbT7QIy4yqjsKMU2JA=
Date: Wed, 28 Aug 2024 12:07:54 -0700
Message-ID: <8ff02d0c947fe2a0635ea85dff732bc9@mail.gmail.com>
Subject: RE: [PATCH -next 1/2] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
To: Jinjie Ruan <ruanjinjie@huawei.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	broonie@kernel.org, Anand Gore <anand.gore@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, rafal@milecki.pl, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000639e940620c31387"

--000000000000639e940620c31387
Content-Type: text/plain; charset="UTF-8"

Hi Jinjie,

> -----Original Message-----
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> Sent: Monday, August 26, 2024 5:49 AM
> To: william.zhang@broadcom.com; kursad.oney@broadcom.com;
> jonas.gorski@gmail.com; bcm-kernel-feedback-list@broadcom.com;
> broonie@kernel.org; anand.gore@broadcom.com;
> florian.fainelli@broadcom.com; rafal@milecki.pl;
linux-spi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: ruanjinjie@huawei.com
> Subject: [PATCH -next 1/2] spi: bcmbca-hsspi: Fix missing
> pm_runtime_disable()
>
> The pm_runtime_disable() is missing in remove function, use
> devm_pm_runtime_enable() to fix it. So the pm_runtime_disable() in
> the probe error path can also be removed.
>
> Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI
> controller")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/spi/spi-bcmbca-hsspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c
b/drivers/spi/spi-bcmbca-hsspi.c
> index e48a56c68ce7..f465daa473d0 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -539,12 +539,14 @@ static int bcmbca_hsspi_probe(struct
> platform_device *pdev)
>  			goto out_put_host;
>  	}
>
> -	pm_runtime_enable(&pdev->dev);
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret)
> +		goto out_put_host;
>
>  	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "couldn't register sysfs group\n");
> -		goto out_pm_disable;
> +		goto out_put_host;
>  	}
>
>  	/* register and we are done */
> @@ -558,8 +560,6 @@ static int bcmbca_hsspi_probe(struct
> platform_device *pdev)
>
>  out_sysgroup_disable:
>  	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
> -out_pm_disable:
> -	pm_runtime_disable(&pdev->dev);
>  out_put_host:
>  	spi_controller_put(host);
>  out_disable_pll_clk:
> --
> 2.34.1

Reviewed-by: William Zhang <william.zhang@broadcom.com>

--000000000000639e940620c31387
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILmUyo8KgeArmXDJOMmOWAwPJ3zJ
z0Ck4QTJnDh+KE14MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDgyODE5MDc1NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAd9kANFvIsMTC43edA9OPn4+hKxiDlizhuesB8egbSyUcc
QoYFyPM5WraPWA53vJOcgQq0ZROR9t8aGgWEj5EV7nCOGFQqIuqoxutuXzMTutiHf3aWBkutLQql
xN0HfTHAqEyvt806zHbRbBB32T+3U404MZcW2gjjgQLPPaD7whZ7tbuPWSd2YiGC+92UM52NPR3k
/RT0mu7USngBwW36WCqZ7uPsqQOUoSS7AEoHUXGcI/tgsNJY+98mMyeJHnBMMOJYrbpLrMC5M+2s
MgCwSA9JXFm1oEaHxIo0jAZx8WK+iDzJw0TrJEwXcKx9r/zEYM+O8RC2JrlqI/ALb/rB
--000000000000639e940620c31387--

