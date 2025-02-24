Return-Path: <linux-spi+bounces-6886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001BA41A71
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB81885B94
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACD24A047;
	Mon, 24 Feb 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIMRpB+3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6D242934;
	Mon, 24 Feb 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391966; cv=none; b=Wuzf4JRz0MAYnhOvOZ2ZXIXxcLPFPbduswByTTYohzEyXA3/Bj4nhAAOV8EF1n4JBLscwY2hCKp8X9gdw0yei1+BaOBlmYjfa5Lk6ya/3qXKaU//xiu9Vg6aC1hHiekP29x7P2vJlHLJohVLE//yv1I97Twn55H+K1GKLBDuI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391966; c=relaxed/simple;
	bh=9Bqo94YHiFiKkOBkFOEIOCxQ9JWo07gI933V6qyxAy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6CBEko06mAlySZ7EISsyV2A/3WQFttJe8VuztEHoLF+y2xcn7gze+a7T2PrZLi7a0XkB9PVRZD44Sl+qdHmdEe2HT7AuOFXq27CkoaQX8ZMfIGUdVAWHk+xfQ7w8cIAJ4kBwS68TRHGsxa2ixfk2lEeVcMmP+bskqByzVD5HAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIMRpB+3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-222e8d07dc6so10401985ad.1;
        Mon, 24 Feb 2025 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391964; x=1740996764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPGO+zy6qEo7yGIQSUB6POZKOvKXrvFXwU9PL0lZRak=;
        b=lIMRpB+3Qn4kZENj7iSXBNOur5IBiT+RZzf2knmZn0q/5094+6NAdh8AUjhFxrkNtx
         ij0phMBHvosTu26EH309V7UMrTwZjkIG6K19bJoT82T4iouxqzIxnv3vSdGRp1svdoDD
         SjedUH4N17hGCP6nGqt5biR1O4ELeib2wNAXmQGKuJ5Kjlw67j/hjAJMr+m6IUC4qqOv
         ApJTQYeDstCFJ93m5+/5xzoTxjj6nhKCiUR2PC6KGQ605doZb44deMUM2L63oxM+KJ3b
         8O4s6BG/y97HZeTJ6c5eBcGv6fv2HSZZKn5f585bXdIsSKzN/snikQCIUH/YrYLUST/d
         SR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391964; x=1740996764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPGO+zy6qEo7yGIQSUB6POZKOvKXrvFXwU9PL0lZRak=;
        b=Tt2X+8PHP7xk8GuU3qqff+bE4GTK8aJvzrZUQPPcENwRJ6PALhQjUTKZ/cN7AXnh+P
         czAPGTipNhTU6bPs7XObY9tLnio0lO4mB8o07iYqxuVs8p09wx4Y5gP5Lw9m7fGiMl5K
         lfkRtej04LByB02vOErfj0ME20LPyfspM/KgYATrhRDbvtQbuO11MNjnXetfXLCddkp3
         3Fs3SFPxlxjydc/2nUj/ez3DxKi1jXGjrsc065GIh8zpNpNFvNrHw/2/aplpvWdhCEGl
         34GJaI2aLUK/a+FBHABFFz9NSgl4ZonaA/Xp/VrPcC1s3150tgw8RG9nZQyNWmhfy9Qb
         KnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4laEwfR/6HN7viuOYK6nBcA4EqgSQ59NHYzkqFx8GnqmyJiifyW1fX8GgVCv3nXiUYxWRT+tx0B69RDy@vger.kernel.org, AJvYcCWo2HH3MscHYy6Tz/9rByECxFAlQehZwMKzsqOZr6l+yXXAsjRkN/dpUvDyYpzVSpD7hVXjZWPocEFA@vger.kernel.org, AJvYcCXUfKOlPQ8HAs45J82eEhG9m/dpDa/jXusUcGfpVBDGZc9W3BGOXvAXapxWP34me0y5fH9d1ogtKZkO@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/SXiJbBIt8WJoCzszTYb7p6N7sBYm4mrsExv0pMUMYj68N0b
	KCvQBjUkVXCHllnw67Tl82z5mbxkQK5HkGWGfrFZ5cKsAmj3VpXR
X-Gm-Gg: ASbGncu/PAOOeZMetIlBZ3WawxQ+bwbayth9uIdBtMma5kcgg41X3GraUWHw9E63S0T
	q4fPNjUa8iWIrJlch3gY6M2HMe3mWqA4VPdSpswyIOE3y5my3bl5v9SNgSrM1FRwLINmd4myhmi
	mLptDvLWjvzaAtM+4V9gN40so0donu0NxncSI2gGgVkC25vYwyd8v8vc5gCdGj1Ang68oXR73fh
	PC55TV9d3+hUki+0phqV1ewHSnHT9xbbuYBptq0jwnJMmq6oN3M8BjGx5jvuPTpCqza3yE4bm0p
	aeUdBBhuyZO3lrE8Py9i
X-Google-Smtp-Source: AGHT+IHjrhSY3sFSqcYVrgR3HWHG17PPt8fPA3aXE8o1SDs3Jub8Wamh6wMCeD3ZCxlYYk/Q13AOhA==
X-Received: by 2002:a17:902:cec1:b0:215:58be:3349 with SMTP id d9443c01a7336-2219ffa04dcmr239987545ad.14.1740391964148;
        Mon, 24 Feb 2025 02:12:44 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a464f1sm173274365ad.206.2025.02.24.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:12:43 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] spi: sophgo: add Sophgo SPI NOR controller driver
Date: Mon, 24 Feb 2025 18:11:59 +0800
Message-ID: <20250224101213.26003-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI NOR driver for Sophgo, including read, write operations.
This driver is only suitable for NOR flash.

Longbin Li (3):
  dt-bindings: spi: add Sophgo SPI NOR controller driver
  spi: sophgo: add Sophgo SPI NOR controller driver
  riscv: dts: sophgo: add Sophgo SPI NOR controller driver

 .../bindings/spi/spi-sophgo-nor.yaml          |  52 ++
 .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  |  18 +
 arch/riscv/boot/dts/sophgo/sg2044.dtsi        |  24 +
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sophgo-nor.c                  | 501 ++++++++++++++++++
 6 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml
 create mode 100644 drivers/spi/spi-sophgo-nor.c

--
2.48.1

