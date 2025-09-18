Return-Path: <linux-spi+bounces-10146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A9B86A29
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7E91C87385
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A72D838B;
	Thu, 18 Sep 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uO6yzOKv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF412D4817
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222748; cv=none; b=oFilp7jNyVnITwPRBlPGT2IPuf1btaUTdz3TnHpzM29KxWgOMs4Zs14BWP538shLUGxhm3gQhd6t1kk418rKm4FnlmmJuCukztMuDS/Cso7caMHJqZPnXYcHnOcD8H8zTK8yzE3h9LgTYp1VAhX4DHHvACRzGlBtwDJ7hngIt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222748; c=relaxed/simple;
	bh=E3LZSLXMdPL95SK+eNzUYQ+vwbzIS9yTVFJp5UGnXkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBwQTnUkVnc1vZwEM3H3YLb9mF9CArMD1CFpO5maDzzAmBMfJsxTdETl6zxGhH/reqFAPGpEv9SPpYIb68xYR4cWT8C/2iSUJYK1dgx3mDPz9xx4/KHmeXelsJMp2iKOyXy8dqmD+jjEZaMP9wAMoW1X7Lq2ROmIJ2sSvoK5rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uO6yzOKv; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-621cecfcc04so694751eaf.2
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758222744; x=1758827544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=uO6yzOKvHUrj5vWlRb7yExzuBt4XiR9P5NmhnwiJ5bDrhv3Z7Hecd53lI8VrcTd3II
         zrJRfzsTwktoU7s0CI1ssCCylnu+AgbFR2rgrGckzPm1s7kWUdkQ4l/Wnxbh1XBK1Sqg
         txFm5A42/uv01tv4x0ttQMt02T5j46PApO1ppJqN46vyFrfx2959VxxCvWgPl8Xk9Hn5
         jxswfcqlP9f8LrIm+FI9jCco3LHKSOKqLDcx5cxGXcv1MjW4agW+wZY3WA+5YJxJm5AP
         BkHi1dlGWCpBTpVo0tH1DUP6tfPQARud50O/JiatwTiFwN9t/wwdToBLf8HoVDAYvLmO
         Wd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222744; x=1758827544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=CAt9t+1jlWVJLeyPWNnAdQ5V46lM+NOKv9sTxPETW+GzJvRJkrwwKzls9le9J+nTzE
         q7OFmUGjCqoAzOCcViCNzSpx4kjKu16C8aqbwPReVtR1PCyxVXw+uCuGLaWDAbAjKW/e
         G+WiNLxvAFOu7HaIhoQupehIinKeTlKR0mcN5w2Q7E6xHmDP71IbaTjbqAmds88Eq3Zy
         DWzFSy4MO3KOhBLvNh1r33rDDMQNdHpoYKTmMuL1DBPYm2cyAht3LhjL6rAKGY3Fow9H
         Tqs5ikF7sqGh12VdXjKiAP1jLWYidXGUcMkC6wiqV8pDTysOTrp4eAPXKhWy9LsN5oif
         C29w==
X-Forwarded-Encrypted: i=1; AJvYcCWhcYxOcfl/CFp+C5HuVNXugII2q6PRsUK2HVfW7YJG0s01UzmiETtHkY6lkgF1jurgSNtE9yL5zIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWST6lQYDoNGJamI4w0NTUJ2TbnN6RoYCHYVfaLkCSpvIQIN6
	dKVr+yCL+h8xHmdd3cpaAMRlgPMYcDnoEWJ1NWXlQQgTc0tjl9hsrXfxSqH7pSfh9Fg=
X-Gm-Gg: ASbGncuE4GrdDohZ4SfzzW/pPjtvmGUXIAJOsgzyVeJrEDGUthGaNn8f8EupKnzpuEY
	C4XJxB3t+59jEClFEMflnCmagpnxBzL9fQ2PrSPtr+EJ94KF5iQpB89g28zjCRmyYPtWb6F9XkX
	LX2g/HRkrgfJsHzyriomcmZS2xIWJ875V6fHJChj3ZDywv5ygNV9F8b4yjGNcGnFAVUC1u50/QV
	Q/Z1ahGxNX9iT62WtCChER7Eny4pyiKvs0Rk4Q25r45B2iQC8mcHdoPCCF97I9EqwIl8ax5CEmO
	+CCSmyCCweqlMjrzrTHRiQT3rHQjyP4dxN1tT3s/Hz3pOIErn8N7g0dZhkfHTpX4HaQGxKGlOp2
	rJt0YEU6IuAAEPhZEzdReDppM3NUfk5ZwmAxb7l5ScgMPpxlW/4Gewsbn5G0AUHtTcVsiDNBd71
	+KjL0jygHcoxDWjrZwkA==
X-Google-Smtp-Source: AGHT+IEjWUgvc4lTOFTwV5s3qOByTrBRgcgcc0xXFcx8Jx0Wu7qnzn0uZbvp8NWcWQQ5wdeD4/BMIA==
X-Received: by 2002:a05:6820:2218:b0:61f:f591:8a2c with SMTP id 006d021491bc7-627256b01b1mr242474eaf.0.1758222744202;
        Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db105811sm995869eaf.15.2025.09.18.12.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:12:23 -0700 (PDT)
Message-ID: <5607a969-2e42-4530-94b2-caca21de11aa@baylibre.com>
Date: Thu, 18 Sep 2025 14:12:22 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: offload: types: add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  include/linux/spi/offload/types.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
> index 6f7892347871..0170fd1f42e5 100644
> --- a/include/linux/spi/offload/types.h
> +++ b/include/linux/spi/offload/types.h
> @@ -59,6 +59,7 @@ enum spi_offload_trigger_type {
>  


I think this would be a good time to add some documentation comments:

/**
 * spi_offload_trigger_periodic - configuration parameters for periodic triggers
 * @frequency_hz: The rate that the trigger should fire in Hz.
 * @offset_ns: A delay in nanoseconds between when this trigger fires
 *	compared to another trigger. This requires specialized hardware
 *	that supports such synchronization with a delay between two or
 *	more triggers. Set to 0 when not needed.
 */

>  struct spi_offload_trigger_periodic {
>  	u64 frequency_hz;
> +	u64 offset_ns;
>  };
>  
>  struct spi_offload_trigger_config {


