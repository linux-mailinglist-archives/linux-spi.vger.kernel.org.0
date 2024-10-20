Return-Path: <linux-spi+bounces-5260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D29A55B7
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46764282DC4
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7BB194C62;
	Sun, 20 Oct 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4c8Atlv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C001DFD1;
	Sun, 20 Oct 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448516; cv=none; b=p49fjYefCPVOzuwg4qgCPCUhNiea1a4eY/hpEY4GDxlaZhEIqUnMCBYReI9ll+ZM3u28XxdSXh6TpeCQmNKA7x856zX0Ir5pa9vPS4bdGuKuIcR6C0BGOFFY+zdnlnIxegco4nEHV3h/ydjdBQaFq8iuorfn8X720+4KBKzlJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448516; c=relaxed/simple;
	bh=EmdlZ3kPaWca1OOjqy6aHzFOrYcyL6I9/3TmurTBc3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLlPWObMOwtKzNoQcmaotVG2b9pyt4jkXKe/tFdRZwfU2OWRmW/WX5TvZ4Yj4+S48G9OUmXO3e6wLTLlYYQq1XAtWvsh9+gjTcmbmmtu+vj+YiuxGcsGFP3zwwQIIY829yyxePYMcoVd232uV5Eu3dQkdKYokOQ7CFl2BVR1gEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4c8Atlv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2819401f8f.0;
        Sun, 20 Oct 2024 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448513; x=1730053313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTXpT/JpVyVtxkjP7W23UuOA13XhL8tSDH6gnK5e0bw=;
        b=T4c8AtlvjNv34qr2I6+krGGaIKaKQ7AvBnBc/D9RecjA+no39ChALKullES8F+el3N
         EKVSfWpJhNzAIxizFUxmlr7qDPZwYu3Rb9961eXeYS8ya5245/kGUORT4pl59mVXLCKF
         y0aXwIvK4WGb3LwEBrAUost1ffFETAfWcQ2pKXyfwKRxyLq6L14JNZb4k8MXQ/14djWc
         xEV2isUOW8oQ/odEix/DgAHuz6ub93NeA6jV2ms/5YI04N91oiIxArPSTJneVYKmBOr0
         Aa3TEH/RnT+H5SNGuy+WpOr7qUQuWnR7wh+CD/EcUnKJIqUzgfmgm7MVnmWUfjJb2W8q
         Hv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448513; x=1730053313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTXpT/JpVyVtxkjP7W23UuOA13XhL8tSDH6gnK5e0bw=;
        b=IHu/N+UTirjrGAE6pcUpp0UyfvlBJXJYryiqsi8o8nK2g6AT4ANQa7geJuA8eWBRAw
         OzbixdwhJICuQwPui+ZFRLrcb6D+kMr8V1i0MEWl3eN/XNQgFwCTckOzWVckTWQ2DVcy
         TEaOEOrzOvkKTQgPlhLQWhmw5wIn91LNOXnmIlpgeUxcZfOpNJ00BRa5aXiFPpX1PHCt
         h6N2Xt46Q9v2dhHbgszsaCDsOsbvXbqzgR9tqyQxBl1lziofNb0Xp5bfVNsBPwPL3Evy
         eOWGU78nDmKgXQ+Gn6nyM7Fu3KuA5x12J8kRLGWk9CLc1z2piKA8PVBsUv0Ubc436WbE
         B4jA==
X-Forwarded-Encrypted: i=1; AJvYcCVGtQcnzcQQqp07wKe6LLpjl+2lbVk/zcSn0T41+N53pzSJSNelDgEy4W6nMUkg0jurDmaAVN4/i7pEJplkABe7Cdc=@vger.kernel.org, AJvYcCVTtKkvbyPGfBZr02leKgBc5wdOOK9/qAB+Ncko7EoIMBqtvgIaNgkaJuSDlVd/pt8oagVrhP06NG53@vger.kernel.org, AJvYcCWyWgqb+lTGKWbTDO9bbGc/7qf6gPKXi/GiyvjA+B56ScTA+kiVRhwDmZr+W3+WD6fVntDnPfvpywrORl2D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzq/fqqEvu2aeL3k/fBGjAZzxB+AAYAlNcLq3hQku1brNBOLRx
	glZcunViPAF+UX4lcSg5J2KAZ8/RLGc6XdR/J4pp7Rv7sKzP3Jmc
X-Google-Smtp-Source: AGHT+IFvhKtzmjva7FweTTF84HiAmiTGKtr2GqvtdA2vESUECZz9KPP0e9XQ7gvKk0XuvlqBEzZH5g==
X-Received: by 2002:adf:ab06:0:b0:37c:d1b6:a261 with SMTP id ffacd0b85a97d-37eab73d61dmr5966041f8f.59.1729448512503;
        Sun, 20 Oct 2024 11:21:52 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:52 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] arm64: dts: exynos8895: Add cmu, mct, serial_0/1 and spi_0/1
Date: Sun, 20 Oct 2024 21:21:15 +0300
Message-ID: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds device tree nodes for multiple clock management unit
blocks, MCT, SPI and UART for Exynos8895.

Exynos8895 uses USIv1 for most of its serial buses, except a few that
have been implemented in this series. Support for USIv1 and HSI2C will
be added in the future.

This patchset is dependent on [1] and [2], which add driver support for
CMU and UART.

[1] https://lore.kernel.org/all/20241020174825.375096-1-ivo.ivanov.ivanov1@gmail.com/
[2] https://lore.kernel.org/all/20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com/

Ivaylo Ivanov (6):
  dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct
    compatible
  spi: dt-bindings: samsung: Add a compatible for samsung,exynos8895-spi
  arm64: dts: exynos: Add clock management unit nodes
  arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
  arm64: dts: exynos8895: Add serial_0/1 nodes
  arm64: dts: exynos8895: Add spi_0/1 nodes

 .../devicetree/bindings/spi/samsung,spi.yaml  |   4 +
 .../timer/samsung,exynos4210-mct.yaml         |   2 +
 arch/arm64/boot/dts/exynos/exynos8895.dtsi    | 163 ++++++++++++++++++
 3 files changed, 169 insertions(+)

-- 
2.43.0


