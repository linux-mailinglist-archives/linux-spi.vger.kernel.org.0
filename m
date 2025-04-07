Return-Path: <linux-spi+bounces-7405-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25923A7D43C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 08:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04653AB565
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 06:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D49C224AFB;
	Mon,  7 Apr 2025 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpnaFRpj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEB221F3C;
	Mon,  7 Apr 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007722; cv=none; b=Q+G/oRvcVI7h93lneFik16Fdngdyn/k3FJXtC/+b1uO7K5HpkQ2HnY+JSm1AGfwIoMBCKwUYadeJrLaMdqWlO0Xfi3NS9Ris65Mo9eW75IA+/SpkBT2GzDNfIG/KrfluKddxF64Sg4hZWedwi2lNB6hnl/ITlpaqUjxxqKU683Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007722; c=relaxed/simple;
	bh=PrUQRbB1c+rJuvNmtq5sRl5XHonz7LhulE1jv95UeZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YTi5a9zBHeRMrP2o2x8XL4KafWZErkzsUTBJEW8G6JigP8h0orDWqrsDJupc/RAHybeqXufqoDH5nBs4/FVgLkYz+h/VQ1mGKm5QJTdFSe/BOtzyUCX8UmoJApuy/n9kTbSmvHw0x4W18HwMCK/cNlQWSQjlqmM0o8nz6fQ11o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpnaFRpj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so2558303a12.1;
        Sun, 06 Apr 2025 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744007719; x=1744612519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUKnCXni+ZS+V5rei8asTaXf4mmG/ra2/KlqUzUvNL8=;
        b=MpnaFRpjcU4UjbMww+9pqRtasa/ZZi1c2XcgzLI9XTv8oWwf0Z5cQ6qo9CAyUukMA0
         8sx40iRy9OuSdN5PwWZZ9dMRThLERmY4l126QUJ4LxKwRaK5W5gRCyoen8K5iTxyqP/f
         6DG1ymzM5MU2Evw9K1+zVlgG7YMNGSlpwzZVh3xGKDVO5512JDf412r9g43n7dfhqU2e
         JeMCGoUcOMMZpvIsgQqDK4K2QkGjURaGjHIsS+eFJXhFPtyZgvzYcekh3F3ag3DCDyeZ
         VWnwWSVxAY3WRLZNkdpWv0sRyB0wmnuL5Jd/CKDMbqu2C0o+ASBE9CkXmzkUi3eDKBmJ
         yvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744007719; x=1744612519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUKnCXni+ZS+V5rei8asTaXf4mmG/ra2/KlqUzUvNL8=;
        b=Divh8gJgOwxlkWfM0QHd8M6jsRpJqstwbPxZF+J2DG3t6NcscBnX4jnTee98/VCZub
         ocvi1dds6vjJYavngbjfZjwAEUx2FOmURc1WkW8yxC4tfvmpMLMSye0jOQSoJ6aNRzwS
         7GoLj8r87/w/QNFrq3IZJwhzFbqxs3XiltfWjWRQVYvPQrQU5p3mJeAbARI3mgNd0ckK
         l90dsmQdBtR4/O8pRmJJmIrx6TiUIOSNfX9ymDer1RBAaLggefn9XpCmXg1tSCTVYxmj
         NZDDpsHJXaeZ1tR0sffaejPhXQZUrzx2QZXlNp9S69GDqJ+NTsxN98JOwHxU9OxlNQgb
         u9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWn+xABwicHq4X/sgJ29ANv7jgUYrkPYYIMKyPcQLD1Rowvq3gIzygL+ICYx/PQFnTUMqWiqLtQ1LEL@vger.kernel.org, AJvYcCXLtbBA20gyyC3cNDlTBI7/ZsMrEye/R0Ky/NzjI5l6DsndimFVjd7p1zKg8qFsCRBGNGhvtsC1/P9FWOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCs6L4G6ejEiSy4g1lYX3cW3CjQSNhIIS+2jr4BdUl2N4LcIG
	lA5rrrnWScUl+wlwHq7noShss31k1z5/F8rw2YZmXleH8gzBUr6y
