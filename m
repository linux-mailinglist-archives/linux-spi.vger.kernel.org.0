Return-Path: <linux-spi+bounces-10088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3681B821AD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FE3B753D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958130E0F7;
	Wed, 17 Sep 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZiA0q6DC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DB30E0C8
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146851; cv=none; b=ju23BH3xyxEMfIqn6bA3ImwtDRxWf4MD0/Y8uB5fdD2OlSXhi7sBSCMw04Y31tNG1b60oOYMzmLgpcw0MyieCl3xgMkqfJdN9D7mpGiiE6rXwHBwbu65RYGfaPJpDrNyEcMg7TG15+3f7hqfxvwIPxdYvrUUlv+DQU9ref6gE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146851; c=relaxed/simple;
	bh=nzUaN55jEAng4Zv9fz+h0GiC5YvS42PpGZXeLpWjU3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzJXZ/RpHeBFC4yKu+pzEN6r+X+M/uggdIxT6LN5H4yU0N26VJg/LbqqSfwJAxRH9ynQaMe7VV6gNlquQ6HeE0D77r9hCiwfgC04ANhj7G/HePPpgZgPshsimmAsimA2gCDB46TB5/gMp2FUjeb+MQ+QfNo4SFXPasLh8gpdW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZiA0q6DC; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-423394b393eso1653685ab.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758146848; x=1758751648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp8RbtGYlwCTIrM7MVPtV3vKCoFBge4Bz36KG46LLsA=;
        b=ZiA0q6DCcc7rXxWISXql5cxvSFl2WHw6OHSJ/Fh6KY1nITEW3+SOVpK6Gu7sCG18Fn
         pm+uZe1UzfY9YViIVuV6BAXh5p3VU/v6tO8CCu8Gt9ULK6/AE9xCiMKfW8cjX6WbuQrF
         gCVtaVz6FoZHlh/BRW4SCnxykDnvnkuYE6XhBjgLdVLNtDzCQuosX27g8uuuddgEXMjg
         prXzVxl/JmhD9aycGrnedsxacc/wGbX1DAR0VcrzRBxiEzaRH7RkGxhDG1GPzMG5yKI3
         lapI4BB5dJq58WbWCOND3tK1kw1xgqy9oYogFJShm0j23tLqlflR8gvZU1HPpyMidpSu
         sCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146848; x=1758751648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp8RbtGYlwCTIrM7MVPtV3vKCoFBge4Bz36KG46LLsA=;
        b=hvicvqXV0O2LdfcB4sJrRhxyh0TMlXSae0icfHF4V1zmDnwR3cfRBVg2M/rmuoyaWF
         h8e6dUGTAvCyuYR+MrZAgOIqRLIonb0NpEsk2ktDDnEj9VrtE/0HVmITx1F0CGbYSR//
         yi+kfmQwvyuVwcL5Z7gMI6S/fhJLS+ukvB0OUjKYzPR3ptZYsybLTAePHdMJT/aIWCqs
         +wosOVlM0h77gBR1kllC38UzjQVF46QSsoOiQHVZW6FPb/6SJ+LV++e5JiW9Mee8nYaX
         Vabr1Mch64Kle9qpK1Ctyq4DXNIseQiy6ER9WGFCavRuyREPL1rIpQaakF1EPG6+6NoO
         yStg==
X-Gm-Message-State: AOJu0YzzDHheMMW6nIc7TLecRlkRbI8yf2wxJ4wG4LGb0SJfwWjeEx6N
	VIO1k3mLM5fhhcvm9ILNEHR5mnOfjqWcrf7pv2FKV4aLhQRN00ZSsxuoEWq367EZwVc=
X-Gm-Gg: ASbGncsQkeuNIVwIGXjqBHai4sc7dgDDeHvzRmqexJNMWjZEunQDhd5APJBvUUz5NqG
	CGI1bsQbRAblz9M9qUAzXm/P5Yuy4j6HwMq0UYrkchwfHs4NSFF94VrLB4Qi38YJn1/xsBZv1dn
	nubTmQUSRWUDV/rAkWfQUcC8ilKGms6DmHlKg03zvNDgrliR/SZJl3fFY3shqPLbVBH+zwvOcDz
	mB3aHq0UvrsMQdjR3XQEI4dVE3fpYTe/MPfanpBX59hIAcC3qKRGjCZ0pgyPubZkb7v5lnSyfdZ
	KfB76TZfI3Lvy2eFJbEX/oIkeMAF7xWdO3+RskqBespMsrWo7AybZrC41qX91D8qQnx4pCOLCtN
	iQA/WIw6YUt+1Ps4x2Cs3CWqgv6ctqpPvX3rodh2Guzjm5f+7a4kFVd/EjylCp6WW2Oh76IQaqq
	kWmatfQuP9/g72hV+nLyg=
X-Google-Smtp-Source: AGHT+IHKI3XQBkBxfHfdLx0gpZ16Wz3vuAMqg+Tko1i9TXarf8MFb1q82xDwIkDYWvOkJteES4wzxA==
X-Received: by 2002:a92:c26b:0:b0:414:117d:3186 with SMTP id e9e14a558f8ab-424449d9c55mr15071065ab.13.1758146848530;
        Wed, 17 Sep 2025 15:07:28 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afa9f6fsm2346335ab.22.2025.09.17.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:07:28 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: support the SpacemiT K1 SPI controller
Date: Wed, 17 Sep 2025 17:07:20 -0500
Message-ID: <20250917220724.288127-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SPI controller found in the SpacemiT
K1 SoC.  The driver currently supports only master mode.  It has
two 32-entry FIFOs and supports PIO and DMA for transfers.

					-Alex

Alex Elder (3):
  dt-bindings: spi: add SpacemiT K1 SPI support
  spi: spacemit: introduce SpacemiT K1 SPI controller driver
  riscv: dts: spacemit: define a SPI controller node

 .../bindings/spi/spacemit,k1-spi.yaml         |  94 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |   6 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  20 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          |  19 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spacemit-k1.c                 | 985 ++++++++++++++++++
 7 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c


base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
-- 
2.48.1


