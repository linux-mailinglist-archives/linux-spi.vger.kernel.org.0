Return-Path: <linux-spi+bounces-9100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E61B0570B
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BA9189B085
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D8C26A0ED;
	Tue, 15 Jul 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vov71AGM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E425E813
	for <linux-spi@vger.kernel.org>; Tue, 15 Jul 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573013; cv=none; b=DSOzYuaBMIMA6FTdDteVdR4tamscqWa2m6+mMSJnFI6kpUWtJJnvbKUJL++xHILEx4XTyw0exOaeWiJxa4zi9Y80vp5soJKKxUM2tirCyqLu4jCmpQtCB+SttO+kTjzFQR1R7+ASa5K1CLqr+irVupsyqiu7ebQgpMy7jZ7Zczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573013; c=relaxed/simple;
	bh=wruxt6W1EKNfHqctolzOd8XLuzn06vOEl1Dk62z2TiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bA/ZcQpHK/TKFgZ8DFADo5U/jn3D9FMKK3lrerCL0vErDHkXoP1Bio/+sq1Ix2bCAdtLSb2KZ+mym8MtVy0vcbd5oCpYqX2CkFohIrikiU/CmWnEZ5mEuo233VLuHnTVyoeinZd5TFnwmBfHUG9lbOVzd1eiGfQCidu4RGZAWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vov71AGM; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-60c4d140b4bso4356902a12.2
        for <linux-spi@vger.kernel.org>; Tue, 15 Jul 2025 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573010; x=1753177810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHTlVUx5DqZUsuPP7cnXeDyrD2T4mRFc4Wtv3aKjfJ8=;
        b=vov71AGMZp296PYtvAGaTUlWZzqfLnj6hnhCrncGcCDwuwh1TmImZHe+9okpv2hgNj
         ZCMv1K41quwDqQRKbrgZRkvGWeyRRmfAZKFIcu2IRcuaUY9jvo3xTexC35BjflAaDDQ+
         jqZKKfkJApF4BrocjuYM99G25gD9fz3Sg1DdirH1RAL1GuTbuQAkRK1eFS56uEe21ist
         ub0j/KPCTvgOiIzj5nbvarYV0kMyFdpN4I7j/2kuSma/7bMYFA97h3QTpegNkUV02D9h
         rcsL5Fg4NhGqOQ83thuv2YhCCR9Jhkuw8ajfO5kN0yotbh3Wvw3/a19GDodMSH6E0ftN
         4vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573010; x=1753177810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHTlVUx5DqZUsuPP7cnXeDyrD2T4mRFc4Wtv3aKjfJ8=;
        b=nCg/j3hANRGBs16pBRCz3CF9re6UQuJFmfDSaYuwPS3jiW5YW0MRI4wIOvbWoY/YDH
         l9E+7ps5qshowf1RHenJRd4jKLDmJcMgLSpWnasFQUUSlrGgpyMpOwnrQKRINN7qAVaZ
         ZW3KOQc2eNen/mJ7gTjeFsk1xV9ZR31aPY7bgLswvhYzRCAZFppDrGkkoqnKx/8QO7AL
         jLlt1zZXmqBoNCjQY8xg1nmn6rU9yb/FEvcJI8LTVEYvxY+1omyC8Cu9U+l/UJ8W7yAQ
         RPNlmNE6LhlcFaj96Lzs2uZmDVtFwNtLmqHT7ltAjfyW0xWUrkJfcJySzBMmOcri5JKN
         u/gg==
X-Forwarded-Encrypted: i=1; AJvYcCXL083f/z8Al7hyh7AmitPSNIG42taP/gbpeecTq/2SufNLzsu0He1rkQofUQbGTRz3ylObi2ntA5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0hBA3MhqeN30TIHESnnv3Y8vGxzzcTrP97U0JLmMsa/LrUPd
	9S2NtNQGJ7iUEjeERmOB3exXzS2T2iQyKtjneA5qzZPQzu5v08zTl5atz6SBGO6kdo/2yfbpt9v
	cfR2adVG0Vg==
X-Google-Smtp-Source: AGHT+IF4xTtuN4grGlrf2ySduGrYS9dG31ff9QUW2wnvANZDmyWQD/+00BdyXJv1mNjORwS5oq/itc7fML37
X-Received: from edaa8.prod.google.com ([2002:a05:6402:24c8:b0:611:d3ed:63ff])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51d4:b0:607:2a09:38dd
 with SMTP id 4fb4d7f45d1cf-6126b6923c7mr1800812a12.18.1752573009965; Tue, 15
 Jul 2025 02:50:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:50:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715095007.896620-1-czapiga@google.com>
Subject: [PATCH] spi: intel: Allow writeable MTD partition with module param
From: Jakub Czapiga <czapiga@google.com>
To: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Konrad Adamczyk <konrada@google.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Czapiga <czapiga@google.com>
Content-Type: text/plain; charset="UTF-8"

The MTD device is blocked from writing to the SPI-NOR chip if any region
of it is write-protected, even if "writeable=1" module parameter is set.

Add ability to bypass this behaviour by introducing new module parameter
"ignore_protestion_status" which allows to rely on the write protection
mechanism of SPI-NOR chip itself, which most modern chips (since
the 1990'+) have already implemented.

Any erase/write operations performed on the write-protected section will
be rejected by the chip.

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/spi/spi-intel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 5d5a546c62ea..9b41cf9caa5b 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -189,6 +189,11 @@ struct intel_spi_mem_op {
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+static bool ignore_protection_status;
+module_param(ignore_protection_status, bool, 0);
+MODULE_PARAM_DESC(
+	ignore_protection_status,
+	"Do not block SPI flash chip write access even if it is write-protected (default=0)");
 
 static void intel_spi_dump_regs(struct intel_spi *ispi)
 {
@@ -1248,13 +1253,15 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 			continue;
 
 		/*
-		 * If any of the regions have protection bits set, make the
-		 * whole partition read-only to be on the safe side.
+		 * If any of the regions have protection bits set and
+		 * the ignore protection status parameter is not set,
+		 * make the whole partition read-only to be on the safe side.
 		 *
 		 * Also if the user did not ask the chip to be writeable
 		 * mask the bit too.
 		 */
-		if (!writeable || intel_spi_is_protected(ispi, base, limit)) {
+		if (!writeable || (!ignore_protection_status &&
+				   intel_spi_is_protected(ispi, base, limit))) {
 			part->mask_flags |= MTD_WRITEABLE;
 			ispi->protected = true;
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog


