Return-Path: <linux-spi+bounces-10291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E5B9F326
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A927B5600C4
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94953074A2;
	Thu, 25 Sep 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="StNsYGYl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4900301011
	for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802630; cv=none; b=AvTCzVWoGe5jEP95EFBqbLpI94Ihkm+HSqVkXCwUiGqa4YwsPY3/yTAySCP3C6pRFBWuZ82n2IyNcquheoEap/JgyMLKsqQwyp8GjjCq7WWK0bvPEDl8VJYRNEY26W1G5RYKSAG+YTA/m99VF2ATY7yEoR/9uj/z/CRKDS5fbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802630; c=relaxed/simple;
	bh=vgomaG/u0thPIen/u5fEAsol9ifdvARTkvcWUS9qze0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UWRZKMl6GrXliBtWzmtfi3hHd3PZgvn1S4DdmTjnmULnOvWErcekztU4qpDiSohriN9n1qF5CYsCjxKK8tILteE82ln/HRiQjKHc4ew0++g4gzsJo1IzpAk+kf0shVUxlgeDvDtMapSStZPsGuQXr/qbHxtAcWsC6+pBrPdUWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=StNsYGYl; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-889b846c314so30007939f.2
        for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758802627; x=1759407427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiMnnhjmKlHUptnM90BucFSlyBtvswCn8MfVq9OViiA=;
        b=StNsYGYl0erLr5FKVWx4W9JZSyZNyKMHScuwKRWPR6RtKFXxVA4da6/bWzXOsx176b
         TMhJK7Ot708G300puVuls6G18fitfQdvIGDvjFGQfvShh7Y9eNOTddpodHL+US2c4j6U
         pv3S5NDHlVEIeoZAnvlKC0S/7MGoOUm5/e2DsjUYeyiQVRBS9YzTzfQ2/rbCmcgV+rMP
         fmYkORfD3kY0WmxhT3l2EDgMQIplNNpHaOKd8wv5LnBM+zffENBgJIu2/fgKbBWT3qa6
         aAzZD8aJpvQ6Vd8U96p1CD/oGORLGdgZrVamEiEKlbIFNkZ8GN/zT5hVSqlyXlDxniyT
         15qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802627; x=1759407427;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiMnnhjmKlHUptnM90BucFSlyBtvswCn8MfVq9OViiA=;
        b=u1M89GQg3Ygb+SeYzCGREkIRiYwZDSiGFW822eIlOcwjHoTWS6rVJdAEsAay1Gdi9m
         Ttl2TMwaKO0grFupsnCaU9btjiVD5sVkeme6TCP64rKHBmDOpsrhtlaR9Xp7dmg2kjmY
         4D+cKGAh/jWysrAIbVcdeebJC5ep5YaybA1acgrVDS7PQzFcIfZVDgC0irYQAW4vUuwh
         goXCKTNpPXrfnyemcgXOaWNN75iEZORAyt0/fQb7mvinxmUY1fb+bsvxWeeo9gMEPJCj
         rvsk99ZOgnu/96ar2eLuVDtsUM/dNgdQ2t+nSGpVO/tSPy8v0sz1t3w3FztKkAUX9iR0
         zw3g==
X-Forwarded-Encrypted: i=1; AJvYcCUL3RbKNwyISoloSmd1fb72/IntrdcW3WAMGHxkxVL+uOTwkVjngdMZmeRXR4PWPcACISC6bNtSe/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QSIR5Gs+0Z2pKU3Wm/3Cs6OUHhme1g8R9knTbaeeu94Gcl7/
	oqEcSVq12FAobv7OtZGepVjUFVnErFex5oQj/h7xi8SCqWJK6o8BICt5jO//H0QDCy4=
X-Gm-Gg: ASbGncvrhZMU92GA68/FakivU0j/5liRfc5DZeA4ZsQ9GZb/Ca/5B3Pehteii3xHXh/
	4nybIDCFCsB/zDSolFNcsxLaHeky343Vi+g3caBijVsfZfT2xLhud7dcClZhAeCHHM8cP0mV1k1
	6HegxKz4NMNh0SW27Eja78TeVeT99JGutUymi+NvkWKCI46ymplpbztrn0hRKzPNvnBkq24KLsT
	tjOXVX/1r8syxcsLIWDMIFjfkzevxLg02zAApLAHLN5UGbQ0ek1d5os+lr2Xu7Nc1/4qqwk6Ckg
	xnERtIIJKQHC2swpdrIIsLGmm58+Kp5w20GDGyxki4D4R2flxqkKDwPHC8+WK0ylnzSYn8PvweH
	zeZbyHXbowbRwN04NRrbdOVowzmg6jOKs1p4fHskpY19qON57SHkl0s07R1cZaA==
