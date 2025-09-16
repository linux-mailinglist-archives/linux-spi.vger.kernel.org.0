Return-Path: <linux-spi+bounces-10048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEEB59B08
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8B34600B4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46231DDBC;
	Tue, 16 Sep 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="obZ4N0j+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634F315D3B
	for <linux-spi@vger.kernel.org>; Tue, 16 Sep 2025 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034519; cv=none; b=CiZwUmEOdqjipSdwJ/IGRL1MflIFQk68+WLZKznXy6yW7bHhBfuy3qLR23XhjqVlcQuXDcbJjcx9G/OXr95IWlD5aMK/vrTrHj66y7owEVr8BBvGYCoCKokyD6IZwYCugmQuzlJkndHYXHL7hFYphpOXPAXFzmDJLOy5kynpH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034519; c=relaxed/simple;
	bh=tm0kA5/U/7lPdDiVcC4zEEqOIVnKxf9PeM+eT4gS4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtaWxgs6BfZdgz4uQYlIhbbABxn6qWnztJx4/aCFdAlJDHuUDfX8kQk8e0bRIqX1AwIfD8jA34mTF/0TvgDLlryF9UOCZZmkZ+JbBiwf3LpcjZwBIt9ZHgZTMHGzvCspvwwL8FrJbrS52QffiUCszzGxrrLJxMOQvzOZfoYVClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=obZ4N0j+; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-328466c2aedso4857817fac.2
        for <linux-spi@vger.kernel.org>; Tue, 16 Sep 2025 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758034515; x=1758639315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5iIq7+KHCywK04RSDS9es8l3U4mIawqQHyrRZJkTg8=;
        b=obZ4N0j+eWHDyjwoNB8DM51ouON16EJd6CsPNyA1WIjfhnr1hkFuHxYKr7caIYqFzc
         w5MQvEudlutDfIHU0rk1jWT++LF7ynasoY4mJmEfy9k+zL0O2DkKCGgTHetyU92BzJK+
         zAqcPMC8pP8PQhzpEWq7koMrjpECa+KRpDtPrGXhInFDdBgDR8jQ1VdNEADeroeMRXb1
         0e2aL2sanjC4hHaTLGvXWUHJl8KHv77n30R9XXGVgNzGqciGBPPHpyfI0VZR0dhUu+aB
         uN77UjvJPFd+ZTWNN9P1ue23IB7ldgGpdciSlR3H1Eu06fsc/Ep1wahJKTC75yrhfO9r
         YdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034515; x=1758639315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5iIq7+KHCywK04RSDS9es8l3U4mIawqQHyrRZJkTg8=;
        b=kjvFhvX1bVItolRXv8DABqtxG4q9Kf8952WhaPRWcO+DpklQ+wAw2LmaHe4CA+gTbe
         3VYVGI1jvyWaxIpP+nUEosssYJQS3NzQ9rQQC9wu8ipfBdiDahqEzwZi3FD8yzSKyQoY
         92wbf7D2mDbF1AEVrtslnsq8IN0KUWeBh5miLUw/GGn5Isl1A67H2c06DdffBjc+xQdg
         ghRfc494Eol6bENollS8aWi0nmV3XLAxQFLnVHBIiTlgp0gxcZ1whAVLHjIyTBOyeUn3
         BYy+f7DKDLzsZDZAe6FrwIslnwU5/bbYXXT1o8e/XGEqiWLCub4K54hX2sESxOUDzqlE
         05dw==
X-Forwarded-Encrypted: i=1; AJvYcCXD480fohnIFmS1iqlZhShMEb5Cjliq2q00xtpRH5+bCg7dgIicdnktifY0fy3Np5KPQVddJJyTKgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JY9H1SdFnu3D7ENbAMG3xFVV3IDToyaeKdXcav12w82vJ4iK
	GuBSs3PWv1ZGFNCrLN0bgrPMMb8fmKplQVz2BCL42VpkHHzLS2/GhVezf2A9/OehRbI=
X-Gm-Gg: ASbGncsp92xE9waM/4MEibCLUIpDiSYyhSaa2IiUiX0S2xGCCMTr23omXWmT7guryzr
	TU6plZ8sUKcJxROEsqcMArKtb8OPsjnMHSqAZLkEl2nZKIU4z3ouxC/h5Ownba7VyPTuahguzro
	qHFDPagEgxfNQvdxX4TfVWjyM+EyiK6LS0iF+NhkoyMieqz3iamjWdANDD4izRPiWjOg5yODp0v
	StNsO0J99+TgPpiz7MideU1uvR+7QzU3s0TT2owghblObYES+ysQIj/QSltXLEVHlyRmJT1F6A1
	U3TAo3QDNAnpnXMu5Xgl3jH/YSbl3woi4zy6d4YiHoCMlSJea5mbhCyfu7CBmiwIb6dus/cNp2W
	/AurjBCzRnjpMjpJfKZG4Ae5LTSa+vTMe7z/CtDh0qZvbWYAQhVQtyt0/U1WE4zoHBaWM5MaB1R
	8=
X-Google-Smtp-Source: AGHT+IG2j6o5ZiECUky0T/Yvf86ZO9qsIYrDXwjsYiIUbY9fkQXrpUngcoYlXLsDg0lSeAlhfx8Log==
X-Received: by 2002:a05:6870:de12:b0:31d:6e43:8d3a with SMTP id 586e51a60fabf-32e54e80af9mr7157585fac.18.1758034515240;
        Tue, 16 Sep 2025 07:55:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-33204689b2fsm2368205fac.6.2025.09.16.07.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:55:14 -0700 (PDT)
Message-ID: <711b5e34-3534-440c-8914-ddb41987ee8d@baylibre.com>
Date: Tue, 16 Sep 2025 09:55:13 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1_via_B4_Relay?=
 <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
 <175133153648.4372.1727886846407026331@lazor>
 <202509161304166bf210e2@mail.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <202509161304166bf210e2@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 8:04 AM, Alexandre Belloni wrote:
> Hi Stephen,
> 
> On 30/06/2025 17:58:56-0700, Stephen Boyd wrote:
>> Quoting Nuno Sá via B4 Relay (2025-05-19 08:41:08)
>>> From: Nuno Sá <nuno.sa@analog.com>
>>>
>>> The adi-axi-common.h header has some common defines used in various ADI
>>> IPs. However they are not specific for any fpga manager so it's
>>> questionable for the header to live under include/linux/fpga. Hence
>>> let's just move one directory up and update all users.
>>>
>>> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Acked-by: Xu Yilun <yilun.xu@intel.com>
>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>
>> Applied to clk-next
> 
> Do you mind providing an immutable branch for this as my i3c tree is
> introducing a new driver using this header and so it is going to depend
> on your branch.
> 
> Thanks!
> 

This was merged into mainline in v6.17-rc1, so I don't think we should
need an immutable branch at this point.

If you are modifying the include/linux/adi-axi-common.h file in the I3C
tree, FYI there are some changes in the SPI tree that just got applied [1].
But if you just need the header in the new location, it should already
be there since v6.17-rc1.


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=67a529b7d3c50a56c162476509361f4fe11350dd


