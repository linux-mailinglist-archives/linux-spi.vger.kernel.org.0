Return-Path: <linux-spi+bounces-3617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A21918621
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9915C284185
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8F18C355;
	Wed, 26 Jun 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V3ziSCsC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979618C359
	for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416602; cv=none; b=cXKdy3irRF3J8xLBp5qYSFwiEru0Hd9JqBxWTMdLRF5vKhRyvDfd1lK+qDwpI60obl1C+PmyipZ4absN3WwE664yDR8F9CUXiUVV7YHKJE3KzzDtBqGZJ7Jex19SY7+RwJP1MJvgvWT/IImzeG0YuhrbkvtuRAjb0tVZocmBW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416602; c=relaxed/simple;
	bh=yBf7BjQ0TET4RNxCRr0z5OE/8zpvjn5itH58dt/E6Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPit8YMNDXUfHeWVDTUYEIoqRNeabpdFS5RSgWDYJmZgc+D3rlFk2QCEEFqyHivh1FCYGibFsNPmxJnTszzD0mFFHwZs2F9Qe4sH+4200LsuNgH+FQJMp3UU+pqRd7ogJK6xWtavYx7SDOfLIbqAXis06RQnovYbvhF9yHiVfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V3ziSCsC; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c21a177affso784257eaf.2
        for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2024 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719416599; x=1720021399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4BM1nm1eXhxPHZf+r3STp6lra6HVOKE5lqVSxFWKI8=;
        b=V3ziSCsCzMt0neFs88m41XqYWpLG9SFFsvujEHfu9zOCfNUjRIdZS2Ak0EtyDiiSu+
         XeApb+hq1rFUGyG23Qcu9aeAdgCaGV2n6RMRMtoGh9Ha6RYbcB3+nLdw5Z81sQQcjndx
         EN5jgYvQtH6x3Vl2tFLfe84J6kqnBSux9aCBHaGH9/87iTQiQjzGH/vrBaRP5LxH9qZv
         Iiut6hJKvMOJCTDSnCpas2/kNvaIoaOOZLOA2rvG6aFygi6p6CU2hZYBnRZqkiE4x9Er
         /IiSel4DQKSYHMuPw9SjJ8wcigiQ+s6luE+l+piFpNXrvlRRLA6YgN0BKkhDoUXLXThy
         D0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416599; x=1720021399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4BM1nm1eXhxPHZf+r3STp6lra6HVOKE5lqVSxFWKI8=;
        b=XQWMb7N/8GqbNI898V2FzfEptUWDrgEUgsbwn8W1UalJ8Ll2B05tzlW7coXpsmWHyN
         vZsbOnejDElGp9rxTzV6fqRck7kpffYl8IddsEuhU1CowCkGWFLifnHym+25G+TH4rWe
         wsHHm+HsJ4IgcQxMFH+JCw0xAKF6pBquHg1tNT8DMot2ifu+E7Ois07P0nCRWuPyadC8
         oUHS/RRZeCh8N+9k9SAyJGi15l0afsmgolPCpOLnKq8djxnSI0fTkYH7PM6yZl7w/BYJ
         +BScsqteGbWsIuXCeNdHkPMjEDEephwMQHLkv1A40GAkD2wttOnO655kMejWw/gPIFXo
         EMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtDQJM1dy4AEBjQhVpUtxH6g/n6v1KZ4XEOWmWFbOdx3BHoNMuskjuhTRygnrUIgK1BbBHIAGrZ2FYFsqsjTdSKfRdKvavjdU
X-Gm-Message-State: AOJu0YwKFfFVdZKF9KLYxT2MHuKgSVe1RZ+pocnWglaVRB1csiee53RS
	VdP52iPBzmCWByHe9Hz6PYn04AAUirfvVFspaAyqoRMLVFUNHr0MPmAddkY7RPo=
