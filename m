Return-Path: <linux-spi+bounces-8280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6BAC3544
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E6716EF4B
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBB1F540F;
	Sun, 25 May 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuZfsvQZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBC1F4C8B;
	Sun, 25 May 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748185175; cv=none; b=uvdUWl+YhxQOjLVl5kSuxek2MB+YdF+9+T9Oqv5H3OzqUBPsVxDjAmdfuQbbCEPKWrV1jkdRp/dNiSzbd2DdTRUdqh2QifNDvHeGA+RQBGTPzmMOK5unffXZTB3mrC3DSR/2WOfdVYLMNXbigJTu7Y51yyKotESwio1m2bviBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748185175; c=relaxed/simple;
	bh=5Rf+XH7wYeHA/1Ip4R0wdkjAiYWlYPDMcrHiaZwX1Ls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkAaspbeTl9ao1VlT21gdLgbUG3RTtmE46gESHH6wJUgh9T/qJui/wT6e6rF2GHof3vIla+vF00jMW7PKemZmzgwPqmJjuQ6uH7zLeRFk4sfaQCeVD7yjtIwMFLaWG+R8qJ+5BNin5vRMPg8WaCLHeKnVaDsxC/T22QvCOtwUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuZfsvQZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2346765d5b0so690255ad.2;
        Sun, 25 May 2025 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748185173; x=1748789973; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJSZqhft8oN88RWw/icnXyxnygR+ybrApsl+WofewtM=;
        b=MuZfsvQZ+p2nbzlGJy8lWpY+ufgo188CVi7gR1vLuqQt0NsJHkqnVx7JnQvSJ1h1V8
         NlqVBWJuJgAs7wFVVa1wnptuN/XZvRw2sTnrzBsVrUxAsd/5PYbgn5qkRVOoPRoJw1fv
         ZkGcOwrKCzDZL9ui0THHuAAJaJTJ2Q9p+HBYYEWLYY3kq8s5UKfRLzwu0lTkGru3Y0jf
         Gkmubel1Ef0uvSjhjNbgkDiZiVpwKGJnWBknH+kz2tTNPwk4Z361rBvB4weN8IHKmyUB
         NOtvz1uzdWtA1FpJRGz35EQ8fnegPZH3cXBSZUIBf0prK1uOeDSYb6MgRI1+S288tUFF
         jleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748185173; x=1748789973;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJSZqhft8oN88RWw/icnXyxnygR+ybrApsl+WofewtM=;
        b=nokYu0L7DuOaoN/rsuCKpmOGUk8CbEAeyHZTxqXXxkfM96fDfac32qF9wSoQtPVoaO
         dlHAQ1Sd3W8/cDYL59y89Hchcd0MYJAgFaMS7ZwaLQlvTJrRRtO/V/syWe9Sdei+lTxG
         B5m/ckQUkGvzVi8DRuf83Al4G3RibFh2icS19tkYslNqxQ2uYFFF6UDnxx/ActV8jKLu
         UCkoralPVYZs0UFmvMqEvg5ee2LfYW8NpNTgCfepId+JAwXv/rhKBh8bRC48zKlNnG0E
         687lE0dkKnf0Ybxiyz/c6tS+CIixdknV7oVkjO5HjF96fJrkpOXndcv09sL+fK+MVgMM
         GhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4v5p6hY3MkvyiJnAA9Cj7Tgtf9B10kFXzeCK704Pt2vlLRTn5xGypQnK2igHVZbDA76Lu5WC+yzh+@vger.kernel.org, AJvYcCVpoWVSILpOUBuTIx19c1o+ZnxzYAbbhCTpF7AbLJ46W0KxxU/SO3JBmtZE9Eoxl3SZK8ynuNjscSQq@vger.kernel.org, AJvYcCXkrGdwjci+BVxPPtiXTbhW5JpWHTXVJKtQK5J3ti4QF5XQcQl4a1lAFPifQwgPtpF2H8eK7P89eucxATX2@vger.kernel.org
