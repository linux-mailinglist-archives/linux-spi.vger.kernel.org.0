Return-Path: <linux-spi+bounces-6818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C8A355C8
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905153ACA16
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 04:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53D15198D;
	Fri, 14 Feb 2025 04:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfIf35En"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6312753E8;
	Fri, 14 Feb 2025 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507639; cv=none; b=Z/qQvKP3nIa4Xy0YnJwA7zdZa31mvvS9XDQkwNgTfQ2uzf8HrIqSLRowKDRipdTBdOSnAxLOhcfozQYUY+DHFNM3MEIG1CsN0KAN/BMGQQRsOHTCGR55/J6xIcEQQlGAcnxxV6iDFAvFq+pR4cmfE8TC/cvbdoIOrBuJ0ZG89zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507639; c=relaxed/simple;
	bh=USnMmjcoarjWB0C7UysmUD9xHH+ezCjgWDciylajuVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ssq8R+3wjJwOQIvYPTSDvYjL4Dd3hTrEg/kvQqRnp5kyszAmidYFV3QrpZbE7iRpWm3v4JptyyppLwpYR9ZmqflHY2LfEvYGIvdVT2t2iI9wMPOS+dZ1U0cmyFqgii5gfJ0df+qGYT1pivk5gMq7xAftF9HzSnz7CQFo024Kj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfIf35En; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86718541914so1474868241.1;
        Thu, 13 Feb 2025 20:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507636; x=1740112436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=siVlNf7+kZiCwEjKhe9SG338WyTZGu1DUBJ8nqaHKqg=;
        b=YfIf35En7fdHS1exXYmyTmCSSfx+6l5FPgR52iKrw3qEBze76Jjbk8n2qm0IKH26dt
         K41gVQlOD6CxWQZSkf7HLsM5aXVKv8Nrvga5UR2sFf6kptsRBCnsImck8NomyMJJBX/4
         k/0lTI4Yq6piv0Y9+TdqrpadNpsBOVsNPlnoqlF/6vcjuRvDSpSZHplAn1Fqn1x9w/Q1
         k52ZrjZQpYZ5f5FIbQ9Mf/jXT/ngeccsL8MhBHWovedQby4FlBXXhBT9I3GkIeafG8Nx
         jg/D3JY7uxkAhvGnb1NZu615dzlbqawiiLi/U0w3LLvJqaF+TLeLCnuMk5fzZzHYy+LZ
         7JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507636; x=1740112436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siVlNf7+kZiCwEjKhe9SG338WyTZGu1DUBJ8nqaHKqg=;
        b=WgZzV4bVMPLw4D4reO5sfAB6s95Zh3+6J/qZFDxaZ4dwQGACAcL1kVfTaSYVNi77CW
         2EzVp1s4pL4hTOQsCZ2RJoM8w4k20iOiVnPtv1cD3sBj4I1+4GzdN4g4WhENUGzEGOAv
         3oExk1rSXOp08DKDlj7y33trcvxJL62kdrXz9F5cRRVsb7Qa8cWUNSiKcnui4iyqhe28
         ZGNIeNOsF0B/siNM+lfWLz77oK7qf0QFsYsR+1KiyH4nrq4PNDP+FnX6gFNjibo4iGqE
         i/RDOpuLRasZIrQRDMtOf9vanyhaYbPzMLkPBAKxNhVM6tIJ94x72xvMKBzF6R9cZ/sg
         h1cA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9b04+lVdjafwUC1VwObWr1VttB7q+/2OTZQF5Nv1/Siku1RgTTf2CAIgppS1UlCZlvM0kFbVmCNP@vger.kernel.org, AJvYcCVkfGlG6ewtR+U5MO4kIU1KaJfMp0bWVpoDTCD0mxNdWsSdsZ2hRjfpSRUhCqa0zt2rPShG4MvJ8MwvwUPv@vger.kernel.org, AJvYcCWWrtOpcJ8GQXcpI1M7W58aYxh3BxfnYC6reoMEeivdEJP3UV5F/NUnJ9N1dkxUp1tFSRNihkHoCC4W@vger.kernel.org, AJvYcCWwk/yYzJ33vSTDOXADMD7CQ6h2YRr377VD5vMeVJ655pVIwam+9OqPIJbtZ+hTLAznmR3XQXxST8+e1lbDMawgSMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PbMX5MvhuSmT8XSGTbI2Mq73EI3F87ow4oZCgexSJmDr/0ZG
	Nyj/CsYUGKHqbBzRWDVhsXoxEpy+aul4OZsnykXoNv5JsmKrJ5Z0
X-Gm-Gg: ASbGncu9tTajSZKz5pvDQmGYkg6nTc3dq+p771IrQpOGwLwFsrM06Z48NgGSXb16ukR
	5VkbrbzH5/zYAlgg6w9fZcdF8aEnJLBP+ZTujo6IKB/ZVnjEcfE5jsnd2uZ/VMmc8w9Rc2gqAv6
	heudanqBImZjlQ00nn8qa2VSTAyZnD9RNU9ljuomapFGrHmxm8/ornxB/EHyHq5R1HMnnhUTX6k
	mHchqxMfgqtEiBhvYqGu370JwKftQteOM3USnY2SF4RQA1LR02vf/fC4zHyxOpNaXhj/EhRcGn6
	rlT0WRzINSMgF7PoXUwt7JMzaVeQtSuf7vpxGDXV4WBSWKfobN3JZrtUD2uPnLgKeIGirERjddh
	63g==
X-Google-Smtp-Source: AGHT+IF7RYcNLcFYj2hbuk8eDkpTmpno/O0WPJ6Z+8th4nlcCQC4glGWXBaW+GS0fZag6OAbmKZLlw==
X-Received: by 2002:a05:6102:3f11:b0:4bb:c5ad:af1a with SMTP id ada2fe7eead31-4bc04fba69dmr3988014137.7.1739507636407;
        Thu, 13 Feb 2025 20:33:56 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e857f2desm422800241.10.2025.02.13.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:33:55 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v3 0/3] spi: s3c64xx: add support exynos990-spi to new port config data
Date: Fri, 14 Feb 2025 04:33:40 +0000
Message-Id: <20250214043343.263-1-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
configuration port.

The difference from other new port configuration data is that fifo_depth
is only specified in fifo-depth in DT.

Exynos 990 data for SPI:
- The depth of the FIFO is not the same size on all nodes.
  A depth of 64 bytes is used on most nodes,
  while a depth of 256 bytes is used on 3 specific nodes (SPI 8/9/10).
- The Exynos 990 only allows access to 32-bit registers.
  If access is attempted with a different size, an error interrupt
  is generated. Therefore, it is necessary to perform write accesses to
  registers in 32-bit blocks.

Changes in v2:
- Added a default "fifo_depth = 64" to prevent crashes when "fifo-depth"
  is missing in the device tree (avoids divide-by-zero issues).
- No other functional changes.

Changes in v3:
- Reordered fifo_depth handling in s3c64xx_spi_probe() so that the DT
  property takes precedence over the default value in port_config.
  This allows node-specific FIFO depths to be applied correctly while
  preserving a fallback.

Denzeel Oliva (3):
  spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
  spi: s3c64xx: prioritize fifo-depth from DT over port_config
  spi: s3c64xx: add support exynos990-spi to new port config data

 .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
 drivers/spi/spi-s3c64xx.c                     | 29 +++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.48.1


