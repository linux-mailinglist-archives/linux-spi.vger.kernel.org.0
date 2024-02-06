Return-Path: <linux-spi+bounces-1107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCF84BD9A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88AB1F29A2D
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C555134D7;
	Tue,  6 Feb 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWBNV3WD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514413AE3
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245987; cv=none; b=PMsQ7NKo0ZlwksV55vyN9ug1TOYZnYFa+Ssaf0tQ6Xff2DxhkbDyDq0ko2IgRMYkmBhKcJMHpQIXkuvxDfyCYh1Ftk8eXbqClu+ZFYzccUz5LdS/UC6EImyAyNaNshwBLciZXHrJMFn314+6oMxFQSud3YIAbKQKQxl32uzsIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245987; c=relaxed/simple;
	bh=Wf1u/K7cqpPvvIf8VkU04/Nn9EPNlzss+1dDdFad+Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y70gQb/Q7pT0DE6GLR7iR5BtwASfXXkwov96nMmDrGhbONjkBzw2G2a8paYOQUFHIH742e8WmeTC6T3J4PT69Cqn8Mv5K+GAu0p76O1AvoAelv5IL27JgOGK7KRprX4hLTd3gwJwHTQ4djm3D0dhTGYKzm8GYuazv8DBAzhIkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWBNV3WD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bda4bd14e2so5204571b6e.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 10:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245985; x=1707850785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1vP2tD4oba/oi29yYsZV4fMHdfaG3LQ4rAdhQQXQVE=;
        b=qWBNV3WDQsiYp91PymhsLUMtCNsBv+kd5XrS+cthSYkJU8lCTTxCMahkPuUTd5WT1u
         7gkU+Zu3fztYW0ndN8kH/eCWQifQM5EktMQbtch6xAMDQG/sAtA/LFzsWnHUgOsy8M4m
         1Ah0xGX8RDvzatJWsb/TUBmxgNgtJLM9+UacfQTDNkVKfGz7y498Q55AncO4XckIDZ4T
         o5+dUGy/XNHXDIXOSyiCAbF5LQLSorQ9ZDPTYpRLEbGvWEq8bh5520ic1ZryUSyUZ8jk
         knAUO6idNjSLpLWchythE8r3ENhRErMR0XIFw5VI7kboUXSlImkzXa7WnKTDN95m84V9
         aWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245985; x=1707850785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1vP2tD4oba/oi29yYsZV4fMHdfaG3LQ4rAdhQQXQVE=;
        b=v9CCYFXtgfKiBHT7dqRGEScqck3++g1QXpdSsdp19zNOwNDteiQA01veHk2llOOF9L
         7Z0qzTU+qml9t1Wxy0NnPCAW3p67yw0g0VATs5QM6X/BjMM7DC8eUMi9FoxJS7Ffxvyv
         jYjXGemqau3hSVgJj1gXG9vK70FhrToMh0/XLNgt9hdSq1BM6Z/pTolJ5I6uYqnoRGQB
         4ZJ+WnUMOdF3Tv64iBqV97OJ+XOpFziJFNi28xBCtSYxPGGNt1Cq7My4YsWjVhIoJQcO
         hxT0IkMsc4KQ0HNTSWxTcNkthwJwDC167NBsL3kP+bqLkb9J2FrFVESYWgUmXDLXcBIu
         JEjA==
X-Gm-Message-State: AOJu0YwoXylh4A4gopchqmowY4VSLU6i8gaPiA94qNkdKZt0OdFb8jA0
	hCaPn7HwTeDtz5yaK9qwdTSvFIxsv3W2diBVRj3YRD5dPNc/NfyVWODBSZjn9x0qY029kJ+4y2b
	V0VGuDsZu4/sb5vi9DEy4UFjMnJTw+7pN3A6i0Q==
X-Google-Smtp-Source: AGHT+IGNS0Oe8KJpF+kSyUJKGwQnf7SQKD89Hzf8ag94E2qGy0uUAETcBpz/zFnwxMj0ha/tlZ3iPN8n3xLEWVVj8nA=
X-Received: by 2002:a05:6358:cc15:b0:178:7fc9:3991 with SMTP id
 gx21-20020a056358cc1500b001787fc93991mr404491rwb.23.1707245984726; Tue, 06
 Feb 2024 10:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 6 Feb 2024 12:59:33 -0600
Message-ID: <CAPLW+4kPib_3MJeGL3bHT__rLoJOS=GS+gNZUbZ0dpyey9E-Hg@mail.gmail.com>
Subject: Re: [PATCH 0/4] spi: s3c64xx: add support for google,gs101-spi
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> Depends on the simple cleanup patches from:
> https://lore.kernel.org/linux-spi/20240205124513.447875-1-tudor.ambarus@l=
inaro.org/
>
> A slightly different version of the google,gs101-spi support was sent at:
> https://lore.kernel.org/linux-spi/20240125145007.748295-1-tudor.ambarus@l=
inaro.org/
>
> Let's add support for gs101-spi so that I have a testing base for the
> driver rework patches that will follow.
>
> Tudor Ambarus (4):
>   spi: s3c64xx: explicitly include <linux/types.h>
>   spi: dt-bindings: samsung: add google,gs101-spi compatible
>   spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
>   spi: s3c64xx: add support for google,gs101-spi
>

Just a grumpy note: I wish this series (except for the [PATCH 1/4],
which I'd argue doesn't belong here) was submitted before the rest of
SPI cleanups and reworkings. Would've made reviewing much easier,
because this series doesn't apply without SPI cleanup series that has
to be applied prior to that. There are other benefits to that approach
too, as was discussed earlier.

>  .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
>  drivers/spi/spi-s3c64xx.c                     | 89 +++++++++++++++----
>  2 files changed, 75 insertions(+), 15 deletions(-)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

