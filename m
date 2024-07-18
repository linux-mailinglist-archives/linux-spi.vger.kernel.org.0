Return-Path: <linux-spi+bounces-3891-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50819346DB
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F0B282365
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED636AEC;
	Thu, 18 Jul 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPGLe0iK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC12C1AC;
	Thu, 18 Jul 2024 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274458; cv=none; b=Wc32ajfbZspuKF5olNZvRZsuZH7Y2Sct+lKqXR2mNqcQBnsSdREvwxki4wSWssmyFCTtQK1w4xrKxRXUUdn3hESXa1MCSoc7sqdBmD/u1Jv8iZPwCwtjhtxndL44yCo8wHu0cHYQ2jIaqQ9BP7UBSfu3X7YmXH1lP1C8v08tzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274458; c=relaxed/simple;
	bh=toWkYc4Ctwc06/OlNCQ0sQyYdV9skpmiyoNCmJi8o3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PTdgcYpNxMMgb4I4DaaAjb/67y4JwDAZCCmijVkkQ7Re54PmTpGIy04Y/BdrcALtYNZqVuf5OBOKBk9l8jURTWviOUxAy+woINsj6+QEr4xL1B5OTnK8Es7qrT2gd9SXbxjsSQX3CbBAYtu+BkrGATsiLtPcfE5S+loy2aRT6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPGLe0iK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-396eb81a1cfso139205ab.2;
        Wed, 17 Jul 2024 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274456; x=1721879256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDh6Ql+TGdlrLagqD7b5t329MBkSs5xxrsa8OqakPWc=;
        b=MPGLe0iKfDXuwpMjVL7sCDzJm8FHQmIAYGcHSBep+pD5FcBNsJ+Eep/3IxNoo0pde4
         hhoNydKhG05axB034SMMAJiN1qC1Aao6UKnLua4zfzp1m4EyC/XRicmc7DS2z/59plGC
         PjSaWiuJen63CRrhEovPWvQvB2IEozOoFAXtrOpgds0uUgoybrm1dEUSa5XmIsLuL/sM
         fDIzEY2Ir/xA0eU1hwXfUlKf0qDp2KU28BnGN14sTSbdDjJxqVxmua2epE0Y9z2eiEgw
         Kj7xjkCKO4z+jhf/GihSXwcHsENx4/iDr89CzmU/v6QS4pUsgGl/RZtw3amCaO4CzQUL
         P1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274456; x=1721879256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDh6Ql+TGdlrLagqD7b5t329MBkSs5xxrsa8OqakPWc=;
        b=pnBQ/ouDj05wihmvSz7pjNebnhYfALyr9o62wg1HjQ2RV5WS1W/nQGLluq4/12Yjcp
         l3xoxfwtRP94Da/qqWWMI8ud+j/hc0jCniU7fI/sc18P59eFXcFbBwOUujluY3FWAnWk
         R3qDy136KjCqQ/d/RamMCpM631ZndDmK9uhyK4zPBaYKxMtXJO5/lMDXOm35B9sw6+cL
         67WgrC65OkPfLpe4rhBujljeJeuuyOWCoetarVMb2vZTlCzmvfeQ/PXNCYjWAuCdHnYR
         KdUoWgGEC7Jf4Z6CZQcELfSLhnwI8kcIqNxGvkvGNeVwcl9cdgCJcLFPov3wUX6AloDE
         IR3g==
X-Forwarded-Encrypted: i=1; AJvYcCVh8YyfKtBuKiyJYA7YQVZSY5WkVZeqShmCziTccYbDO4H58evBv3T6NwQXX3UNyeW5ZQgEMJ0LEye+bq0iieb9m20Iy624YrzWXquIBvjJ/+wDCtqt5k3Yfb8KC+qHC5wD82Sm5B+V
X-Gm-Message-State: AOJu0Yz1WkKD53I7bvGQ3eanei2a4BKexyH7IdBdorkrFgdbrXkyWBys
	32NBtPAddhJ9I6K4+V4rBmSeQYv7aCX487du3MgDEey4W8qj7DIM
X-Google-Smtp-Source: AGHT+IEslbSVdfarj8VF3abfpeoMwQof3aoz3IYeXUjuJa1oSpr3Ne+IxLanbUpayuHh8H8+p2mXdw==
X-Received: by 2002:a05:6e02:216d:b0:375:c9f0:5297 with SMTP id e9e14a558f8ab-39557425460mr45169865ab.26.1721274456490;
        Wed, 17 Jul 2024 20:47:36 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebc384bsm8946018b3a.70.2024.07.17.20.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:35 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 94805800D3;
	Thu, 18 Jul 2024 11:56:47 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>
Subject: [PATCH v9 0/6] Add octal DTR support for Macronix flash
Date: Thu, 18 Jul 2024 11:46:08 +0800
Message-Id: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

Add method for Macronix Octal DTR Eable/Disable.
Merge Tudor's patch "Allow specifying the byte order in DTR mode"

v9:
  Change the name of the configuration register 2 for Macronix Octal flash.
  Fix the bit value in __pad of struct spi_mem_op.
  Use the local variable proto instead of nor->read_proto.

v8:
  Supplement missing S-o-b
  Remove function spi_nor_is_octal_dtr_swab16
  Split IDs by MX25 & MX66
  Add dump of capability in debugfs
  Add dump of params in debugfs
  Add dump of reult for mtd-utils tests
  Add SNOR_ID(0xC2) in last of Macronix ID table

v7:
  Add dtr_swab16 judgement to enable/disable Macronix xSPI host
  controller swap byte feature.

v6:
  Add byte swap support for spi-mxic.c
  Remove flash name in ID table.

v5:
  Remove manufacturer read id function.
  For increased readability, separate Flash IDs based on whether
  it supports RWW feature.

v4:
  Add patch for adding manufacturer read id function.
  remove patch "hook manufacturer by checking first byte id" 

v3:
  Add patch for hook manufacturer by comparing ID 1st byte.
  Add patches for specifying the byte order in DTR mode by merging
  Tudor's patch.

v2:
  Following exsting rules to re-create Macronix specify Octal DTR method.
  change signature to jaimeliao@mxic.com.tw
  Clear sector size information in flash INFO.

AlvinZhou (6):
  mtd: spi-nor: add Octal DTR support for Macronix flash
  spi: spi-mem: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
  spi: mxic: Add support for swapping byte
  mtd: spi-nor: add support for Macronix Octal flash

 drivers/mtd/spi-nor/core.c     |  4 ++
 drivers/mtd/spi-nor/core.h     |  1 +
 drivers/mtd/spi-nor/macronix.c | 95 +++++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/sfdp.c     |  4 ++
 drivers/mtd/spi-nor/sfdp.h     |  1 +
 drivers/spi/spi-mem.c          |  3 ++
 drivers/spi/spi-mxic.c         | 17 ++++--
 include/linux/spi/spi-mem.h    |  8 ++-
 8 files changed, 127 insertions(+), 6 deletions(-)

-- 
2.25.1


