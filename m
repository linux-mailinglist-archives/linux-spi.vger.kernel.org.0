Return-Path: <linux-spi+bounces-3799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A692AB11
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 23:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3921F227F8
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035514EC42;
	Mon,  8 Jul 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XDys5MyZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7714EC51
	for <linux-spi@vger.kernel.org>; Mon,  8 Jul 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473556; cv=none; b=un2aWsSTwj5y0tUzmEs1A8dMgdRJMOfqWvoHGVx0+jGXKn9XCyQaQ2VJx/Ibq7ea5QtH4GACS5pUL41P8ZcZWDmd/U4IuEL8HVsHDJJIxJlGH73KR7A6gwUBSCWvVdeCnK4yW4ZJ4rzJIjIOrP3QGR2U6TMpRfd8W3LfSCFaRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473556; c=relaxed/simple;
	bh=hsAhfj8aFEJs71FYpyqPwZGOXF4mUvOaxuVfwyymbI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvN38SEU2q2IBrO7yUIhvS3Searqs57uu11EPZDThuFNcLGxCZbMJdOmpp18kN4dOCnl3LLYEfVy9xqJjCruqWZVzygQ5iqMfYq8g+RzqVv1Qtoe6Jq37q0AXj2LEoDFqt25q1lWYFozKE28vBzR1gQWrAgyhD0UUUkVsjT5Igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XDys5MyZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7036b87752dso823822a34.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jul 2024 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720473554; x=1721078354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXYMPnBhTdbUT+bRyOjqdFg2raSWl8DIGx1soVkduSw=;
        b=XDys5MyZhHNieTee5sQHCa2FS0EOHE3PvP1ei/qgPgKD9iv8l+qlmgnU6vcLn7VWP9
         5aKOIlnaULeszFiPd6zu3vNHSwin08oVh8Cc4za5q0QrFjYbp821bQaBFA2oTY2TK9fM
         bEj6QrVjanTvCLNPuFzcA5MmMFnhRc0eHr77QJUXBIY3gRekMukemWoP7BDpXQb3cnzY
         /eGxFzQd3FWpYmcZQGF6okDd9lbo+GPBGkABT95cj4994zIbrjS1yd2x6dJ4fRRK+VtN
         1kQlt+EDoUZtJKtPAfa74eKMJzFLhWWlDhk7qluZamSs87TdqW3WXxqGTZF562r2m8fU
         cOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473554; x=1721078354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXYMPnBhTdbUT+bRyOjqdFg2raSWl8DIGx1soVkduSw=;
        b=BS3IUv3yRq5EpOkrDapBha3oFodDn6moCS35Onxnm0MwqfhxvuXA7pTvBnljz9CJAm
         97rf3TzOxD1jQVxrqmk0uMXqSdfhnuZzQrLZlfD1g5jtU+GYJ9vdWDNeF7n2AKqVdU+v
         9KFLjdP3/PYr7lqUdhkFqFN2h1mv//clGN9/ooABMwWIyGbI2Gu5+1bByK8e45Wv6zob
         4wwstiOJVZIeJ0T7quuWTlCcCPkOrNzvWxGFp7h/HZN3/ER4eDPz3hQkwFq76D/MWqhd
         07u64NdZNzfNgrHJVEzdkMa4r5kv4JzbxJHoJSbPuST9NLFU3MdTqWkWgWt7HGKxbvtL
         SFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUaybmjal1JmkGCOavZofb6+wCLsDVYxavsNrpXtxGjLWhk2pwGgMnW18s4GXyDkbY7oZh02iax9u1fEs7RhUdaNlYZAvUG/Ll
X-Gm-Message-State: AOJu0YyoTRyFFPXrsMIuF3n53oWSyulZk9sheqDaZrs2HhajZXhZrjFm
	SSKscg80xOLLmsU5Wbj1ZqhPhjzLkF1RkXFGPaKN4yutwtXoQZA9uqB3eBWJZq4=
X-Google-Smtp-Source: AGHT+IGIs8S5SwxO5AG/xIB7go50K9dRKNy/yvMs5ivx/sMjNBmQ+wjU9JHs8h70Kd5YvwnO3+hheg==
X-Received: by 2002:a05:6830:3443:b0:703:67f8:9b3b with SMTP id 46e09a7af769-70375b4045fmr634344a34.30.1720473553835;
        Mon, 08 Jul 2024 14:19:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f791fbsm165072a34.27.2024.07.08.14.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:19:13 -0700 (PDT)
Message-ID: <f543a6c6-ef79-4dc2-a5e0-872d491d9606@baylibre.com>
Date: Mon, 8 Jul 2024 16:19:12 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] spi: bitbang: Implement support for MOSI idle
 state configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b08e21823638c241228f4bc27a7bf5d4ed88d54a.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:05 PM, Marcelo Schmitt wrote:
> Some SPI peripherals may require strict MOSI line state when the controller
> is not clocking out data.
> Implement support for MOSI idle state configuration (low or high) by
> setting the data output line level on controller setup and after transfers.
> Bitbang operations now call controller specific set_mosi_idle() call back
> to set MOSI to its idle state.
> The MOSI line is kept at its idle state if no tx buffer is provided.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

FYI, this doesn't apply cleanly to spi-next and needs to be rebased.

(conflicts with https://lore.kernel.org/all/20240517194104.747328-3-andriy.shevchenko@linux.intel.com/)