X-Gm-Message-State: AOJu0YyF548OzgQfZWpBmBK7XTqP4QypK1QGvmvAYbNcmz7Xdw6CjgaO
	FcV0K6U4z/rPanyTq/vhcyYC6Sg40fIu+gS9TAX/3hPWmyW9sTtEqIy4
X-Gm-Gg: ASbGncu/zZlWiMWM0Vqxu9DX+3X3SktvDOB35oSojzwPy27LtT1lKLibPJK8Wz+hKmb
	u/fjTwalur9zfIM1xm6vkLgYAsaHNDGFfGr/639ElCXhhUS30BDFiWUdqFt4C17fUzW20M9lYvV
	VXuhZUIPAleoUYo33BPt0cXz0d8TrA7BNuKVKXotkL9//TauDDNTD9jfHSxmSr60Bs/DaPgx8bl
	dIqRv23kUgFQqh7VdP2ouO7DRAJ3IKIWjgjKEvewg8CB66ALZZWus9PR4HwXxtGPWTKbzCDJwUq
	uoS2eZTWMMW52W926ZfQ2Vg8lIzNRq3HCYcu35HDQHMh5jXroGc8/w==
X-Google-Smtp-Source: AGHT+IGMA891Z9QcMnUNy37nLhB0qBQRarrDsxvWe011CA95ftR2WVjmKQaGn9yEpFYZJ8bwv7RwvQ==
X-Received: by 2002:a17:903:32c3:b0:220:c34c:5760 with SMTP id d9443c01a7336-23414fd3f1fmr80933825ad.51.1748185172627;
        Sun, 25 May 2025 07:59:32 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2343f8e2fbesm12204845ad.250.2025.05.25.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:59:32 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v2 0/3] spi: sophgo: Add SPI NOR controller for SG2042
Date: Sun, 25 May 2025 22:58:40 +0800
Message-Id: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAwM2gC/23MywrDIBCF4VcJs+4UNZdiV3mPkoWY0QzUJGiRl
 uC712bd5X/gfAckikwJ7s0BkTIn3tYa6tKAXczqCXmuDUqoXvSqxeQ8pp1dsHgzWgqlBemhg3r
 YIzl+n9hjqr1wem3xc9pZ/ta/TJYosLNODta1blZm9MHw82q3AFMp5Qsn912RpAAAAA==
X-Change-ID: 20250523-sfg-spifmc-7a910290e964
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748185167; l=1277;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=5Rf+XH7wYeHA/1Ip4R0wdkjAiYWlYPDMcrHiaZwX1Ls=;
 b=w3J+SqKPY7joyY5psDMZB+uFx1T6KaYC9OLGQsA2Thu53R2RBdIYrBT7sOAQn4ef7ZzEtCD6V
 eLvSJDWaMGPAXW6EgcdiNWwkHqxEtfQ79HoahVSQP1t4TRogUPsN1fz
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add support SPI NOR flash memory controller for SG2042, using upstreamed
SG2044 SPI NOR driver.

Tested on SG2042 Pioneer Box, read, write operations.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v2:
- patch1: Accept devicetree nodes whose compatible contains only
  "sophgo,sg2044-spifmc-nor" to avoid breaking existing devicetrees.
- patch1: Improve the commit subject message.
- patch2: Dump the SFDP information to commit message.
- Link to v1: https://lore.kernel.org/r/20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com

---
Zixian Zeng (3):
      spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042
      mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
      riscv: dts: sophgo: Add SPI NOR node for SG2042

 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  7 ++++++-
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 18 ++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
 drivers/mtd/spi-nor/gigadevice.c                   | 17 +++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)
---
base-commit: bd8ad2bcb8ff8e7af8d35273a8194104ca9ba5c0
change-id: 20250523-sfg-spifmc-7a910290e964

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


