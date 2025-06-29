Return-Path: <linux-spi+bounces-8858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B242AECBAF
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF863B3A98
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55CE1F150A;
	Sun, 29 Jun 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im/5Mksq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F31E2602;
	Sun, 29 Jun 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185421; cv=none; b=gTRtUWcbWtt+EDiSo8e7Uo1lhFBv/BCWDAicPb9Tw+1jbsuVna3NPhUB8xzEBSl8ia1Pxp7JUaPHN0Wg3FnyukG+RAcFMp7MC0IDgOeYXtRUKAsm+3pNZ+Pm/IfgGCoe+L3m7wcb7r71dkSQl6yef2/8bXMRcGoMq1k1W0R2Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185421; c=relaxed/simple;
	bh=LKtaI0pAOsDCmEDvjcAJQIr31hlkW2ymLC+5XkspvJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EoYWl7pQGcZpO424Cg+Si6ws96VFozYsxkXAUOggCqSzmnSLxYViqyT2lKaxRCDySvNYM7xettYT6XTXE7nmDTEOpGB+kLpawHhl2aQKl8bJQtKLjzUubikIoBWr+C8HmatVD+64a2iVdpXo8Pn1/bFs7g+OMQT7co4kDhrOE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im/5Mksq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so701503a91.1;
        Sun, 29 Jun 2025 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185419; x=1751790219; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iT8CFBVHA2PHKdhe+MXDUNE+DyeuqyUpTK4o2FEoGw4=;
        b=Im/5Mksqd1rZRivEtf8zsb82T6fN68Fi4YT0eQAPm7/6HpJyA5dQlSMLDyTyehBqr3
         vX6+g4tmP8Rc6tmyljibpaZYHSQWX1bDHvg3dRRQ/QQJS9wmam6FWaTMtjdQL2J96GXY
         VgB5UjeVOwrv9u5v9FSzMwLyCAWr/vrTwALgDRVZRbE5h96PceZGdqnN9e1JnSdnE+E/
         QPrnhVH0KFX5+7/BVelongtBxhZBugB3x2KPGJqpd6h7jcZ3UyFTwr5GXe4cfq81VSET
         c+t5JkTaJxSpuWbaAED8uxxRzp8XWj6REpLrYNb2+VeHOSOxqJtVc2v+QIl+eTQAM2fh
         rF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185419; x=1751790219;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT8CFBVHA2PHKdhe+MXDUNE+DyeuqyUpTK4o2FEoGw4=;
        b=WSxc8kA6VIZ2+DBhYwf8bqYB/oA08W6hQLw0HPGeV2RmraJ3M/QQVrvp8/kY81dX22
         qLLmGj4+nhULwZoVAXk9kTVGxcr3iLwATruRPTor0EoNPkyEvem81wP5kkr/h2+vrwOO
         BenVlCsBKkE+vRt1RJyBtCegmA2oEpa9cOnPz6qHrygBKb1pFaXKDFE41csjrufofbs3
         m9qkr0IK0pvXl6bV5J0cj4K5p1yC3qz6aMef/9Iud0dJmk3+kVDx42hwmm+Pxr6YKWJF
         s7dWUNdg1xJAJsJ50bGBCMbiysihlP0RbuqS8n8EgjY2EOJxcnn5w9YHqSIsMUl+l4o7
         9jOA==
X-Forwarded-Encrypted: i=1; AJvYcCUHn5992c6xmooy17JlSAVaEJEJnCUFS4odkojL6vQICPAInKnG/Yqu4iAMxLu9hKDbLQLb8MUS8wn0@vger.kernel.org, AJvYcCVb0zJzsJV3nOWppfnDcmGhwBNoh8dWBdCaOrrZrMEZl6ydtZjlge2JVLBmtW/VtMKQhWrQUmZ85beXtWcv@vger.kernel.org, AJvYcCWA32jC4zSVkLx0iiW26NgdoPCoqK5r1T2h1zO+Z7ZOVGadJB2cEbWLkSxAyGQUkjoBOj+XGRQ0EqvU@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDxRLbJpcVgsDhop0wR3Lxq5HWLeQYlnYyircHHY+YV2wWNZP
	R9G4Fc8jxTRyBkXfkl0CxJPq4BZjg4IRpioWzVdotc8c9UWR8Ue1kBVHFEwdSg4gGVM=
X-Gm-Gg: ASbGncvHOY7SQj4J1/EkfYNqRPr7xqmfswLPovd2Wq/4mR6lWXOW1fDEYAE2OizUY2j
	+ONOwXVBwARe2Q/fZ7436RyiJZbKBF3e6hFTF6KQeu/JdO76MzEbF9poJKA4+2PzVVeT5t+LuqR
	zSa+0KCx8wU5GiABMYkI/LlczG3LFbl9+C3QHUvvD+dvEYU3RZLuX+Gyt6mB2xl2sKZNGIbvLiB
	swWpHzogsQAIHmKR5fCDN9+SqUvwJcNKtUJ1JJY7PTdDmPyVKHqsQBvUhxNpKbfiKunB0pNwd9k
	b1i2Q+PHVTOhCVpyWGqtzfY1PN9NqfrlcKnj428yUbcIrkNYWBZXiA==
X-Google-Smtp-Source: AGHT+IGkogtkfd4RaBa+53mBJuGMKYemWXLFm3Z+9Nh+DPGDIY7c7kUnrfh43VEBbsF0oQoW8UIuQQ==
X-Received: by 2002:a17:90b:2e04:b0:311:abba:53c9 with SMTP id 98e67ed59e1d1-318c911cbddmr13750481a91.7.1751185418667;
        Sun, 29 Jun 2025 01:23:38 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::168a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm10495839a91.26.2025.06.29.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:23:38 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v3 0/4] spi: sophgo: Add SPI NOR controller for SG2042
Date: Sun, 29 Jun 2025 16:23:09 +0800
Message-Id: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO33YGgC/23MQQqDMBCF4avIrJuSTIxiV71H6SLGjA7UKkkJL
 eLdG11Z6PI9+P4Fog/sI1yKBYJPHHl65qFPBbjBPnsvuMsbUKKRBrWI1Is4M41O1LZREhvpm6q
 EDObgid977HbPe+D4msJnbye1vX8zSQkpSkeqcqSpQ3vtR8uPs5tG2DIJj9T8UMzU6lpjW5Gxb
 Xmk67p+ARyza/HfAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751185413; l=1859;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=LKtaI0pAOsDCmEDvjcAJQIr31hlkW2ymLC+5XkspvJk=;
 b=YLmRX9bJFi28MdqzwGvr0+LQxNtd9EVILDTfJCzRxnX7jC+jYtagrVP82dyF/rrrwfKmhn4WW
 zofIBYJV37jB52dYeAh9hPAMXx8r9Hhfl+kW72Hms+Der4N9sGbaCD1
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add support SPI NOR flash memory controller for SG2042, using upstreamed
SG2044 SPI NOR driver.

Tested on SG2042 Pioneer Box, read, write operations.
Thanks Chen Wang who provided machine and guidance.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
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
      spi: spi-sg2044-nor: Add configurable chip info
      spi: spi-sg2044-nor: Fix reading bytes issue on SG2042
      riscv: dts: sophgo: Add SPI NOR node for SG2042

 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  5 +---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++
 drivers/spi/spi-sg2044-nor.c                       | 29 +++++++++++++++++++---
 4 files changed, 75 insertions(+), 7 deletions(-)
---
base-commit: 880f18ee6772d4add69519cb7de2fcf9f4769cd6
change-id: 20250523-sfg-spifmc-7a910290e964

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


