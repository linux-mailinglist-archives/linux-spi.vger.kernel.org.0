Return-Path: <linux-spi+bounces-12070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C5CD425D
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED50300B9AA
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BB27F01B;
	Sun, 21 Dec 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+ewCzzF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58F238C1A
	for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332260; cv=none; b=AojiDXtxaxqV9v+UnJroA//9D3jyRb2SOFeqkxH9NBrIraLoFBV0fk9G/K6f1atiyXlERDBS4laZnblUmoDT447lXK1OQnsBpXLMztRE0ENCsYErrXD8rGWfv3+gGhLJi7QIqHkhE7v2zuF4nCnj77wBetgW0TJepRdsKCznNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332260; c=relaxed/simple;
	bh=8fCSODvcBdp2PEhtURkA7UUjirAp4XG9bUc5v/PYx98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfvY9suJD9dApTA5IrztwHmLkg0KvrDfn1eesJRY23HCnr47ceGpoWQ4Q/tq6OgfsRTzmu5UVeqUVbNWVvN5pPeMkteb3/fwRpiWY0/5l/1jCO7QkJtUpbtmuDOFOrkUHWA341hUjXmHkjHXOGN8jDafYxbyOtsSEIvM+Vo2o/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+ewCzzF; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso10498115e9.1
        for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332256; x=1766937056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fCSODvcBdp2PEhtURkA7UUjirAp4XG9bUc5v/PYx98=;
        b=M+ewCzzFakXFdFbZwGaYQwRI2jMYBHcWP0yM8Vb02wJHHcQBzWQOnMc5/SD4WfLk6m
         mooHyRo4xW4bsQzapa1yNp0eKQCds5GfRgUqwFVN9ecmGmVaBRNFUJp3cxrp83K3thCX
         0QOwkzcgGM7AVAUl5ePxxOuLAUNNm+DgaEv13JYGrwqpn59BLJFRX2coJFapWTdoTQLP
         Rps+Em0aN+W4c6v3/Dc10vwRBWxs7yuUXjvtbjU4eNjYehXeqLXSwdjxl7EfOnIGEJCP
         0HkQdhOtxyMAdYht+k/C5S14GjSCLoXDz6ZWT+GhdQXBrgTU9GmYenW0M5cZZj+/AUhj
         nXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332256; x=1766937056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fCSODvcBdp2PEhtURkA7UUjirAp4XG9bUc5v/PYx98=;
        b=czT/QBhqsEBpGMeWZ3M9gY6XfoTlBmO923i8aT6eQmw0RNfGw9vakvDAIL9cJNPsYE
         /rf9Z5xz1yh/00bRuaggvqbwdGX2ibW7Wq/kTif/fgs6xkefO8sjZml1dokSlKGfUZhG
         /EnEs9VyxlzVdTrZhOhhCog8Sy5KKVNgJBTgTndzLTLH3QcVYHwv1p3lIosL4YoNSa7a
         EHh7m7XO4AiCgmwuNDwuV21fYyqYLTLgd73EIyxFdWN3IBPsfebmvdTQQWhZ8oViV9kf
         1te8P5T4FtmetbLC5PF+SInxZOK/YFIn0e/xRW6Kde6csL5SmFYPXb9yJlDAMa7wEJeb
         +w3w==
X-Forwarded-Encrypted: i=1; AJvYcCVOdKPnkLEL5OT/uYvyvLQlx8f24hWV2lBE4EfXVnbOiLsIOtyZtOfgWjN4lwwJJCBxobtMopKO4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR90e6j24p4OiNnMp62QH1LuByq2Px3LXtBb57InLjGLU8VN+j
	AEnLOgBUAKq4eugCF7oe5SdSrKB3fmWeTdjGUxObdSFmQ3iQK4q+ouxa
X-Gm-Gg: AY/fxX4PNpVn6gMmPJQnoHkEfhBTrm9kz9WJQup3CvYI0KiWvJQw9Kx1957wRqttBO/
	FvuC6LvFwpjS82vXJfBzb6jq28CzZ8jk7va1Q8a2/f3YZThDS8M89MHo3j1VaFSN3Oyat0lq5bZ
	FxBJ19Htoo8BjptqXqWWbP8Pt/4wvoqVrssjc8MQhq/u6AvB7aam5yEoBAtNia5vrfbCEAf4rgM
	MWuJhEI+G5xQ0HCKxmHcPkWs/gSwHOiX0dQHALGOvGqEkYZPxv31XOaa0EXdzwS9CEoUwe9kXll
	z5Afolq9g/onhp9f6SWNIWnsUHYaSeojjQbpEE6Ue/UkSW82nXmQBhxKA1fgo673pPnJYVVUCLp
	Ws7lB22jegvl+Q7bkoEGmGY+mNjfw3aINzdfZnzUPI72kJRPf3xyJ1nQCiFp44a1lY7WyqeI5oH
	MjNEmQ5sz2l5nbgvQzly6Y9RRH1qi4ugF0MBQJNpjSbKlVJCyVAbnjMf2Y4K2lT452pL9z90afG
	66eLw==
X-Google-Smtp-Source: AGHT+IEbzuiMyIUOvROlypd6C5VqTcqsXBg5CYHBj3GvTOlnnKn2/wIG/gIMrEnzDQVWqbyemA9QRg==
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d195a425bmr82073325e9.34.1766332256115;
        Sun, 21 Dec 2025 07:50:56 -0800 (PST)
Received: from jernej-laptop.localnet (82-192-45-213.dynamic.telemach.net. [82.192.45.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a40c5dsm79185175e9.6.2025.12.21.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:50:55 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: sun6i: Support A523's SPI controllers
Date: Sun, 21 Dec 2025 16:50:54 +0100
Message-ID: <2391651.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20251221110513.1850535-3-wens@kernel.org>
References:
 <20251221110513.1850535-1-wens@kernel.org>
 <20251221110513.1850535-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 21. december 2025 ob 12:05:09 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The A523 has four SPI controllers. One of them supports MIPI DBI mode
> in addition to standard SPI.
>=20
> Compared to older generations, this newer controller now has a combined
> counter for the RX FIFO ad buffer levels. In older generations, the
> RX buffer level was a separate bitfield in the FIFO status register.
>=20
> In practice this difference is negligible. The buffer is mostly
> invisible to the implementation. If programmed I/O transfers are limited
> to the FIFO size, then the contents of the buffer seem to always be
> flushed over to the FIFO. For DMA, the DRQ trigger levels are only tied
> to the FIFO levels. In all other aspects, the controller is the same as
> the one in the R329.
>=20
> Support the standard SPI mode controllers using the settings for R329.
> DBI is left out as there currently is no infrastructure for enabling a
> DBI host controller, as was the case for the R329.
>=20
> Also fold the entry for the R329 to make the style consistent.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



