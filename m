Return-Path: <linux-spi+bounces-8497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE67AD8ACD
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 13:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDD1E3D88
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9607C2E2F04;
	Fri, 13 Jun 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="vCaZPppF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03C2D6626
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814918; cv=none; b=ClUjklOUxDtwMtpJGJ+aVEMvVTjzzGuhmfJpTxII9CEerBMR3s87IZc5SOXtRx8IdsInlhroFBuqBRirAC3AARiCwAhE0RcTZaTOK+mHmrRfgfrFuq1QEeKz54cSXy5lCuc0pPCUzn1KeKU5ctBE8mg5KBIPCQhkua19vo5PRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814918; c=relaxed/simple;
	bh=Xu9/tBx7J9HDSStwJKx4qcuH0x0i4S5UUTdM0NWoFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARP9L8juX8Qpl6tQVVrGeLDYdn45oLkjI7vWeINPEas3TTMkxiFFnwZk4Ov4JuNWiSEJ/bDtxh22wbQP1GTPtubZwttTSQ0P6DCP86by7GHFmK1uhkmKyXPeEDskvzXGE9+gCISa7hv3BAzsQK7w45SftJnfgzLOl/19sUC9o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=vCaZPppF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so17217536d6.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1749814915; x=1750419715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IO9Rd2HFTD+1YUfAySkfEq/dcEm2RB+c5PiJqcKqYFw=;
        b=vCaZPppFKldwMOpfY9qwXMyXK2n63c4Y3wPPdUCkD/NsZWDSzWPhcMrXiaMn397fQK
         lpnhZ7mzLivt8EIJyBy6XjV4oMyqIL0XCtWdsgk31eJdw+AOufwlLY+480r64Su+xOMU
         1738ZjQi87AJ6UGtfhqX3hP7zeSo7D72mgGlpsV/qQ+a52flJbbDe2ec/U8Fl/ZB5y5k
         TvXr0njPK4Emygrhl/JeatCHrJgo/c8q6yZ/vAbtZsu7HM+kaR+7wOT2RRnvkc1PLBbZ
         siE5NBO4GzqM+8O1l2XfaB/uQ2c42VI7ShrVgPFbk74bFmCnyXa+5PDGEhQ5hyHhP87+
         ETiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814915; x=1750419715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO9Rd2HFTD+1YUfAySkfEq/dcEm2RB+c5PiJqcKqYFw=;
        b=XvUhmB732O+Y1thccXf7D9q7oDQiATmpU+05KRE1Oi1PRgOh7CqUEbYwuQj5YAV0z2
         6uLFCKnzpRYcr4PbNFuaeaftM2iojgnblIGYOuskxlLoASd7rdnOgc9Agzam6YlNi7L8
         kI6lF1UXwsp49kNxxGVwB//KGzVlWugNw7/7wvjVSAw8B+fOq6aWsMeaJCP1Gd8Z4s1I
         eDIqltL/sDioZFoiF51Yscpw1SbNpfAU6CLj+ZGSicC1QcgjmQdgg84JQTxgo8GpAutW
         fw+CAYE6V06OPXZozRFZwDX8T+I3I3C3yhD9UDPJ1rkGtLmxF4SeRW9BY6ocSUGuQXpQ
         /59g==
X-Forwarded-Encrypted: i=1; AJvYcCU4rD4H6u0R6etHimH169ViJfaLCC5xHI2ONESAjTXGLc2kmGJDH7/FBvP0fzo34Ihl9jQGO13PZE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEiw6ZHSUZJS0rPeAjHQMK+lcum9KuSk84lCFg3/yAohPPNKWM
	n7+lXoagG4dnn+EGVBoBGjDjFG6HFS+57qoEU4uSE3CNKnJYhXE4BAo2StcMVPuRcEA=
X-Gm-Gg: ASbGncuw6yBjwF4aSA05gMNgi8s1cd7Ke0dGts7YNIEleEWdks0jNQc+AkYaIJ5f1Q/
	IfkZjKmXPMNdF+25wLYdrNi9AszVXhwuAIoYSW1dyyevXAIaQaaqkN5fRNnnaWApwnlsNICECPT
	/g01/SKPSjgetUzMv4YglKwznIpftSiP8csUYWBXwm1bDm2LLlpVCG7U0bdHqpZPbiDiq5/4NhJ
	YMOVIJEDTF4EdFomC0auboV1R0GEnI2e7i7k7R6XD0L36+3rQCwf/wk6zWj1CAG1iMAFnUV44ws
	BW50sv+n0JD05aEPixvlpFNB8f6OqRWdp9JCEANWYR7VjauIB1fGc8UC3WCSZ1I02VbHMr1baVr
	0+1b/Pv2BMB9ZkXsi9lIX59tFARz/5OEu
X-Google-Smtp-Source: AGHT+IEc5wMP8ofTZTO6iGwnPV4OsQNdZGNQL5zwacGNvbNKtJCkrAxEGOyHCjmYXgP1YxiBm+lShw==
X-Received: by 2002:a05:6214:2344:b0:6f5:106a:270e with SMTP id 6a1803df08f44-6fb3e60bc99mr35271836d6.44.1749814914668;
        Fri, 13 Jun 2025 04:41:54 -0700 (PDT)
Received: from fedora.. (cpe-109-60-82-18.zg3.cable.xnet.hr. [109.60.82.18])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6fb35b3058fsm20558206d6.37.2025.06.13.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:41:54 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	ore@pengutronix.de,
	luka.perkov@sartura.hr,
	arnd@arndb.de,
	daniel.machon@microchip.com
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 0/6] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Fri, 13 Jun 2025 13:39:35 +0200
Message-ID: <20250613114148.1943267-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic support for Microchip LAN969x SoC.

It introduces the SoC ARCH symbol itself and allows basic peripheral
drivers that are currently marked only for AT91 to be also selected for
LAN969x.

DTS and further driver will be added in follow-up series.

Robert Marko (6):
  arm64: lan969x: Add support for Microchip LAN969x SoC
  spi: atmel: make it selectable for ARCH_LAN969X
  i2c: at91: make it selectable for ARCH_LAN969X
  dma: xdmac: make it selectable for ARCH_LAN969X
  char: hw_random: atmel: make it selectable for ARCH_LAN969X
  crypto: atmel-aes: make it selectable for ARCH_LAN969X

 arch/arm64/Kconfig.platforms   | 14 ++++++++++++++
 drivers/char/hw_random/Kconfig |  2 +-
 drivers/crypto/Kconfig         |  2 +-
 drivers/dma/Kconfig            |  2 +-
 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/spi/Kconfig            |  2 +-
 6 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.49.0


