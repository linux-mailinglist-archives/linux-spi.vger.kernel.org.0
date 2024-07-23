Return-Path: <linux-spi+bounces-3943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D693A6A0
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850E81C209C8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223CD158A03;
	Tue, 23 Jul 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lzfkyCuR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2F13C3F5
	for <linux-spi@vger.kernel.org>; Tue, 23 Jul 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759816; cv=none; b=cjbXNHaWtuVu1xfOwVUNUSn1MB1TEdC29/T/+Siy78A+rmQufimK/p0nLp78qM+tAF4dSUHG5P4x1dmJAcSJQhRJgNYixgqrafPc+eEBFxlS5nO3ftDd300P3Hc7cKQlmIbO3EGmoV2cZPg4Jgr9dblfbG+Gca5jYWdVL5sQb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759816; c=relaxed/simple;
	bh=wCjAe5rysnyPHTE32w/Il9C+QuDxWjSafUc9QGpJhDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ie7AucPMQl+voIkHiED4fTT7nn5JSnHqglDGlEEHy/iL3urh90tLDNIo6zL9CNlesdmWTEikgVNiTaBcS2/Ra3q9K4KpYyF5YdVCmtChSHCKG4I75tSmkPah6sqv8f2MvRHM24E1xFLgUh3t5Zy6SLLCFwlGa1VWVq9x2QgVcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lzfkyCuR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7044bda722fso3378316a34.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Jul 2024 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721759812; x=1722364612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+UFYRZSUcd9DOmvcNxoBDJyVG+xJwiw5jLRr8VEv+0=;
        b=lzfkyCuRoMwFEPPToAps9A8OXa9eBj+yCwFIvxntR68Hrd33afxpl+7nCR2VaGdmhf
         tzsrBi93tLOwfkzkL6oE5MAa7A1kNjl/TJhbgPQAxJFtPkO5Zboe/VeXrXxh6gcU8ddq
         LbVRtGB6vSoCti7hTggSRL9p5lz5tfNNRLl3mDk0zvmCbOe9yZ1uoO8CQTgHVd5nq4zY
         63T5qyMEWkp1sZMWAC2cV1yBkq5eHHG6kN7hQk1lZkdpyUC4WV8JCU2YMFEMTIvsgQFP
         JsFg+uuEdsW5toyZnOEz6mQ77qITDNP6jCBPbgz0nuIShJEDOUmVnYPrtOIN+V1Z2IoI
         VF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759812; x=1722364612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+UFYRZSUcd9DOmvcNxoBDJyVG+xJwiw5jLRr8VEv+0=;
        b=wJAAFEH54kXO51p4lhRNzDxiAzNmSr0pcQzupDigiel4BGtiO2ba1uR9FWABRNSUIE
         +2TH0xLq+tecvKawh/PFKssbjNZryv3hxCr5JBQda6DGa7dirvryKDcX1/J2ei8GgIeW
         LGu51w15VdKYAASXBGUEcgXaR6wypqzQxN4MWqFdenZi6I8OUGRP/bbE5vWrodraqWD2
         bM4Xfk7POw9jgnoJinG0I7n4VO2YsaOqSCTZSqvJ6Cd0kg94O+Pi3J8q2MLH5MOc1HEU
         YqXBCu0dLFyE6dWGaanV2As//+EwX8H1bclKJK9ejALmoLJK5ZiQXrJ8GyY6ecFNpnL+
         N+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQZh97KAvgMoUO4etDaN3fMKQQP2clMuNOXgNZ6Yuuv1sYF5cx5zN60ZBgp7PGXZ0YBktUjEJKeo5tn20ULgfJs3NdacSlfaj
X-Gm-Message-State: AOJu0YylGXFf8NzxhFkmlIFUkvLioWwh4mur40gsBwFBh7wjxFoIEzjV
	wYWLFmZaKdzGpaWo3mNLI/pK1ExCdNtjN9t23LF5ADbU3iHMtGEV+zqOfpgBtbY=
X-Google-Smtp-Source: AGHT+IEE0rY9DlgVCA4eTLFv5LAFuDv0yqZEcQ2Yvr1s4IANSDqUYYNRsOGkILxVq+PW1Epg0/lx1A==
X-Received: by 2002:a05:6830:7007:b0:703:5971:70a4 with SMTP id 46e09a7af769-709234bddc7mr781730a34.28.1721759811906;
        Tue, 23 Jul 2024 11:36:51 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f6172f97sm2131109a34.54.2024.07.23.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:36:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: don't emit XFER_BITS for empty xfer
Date: Tue, 23 Jul 2024 13:36:47 -0500
Message-ID: <20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This adds a check on xfer->len to avoid emitting an XFER_BITS
instruction for empty transfers in the AXI SPI Engine driver. This
avoids unnecessary delays caused by executing an instruction that has
no effect on the actual SPI transfer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 447e5a962dee..cb3fdcbca2be 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -258,7 +258,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					clk_div - 1));
 		}
 
-		if (bits_per_word != xfer->bits_per_word) {
+		if (bits_per_word != xfer->bits_per_word && xfer->len) {
 			bits_per_word = xfer->bits_per_word;
 			spi_engine_program_add_cmd(p, dry,
 				SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_XFER_BITS,

---
base-commit: 67e899c7df7dd8507ab61a2e71fe6c8299afd427
change-id: 20240723-spi-axi-spi-engine-opt-bpw-e801253aa43a