X-Google-Smtp-Source: AGHT+IGchv2CNYxx9JQbC4IeYd/wa2PLkKLFA1ut7JvKUIyUBucm43vFik72ll2XyHQiSOK+veiTDg==
X-Received: by 2002:a05:6e02:1709:b0:424:881b:ca76 with SMTP id e9e14a558f8ab-42595653b06mr40363335ab.22.1758802626788;
        Thu, 25 Sep 2025 05:17:06 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5adfa6sm750664173.58.2025.09.25.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:17:06 -0700 (PDT)
Message-ID: <ed0e5d82-040b-4642-8a82-611f6b0a401f@riscstar.com>
Date: Thu, 25 Sep 2025 07:17:04 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] spi: support the SpacemiT K1 SPI controller
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, junhui.liu@pigmoral.tech,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250925120909.2514847-1-elder@riscstar.com>
Content-Language: en-US
In-Reply-To: <20250925120909.2514847-1-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 7:09 AM, Alex Elder wrote:
> This series adds support for the SPI controller found in the SpacemiT
> K1 SoC.  The driver currently supports only master mode.  The controller
> has two 32-entry FIFOs and supports PIO and DMA for transfers.
> 
> Version 4 incorporates changes suggested during review of v3.
> 
>                                          -Alex

Please disregard this message and the one or two
others that got sent with it.  Something went
wrong with my git send-email command and I'm
going to try again.  Sorry.

					-Alex

> 
> This series is available here:
>    https://github.com/riscstar/linux/tree/outgoing/spi-v4
> 
> Between version 3 and version 4 (all suggested by Yixun):
>    - Fixed an underrun/overrun comment error
>    - Renamed a pinctrl node
>    - Formatted dmas and dma-names properties on one line
> 
> Here is version 3 of this series:
>    https://lore.kernel.org/lkml/20250922161717.1590690-1-elder@riscstar.com/
> 
> Between version 2 and version 3:
>    - Add Conor's Acked-by to patch 1
>    - Add Rob's Reviewed-by to patch 1
>    - Added imply_PDMA to the SPI_SPACEMIT_K1 Kconfig option
>    - Fixed a bug pointed out by Vivian (and Troy) in word-sized reads
>    - Added a comment stating we use 1, 2, or 4 bytes per word
>    - Cleaned up DMA channels properly in case of failure setting up
>    - No longer use devm_*() for allocating DMA channels or buffer
>    - Moved the SPI controller into the dma-bus memory region
> 
> Here is version 2 of this series:
>    https://lore.kernel.org/lkml/20250919155914.935608-1-elder@riscstar.com/
> 
> Between version 1 and version 2:
>    - Use enum rather than const for the binding compatible string
>    - Omit the label and status property in the binding example
>    - The spi-spacemit-k1.o make target is now added in sorted order
>    - The SPI_SPACEMIT_K1 config option is added in sorted order
>    - The SPI_SPACEMIT_K1 config does *not* depend on MMP_PDMA,
>      however MMP_PDMA is checked at runtime, and if not enabled,
>      DMA will not be used
>    - Read/modify/writes of registers no longer use an additional
>      "virt" variable to hold the address accessed
>    - The k1_spi_driver_data->ioaddr field has been renamed base
>    - The DMA address for the base address is maintained, rather than
>      saving the DMA address of the data register
>    - The spi-max-frequency property value is now bounds checked
>    - A local variable is now initialized to 0 in k1_spi_write_word()
>    - The driver name is now "k1-spi"
>    - DT aliases are used rather than spacemit,k1-ssp-id for bus number
>    - The order of two pin control properties was changed as requested
>    - Clock names and DMA names are now on one line in the "k1.dtsi"
>    - The interrupts property is used rather than interrupts-extended
>    - The order of two pin control properties was changed as requested
>    - Clock names and DMA names are now on one line in the "k1.dtsi"
>    - The interrupts property is used rather than interrupts-extended
> 
> Here is version 1 of this series:
>    https://lore.kernel.org/lkml/20250917220724.288127-1-elder@riscstar.com/
> 
> Alex Elder (3):
>    dt-bindings: spi: add SpacemiT K1 SPI support
>    spi: spacemit: introduce SpacemiT K1 SPI controller driver
>    riscv: dts: spacemit: define a SPI controller node
> 
>   .../bindings/spi/spacemit,k1-spi.yaml         |  84 ++
>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |   7 +
>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
>   arch/riscv/boot/dts/spacemit/k1.dtsi          |  15 +
>   drivers/spi/Kconfig                           |   9 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-spacemit-k1.c                 | 965 ++++++++++++++++++
>   7 files changed, 1101 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>   create mode 100644 drivers/spi/spi-spacemit-k1.c
> 
> 
> base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781


