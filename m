Return-Path: <linux-spi+bounces-8593-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31611ADB1BB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB20161C2F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9472A2BEC28;
	Mon, 16 Jun 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRqGg63o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD52C08B4
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080222; cv=none; b=P8Ac66wj9vJyiJpJICzyLZA0ZkjGasMvfPzDixpCEAJGIUutkn1ROD6lvppzeApScpltCnUxaVN2rutactakUIIrMAUmuYiFwErrFRLMPOPDV+DaPZeqHBf66tLST9deUTPNv52NYoBYhLyRIGaRo5+b7wV7Mn2wXP8QmEF0guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080222; c=relaxed/simple;
	bh=cyawNk1X0Zi/5eV0YddzR83paiy0w8sFEtP0KMTHO+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSlapzHYY1l9+GQpqzRI9x+erpvKkDjPxPbxuO/CKhbjgn0A5qRSn3kIbHEmZIAqnLgfyJQ8tUldL4oTWMRYcEt0JDlOTsws1I2ZxxErmsZfBKfByQJbDoiMnYSwb7MzgSkndUWy+xp+dfNIC6TKbKSiKM7C1i8U/pxtuof5PIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRqGg63o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so29562035e9.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750080219; x=1750685019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qEWpHoeWIO3tFYAF9CvYNghxJJaKn+YeJWG4YUN/nk=;
        b=TRqGg63ou/s3tD74bRsyVsr2sY1dkVhUms4/6J8wHrZt5ko0oWZhelFQEU8RRlbj8/
         Prd6UuBno5THmCRv2c/2vmxutGq9tgRZ79JAcRkDTezmyyOJXGtoUwGIwWkinNF65tkR
         0w8QAGj6elBXSSVLtKpkeik/cN5HNpkjmVVKkXuX2rLdgkMGqMvdDikqiQS3OZBPJUGy
         y1ayWGUCOgLQz1Or1WJ0Ptz0fVGhgTyGL8WyAI4Jd48uWcG8h2lszXnX0H/JaNQXrpjW
         5NQ7lrk1W9q4vlAOuqqduyg1WD3ib+LFrjzEwT2eN85Ybrql5F3q86WxD8r3NQSq7OM5
         zU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080219; x=1750685019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qEWpHoeWIO3tFYAF9CvYNghxJJaKn+YeJWG4YUN/nk=;
        b=mfBlud+zz0W5Od18/muo8VZ5L1uzs1WbrTf+OxKOVr2oqHhdHCpfaZBGjK0MNNVjtz
         HVF1QjInZcSdubRJPeU3UjUBPOtuHrymuM8Ej/4952+0CVYbWw4LVa8j+F0zu5bKNND4
         MxGu4x4FRE5AIffLh/seyftd23Yw4F3gOH0xGI1UECQwFg6itteHmKHIrlS8leFmyX23
         rkox9atduCng/H1SOQiTnyo0lKWOXe+yeyosper0X2aRQ0XjFJxPbP6+GSmA/bLYuMWj
         WyrAAqBg0GjqwtvKhbssjHP0zOc35XYg+4Tig4vRNpRtq/Yw9MDZrErJVBEqWvxdED9s
         u4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhH7csj9EVpqiP8pdngH1A1WUl216t7LApEy7lWyb7HSwaDDkVXFM9q0AtZuKCpiAO1JdVKCd4MD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYH9npWWuT4vhdabJbr6pwTXZOBSkM6c6etYCS4k8muEJ7exI3
	cgmBl/5zd6Xg9e9HakZCNRuBlJ8LRgDDSaGUhM8Gphti2oZh5dSH2HNAymCawz/4L8I=
X-Gm-Gg: ASbGncuXInz53wyvYUZ/TEpsDDfHWUlXmwrvORdTgzpS2aTujpfzc0fpDt4kgtr++ZE
	7QZmxRKGESqKCU2029Z3YsUoEhKBNBObuuK3EgVAo2gMvSYQQrDGRlmlP+6Icq5jURH+sVZeZTd
	QyjROyHWm8CoM56FKuiq8d5CUIssAtl4pkPBG/JNulBnJ+YJ+tF2rW3NrV9PnsDiyHAdyVqPuBw
	u9JoLAW35XcusJYGmlFjZaZMQJJK/JB6sdk9ZRhJJS5ntssxoBnjhtuBWCuW6xN8c6sP9LNU+bv
	136uu8uJ25S+MLcp8+E2LE5K5jVuSnjkn5RVyHbwQRpMwrnuOjfcdeIv0kjUJ1+luac=
X-Google-Smtp-Source: AGHT+IERCtaWBolBNjDrXYPOFWEd3Y/yA2ERjVGzzTRMp9TUI6iIxEBCxIQatiSsuRqkKHIXYBVg9A==
X-Received: by 2002:a05:600c:1d1f:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4534f9f165amr12231765e9.20.1750080218851;
        Mon, 16 Jun 2025 06:23:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e241b70sm142753815e9.18.2025.06.16.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:23:38 -0700 (PDT)
Message-ID: <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
Date: Mon, 16 Jun 2025 14:23:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: Christoph Hellwig <hch@lst.de>
Cc: Mark Brown <broonie@kernel.org>, olteanv@gmail.com,
 oe-kbuild-all@lists.linux.dev, arnd@arndb.de, larisa.grigore@nxp.com,
 Frank.li@nxp.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616131944.GA30260@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 2:19 pm, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 02:15:56PM +0100, James Clark wrote:
>>> Yes it does, it has a few modes that don't require it. Presumably we can't
>>> just add a depends into the kconfig for all devices because they might not
>>> be using DMA.
>>
>> *for all the different variants of spi-fsl-dpsi devices I mean
> 
> This is drivers/spi/spi-fsl-dspi.c?
> 
> Yes, looks like it is one of those rare devices supporting a DMA and
> non-DMA mode.  But everything seems nicely guarded off using
> "dspi->devtype_data->trans_mode == DSPI_DMA_MODE" checks there.  So
> wrap them into a little helper using IS_ENABLED(CONFIG_HAS_DMA) and
> everything should be sorted out.

Sure, I don't mind doing it.

But separately to that, I still think making the stubs consistent would 
save people a lot of time diagnosing build failures if they switch 
existing code to any of those 3 functions. Principle of Least 
Astonishment and all that.


