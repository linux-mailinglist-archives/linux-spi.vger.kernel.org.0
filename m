Return-Path: <linux-spi+bounces-9533-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA88B2C370
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65C17A547F
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F530504A;
	Tue, 19 Aug 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM8ixJ6R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63B305044
	for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606177; cv=none; b=fGyQ3JCzG5XEqyLnDuzPaSO/R4gPrxKwDlKMB265avN5xIWRHyM5LA2vFinZ/G4qOdDRi/s8rKHXTqJbs+AAqiTG8q/dSBCHcPCxN14uIgVBjah+krYtJNI45NmHO3rflFR1iNChC120bV6NFiEI62csTixmyMFcVO9accB+FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606177; c=relaxed/simple;
	bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4ArWZJZeyMUpVfqOPNwfLUlR4ey8xFezKr//b9+RBxnS5FyevWfKVPi8t6JZaSbwnkvxrVXbHcuICxjNsq+42Ze+36nqv0EUtHP++LOYR8JzY6/gRVaczEWzVQzRzGc3XQIxjzFTGTmJ2JARVnyzOkEwUqhq7/YaKmfQLu5xQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fM8ixJ6R; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f8d387d6so35202581fa.0
        for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606174; x=1756210974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
        b=fM8ixJ6RQo60D4JPEtBo6KumlRlXnEzNb0KqaHra06JgB1I1tUBAKnIs3Yov9i6BV4
         Unh3rADN79v6mZXZq1OvojG8vsM2kYAVTIDsLwbZrwFatF1VtNJvlSToG1uSxrYElgJX
         Jr0soMUn73gRjzRYbxgIPIkBrDTiqkJixCYFXNOSGFGVEtUq3F/CC4tvBaVV+kwJWsQk
         VdJ+rqhn6tGoYASYmHucGq64+R7STHwLpwxcU4pzoRbCsWINp9gXB63IzQDuENLwFfA2
         A8fF1p5IhA3+JOrBgwQGIqQUIluoKOtAmY2EcCsuX9psAbCyC0wICYp6wlkN9AWyn27Q
         7+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606174; x=1756210974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw/jOwKQuYtz365HYvInA17YdqiK5qLhDO82IeRsFBE=;
        b=TNk9FCCAvqgT6/m0UZuEz3M8WdnxY0Y1YB4RdaRcuWrvE4yRxOR+RSubQJujBw4osE
         e85DoMnhxgzz5p256kWaVKaDRx2KTEG7/aqHKB467NkIo+Ksc2uwy7aj/55qM3X+xpyR
         CIL/UUx6xjHgzyh5tPVlF8XhEo0WAR+5WkekkD7eDGWDd71PzgT8IOYHwp5JeazJPyTY
         NdnRNvCcedtIbuappF6bkMd686ErBPuFJY3wem9iikUVOmxjn9/ODLc8wwTezRkJqmZa
         +R3WH+vcVv7fE6oJEgZ1AsvT7Jh6qjHaEhG6uRGxtHfDatThFK0L/3QGs93Q3ZPHpEez
         fkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXaUsryF5QiqZCHPjF3jZt/B002DRLe4YFEl+xuKm0Ka1VzLiY9h7K1VC3oJrFGqTEvG4e1tQ3ecrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMyS4ZKPh1Owx9BjcI/Yfph/8YurFngoTc98OmUoXGhHl8+Bl
	vin2YXY7Dvq44muVfVWKH25R7snC/oaVfzbzCOKjp1WWv0mmYrk62bCC7fVn+nNGJ6RuzF7xSZ7
	r3bROSInZpdgVfkalfsqjT50TiT9pEZeiFLe3dR4BZw==
X-Gm-Gg: ASbGncuvQZueGICZl3mw9tCCkVpYKJ6wqGWZNrBvBI6bbrk8adLUDflYuuIUZ1mk9mA
	Y5+RE+9b8IubQqPf1bHxexsWGAtKaxRmkbrKbj8xl5+AvQM1O9mUasQbcDwK3rgMUgSZqoNF8TD
	fOseYdujMzrRJAZM+6kaZWBlXDf4EIY8meXiP8Biangx0LMNMBJW4fxa/LLba1G8YVx+OPmJoyH
	DLXEDPj/Y3o
X-Google-Smtp-Source: AGHT+IGNH/KGoaBSyDp4h02tKapeKQZmf3kymXUsGq0Isjr/TRxPuFwtsDzGDorqqxv6Gg/sQbzuFVjxKVKE2P9+7Vw=
X-Received: by 2002:a2e:a98f:0:b0:32b:59d1:7ef3 with SMTP id
 38308e7fff4ca-33530737cadmr7048501fa.35.1755606173912; Tue, 19 Aug 2025
 05:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815082118.586422-1-rongqianfeng@vivo.com> <20250815082118.586422-4-rongqianfeng@vivo.com>
In-Reply-To: <20250815082118.586422-4-rongqianfeng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:22:42 +0200
X-Gm-Features: Ac12FXwCXMFv3UHJtH3jQfAak79Kdy3rWEOtMWOBnQNnjLpEps8EvhN2w2SpjZ4
Message-ID: <CACRpkdbzQmhtpbYxnTtKBrxJk8d3-8U7rzkrncW-05-vKZTUaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spl022: use min_t() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Mark Brown <broonie@kernel.org>, 
	"moderated list:ARM PRIMECELL SSP PL022 SPI DRIVER" <linux-arm-kernel@lists.infradead.org>, 
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:21=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:

> Use min_t() to reduce the code in setup_dma_scatter() and improve its
> readability.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Clever!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

