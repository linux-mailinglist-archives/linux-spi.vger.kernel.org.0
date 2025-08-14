Return-Path: <linux-spi+bounces-9444-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A7B2706F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 22:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AB0A087AF
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C52741BC;
	Thu, 14 Aug 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="svHurz2P"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4513266B59
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204917; cv=none; b=sP3b4MsJM2L26guXoLa7meQGmjzXlc+iGn8iBChJ6leXiBitPJomdCCYHBXngoyOsrmnhLAcuBMEO3Ka1p8zvRvlSYOslbh01NSkqXsSepxA14orzRqLqh2CFgT7IDTUXoRYJusoV6Lrr4UP2yUH40CysQ7CAY6bod+aASlmHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204917; c=relaxed/simple;
	bh=c15i7N/nHlctlKIhfbueGZzSOzwJXM0VEKrLTLzVMFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgB3N2b84CwMqRGlum/f4cn08rf7M4pY6dtx7wt+3Kosd/yHhjJyDhZcrCJGvd6/PspsbgccPBAZbi+RZR2GDsOz08JAKF/RxqH8ERsUwKvkQ87wZ79kOi8PHY3p0JRX7OM6SUh9f3++1LNfwPkeH78xR8APlSPYV6XRKYf2BKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=svHurz2P; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce50dfb4so1506546fac.0
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755204913; x=1755809713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Lw1CQk3OPOq0zllcKBx/nVguWCpRXrFP9xKbQEaC04=;
        b=svHurz2PGwVSp14Zl00YZ+PBw6vB+3kYKsQMDFPjR/g32lCuxgDpG0Zk4q4y3wvO4s
         eESBMa53EmsaEpVQL4zbV2wzwdzsWSvT1/BVP6PF3G+a9G22wbYCFpKAboxwEpGZ/WYI
         vKKlfHIXDYnTlU1ximIDhnSpvMwlXlxycP5Am4N96E2kKF+piCS2IeN7vfTQ2QKN0FSb
         EyaIvyVHZKXVIiAjLLcF0Fb+g/5Yp9NBdsfB02kOLSPoXcap5rqdWgOFDReTMeYFPzXR
         ASF8Z0Pewqc6pemEXU1Bl48j/tRR58+hYoUF1BsoOsw97DyxQX8cv0nEMLf5l1S2fj/9
         Fddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204913; x=1755809713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lw1CQk3OPOq0zllcKBx/nVguWCpRXrFP9xKbQEaC04=;
        b=XLYpJj2uV0KLKWhzTGRZkzODTBxmnDtOSgcVPrDZNx9h43kh0OIhMUi187z9iydsR9
         Q56NuuXl+/b/lpWtB4S7J9RYiVTsBr0sjJjRGKFb0TPICq8M5f/AFh0RfGfjdtlYGrKO
         Wh9I4W5aLTXypnXM1y3/WTTxuQuYFndG+Yk0dgOwhDUpRgXlsaH3zo9UHU0oLRhhshra
         jWLUMlOkHZu3PQI4QAYwpa1M7HNIjKeiZPMDKfSo1R2X4JiAMxMl1+xH2MTYz0308Fwt
         qjq3jYx7p+z2c/GBBgdctd63zFOfC153jAUlM7gYz++0bbacezYEPfQe3mZHhkgQxjaL
         ocWg==
X-Forwarded-Encrypted: i=1; AJvYcCUyrFR25G21FHH8mf67mALciSIL+rNd0N1EbDp5nHW8ZBZfsWTQwcuxqTZLNFp84WulGkQyLD7eGtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wEWMdP+XdfHuo5FTEEgczPlg6XuAwEV4SpHWFJu2e5RL2LZL
	ovv/Iuij0mB3zYDhMeVMZuNM0CADDAX+gbHLAR7cR6ryFlU3Yq+RN6UcMkKd2yX6z4Y=
X-Gm-Gg: ASbGncuQwAlA7e49vIWD1px3og3UMmFg61xxwy+Fov/XyptMAMhq09ttCsmLTn5rx/l
	Qdbl+xSCn1BBsnFUJEc6xAtUN8SaT+P/BaX7vt0q6hhZ58rphGtIRfd9HXid9sOOZ6GAG/AsnaB
	We+5/0gIJqThVUucP2DMMSjypKOmo7I8w1nitv6sVnwR98cqcRt9wNt//Pfv1vOfCUsT6M2ftjd
	yymCPQYJPub6XC5htMBM7M4ToqnndX4hJwy7DL6H4OLleHWhGu5zRlOzbTw6D756RZXuYArW7NB
	8X7VRtkEeU9jKQLB7wTCMTusfXuBNYDZNlOYMwrx2dxPnbvKsJW1Uf04cHUgNQX3P+DJlJ7M0dg
	hATq1hJbMtSOPuAJTrGR8VVPdyQyqfN+kIzGSBJU5S8NK+irFrp/UFYG7m/HfbYXLY5XfMAcDyf
	r5CMZSlf0Wgg==
X-Google-Smtp-Source: AGHT+IE5YbjZs2djBXKIUErUo7BXp2zMu/SzcdDO7ZnF6dPRtxmnztErim872SLpP49Q3QZx++e6ng==
X-Received: by 2002:a05:6870:548e:b0:2ff:94d7:b006 with SMTP id 586e51a60fabf-30cd0e61eb4mr3135219fac.13.1755204912792;
        Thu, 14 Aug 2025 13:55:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30cd018da90sm905636fac.32.2025.08.14.13.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:55:12 -0700 (PDT)
Message-ID: <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
Date: Thu, 14 Aug 2025 15:55:11 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> From: David Lechner <dlechner@baylibre.com>
> 
> Add a spi-buses property to the spi-peripheral-props binding to allow
> specifying the SPI bus or buses that a peripheral is connected to in
> cases where the SPI controller has more than one physical SPI bus.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
the subject line to `spi: dt-bindings:` on the next revision.


