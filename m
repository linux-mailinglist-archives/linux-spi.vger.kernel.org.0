Return-Path: <linux-spi+bounces-9132-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105AB0B436
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EF97A99AB
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1B1D79A5;
	Sun, 20 Jul 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsDa1yjg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3596192598;
	Sun, 20 Jul 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000370; cv=none; b=MhvYqkURbEkArp6H31Rr2+mmeURxE2Yjd533BsfKq5KpxVgkpeThxMHJcjvZKrIVwxeERiuF8gwdyhl8NZo3pAFaxEbr5E0N8C9mWaajsi4zb66xe/aYGPwyAlnhdFgMaNaaO+kM7IQGRW+ycp96MjgTBLwi7v80BSwK0lhVZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000370; c=relaxed/simple;
	bh=txKyTWgMnO1Ncvzz/n1aTwE0i4eSFrFSmoLYu+02pqw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aaZWbX7UCfCiCojndJodqBU149nvucfzArb754EpYU+9Lpjq+8l0q+12B3CMR2aW6zniNk0TQDwmeH4Xc9bwR1XHkouHMVuYmLSF+I6dOvrZXFYhn45yjvjaH6Ngf3kzbIqvFc8GMdWI6QrCtjspz7RdsyMsDduLJY3lP5CLRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsDa1yjg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313a188174fso3302193a91.1;
        Sun, 20 Jul 2025 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753000368; x=1753605168; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FiNF4SEuIin2EgUqWK8JFEp6BYToNAS7zW+nZhJnUmo=;
        b=NsDa1yjgQMf1/C3tL/pTxMSfd4nwuK9bPsbfKaZExb0xLjnElfXbnbI+IS/cYOCkwA
         iwsM7JG1yyZlSrYMnDHfEmeDaQdOQ4H1kf6DqMFfs1BcP2VJWwYKfcCNw0yOXvCpn+3a
         3TT2qyBXeJe4wFO81LnOXSAi8MZ5qW9pNFUwo9G7cOwzQMfLIHReovBkU/yTEyHYeo6x
         sdnFmXljcYCBw7VRdvibv2sM6JgmhiLUQgIrwwpcFNpHaTs+qOXDpk/A6Q1x9vqV6w2J
         oZFn+fgiwEOUXq0E02FT1FhSxSge/tyiK6RdVrTAXQn6zF3ebCBxptu2MAwFw7i1oCbZ
         CcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753000368; x=1753605168;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiNF4SEuIin2EgUqWK8JFEp6BYToNAS7zW+nZhJnUmo=;
        b=AsBLDzbwNO94C6SJ9Rh38k6sX2KJ+HpnEzbiEhrigDedFu/mvCZrP+XsXWiqGTuq0+
         WieAWkAT8DxnO+yJtuamW/wyXMia6yqpa44GU5Qt+m7Ly28FvgzP/jCCl6EC0MNhA9Io
         WRzDCeOryx/ZgyTmX4H2n7SPtACFklFUhtMQg8MCttV3FCvcLWGGpgJxArrw3Srcf98v
         W3m4Nyxj9jbagX0p1OWXdre6OaOCZ0gn7cNsK8mSMFJM3cxcnmH5TKEYlzdqNnhV/nhX
         IIc/5e2qPGGtZK71W2qs/Q6BlD8LzfvOW15KRDqZOlNpiMDLs7LiVYkT25tMbAdaDp/x
         5foA==
X-Forwarded-Encrypted: i=1; AJvYcCV264vbU/r8kkHYB0cC3SoQ13pT08cNgCN8F8U+1Orl4MhB9PoThdgc3sptL1BUQlMS6wEuCS1qpOdt@vger.kernel.org, AJvYcCXEn6ba8nzj0kUYLYhFNdZXKW+f6zmkoH81WIVeXp0tPzYOGxbG/OXgQedpxwdSgrzBRrH6YrrH82j6@vger.kernel.org, AJvYcCXMr+9fCFvvhsCOyLDnJpiuc+Guvm8zVMbV93oWKyVswbJkTdtFfOZnXeFR5siQM1NGID8VX+sSyRx+V05P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3L60MEDne6lVl0uU1BYmX0vlFVFM1RxxyPs4mBxymvyVMJ70j
	uVcVnk0b5z4ELztTaBFiaWjhtR58K/Bh/k1RUjHN4OFpr/duZI6lcvcs38xTFrIJOgU=
