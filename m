Return-Path: <linux-spi+bounces-12072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B3CD4272
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96CCB3006283
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00527F4F5;
	Sun, 21 Dec 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0x6QkUh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46A1E2834
	for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332374; cv=none; b=BSUNSQqMaw4EFCVxB55oMJfncNzim9SRtYq0LSlMRvXuOBJRqa5WLGNs3ywXpOP6qV8yhaHMyTybuuy45LPNIf44YmUzDT3+lfPqDy3DoR9AhyP3nO26FBOXMCKUUpz/j4/9bLtgDadWgNQpGeGZb6r90UOvJqhi0aQyd9TZNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332374; c=relaxed/simple;
	bh=Ktfr7SJQpTbgMhZZT/6XJflt14sbq+igmEnRrXK6oIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a999o03EokHwWvmcWJzYlhNXxNq1g/7kyWbRDsFrpvIC50ylUXTOwmTwvDZgn7uKHNwNFtlFsXI/hlLJsvRaEZ3gUcZhZabtrazZC6veZ9YvbLmTkodJ0H97fknDOq/TjPWzauiREiZmllK9Bgf5LGpnjzBwfP2kZAuKFCygx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0x6QkUh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47a8195e515so23131595e9.0
        for <linux-spi@vger.kernel.org>; Sun, 21 Dec 2025 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332371; x=1766937171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktfr7SJQpTbgMhZZT/6XJflt14sbq+igmEnRrXK6oIQ=;
        b=b0x6QkUhCzEVOKd0a2Z+If9/8EC+j+8WA80JZXwvTTLRdd4Wsea+/EKPuEQFdz6WNM
         mvK8Yz3giF6O4UCX54kegGiuI638clUhuaJUkmI+B2JMlp2bQh8yr1i4m5QvD0vP7UwR
         MIJKYAPy7jYTPuiDYBVL3dsFPv/Ck5i02B11AzDU0XTwsUy06y8xw2rL6ThScgwjuEE3
         zLJQT7sqA3QHfDc+BQNOyhyWopQAU0edY1ta8c3yVsfXVijVqLEuES5GVk0N0Q158ggu
         6CWVj6w2KDjOkcW7Q4pHI25yy68+iS0sXOP9Y8bDKBh+bBnpgML3Q9pu5Jr807Ftigz2
         juQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332371; x=1766937171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ktfr7SJQpTbgMhZZT/6XJflt14sbq+igmEnRrXK6oIQ=;
        b=NS3ec+AkrWI0BBGJHFv21WbrmGUBtj7O84S360HPxAUPPyvZ/1pqkx8mSp64iXqzK3
         m/TZoitvD9ZJwavsx7tbMDQ+meMvFord94cPQJjYTe6xfz8V5TIIid/8Xhvtcy4fBFUl
         jHHW9ureZesME2dSva7bM5LT1Cv0VD/PodcHD4kgKZsJqMlJMTL/ljWNuKf4ZtIFdETX
         maYbjOr4l3UjVMuNI1smHZwarn7YHUYqw1vhXbSksUKeHIcGVyAjAPzz4iQGoU/CUfmJ
         /NiyCb2lV7lGrul8/tM3kqefxKQ+13OHCbzpHc722F89r13AW78W9L4N+CEb79fP+5Rs
         e09g==
X-Forwarded-Encrypted: i=1; AJvYcCVmkoHUREB+enUqQDgNAyZK7RRanvt8AlZQSLVkuvJCGglf2QTiwiBMAcYnDH051IgUDGKGpp6xsy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsOd2E4LluAq/j9kI1fZakl49EJuehdkW234LmKPryYG5MMIK
	FcmuaRQNKCzm62gWDC+y8BNHCjB+ss5aHK91eWMDH1WbXt1wx8W5bSEM
X-Gm-Gg: AY/fxX5bgwZT2STflEy0djwsOuf1WeJZHD7KUjTNc5MFZO/GNQpNVJbFAn5+Oogd8jI
	PFgXO9/E9o0+4s+0AqMyRuJZb06FX5ElYJpn0d0arKUUTMSigsmW4gWvWW8UVW1FK7mtjK+xs0L
	T8dnNXUKMuGiD/aS22wvNLO0sWtoETBoBom19EpeYM1D/F8aPegLMkLXR3V5tkzvfyWSbqifSu1
	boGq5vH7KSbBuipM8WJxPoIA138fkuLNpAj1vnNkbvIWkE4RF99AXTmDw7kjyqjrjLsTlKoEPt3
	MfC8/EyTHEDGmF5EcDk29t9Y0PnZ4pO0gloF3TCV6mi0OPBSyJlTIgMVJTeCh/1twv1H0cNYnZR
	hNJ9ivJuvlDK3PDWokJ+YeYbZhtNRQA7e4ohiK1Kzoo/Due0yY5dLSSpaornTKCbq/WNb5Ed6GL
	MMiAwXjwLRaZMnb4qx8Jjkl7A3Im3jidkDAo1VaoBAIdEOmp82hap7E/lGmzCzgnIB7FYX
X-Google-Smtp-Source: AGHT+IEbJh6QEEBqVoiA8uGAKHnpKaENlX2JGObti1D5zf3tJMVvd1glLOCkUq93fMJj0p1hdC0a4g==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr85515255e9.11.1766332371058;
        Sun, 21 Dec 2025 07:52:51 -0800 (PST)
Received: from jernej-laptop.localnet (82-192-45-213.dynamic.telemach.net. [82.192.45.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a0fb9asm81695155e9.2.2025.12.21.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:52:50 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 4/4] arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR
 flash
Date: Sun, 21 Dec 2025 16:52:49 +0100
Message-ID: <13909614.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20251221110513.1850535-5-wens@kernel.org>
References:
 <20251221110513.1850535-1-wens@kernel.org>
 <20251221110513.1850535-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 21. december 2025 ob 12:05:11 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The Orangepi 4A has a SPI-NOR flash connected to spi0 on the PC pins.
> The HOLD and WP pins are not connected, and are instead pulled up by the
> supply rail.
>=20
> Enable spi0 and add a device node for the SPI-NOR flash.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



