Return-Path: <linux-spi+bounces-935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C417A84545A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8125C281611
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD24D9F7;
	Thu,  1 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtL+jfKV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33033C468
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780643; cv=none; b=SMNuLZt05P5Wxxdg8hmxHPTmPMTWVXho+WX6Ya80PbbsI1JBZcvo8alxUOuOR3tKACdfYQ8tXLqvKGilQ9MvpgJhFIcLUBSnWDeDpLg8Efx8z03QBiaRdpctLjdF5hPRM8F6TwpHZtvEADyVwuNVDqjC2Bh85dhX5Fqu8RHC8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780643; c=relaxed/simple;
	bh=eYOZhaINVUhq/Jdo9fhim7S6c+OH6eRrLM6SYmkPOSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhU3jDqwKAIG5/NbHqvfd2vXqQNKGJ/ieTJRb03IhePMV2VbwbGBw/scQQJkq4z2DQa/+1UFCICn+4Xcz5LbKeb0p8gzUgroi3P6ETmfS0C0tLnzy6ERPyTzr3cE5dN+7Revcmfd9hbaEQPZvBNdQop50/54b+/y0T50BVqj+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtL+jfKV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d93f2c3701so4090985ad.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780641; x=1707385441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss0g81yT9wKFWo2ZDitmqtrp4zEL5b51ea1juRM0Zrs=;
        b=jtL+jfKVpl8Y4RO7jatB0Ud4mmUZHTZsoQXsSk26Wg49YcblVatTPkfUutOShDvIHc
         P7vp8AlM4TSsnpSR5hIgFTMwUFbz6pLnRifzeVKE7c6jo1KxjFp4hJVGzseS5G+OGv2X
         eYoF+SWDA+RuKSpLrcMe+FXNYkQGFJLyrNj7lsWRsn03XlLY0Hccx5tbUoCu7LJoVZzR
         vtNhFRXMeyeHIjEkczwExyQNUGgXWt+Eu4jFXrQm5xryegTeioxqtCxjarFqkXylcF77
         ZLph4N/jVeeV1NE71CcvWFwsCg6HYp4lWL1J34xEEFbDmpSrCK3YXHSjaYVpmpWGmRj+
         30VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780641; x=1707385441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss0g81yT9wKFWo2ZDitmqtrp4zEL5b51ea1juRM0Zrs=;
        b=CZaykQhO+C/w+EMvADB14QolTy6t+fEwvugcx4dBU9LfEWJyihRJdZZ3xbFwGCcLMv
         vXt0hHNWK2xbubern2+nWfRvvCZDBacIdFYS7ptC7Bn4iyelCUBmsKIwg8DiXxfNvBUB
         FAFM4q5H/tSan00bxnCg0Id2jlkIrckZ1/3zbOtRK62Qy6rkcs35eiY2sPK3qkcG4hDh
         +S7gktMWrvEjtGHrpjASBP/YhIN9kAl1dD2lduNxybzkQb79ITq04Fvp3ZvLcgs8SdRR
         6+zM//S48maezS3AoVUUXkdwDKyKYy7OBiUJpI58+kQfuAN5Q9+DLofBrLuRYeAb+kE/
         KUyw==
X-Gm-Message-State: AOJu0YxfndVjfc55jp1ZE042C1BOsUrI6Y8nF0YCYOBmOZnqAnZcaczd
	2ufcgO6np07UFdvFQDhT6VOQeV8wZXnLCaNfnPOWZKpGGhb65LUs
X-Google-Smtp-Source: AGHT+IHf6QCg39RRgRDgdcGuFr1Kao9gOXa1qvRZhMQpEpoPKQ8ek4HSeixoDorqxT8VmeR6jvCkWQ==
X-Received: by 2002:a17:902:ab83:b0:1d8:deb5:3390 with SMTP id f3-20020a170902ab8300b001d8deb53390mr3301038plr.42.1706780640889;
        Thu, 01 Feb 2024 01:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWtE9lhj2AhOrYca3MMGemp0z/sV6d7fOfQ/L17BuTp0zSqeJjZISTmQjuaALLQwfQQW6gU0eKVv5KvlWQEHUU+O7mUKyKjpDiu/yGj1NijZ8bm/n48xfdzIUIJ2Qs0UBNjWpMF04zxaHQj9ZbLwz9/Xd0p+2LxLYVoWGmX4XemlMcUiWMQlg3X8j9XB2m6RGnqSche/xkqsrLV8N/1vgeVIWPtCeTI0a7fMOO+SPhqPHzazrL1FTkRHV+58qMGIiOqm3EyyJYcjNGyCkvsKRwp42Xq82T/rz8gajN6CB9mGh6KdNZIJDFbXXJqN8g+y+tAtQ==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001d71ef6afe0sm10481963plh.103.2024.02.01.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:00 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id B87E280671;
	Thu,  1 Feb 2024 17:50:00 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 0/9] Add octal DTR support for Macronix flash
Date: Thu,  1 Feb 2024 17:43:44 +0800
Message-Id: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Add method for Macronix Octal DTR Eable/Disable.
Merge Tudor's patch "Allow specifying the byte order in DTR mode"
Add support for Macronix flash

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

JaimeLiao (9):
  mtd: spi-nor: add Octal DTR support for Macronix flash
  spi: spi-mem: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
  spi: mxic: Add support for swapping byte
  mtd: spi-nor: add support for Macronix Octal flash MX25 series with
    RWW feature
  mtd: spi-nor: add support for Macronix Octal flash MX66 series with
    RWW feature
  mtd: spi-nor: add support for Macronix Octal flash MX25 series
  mtd: spi-nor: add support for Macronix Octal flash MX66 series

 drivers/mtd/spi-nor/core.c     |   5 +
 drivers/mtd/spi-nor/core.h     |   1 +
 drivers/mtd/spi-nor/macronix.c | 169 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.c     |   4 +
 drivers/mtd/spi-nor/sfdp.h     |   1 +
 drivers/spi/spi-mem.c          |   4 +
 drivers/spi/spi-mxic.c         |  17 +++-
 include/linux/spi/spi-mem.h    |   6 ++
 8 files changed, 203 insertions(+), 4 deletions(-)

-- 
2.25.1


