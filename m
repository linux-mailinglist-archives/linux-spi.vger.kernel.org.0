Return-Path: <linux-spi+bounces-12071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF97CD4269
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44AA53000B72
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7462F549F;
	Sun, 21 Dec 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atQXr+68"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57B26A1AF
	for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332315; cv=none; b=b2+1BEGFlvr2EwJa0rTNHAmrFUgInPWg1gaHS/MoxdLgF7SxXFjMIwd792eIIYBWYIFcRD9XlONGwnnv0aKd0QYH+KD4rXWBOoT4E/L8pHHfpCb8rBnkAxWNgYrpF50jRztp1ED3iVrJwN6nD6fG2SPgdHk+AgztufbVHZv0j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332315; c=relaxed/simple;
	bh=+wGpSjoV+I/C1HHA1GCDrk5eEUiIYLCQUe47VJqqo2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqGsk8NGZe4L/38hTmXnCU2tX7g5+RKU5EhglaZRy3jayFnUIEvpOmAZ+J5LwCkWp912jZPPeJ8xv0IBmBKk4eRBKAtGg513lQA5sAYVrVvHU2CBZ/kRACR3WZ73nlK8UzGNGPbA0aJ0oT7y4xG9D0BbBP34/F1vct8HFiIeEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atQXr+68; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso20954895e9.3
        for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332312; x=1766937112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wGpSjoV+I/C1HHA1GCDrk5eEUiIYLCQUe47VJqqo2Y=;
        b=atQXr+68sVHzQ2AUtpf563/mNgiRTEciHDwR3Yvo7S4VDP+aI2/r1JFY7Hwlk28r9m
         7hNBtJJV/DWw1Y6X6brJHVQLFaxGqW0rgL1ch4jFiyD/cfz5xdb9q0XhDDsvv0QSBqr5
         gAzYuZ/QhKg4wrbFyb2MjkTeWUvFidrN2AZIplqY5HDtprCncMT9SXXcUiL4E5qzporZ
         BXiNl05jRjMkNgDENLmhfwMX5ViTZM9T20dqFXudjF8Zupea57UI5yEZU45pNGEBaNLU
         Z8SYa/LNcgmFo+fdiWkg0xaW+4IorQVfr5hNBqTACxi8F09EKjD8RXALOVxC5HF9jqd0
         ynFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332312; x=1766937112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wGpSjoV+I/C1HHA1GCDrk5eEUiIYLCQUe47VJqqo2Y=;
        b=Y/ptUBHn375ZZTPmRO6M8BrOYA+d5edG16SA+AXd5uSI49Xk5dSRXkY4pqMlkJRICm
         ecfjRxVxl/Kmdf1z/SfhY11Rea7jU9twJlr8aXGf6BQkGCONLZz8d3qlCoT/dPujddFa
         Uzpkt34PAd6gqkOBZukytt0sI8/3BD/QUvlWYvwDJLW2K5h5v5/FEVsSa/hUnBoSNmL0
         nGgkdE4v/Xgf0C9GoNpbHShtOS0L2WYxN1wDs7pDzPw78iY30FUVBPLqYMkGJ/llsK+O
         Z1C0vcj7knfTLfRyawzxDE21dUHfOe1oX9gqgKESmwRVO8C/xJYglrV2/6SlQ0YRt1ws
         6UKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAYpdJ8lyuSJrTBcRwNXIE70Pl8t8A5liZB/dfxFbgQGinNT3Xhd30ZtYw89w4txTHVt46bV/777w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd4tHs0bcAb6zIWqm6t+97zomPagYsQDrn+wWb0UPBMqOZ5VG
	xg/TzVc8TNrfRRI8OAiPGv7QiwBax+pc9iJEMImTqTiT2FWjZktvF8HL
X-Gm-Gg: AY/fxX4j0vuygoT4OG8+BnkcftOX+RrvuPTzLZyUevKYaSj6rc0owu6HRsHqC8l/MTA
	kCvUQbsXJCd4zysrHwuxgBQawifdHF4g7obB0LvGqWLGj1YtqyTdThVrLJSEk0lMUuHgAMz36/W
	7IOZ+WP8YeGlB/vQkyUHWPa79oVrQK8OfK53f8CiMA6Tmyot46BmuibX1t3m5vLr5J2hIqvg0Jk
	PRgXaY5j1GAxBPmLgRFJQyNgNZiKjfAmOFwQ+TXUN6/a6mHjrHK4JwM2szr5obAaQsmmi7pUwVS
	maocoMUfhAngBrPgkTl35Zp6ZexZOpwMyqehGlVhTG465XH2hkcM6vF80n+0YJPHNh6V20wkBs1
	CkbivezvWwKyPcsGqaiajOiPNzQvEGzVoGVNkb77YyfLhiLxTzaX3M2xy+AiqkWclR/E1pQUcb9
	8oiEF0W3wUdjMTuMURoh4oCVEcqXOrpXFtdReKMEJejPZZRrXPhw5XEeJ1TiFmj3cUPLCH
X-Google-Smtp-Source: AGHT+IFL0JinH915To7UZbWNxmW3rxApkR6Mgi6PhRVUaC2JRu/YiTvBxUG9ri+ZhDZkaKBLH64B+w==
X-Received: by 2002:a05:600c:3148:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d1958e459mr83426535e9.36.1766332312266;
        Sun, 21 Dec 2025 07:51:52 -0800 (PST)
Received: from jernej-laptop.localnet (82-192-45-213.dynamic.telemach.net. [82.192.45.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm17292809f8f.1.2025.12.21.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:51:51 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: allwinner: sun55i: Add SPI controllers
Date: Sun, 21 Dec 2025 16:51:50 +0100
Message-ID: <1940379.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20251221110513.1850535-4-wens@kernel.org>
References:
 <20251221110513.1850535-1-wens@kernel.org>
 <20251221110513.1850535-4-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 21. december 2025 ob 12:05:10 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The A523 family SoCs have four SPI controllers. One of them also
> supports DBI mode.
>=20
> Add device nodes for all of them. Also add pinmux nodes for spi0 on the
> PC pins, which is commonly used for SPI-NOR boot flash.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



