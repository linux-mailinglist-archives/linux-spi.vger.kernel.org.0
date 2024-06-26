Return-Path: <linux-spi+bounces-3612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2827918508
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987D51F210AF
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B189186E2A;
	Wed, 26 Jun 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="09ktxmMs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5E186285
	for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413858; cv=none; b=BDHeoPxObbDEaq7riZdQ5KOB/M40HRKhZJbyfMRWE2RkH0DBGJmwbGjE8b0tjbhSVOl92UwkNXjvZDU2VHGZ9DIaX8sYRw6UemPkxqA9R31hQxoR3wjqD5HZDjsdE+ZTSH5WlvUzpn1TnCiqUuN1kn8aTSEEEoJpfHx5n4MJAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413858; c=relaxed/simple;
	bh=EyKIBf8rhtksttW3da6l2T13EshR1mCGrN9WMjFdm7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9qBjG5tkQqOZjOsTwO4TybPExEcpQ5lg2mNP02Q1UsmjqSscVUrU9HIDLvVfQOlQEjhBgnfgxK7Tmrk4mBepICJI4/UFD7nuqEgwfyIgmR5j55EyZrNNlZlrhsIWme/GQWd/CqXIGs2Gs3yJ/DjOOYpplie4XDVGeLkjCsojRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=09ktxmMs; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c226165667so326021eaf.2
        for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719413854; x=1720018654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypUeuWdUwZsifKp2oQUDz0+C0S3QazinJXlQdPM0mDg=;
        b=09ktxmMs/SkeTGiLL1TA1Andi+jM6Mi8vh9PaTQ5DJSIuGvZZ7vYokyRxj1cocsDNX
         NjpdGtUkhuPdi0RR/YcWd6Zz57oX0v+fV0Fx9LIrX4KHop4SmmqhsiE0IhDc3zP91A6g
         0q5lGmE1MeGc97Q1DuYrIrd+2HZjfm8pokx/n2tQWXDeAEjvepXBm/fUkl8nP27iA6Sq
         NlXFpF9h2xefv07zV4Jvu/7FSkEA9zX2NMeRV7flwh0RfTM83j/xn6ujaD//J+sSWVLW
         PUFDksbA215H8dD+04EytY73Lo0dWrZOv/+5vMhlPZ6GMFcSahNLtHtp7XzeLe/Bndys
         ttRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413854; x=1720018654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypUeuWdUwZsifKp2oQUDz0+C0S3QazinJXlQdPM0mDg=;
        b=E/AviVO/O1BSCkHJIIu5n7FZcfzVw8Hyen7pNlgwphm5hbOgnwboAk+wVB5nUTnnXh
         flCp6/nSpEIUWxXbNaY3Kie5llVCJG5EYumwLJzWuoK7pqoZawUpvLpvBJKdWs6J47hV
         /rUx+0f2VIPR4hlhzrCsD6m2DxORJT2vfI27iyheo26cNzzQ6HyIc50/+dLl/+X8acJX
         3lg2rkWHEZRALBSr4ZQt+t6kp9i2UmfaY1n5enic39MQKIMDEZX2vUc6uriLOi/v6eEG
         1ek6db3awuN+fqCIdrPUq2UbbthL1VVPgCHuEs4+WCADa0dzNNJx5q+EJUtQfiFzuHTD
         ZFwg==
X-Forwarded-Encrypted: i=1; AJvYcCXf5iUDV7asmDbnH410NQbagmTk59CZxQ3U9AxeqrdQK3JQg0HqDa+NM2lPm9N//I35RT/WuEpTFOBGA8NSp4ORT9tUGxhvN60L
X-Gm-Message-State: AOJu0YxXIF6pM9K4YUJQp+j5x4NPjKzJSUgE3WMPQwhqO1XredHo2WYd
	nzBNnGeIRHaUVLt8qQzpHrJlZzM4Qv6py1lYfNECw0vFn4LeTltVuduaK7mF+bA=
X-Google-Smtp-Source: AGHT+IFp/xtG514LhEIAkgQ13lFdNrJwaUD90zQEQk5nJABH3gyJE/Xgli4KVJwoM64l7J2/7wDJ/g==
X-Received: by 2002:a05:6870:d623:b0:25d:1c0:803e with SMTP id 586e51a60fabf-25d01c080aemr11700233fac.7.1719413854331;
        Wed, 26 Jun 2024 07:57:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c056a2sm2926159fac.53.2024.06.26.07.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:57:33 -0700 (PDT)
Message-ID: <1d2cde40-ad55-4136-bc72-3d71515f7023@baylibre.com>
Date: Wed, 26 Jun 2024 09:57:32 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 4:53 PM, Marcelo Schmitt wrote:
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index e8e1e798924f..8e50a8559225 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -599,6 +599,12 @@ struct spi_controller {
>  	 * assert/de-assert more than one chip select at once.
>  	 */
>  #define SPI_CONTROLLER_MULTI_CS		BIT(7)
> +	/*
> +	 * The spi-controller is capable of keeping the MOSI line low or high
> +	 * when not clocking out data.
> +	 */
> +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */

These two flags above are still not used anywhere and are redundant with
the SPI_MOSI_IDLE_LOW/HIGH flags below so I don't think we should be adding
these.

>  
>  	/* Flag indicating if the allocation of this struct is devres-managed */
>  	bool			devm_allocated;
> diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> index ca56e477d161..ee4ac812b8f8 100644
> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -28,7 +28,8 @@
>  #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
>  #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
>  #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
> -#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
> +#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave MOSI line low when idle */
> +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave MOSI line high when idle */

The patch series that added SPI_MOSI_IDLE_LOW [1] also added it to spidev. Do
we need to do the same for SPI_MOSI_IDLE_HIGH?

Also, what is the plan for adding these flags to other SPI controllers. For
example, the IMX controller in [1] sounds like it should also support 
SPI_MOSI_IDLE_HIGH. And your comments on an earlier version of this series
made it sound like Raspberry Pi is always SPI_MOSI_IDLE_LOW, so should
have that flag.

[1]: https://lore.kernel.org/linux-spi/20230530141641.1155691-1-boerge.struempfel@gmail.com/

>  
>  /*
>   * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> @@ -38,6 +39,6 @@
>   * These bits must not overlap. A static assert check should make sure of that.
>   * If adding extra bits, make sure to increase the bit index below as well.
>   */
> -#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
> +#define SPI_MODE_USER_MASK	(_BITUL(19) - 1)
>  
>  #endif /* _UAPI_SPI_H */


