Return-Path: <linux-spi+bounces-4103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275559420A8
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24501F248B0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3818C92D;
	Tue, 30 Jul 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Csvc6qmG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B218A92F
	for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368113; cv=none; b=EEgP6Si6z2uktJy/VgzJ4XZrk6KgECM7dwWAK6dKB9GEafCVgYYyuJ9Hqsqt6FLptmiTR3h+CseKwys90qqQFncHp1ztier8wa7uAy1P7HA59FGwAxnQW5J2FBVQ6dBMKjVCDEWVZqG73mHAdp1Xi8JKAhyTbygXp5H2dY77fqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368113; c=relaxed/simple;
	bh=SKmTOaBX04wjOvlQyIPGR7vKP77at+uhYghiUX95zAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/8Z6E/3UZqs/uopaylCtrrBTO6tcCzKKQAn9+NeulZLdSplilIwM+4ZC1+haKcYi3KzqeL+AHwKgGMX8jGUm1R8L2KG+BgdDywUa0mBODP+R+95XKZ4Bboj29zWveQbuTBf5mwr/2a2sgsXUoUHgmDoeFb7sIaE0F11LoucIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Csvc6qmG; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2681941eae0so1137274fac.0
        for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722368111; x=1722972911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAcSp3gzGol40k+svpWQDlw0FhOiOc6Z+GibD7IgbDs=;
        b=Csvc6qmG8dgGcmg7XS2jjJXlgKxkO5N6VBT1VTAHIyY9UVE3a/enZNkbhJv1l8d+o/
         ABol9CKGRd/P6VAVQHlCO698vGHCY7SU0Awtg9U/B3i5fzm7Itf6knxAaOAtd311YBMt
         BGGhvHglMDP0EFUvkkrW1Rc5XNsDAugja8EEFN/4u7CQl6SGxEpviA+agB1Dk7i3irrw
         bmtz9/kL8pFjYK+Xyir1fsWI5v8dV5Wr+2Bc+E2KwPTkwff00HDzkpgeFf79uuTPA4nj
         cfScMSGywbkvKMdgi9llsUuEGfl+kG6/Ud/VmqI8jd+xJy8Yu5fiOXkvhkiEkv0KHge3
         Nsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368111; x=1722972911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAcSp3gzGol40k+svpWQDlw0FhOiOc6Z+GibD7IgbDs=;
        b=oKIk8EgTkvWf2SEIEjHpMbtoRD0eZQjlRo+MQ1xm2ui6+R+U58ehhBizOUix8ot7oj
         50uiCyuyu9w+I4hs9bLmNzICZr7jUu83144QJWuH4++8EPLgKpi3x+wdHU2G/l/oGOMm
         tJavDWfsMBV/JbSiUe7FzMyuiSIVuYoI5J9Tcb0zenQ4sB/88L0yCmnf0QIw7s3phLIa
         7T/oTHLLHHuxV4paFO5RPpbBLvvi8JiLKF3rWrTQAbxaiK6C/LadA65doVUNI9YkZ8nz
         sfGI25gGKnfw6UqapDi+cKPW9hH+sVe2dIBPPIMLwJmB+Ppxn3zLypb5d+UYe7bZAbYP
         uPXw==
X-Forwarded-Encrypted: i=1; AJvYcCUpTb3qz6/juHAjfu/VAjOsB8EyGB0QSSbKwLz6lNxbSFOvTF/AsVlyO8aCRmDYpfJvC4wsG5o17qnO+an18gbpjd7wY/8ZFRgY
X-Gm-Message-State: AOJu0YwcAq9Jdk0gmq/v4yJaePRtgszcSiXvin5afk+08BD4BYm2kdij
	xn+ZpwQzyhCapgehwQHmywTaoG1fMVYWtXkab4u+DYlH7wZVbRWriESvPm/RC84=
X-Google-Smtp-Source: AGHT+IFCb4s837HEsfLSfEZCdGT8mLs37+UsP2wobJU3n1Q8DMM7Wkk0LGDGtJ5LNwhc4EwtwGrFWA==
X-Received: by 2002:a05:6870:46a1:b0:261:22a4:9235 with SMTP id 586e51a60fabf-267d4ef991cmr12257418fac.32.1722368111095;
        Tue, 30 Jul 2024 12:35:11 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2657723a471sm2372513fac.54.2024.07.30.12.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:35:10 -0700 (PDT)
Message-ID: <0e60b324-143a-4976-869c-15d1a288f922@baylibre.com>
Date: Tue, 30 Jul 2024 14:35:09 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/9] spi: add basic support for SPI offloading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
 <20240727141512.6dfecc03@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240727141512.6dfecc03@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 8:15 AM, Jonathan Cameron wrote:
> On Mon, 22 Jul 2024 16:57:09 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 


>> +/**
>> + * spi_offload_prepare - prepare offload hardware for a transfer
>> + * @spi:	The spi device to use for the transfers.
>> + * @id:		Function ID if SPI device uses more than one offload or NULL.
>> + * @msg:	The SPI message to use for the offload operation.
>> + *
>> + * Requests an offload instance with the specified ID and programs it with the
>> + * provided message.
>> + *
>> + * The message must not be pre-optimized (do not call spi_optimize_message() on
>> + * the message).
>> + *
>> + * Calls must be balanced with spi_offload_unprepare().
>> + *
>> + * Return: 0 on success, else a negative error code.
>> + */
>> +int spi_offload_prepare(struct spi_device *spi, const char *id,
>> +			struct spi_message *msg)
>> +{
>> +	struct spi_controller *ctlr = spi->controller;
>> +	int ret;
>> +
>> +	if (!ctlr->offload_ops)
>> +		return -EOPNOTSUPP;
>> +
>> +	msg->offload = true;
> I'd set this later perhaps as...

If we move it, then we would have to create a new function
to call instead of spi_optimize_message() so that the controller
driver can know that this is an offload message and not a
regular message since they will need to be handled differently
during the optimization phase.

>> +
>> +	ret = spi_optimize_message(spi, msg);
>> +	if (ret)
> 
> It otherwise needs clearing here so it doesn't have side
> effects if an error occurs.
> 
>> +		return ret;
>> +
>> +	mutex_lock(&ctlr->io_mutex);
>> +	ret = ctlr->offload_ops->prepare(spi, id, msg);
>> +	mutex_unlock(&ctlr->io_mutex);
>> +
>> +	if (ret) {
>> +		spi_unoptimize_message(msg);
>> +		msg->offload = false;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_offload_prepare);
> 

