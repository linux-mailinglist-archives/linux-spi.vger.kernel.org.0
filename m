Return-Path: <linux-spi+bounces-5494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A029B0A0B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC41F21A22
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C81FB890;
	Fri, 25 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zrzEY/fe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAB18C336
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874149; cv=none; b=eVjoNnq8/301gx0eaBUrLkRE6xUR9XisZ+oePNWGoLgdsEMtQALL11PAEjx3h8HJEMjWuN/XtM4eYvtLTpFYHhT9f40KNF5ekwH9Gwm3HcfTYF5p4RJRtev924NCbLnMmLdEHLmInpsnUoqLX985zbUBaLI8vTnNcnh9cDxct9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874149; c=relaxed/simple;
	bh=+mKkqhjOfp/8NKKCudMMe/P4eWYuwxPS5xhBfWoY950=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMN4zS/xqZSN2TTfvcIPuW7m4BWE2E/uCvFmpQEYIi1CecoEHIMvmM1LG29VTV24oqx1tS6uTsGLxOch8mREq0FlDYGJBdvBDR0QCSyF8tXN22mtOXXBaDWR94GU+yBwe78K+0mt4ds8OBxUq+rqufI6nWcNHYj92TtUJ/C46J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zrzEY/fe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0e13d25so883802eaf.1
        for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729874146; x=1730478946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=989e9i6l9ZWGz9AVMP0M9BcfdKAXAdUqBJ5ScVIDhD8=;
        b=zrzEY/feB5XjwpXRxjHwE6Oz456AYMACAKlTnpKqV0j7nZA8yC50fMxgI32mnLGOR3
         IKmj2bwDSE1UzEI8zotFhxzguYr53qw1NB38OvvpEDl/0arc/+aSZ6fKl7J8Z/KDxL+9
         b8qfnLGzdRMU3zKsmu8CjYUCOLpKuwpKdNlYhWehXxaTVTMOM50f3E1uZxuztsU3gsn7
         3Jc2nvYImlrV7j8q/Pj42dq3xfz3nIFJYWTN2gi9t+C+hSkJxD4JFwA7UC21b8ELokN3
         G3sv5xncNDshsZQSK3cEkTbsEKhAf3hGjeZuaXWYHQvNTm4smAYt867VF96t0My/vMm6
         FtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874146; x=1730478946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=989e9i6l9ZWGz9AVMP0M9BcfdKAXAdUqBJ5ScVIDhD8=;
        b=rzE6oABrC8/qfbjpjapebKXNnGniRNpC8PCUyh8I1UuW0k4KxitAKUWCeKvoG1jcIG
         q0RnToGUh/lf6T9rOiCqafeAgCdLceXfDjanx+5G/NGu9rDVq66nFh1iZACp/1bc9z5g
         IFUSWRt+SOEmhzLJfRbkdcmwlm23SpC56Caoj7yThHDX80gfkyq3UMZkxnT1MPb/tKDx
         QB/Vn5p3osqIqdjBsatzeTlruiQ2R1hjuFhaz3cNAwW+foNlBe+bmzZUlqLFaqlKRk+F
         RPFERB9a2ZwhQQn0TgynYtIufUuWT2XiZZtwKAWs8JOG6szFTll5FrB0NPB8q7w2Lf45
         TpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4YLjj8syVdgxrYHYykUWIVtnWIW0HIVYjJ4eO7R4duq3GFw1L7PtZarnJ3VZrDwIENXlwbbppKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunU0ktmtY0zIaYSAjJaTfVYA6WCOXmLqF0PMW0g9XaCg6Tlpu
	NVgGHaYca5ry6fZiSWO074aw38Y+YZMaByQAFCE1/AtjgyHOBH799QnTRlL9qS4=
X-Google-Smtp-Source: AGHT+IEFYO1M6pTkfu/lPvM0ue3WVlvBKRAjeNfd/LOIMo54KbBBMSvxxwGrLvo+2kGB0WtDyVR8Mw==
X-Received: by 2002:a05:6820:1686:b0:5e7:aeed:97be with SMTP id 006d021491bc7-5ebee9a6161mr6603567eaf.8.1729874146115;
        Fri, 25 Oct 2024 09:35:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec1843d4a5sm288248eaf.6.2024.10.25.09.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:35:44 -0700 (PDT)
Message-ID: <f7fd8929-352a-46e2-8f78-15720ab31b9d@baylibre.com>
Date: Fri, 25 Oct 2024 11:35:42 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 09/15] spi: axi-spi-engine: implement offload
 support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-9-f8125b99f5a1@baylibre.com>
 <35e3a616b1cd0b66096795f247604bbe1aa8300d.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <35e3a616b1cd0b66096795f247604bbe1aa8300d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/25/24 8:09 AM, Nuno Sá wrote:
> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>> Implement SPI offload support for the AXI SPI Engine. Currently, the
>> hardware only supports triggering offload transfers with a hardware
>> trigger so attempting to use an offload message in the regular SPI
>> message queue will fail. Also, only allows streaming rx data to an
>> external sink, so attempts to use a rx_buf in the offload message will
>> fail.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>

...

>> +static int spi_engine_offload_prepare(struct spi_message *msg)
>> +{
>> +	struct spi_controller *host = msg->spi->controller;
>> +	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>> +	struct spi_engine_program *p = msg->opt_state;
>> +	struct spi_engine_offload *priv = msg->offload->priv;
>> +	struct spi_transfer *xfer;
>> +	void __iomem *cmd_addr;
>> +	void __iomem *sdo_addr;
>> +	size_t tx_word_count = 0;
>> +	unsigned int i;
>> +
>> +	if (p->length > spi_engine->offload_ctrl_mem_size)
>> +		return -EINVAL;
>> +
>> +	/* count total number of tx words in message */
>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		if (!xfer->tx_buf)
>> +			continue;
>> +
>> +		if (xfer->bits_per_word <= 8)
>> +			tx_word_count += xfer->len;
>> +		else if (xfer->bits_per_word <= 16)
>> +			tx_word_count += xfer->len / 2;
>> +		else
>> +			tx_word_count += xfer->len / 4;
>> +	}
>> +
>> +	if (tx_word_count > spi_engine->offload_sdo_mem_size)
>> +		return -EINVAL;
>> +
>> +	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags))
>> +		return -EBUSY;
>> +
> 
> This is odd. Any special reason for using this with aquire - release semantics? Can
> optimize() and unoptimize() run concurrently? Because if they can this does not give
> us mutual exclusion and we really need to do what we're doing with kind of stuff :)
> 
> - Nuno Sá
> 
> 

This looks like another leftover from an in-between revision that
didn't get fully cleaned up. I will reconsider what is need here.

But to answer the question, strictly speaking, there isn't anything
to prevent two concurrent calls spi_optimize_message() with different
messages but the same offload instance.

