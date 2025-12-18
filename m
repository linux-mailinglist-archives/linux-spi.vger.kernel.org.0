Return-Path: <linux-spi+bounces-12021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C539CCCD4DE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA473061D6E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9632ED46;
	Thu, 18 Dec 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzOjmPrn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456E322768
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084334; cv=none; b=Gk4yFZcfpiL5HYQhi0sxnuiQUNUA6qTPItUY/4ajxt/1I25/87jxMGGSQMROhDYHrZCkZ50hCnFvYt5NpO+GP37e/GfAAcrb5p2CA/1qWOevl9FpfE7th6fUqWlHiGywCeWOvWnyRDIwSiiDXucG35GfSrw1PenTXh5EMvm1k7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084334; c=relaxed/simple;
	bh=Jku28IM/c1IYSHnKsavbvy9aaLBIgMj3F4YQHgrupho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBQSMPSdsHoCLxGBDFHJCGIV0Xmajibj2jD5XSRzWLVVoQuPrc6uSJvYMDlVlgl/2kivIuIwhBXlC48KdTuThOi4eBlAUCEEIkARxNm+Dmo7q7FmkKo7IM6lvAt1vPzlLsDJ4OyQDPqgFk+9+8IqXcrc4DSn4yfAAorFEuZ3k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzOjmPrn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0a33d0585so9701955ad.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766084317; x=1766689117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=NzOjmPrn46f7eL94kTiu7+0zvL7EqcBFTL/HGLf3Rc6h3rBZjvJM5i3qCCD2fYrXy7
         eJklrOOWGmpDdYURm2bD9+/3PlBRsY8WKHCZ2GLGzwLcw74QlWuQ3QwUrvnoh8XgWay8
         gOij/Oftk04H9HcDeMjrum7Gp/tJMDS9TcpBQwDo75WutLi+yiY8j3WBiG0hbm0He5W7
         e9CpO9bAAOVDpz+N+io0xTJRBjOcs9kNkjAd+Z+kY0znjtSG4hOPaCJlbg1PV1xakEpj
         cFYP81lVX+QhyL2f1NFGqqWTbtem9suiHwzZLYFwy//KO+NJmpEmbUADkYq65Km/0XcM
         myZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084317; x=1766689117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=sXsR/JgfhkroBCztMa3zKgSyL5LRTYWsp+r7vjYy1zNwvu4E6zzj+OKkccF11+dzAG
         YJu4Yw72BIz3XWYh6Dlw6/sxDkbTcBwK8CLBGy1giO09DcbT/5a0uVRrxuQ8egdnrvEg
         VMHQ/y1u8DcMKm/TP3L2PL1rRdYCo46fhhs4EksRXf1i0o0saVI1lMy8Ur9iLgyUPXWO
         o9GVTZdYAm50SiYrK/Ym+QH0b1HInY9NOCb0SXk7g1rsC5PzDpnH/3dA42Ay80OK40/+
         Wwk9ad0VeM3OLgQroQ2o0/g73OBvyAdi2CKsblFwTCOEkD8hMxX/rqcNgK8xcrcVadB7
         yIsw==
X-Forwarded-Encrypted: i=1; AJvYcCVR6iK8nm9zAcTqbXadhq/TD9f038X9KJIZAb/iqOIvOJQNk8/2hy6K9Xu/LA/WRq7BRQmmeZDmxxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxohiGUhNfZdbVGPd0daG6EKVBVuDsGhCKY6AagidhfXH1AAEPv
	77MBzGU3gpnmrVM7U6fCbR1B7udBeGihtZK3o+j3o8mKUBNVSNtbdkqb
X-Gm-Gg: AY/fxX5i/LAftri9fnBAumj76hM7pVhEDaZrJ8XW+8SFK0KfpJ2MZVCQU4aW8jPA2xN
	k6wan2GAdrzKOfFlTWXEPIBurRAfsZrnXQ2+Q1qENDCwV3Z1b+zrKlBWcnrmvF3LrVZz3u8uTVD
	ya5pzDmn5Epm5X2wZNFRBg5aXNJ0p5jNL6IhGWi1a292LOiQ6bLCcP7cQOlESpc2ksTxfGiB/KB
	C3KIYcOl46QqhRKgsOm+f0gDdC+1DKEemG/hArIjcbTQcK9XwmotaJBLrxi4TRZ6oU+PLlcttSQ
	HRBke221dQX8OBGZe50z2b6Ky+9cAf1Dk9VgnmH9cB2Xy/3zV69dcZP0g93bnjashjiWMZEJC56
	Wj75xE0S/R9VsC8QOcaORQG5CC7lcTxPViZlWuTgs0ruA3QrMu2qI5p00g8A0pfLr6oy5x8BPPN
	o77nHHanR42bfF/KJ1VR+41EDC
X-Google-Smtp-Source: AGHT+IFf3D0xeHaQPPXEeazhorZHgIgTwRHiyRuussKNgJjGtFBYIJhQUMgRhb/IHzjPiFdB5lKzgg==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr177764c88.26.1766084317443;
        Thu, 18 Dec 2025 10:58:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm299016c88.12.2025.12.18.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:58:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Dec 2025 10:58:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linusw@kernel.org, olivia@selenic.com, radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	richardcochran@gmail.com, wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org, mwalle@kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH v2 15/19] dt-bindings: hwmon: sparx5: add
 microchip,lan9691-temp
Message-ID: <8462a516-4e8f-413c-813d-e7ff0e6eaa1d@roeck-us.net>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-15-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163820.1584926-15-robert.marko@sartura.hr>

On Mon, Dec 15, 2025 at 05:35:32PM +0100, Robert Marko wrote:
> Document LAN969x hwmon temperature sensor compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