X-Gm-Gg: ASbGncsTrsh/PEiWrtAQew/M5s7zPDp3nIJXYgB54gfapdRzQViwvWrvy8YWnzD/jHp
	FcEYQqw/yRFQaWOido6xJ2+bIT2TXPLzu+ztn1qjf/jBJZUjwZNBiOnSuY5onAWC8uFScAIixXS
	5SI2lspqpFiU6ZwhU/6mN7XsHu/xBl5oa6fEu2MKRp4aOnYyXgGztzPfvjjwz25ss+6hKyN3sMF
	C0/aXNBFl+w3z5fuGaQSQa59DzSmJto8JbDXrRLewl7lskdz8AGw8n7kzeAzJcuKfCwbPq24t7b
	58An8qhEEKn69XyR6I97i3YoPSTicajTpM2HgeSNeRm9OWgJeuwcy9KeGzruQTQUaPcMxxa1MJu
	Jm0Ec+PiADBCY7g==
X-Google-Smtp-Source: AGHT+IGZKIIWxW0MM8M+8exnM4woxigogql9EMO/mHA038LwIs21zmM+BeC1R09FPp/G2WH28WdCag==
X-Received: by 2002:a17:90b:288b:b0:30e:e9f1:8447 with SMTP id 98e67ed59e1d1-31cc03c01e6mr11886432a91.4.1753000367324;
        Sun, 20 Jul 2025 01:32:47 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1002::1d55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46b97sm4079721a91.41.2025.07.20.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:32:46 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v4 0/4] spi: sophgo: Add SPI NOR controller for SG2042
Date: Sun, 20 Jul 2025 16:31:42 +0800
Message-Id: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6pfGgC/23M0Q6CIBiG4VtxHEeDH9DoqPtoHSDyK1umg8Zqz
 nsPPUlbh9+3Pe9EogveRXIuJhJc8tEPjzzkoSC2M4/WUd/kTYCBYgoEjdjSOHrsLa2M5gw0c7q
 UJIMxOPSvNXa95d35+BzCe20nvrx/M4lTRqVFXloU2IC5tL3x96MderJkEmyp2lHI1IhKQF2iM
 rX8peJLS9A7KjKFU1NzhMpprbd0nucPmRjohRoBAAA=
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753000358; l=2195;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=txKyTWgMnO1Ncvzz/n1aTwE0i4eSFrFSmoLYu+02pqw=;
 b=Bty5Us+RDErqs1hsitaE/Etf77DhqRuEEm5hj9oZFE4DY2gy+5UoSPR3DZCPnKeQv+NsoG1oH
 lSM0QtJLQBkD+90idbkhwV7YqJ/zbSn8bgnFKisClm5VChqzFIMH6T7
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add support SPI NOR flash memory controller for SG2042, using upstreamed
SG2044 SPI NOR driver.

Tested on SG2042 Pioneer Box, read, write operations.
Thanks Chen Wang who provided machine and guidance.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v4:
- patch1: Explain why SG2042 is not compatible with SG2044 and add Fixes tag.
- patch2: Explain the hardware differences between SG2042 and SG2044.
- patch4: Remove the extra "sophgo,sg2044-spifmc-nor" compatible property.
- Link to v3: https://lore.kernel.org/r/20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com

Changes in v3:
- Drop the patch which adds additional flash_info into gigadevice.c
- patch1: Because of the incompatibility, separate the SG2042 from the previous fallback mechanism to independent one.
- patch2: Newly add configurable options to spi-sg2044-nor driver.
- patch3: Fix reading bytes issue that causes the spi_nor_check_sfdp_signature() failure on SG2042.
- Link to v2: https://lore.kernel.org/r/20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com

Changes in v2:
- patch1: Accept devicetree nodes whose compatible contains only
  "sophgo,sg2044-spifmc-nor" to avoid breaking existing devicetrees.
- patch1: Improve the commit subject message.
- patch2: Dump the SFDP information to commit message.
- Link to v1: https://lore.kernel.org/r/20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com

---
Zixian Zeng (4):
      spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
      spi: spi-sg2044-nor: Add configurable chip_info
      spi: spi-sg2044-nor: Add SPI-NOR controller for SG2042
      riscv: dts: sophgo: Add SPI NOR node for SG2042

 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  9 +++----
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++
 drivers/spi/spi-sg2044-nor.c                       | 29 +++++++++++++++++++---
 4 files changed, 77 insertions(+), 9 deletions(-)
---
base-commit: 8727665368cd4af112146b650ec0ebac038b5cf5
change-id: 20250523-sfg-spifmc-7a910290e964

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


