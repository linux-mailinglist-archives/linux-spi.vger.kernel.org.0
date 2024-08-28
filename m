Return-Path: <linux-spi+bounces-4365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10259630BC
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800D01F23054
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CF1AB52F;
	Wed, 28 Aug 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nx9xsyyx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1711A4F10
	for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872163; cv=none; b=HTawd/9qgZuozGQzWqdvj5UfuRMX+KkIXgUTj0L31Otaqox03KrY7PPKlc+XvqBnzpaQ4Y92IfSTyx2fUUrOuRPpAUrqCsgMxVzeyYAXjDRpxvzUuhGWrxSVNEBvA3tQuC4Ck1KNIKjzZyGNrsYNswToo1DNeV0n8lHQNbhdjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872163; c=relaxed/simple;
	bh=zZ/SMZ3Z/D5lKD7SuGqPfmC1ArN+Cd8xh1U7kJJC9IA=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=S7w2eZh8PsM3MjYb7ejUY2kCnJ7wkx7rGYY2CulxdmMH+l7+/rLyAJvabAbAf46a/C3Zy0yoxQabIAH18D5f5SsJ6Mn4PA53TEI2YsFdGGsCdmJbr5TTpUZ8MgM1+PKudTHbKo/kN3lGthWxK+thkJc9ZnG2T28HZicrQNu7lKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nx9xsyyx; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3dd25b2c3f2so1078993b6e.0
        for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724872160; x=1725476960; darn=vger.kernel.org;
        h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypGHyRyKaJgpUow8YV03/lyEnZIENiqYYZIpIYxcou4=;
        b=Nx9xsyyxzGRr/L8KsQtdXJY20CNzh1/JhLb8E51PQuT1Z07HAFBhyFNY0woHEjETeq
         o5h2KRc/5pa4gjbGaGzHK/lb5v6VWpDxq+x+dSJPj0IriNAQlPp7cr1ATPVruC3sjMp/
         vR6YO6u86qfh8+JkgPyOaaEQHWyzr3oaG90t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872160; x=1725476960;
        h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypGHyRyKaJgpUow8YV03/lyEnZIENiqYYZIpIYxcou4=;
        b=dad1MJPYB3X6BLZOOTPTmq3n6psO9M7AGQIYyczKgj8vXRVm9rHH537GJuV8YZurZo
         Bkb/bMnIbJDDdkZblaQSu0WidkkHxafh/W5iTb9r91scKSe0Dm4o3oX34wMg0ZtzDvMM
         SZ+zAqo3d0Wff91/yhZ0Kb1CPv0FL54QnBWxmVNqTBj8cve8cYZu5QYcIl8EoEJCzKUg
         Ztlw/gcfGy5ldIVh0+xATpNNylX2SG3pbEFGAgoWCLFaH8u+3dIrS/CidmXx3FeJJAfj
         lm9vUv2YMovwoWw9+wWfbLwkxmdnarXh5QojIiOwwjH+MPt+BFWtqhkdfjVt7saGUEnQ
         mnTg==
X-Forwarded-Encrypted: i=1; AJvYcCVHKSinzfuRbiMr9XKQJKNA1LrneEUL1Eg83m5UYH78QoqhVwRo1UZOAn25A9h2bQIeDXde8/oc7cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySma4SrF1gOlZZIFzLUYqnefCXbb5vnWwEUNf3+k1oMW5K4QHq
	ECEnx0/RteQkvIejXS48bybreAtvsZ8HxPE++Y8dyk/zjT5wNS6Eo2zYPQ3yrn01lCTmz9uTAI1
	IdL7lQpERT3G2PKW1sXNZ8wmyfhpJ1vM+XTek
