Return-Path: <linux-spi+bounces-9388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30BEB25257
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4419F585761
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777521EDA2A;
	Wed, 13 Aug 2025 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="aq7MQAhy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0C1C84DC
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107254; cv=none; b=ruFArIqhE8UtLtCCRMmYTjCO2tQVfQg6kzlfLiF+QrDCX29f75e3cSlT0vfsLl2Mkfvb3ckhVLw/QHnoQftwo4EuijEODsgUgX1UeVmGL32VHCSzxBCoSyTSdDsppuQodFqf2QY7bQv8qHGRontsXtww1j/nvtN+bRVzdsqoGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107254; c=relaxed/simple;
	bh=uW7fKb8DACG3fG/pvNEYkjNw8PF/bwmqPTIzgomZ1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElHlvGuZCP0aXEynIQj8H52i6IQLzftqZ187tvtvxFZ4qtbKI+h/3fOCQcTkNDrVP4FLGm91QdUsvhaF9xD/g6REYo9sPaczImAc86JyZgelWFbDCS+O0Hf4DpySlUQGMstfuEY+Mt8la2A1nwc0Ddj2hrGWrGyNdxvGto/Vy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=aq7MQAhy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e8704b7a3dso7878085a.1
        for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1755107251; x=1755712051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBsfJFWg1o3SQZ+JkXCo0QRsi2YIFRfM5g31219RL4A=;
        b=aq7MQAhyDL4BdBpOk11DfL73d70i++ZqQTI5l7kOrPCgVCdleRIqPLqXPO4lR0lrch
         dBzBFQ6/BTCjTRvPFFTPvCLKfg2hLtaHNnZR9tCtw8mfaTRydkfwJ3Eu1i4NBi0i7NSL
         unT9TbNDWqEQMwQL2vI8DOnB6dzpgqwJLGCLz/BiL3SlmStBBdQNA3s7B595yGhZEuon
         2/FXSsWqQre2RGS1xfzpElc0N4L5ion9vubzzAEd9bHhylBKDFO7/7+J8+SoX0IA/wN+
         cHqw7o9nbcQ1bHrWGpr8gHhLcNkC3fUDAxsiIjLtqIIGlIyJWGpfSfGzCFpIIlmjBEyr
         T3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107251; x=1755712051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBsfJFWg1o3SQZ+JkXCo0QRsi2YIFRfM5g31219RL4A=;
        b=X1ku1lYhU6TPc60PiKSSSzRVgKqc1sCNNESYfRQrGhE4AniSPsGkLBczGKz4vW47gU
         umFwirF7/cqdWYQ9VY/aoYnUvYJWp2Y4sWv7XrhEPlvZ3CFEMYbcEAIddHEMZYM/EmiH
         bm5wqHMYBFOP4XKVh/2VN3WH9weQi14851H5nza+09SFbzt+Bqf574h8yGo28mDxKDkA
         QqBb3rsI+zJB+fFGd/le2BhDNdYPOqHuRI1Z3gofGI/S3d77/oGVX0DOS9EbvrssPHcL
         zHV9df3AuRwXi6pmDlRctzUhLaawzAjUcQNcjxd7H9J8jA1VvOJNgLNp4NLrlJ25mpbz
         R5iA==
X-Forwarded-Encrypted: i=1; AJvYcCX/I74GQgt/9oafLwm83Oz3phyi/b7cUYP6p+ulkXh8N3z0e/J77BGbp4VWB4zQsFard0pbQXAT8JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lRcoDMwWIuG+j88L50tbrF7fjaO9KRlsNkrxyH07cEjB/ha3
	3rn97XnlAJWJ/Hdba8htfNxA3SHzO2ACzxn+P75YiX9bqfd2MNYhCQVvkIQF694cjps=
X-Gm-Gg: ASbGnctiy2HmNvKLO2ikV697Euqhv7vi16h/YklIXgAchQc1e9bGuadzd+q8xhdGaQR
	1JZEKfyT+fKNIjhfS9VBPf8+ax6qQ1LYZ6YQYjPH8bLwz0c/Ljv9CMZQOdnQq2Vq3NBqzemZ1GC
	5Hq5fCvDc6e1ylNV2FEJd9hncL+iabWjWDSMPhoSBIJlhrwo+rnV4iC8bbT0Wp15qzbxoXZK5Od
	ThprdKbEjZTNEj/iVdasZWEQ2hFpR8XCTYIH7fvOHrK3Cv6kVSEpI0Pu9v5sWWCBFrMX1VQTP5r
	E6tXect2w+HAPWW16AKFUr7R2OFHhUw89pyEcYyQTBadGuHdxBOFqbLL/cYmxOvmbDJiVj3FO0L
	a6pwOh3315NP53zCqwV6LNAOX0ty38AEjMnq0qOsUPA==
X-Google-Smtp-Source: AGHT+IEB/95DXkKwomIf9ip6/yfm146L3qIifjKU7bl9DaOBgZQZz5rMpVm/bhHv87pLjMhka3uuqw==
X-Received: by 2002:a05:620a:a102:b0:7e8:434f:ffa7 with SMTP id af79cd13be357-7e8704761a0mr24882585a.52.1755107251577;
        Wed, 13 Aug 2025 10:47:31 -0700 (PDT)
Received: from fedora (d-zg2-251.globalnet.hr. [213.149.37.251])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7e7fa87e7d0sm1627122385a.82.2025.08.13.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:47:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v9 0/9] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed, 13 Aug 2025 19:44:36 +0200
Message-ID: <20250813174720.540015-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic support for Microchip LAN969x SoC.

It introduces the SoC ARCH symbol itself under the ARCH_MICROCHIP symbol
which allows to avoid the need to change dependencies of the drivers that
are shared for Microchip SoC-s in the future.

DTS and further driver will be added in follow-up series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v9:
* Make ARCH_MICROCHIP hidden symbol that is selected by SparX-5 and LAN969x
directly, this avoids breaking existing configs with ARCH_SPARX5

Changes in v8:
* Move to using ARCH_MICROCHIP as suggested by Arnd
* Dropped any review tags due to changes

Robert Marko (9):
  arm64: Add config for Microchip SoC platforms
  ARM: at91: select ARCH_MICROCHIP
  arm64: lan969x: Add support for Microchip LAN969x SoC
  mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
  tty: serial: atmel: make it selectable for ARCH_MICROCHIP
  spi: atmel: make it selectable for ARCH_MICROCHIP
  i2c: at91: make it selectable for ARCH_MICROCHIP
  char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
  crypto: atmel-aes: make it selectable for ARCH_MICROCHIP

 arch/arm/mach-at91/Kconfig     |  4 +++
 arch/arm64/Kconfig.platforms   | 51 ++++++++++++++++++++++++----------
 drivers/char/hw_random/Kconfig |  2 +-
 drivers/crypto/Kconfig         |  2 +-
 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/mfd/Kconfig            |  2 +-
 drivers/spi/Kconfig            |  2 +-
 drivers/tty/serial/Kconfig     |  2 +-
 8 files changed, 47 insertions(+), 20 deletions(-)

-- 
2.50.1


