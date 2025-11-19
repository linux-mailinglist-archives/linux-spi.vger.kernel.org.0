Return-Path: <linux-spi+bounces-11355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C2C70440
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 74B5A29FC0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E4301474;
	Wed, 19 Nov 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYC60abh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEA36C5A0
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571136; cv=none; b=hhtU1W9z536apRvfiNQdpT96Bd0rD+lCiZs+qaYi01xiD4koatzOxO8S0MNz+9YHi+8/tukwBYZCPbJS30TLhRzVxdzr43KjRnGoHh6XVSb7JPpHVTQPShnXiJPmOsRMAhuUvw7S8hySoEj9zztmksTeIa1pTmW9nhx0mn3yt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571136; c=relaxed/simple;
	bh=vcjFWfWOR2yjv9sI5u/+MJAF+m7NirhgjHp5gOavo68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRRzFxH4hDmOgN1Mq3GliKeN9uP+Yjsml84939xawY5FDrfiolBuB+F0GHevcFBpN7XWU1kGCJrhaED6IbvaR/3y3Nat9Y2d6/WArFxMxs6h0mQK1q9I15FGeLG7jTSgBAhFquSLYUT//wd9A/Pw9bmfe8nuQ47sMwGCb4YLYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYC60abh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b737502f77bso683242466b.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763571133; x=1764175933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcjFWfWOR2yjv9sI5u/+MJAF+m7NirhgjHp5gOavo68=;
        b=DYC60abhm1f5UWLW4iaVs2unNLoBN4dhoRGoTW7GmcDwLAoaIP9dFBhODvzKcl4mhY
         FQKzgk9xvUtNPUij6Lxdf+q7RrZIojuHnF0Pp85TxG4Txe5XOFe7syHQuryH87CVzxHT
         E2BDFEgcZKIpzD2uiKzWYd6UXjtjIuDl3GxKdT/GC68i79/0oRL5ax9doOmYefQG8j7L
         2nDVr6RacsvlAkT1tycgChWLkqW/TfK7yYeuFJaDaN7Wf9lmkr6DvcjKX86YwgHsxWZH
         b52wIJ8s5rrmQI9Zy16CIsuEILytgE0vW2bD0apMxba+Isch9lQfuXajkIfMsu9ii8KH
         A6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571133; x=1764175933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcjFWfWOR2yjv9sI5u/+MJAF+m7NirhgjHp5gOavo68=;
        b=j8eiG4nJScLs843lc8r0ZdTGEOBC1zaSjlWUTJS9GLKHHHX1sExK1/s1f1FfPzWj56
         1NdYBUXsF62pf9BkKzmxeD4nplFuOErXryd5rqsI9vUbtm3re/zYSoxoBy6TZUSL3HTV
         o0jTD5y4AzrE5zcxA+XNZQTdehYbzf66lAeHGytGvUkbThTnXuSeqaGDGuUs1Zg3ZokU
         F0jjzbawuT6EjWKooOwmwYVCIX0t0IH8WsqEncaIfEyoeWZS9FgTekKf4/ruFB/AUOEJ
         zTp+G73cL6u147aUKMRHXccp4sNUUNLssV6SF78c4mVh0bujjjICbhal8ib/ukz3hDPJ
         xTAg==
X-Forwarded-Encrypted: i=1; AJvYcCVW8joIZsknISVWqGJVfeD//2XWgNlRKZAxw/V1NbpCidYp7TuWFTQA+y/FH6xX4YCRrc1BSGPNFZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCz3Eyt/WDeAV8MZzk4bVYNf6khu6EyI8NcTcmdNBCBcKe6KdU
	8tc/GN/j//LnYihrmJCqT1DEU3/JxxakD5giBw0P4cvKPox4sbGHKeF3XYsnwpHi70yb+bJjbwq
	dTbiGmMA0+kD1kqwUvgOsu74VD/WPASw=
X-Gm-Gg: ASbGncsNvma4caDMiDhmHSW29jCg+GeAPO/fepb8Nx1qV/O34gZhWoBOq8NeocPSpuM
	FD0EnkiWwW/dZov5PoJXqf5pHy0l5sZkJMFQ4itJ6ZSa8QIG2bXmvb4IV4+IsXhitkNZqvs48yG
	fSGv68DVFGFeoqNUnoQma58waq3j1j3p5czxMDwpfHyIOeXp5ZACayDiudJI0g/8NhMIQ/RoX7j
	77uT1R1mbzujfyKIkTB3P3xqhAWJjwjvYT3F4y5EZIkECApIe3OfCRfy9X3PKWCsEtcIKY+2kq0
	Dpf4GIayj8FDyV17yNdsdLc+6+mrXTjgaPz7fpu8SMgmdGkYA0EpbDLMlDNVKGfdErC7qww=
X-Google-Smtp-Source: AGHT+IG79/yoAniLg5m6pTLusTRypXvDIibAvx3mJng3rzludQe6A04i/KKfcn3WLMTF9und/v0GYqvS4b0sDflHd0g=
X-Received: by 2002:a17:906:7309:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b73677ed721mr2190487066b.3.1763571132962; Wed, 19 Nov 2025
 08:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com> <aR30JbIbx3MIySjM@opensource.cirrus.com>
In-Reply-To: <aR30JbIbx3MIySjM@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Nov 2025 18:51:35 +0200
X-Gm-Features: AWmQ_bnRsmqZgCIFOlKbUCCwqqweHfcYam2Yo1Gl2z3a9M5AASJDSi9azoDaq0U
Message-ID: <CAHp75VeQgq8AFSPAOvtq+U32KAWO+NOZ_=LXWA_r5vRzkD2TTQ@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip selects
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:45=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 19, 2025 at 04:40:17PM +0000, Charles Keepax wrote:

...

> Apologies this probably should have a fixes tag, or two and I
> probably should have marked it RFC. Lets have some discussion and
> if people like the approach I will send a v2 with the tags
> included.

At least I don't see anything quite wrong with it. But I probably need
to have a fresh look when you send a v2.

--=20
With Best Regards,
Andy Shevchenko