X-Gm-Gg: ASbGncuM50CYAgBtbFzarqk/f0vWpFilEldvKJszPBWXW1AjY6P4gcqn+qjwfkfYBWC
	OvASt9TEjNwFUuzTR/lhlvx6sRqA03Hy7ANt/8A6O5jHKiZyXlxCAMES4zYEEl4Pfn8Ao0d668k
	/kuUk0F6xg/dUfGeSURkQLmLuexwHcfjFQ5fJ5DqwAbPGTxu7GtD9hwDrTOCI3GYbPDRwnSNmbs
	kRzg826HbFr/8wyKh2SFQ1+1QfwoWxdzpSiAGn0Z/6sNQGSv67ir8uqwqzogS0YSOtJtO48NmOg
	xTc8Kqd4dTvirO7uXM7RG2LWv7JeynJRFk2Q
X-Google-Smtp-Source: AGHT+IGRG2C26zGOmhoXFbiYCUXmZOta5ZKasjUrRKCZwa8ZEA1iM0n9fmVIC+YnuIVVcjAsIQP16Q==
X-Received: by 2002:a17:90b:5190:b0:2ff:62f8:9a12 with SMTP id 98e67ed59e1d1-306a62134c9mr12842046a91.23.1744007718706;
        Sun, 06 Apr 2025 23:35:18 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::610c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983da691sm8048044a91.47.2025.04.06.23.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:35:18 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v4 0/2] Add basic SPI support for SG2042 SoC
Date: Mon, 07 Apr 2025 14:35:11 +0800
Message-Id: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9y82cC/3XMTQ7CIBCG4as0rMXAQCu48h7GBbRDS2J/AoZom
 t5d2k2NxuU3meedScTgMZJzMZOAyUc/DnnIQ0HqzgwtUt/kTYBByQAUja6lcfIUhQODtWHaWJK
 /p4DOP7fS9ZZ35+NjDK8tnPh6/W0kTjm1WmmDjZaa80vbG38/1mNP1kaCPw6yU9Y6EFaVDcNvJ
 3YnuNidoIxipSoJJ8GlhU+3LMsbN/KdLQ4BAAA=
X-Change-ID: 20250228-sfg-spi-e3f2aeca09ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744007713; l=1831;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=PrUQRbB1c+rJuvNmtq5sRl5XHonz7LhulE1jv95UeZM=;
 b=+Go8UegZSi0E77pZKJXd0DldPDvqti7TxLG0uptVeWXzxZduvooGHEgeSM4M2YYM6pATGfmqi
 JNh79RwI3F1B23p/37XeiAocKXBVwsXHOPhGKqqgwGevMOI5xoQHKvL
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Implemented basic SPI support for SG2042 SoC[1] using 
the upstreamed Synopsys DW-SPI IP.

This is tested on milkv-pioneer board on bus level. Using 
driver/spi/spidev.c for creating virtual /dev/spidevX.Y and 
tools/spi/spidev_test for testing functionality.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v4:
- Adjust the order of spi nodes
- Place the binding after Renesas
- Fix the description issues of patches
- Link to v3: https://lore.kernel.org/r/20250313-sfg-spi-v3-0-e686427314b2@gmail.com

Changes in v3:
- Remove the spi status on sg2042-milkv-pioneer board
- Remove remove clock GATE_CLK_SYSDMA_AXI from spi[2]
- Create dt-binding of compatible property
- Replace the general compatible property with SoC-specific in dts
- Link to v2: https://lore.kernel.org/r/20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com

Changes in v2:
- Rebase v1 to sophgo/master(github.com/sophgo/linux.git).
- Order properties in device node.
- Remove unevaluated properties `clock-frequency`.
- Set default status to disable.
- Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com

[1] https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/SPI.rst
[2] https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst#clock-tree

---
Zixian Zeng (2):
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
      riscv: sophgo: dts: Add spi controller for SG2042

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  4 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 26 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250228-sfg-spi-e3f2aeca09ab

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