X-Google-Smtp-Source: AGHT+IGx7aFcTxf1GenpaKQHv67xvK5YmcOttQKW/seQI/OiieGIay/0iltoy3aIGzodsou6GFy57A==
X-Received: by 2002:a4a:8515:0:b0:5ba:ffcb:c760 with SMTP id 006d021491bc7-5c1ebb01d47mr11473795eaf.5.1719416598936;
        Wed, 26 Jun 2024 08:43:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d58ff8f4sm2162338eaf.41.2024.06.26.08.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:43:18 -0700 (PDT)
Message-ID: <55d0cc07-c877-4510-a052-4458ee964615@baylibre.com>
Date: Wed, 26 Jun 2024 10:43:17 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] docs: iio: Add documentation for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <e553a7c6ba88b3d8ae2db0963212fdce0919805a.1719351923.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e553a7c6ba88b3d8ae2db0963212fdce0919805a.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 4:55 PM, Marcelo Schmitt wrote:
> Document wiring configurations for the AD4000 series of ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/iio/ad4000.rst | 131 +++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 133 insertions(+)
>  create mode 100644 Documentation/iio/ad4000.rst
> 
> diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
> new file mode 100644
> index 000000000000..de8fd3ae6e62
> --- /dev/null
> +++ b/Documentation/iio/ad4000.rst
> @@ -0,0 +1,131 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4000 driver
> +=============
> +
> +Device driver for Analog Devices Inc. AD4000 series of ADCs.
> +
> +Supported devices
> +=================
> +
> +* `AD4000 <https://www.analog.com/AD4000>`_
> +* `AD4001 <https://www.analog.com/AD4001>`_
> +* `AD4002 <https://www.analog.com/AD4002>`_
> +* `AD4003 <https://www.analog.com/AD4003>`_
> +* `AD4004 <https://www.analog.com/AD4004>`_
> +* `AD4005 <https://www.analog.com/AD4005>`_
> +* `AD4006 <https://www.analog.com/AD4006>`_
> +* `AD4007 <https://www.analog.com/AD4007>`_
> +* `AD4008 <https://www.analog.com/AD4008>`_
> +* `AD4010 <https://www.analog.com/AD4010>`_
> +* `AD4011 <https://www.analog.com/AD4011>`_
> +* `AD4020 <https://www.analog.com/AD4020>`_
> +* `AD4021 <https://www.analog.com/AD4021>`_
> +* `AD4022 <https://www.analog.com/AD4022>`_
> +* `ADAQ4001 <https://www.analog.com/ADAQ4001>`_
> +* `ADAQ4003 <https://www.analog.com/ADAQ4003>`_
> +
> +Wiring connections
> +------------------
> +
> +Devices of the AD4000 series can be connected to the SPI host controller in a
> +few different modes.
> +
> +CS mode, 3-wire turbo mode
> +^^^^^^^^^^^^^^^^^^^^^^^^^^

The datasheet also has the same diagram in _Figure 55. CS Mode, 4-Wire Turbo Mode
Connection Diagram_. So maybe we should call this "register support mode" or
something like that instead of mentioning 3 or 4-wire?

> +
> +Datasheet "3-wire" mode is what most resembles standard SPI connection which,
> +for these devices, comprises of connecting the controller CS line to device CNV
> +pin and other SPI lines as usual. This configuration is (misleadingly) called
> +"CS Mode, 3-Wire Turbo Mode" connection in datasheets.
> +NOTE: The datasheet definition of 3-wire mode for the AD4000 series is NOT the
> +same of standard spi-3wire mode.
> +This is the only connection mode that allows configuration register access but
> +it requires the SPI controller to support the ``SPI_MOSI_IDLE_HIGH`` feature.
> +
> +Omit the ``adi,sdi-pin`` property in device tree to select this mode.
> +
> +::
> +
> +                                         +-------------+
> +     + ----------------------------------| SDO         |
> +     |                                   |             |
> +     |               +-------------------| CS          |
> +     |               v                   |             |
> +     |    +--------------------+         |     HOST    |
> +     |    |        CNV         |         |             |
> +     +--->| SDI   AD4000   SDO |-------->| SDI         |
> +          |        SCK         |         |             |
> +          +--------------------+         |             |
> +                    ^                    |             |
> +                    +--------------------| SCLK        |
> +                                         +-------------+
> +

I think the rest of the explanations are good.