X-Google-Smtp-Source: AGHT+IGjryDz7G1gOMO3Us+XNI736eW6ikdiLTB8ijbfri9hLf6j1+jWDnAQkoBRsW2QG0l8FIDKk4TvoFXdmq38UTo=
X-Received: by 2002:a05:6808:1809:b0:3da:b3cb:cfc1 with SMTP id
 5614622812f47-3df05c348dbmr522025b6e.3.1724872160263; Wed, 28 Aug 2024
 12:09:20 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240826124903.3429235-1-ruanjinjie@huawei.com> <20240826124903.3429235-3-ruanjinjie@huawei.com>
In-Reply-To: <20240826124903.3429235-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKfJvZGueGQZlKs7jz0fDUJQJbT7QLQ7TE+sJ4mHgA=
Date: Wed, 28 Aug 2024 12:09:18 -0700
Message-ID: <d398b10f961866616102c7f0e4f21d0d@mail.gmail.com>
Subject: RE: [PATCH -next 2/2] spi: bcmbca-hsspi: Use devm_spi_alloc_host()
To: Jinjie Ruan <ruanjinjie@huawei.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	broonie@kernel.org, Anand Gore <anand.gore@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, rafal@milecki.pl, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006b05620620c31874"

--0000000000006b05620620c31874
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
> Subject: [PATCH -next 2/2] spi: bcmbca-hsspi: Use devm_spi_alloc_host()
>
> Use devm_spi_alloc_host() so that there's no need to call
> spi_controller_put() in the error path.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/spi/spi-bcmbca-hsspi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c
b/drivers/spi/spi-bcmbca-hsspi.c
> index f465daa473d0..d936104a41ec 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -480,7 +480,7 @@ static int bcmbca_hsspi_probe(struct
> platform_device *pdev)
>  		}
>  	}
>
> -	host = spi_alloc_host(&pdev->dev, sizeof(*bs));
> +	host = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
>  	if (!host) {
>  		ret = -ENOMEM;
>  		goto out_disable_pll_clk;
> @@ -536,17 +536,17 @@ static int bcmbca_hsspi_probe(struct
> platform_device *pdev)
>  		ret = devm_request_irq(dev, irq, bcmbca_hsspi_interrupt,
> IRQF_SHARED,
>  			       pdev->name, bs);
>  		if (ret)
> -			goto out_put_host;
> +			goto out_disable_pll_clk;
>  	}
>
>  	ret = devm_pm_runtime_enable(&pdev->dev);
>  	if (ret)
> -		goto out_put_host;
> +		goto out_disable_pll_clk;
>
>  	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "couldn't register sysfs group\n");
> -		goto out_put_host;
> +		goto out_disable_pll_clk;
>  	}
>
>  	/* register and we are done */
> @@ -560,8 +560,6 @@ static int bcmbca_hsspi_probe(struct
> platform_device *pdev)
>
>  out_sysgroup_disable:
>  	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
> -out_put_host:
> -	spi_controller_put(host);
>  out_disable_pll_clk:
>  	clk_disable_unprepare(pll_clk);
>  out_disable_clk:
> --
> 2.34.1

Reviewed-by: William Zhang <william.zhang@broadcom.com>

--0000000000006b05620620c31874
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJJfXcHuH1NMP+Cbki8CYd2oGjvp
HKwTv4Jxei+OMNnTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDgyODE5MDkyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCLV1fxCuY49aAKPMPw1Gkfp+JnZiB/DxYoFE8r+imyR7Ku
TlwXvU9OFUs7WX6cVInXOy8bLWRm/drKxxgAdJdR7FTUSTp/7DXQCUGUHXIXmeiakWYEwCthCM/3
lJQ8YlvVP6Gzpl7uVxfmp85W1bX9D7qvuurzezBhw3zG8y3dSdJ2iXg7RbbvwqOSKpomU4uVEZzF
ISOdVjGlQWAgNO24hNlXOwNH+EUkNfp0kr95JCPrTm+4arcgIuyP82/CaBrPYi13UOZQ9Zz59v7N
46+QxeA8wiPSC8Plq6g7IqQkaBVPw4SHNmlekvbCLW48EsU+fvrKDEePa24jBGVgBz7A
--0000000000006b05620620c31874--

