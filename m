Return-Path: <linux-spi+bounces-7002-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC2A4D43F
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 08:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13D63A712C
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF891F5616;
	Tue,  4 Mar 2025 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7khl/k5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760F1C84C9;
	Tue,  4 Mar 2025 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071772; cv=none; b=miJApc9poGYqdp0B9G4G9In52ZaSpUSOXED9p/h05KP04C55S2jg1oww8f++n1Ne5StQy0flvmqNNlAYhzhyd7+FFV+UcxwXLiYDuh7Hi1VvEhTHN/y0pLAEetQph0dcp6qWVl0kSapIHA31r73bGjkQEFYDmu2QwkvJ9ks8Su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071772; c=relaxed/simple;
	bh=3F4KPg6kdApnwuPSMqMXl6WB4aXg0NEIUVjnccX21H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZccg1sTXd5bMEdxfu9AvvsBp7UALUbbO48Z7kt80VInTtKihbjXhe6tlVp470Rzn4U/QjQaDpc2VpH0FCUD9f2a1hbyBGi3iWdL6Il8m5hSdmowvzMvireva1g2Xqs6TxaAJt3OGROyp3Bi7CpEe86ireheNboFw+WXTBQLSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7khl/k5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-474eca99f9bso25613861cf.3;
        Mon, 03 Mar 2025 23:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741071770; x=1741676570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJz6BfkcxZi7+2yZO1VkhDnA0gP6qKcbuW9uTn9T9LY=;
        b=T7khl/k5Mlq0yyz3cMgYqK1zm58FyC0xFXQ74ecE7LXPPp4Z4XbYKGzM93vRh2avGy
         BGVLpFk5fvSL25tA0CAAAOgJOwDnNjsYOJXbbU8E8JIMxDLYmMLYNX4gcLQM6HubR9gZ
         np8CYBkOO010Ux1UHuVcjL/0Gc9DKRZDgRzX3eD1+XNLLQc3MNGo/gCPvbkhnUy9+wdp
         qsp1FwHyF1xsiEyDJxTyNbx1bRDgWZa7xliNgWCTgP922EClwnaWUCkzwQuxAeJBiadY
         N6GxlvKiicv8ASM7BLRroI0KLKW6NRk1odgifxFFb9gEj+0A3LJfpP1aoqvWaV0opw2p
         0XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071770; x=1741676570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJz6BfkcxZi7+2yZO1VkhDnA0gP6qKcbuW9uTn9T9LY=;
        b=dd8LSqLWcYxIcvWIPzHJmmA3A/RNIiVbjXExEffX1NTQ0Tf+HIQGNoCI8tgc3ruVu5
         WhLRl2WGrktsXbQZuMU71gI03Ms3C13WGmB7kXx4oUh7LAnGuGM7UYtMrv6RiIBoMsvs
         CpVVtU34swKCGZ3euUoLIhpSe+i4uCJb3JzjzT3OOnBihGF6pT6l/Q4W2a4JlxT/i90q
         QC3on+Jq8uHLAGrPftxB3j3VKkeE9O1MPlPWDHH2nfD8WIg1jk9jHKOZyi4oQpcpXd94
         Hql31t4UFWynDPyBG+8EKLiX1NSySvS7aB5Tgca8pPmIEIbt54JaxGy1MrrGnl0dQCLJ
         hGiw==
X-Forwarded-Encrypted: i=1; AJvYcCXBiqoYJ5gSXq6ADCFMEf/qsKqzlKIHm2M0UZNVIfx6Rxbe7RRJtkdgljWdQlUCplG4feth7YOhQ38lOyM=@vger.kernel.org, AJvYcCXrH8Gby34OJ8AtxlSRYqM4MRmLAIMDD96GUpe3KqwSXtmWtN3pAgmJaFyPxLNwbwZcKkc7ok7TlLi0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wHpLELMK4SHYfDUENY1AuXh6RJFZMmSynBpntE5/vA4S/gOE
	Lk09c6zDmyIymJDxhwRGzEKJYXhpId7BpRXMnpiMHQ/3QRo+JN8f
X-Gm-Gg: ASbGncu2sA4bj9uvBCprDyVVZu2xxmNrAPm4htomFEaSrK5nrKS572r4a9gGwhPQZJr
	2iCSGwFLsAqQmWYBcNWLv3UjRddGdPEX+7iR8lfgbAdk07V2phJJpdvm5GIQMOYEYf2/CBs+psx
	sFkQHtN2H4To1KO4hEbp7lvKQGPNxoJsq2hIExTsKO8CqiYjIrqUyUjigZnln1HX5SD0nq86Yyy
	iJbq3+yq4V51fGkFECNM4n1XEorXk0biFBpfAgeMgAaSDyMJnEscfnpHmtkN1eQa12mA2895Mj6
	XeFBYUjWPY76y0nhIK0e
X-Google-Smtp-Source: AGHT+IEk1WlBwEaAMcEkHM8qOPE+SDf8cRN4LOjRnT6+91LmxAIZe1LjB68C9xMgI3P9EMe7+B282A==
X-Received: by 2002:a05:622a:148f:b0:473:8bed:7016 with SMTP id d75a77b69052e-474bc0f41dfmr203196131cf.42.1741071769919;
        Mon, 03 Mar 2025 23:02:49 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474721c0a64sm71642221cf.42.2025.03.03.23.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:02:49 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] spi: dw: Add ACPI ID for the Sophgo SG2044 SoC SPI
Date: Tue,  4 Mar 2025 15:02:10 +0800
Message-ID: <20250304070212.350155-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sophgo SG2044 SoC can enumerated its SPI device via ACPI.
Add ACPI ID for it.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index f0f576fac77a..70fdc4b6de9e 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -426,6 +426,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
 	{"HISI0173", (kernel_ulong_t)dw_spi_pssi_init},
+	{"SOPHO004", (kernel_ulong_t)dw_spi_pssi_init},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
-- 
2.48.1


