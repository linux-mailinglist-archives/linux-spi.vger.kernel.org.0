Return-Path: <linux-spi+bounces-9119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3816B09094
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF837B20E3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9783E1DE3C3;
	Thu, 17 Jul 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVf3JCjV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B862F9482
	for <linux-spi@vger.kernel.org>; Thu, 17 Jul 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766137; cv=none; b=Xfgl10nHkm1mDlKmG/8FSaGcmdinLqwOCCuAmKCQhZVXDdfw2sESmBaSJMXxaING72eegGbEF8Z3HJbNEluCxr4ljWLaY/jwrjJFJ3A+ANVUyNJFZTIZ/Sm9kluSJ4Y1i9TpgCaY7tJXwN5XI/DAdBi7vaZ037RG0/xNxqKmzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766137; c=relaxed/simple;
	bh=ZTybutIGIe/T86UdDmuxPEBUZ4/0J/+CghZD6UmpFXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NNA3GBU4d7IGKNNqySmifbFGI4Wh9KJtnIqLxpPT/wdFvKvTognqPNI5geesR+GVZ9U2bEdiwNJ6OcpZ2EHfept7ON5Q95jWfnd/9ELR8NcbpRZtXL1kSYamDmoU376oPe5wRXac1BTrXZ9nG8PqWDyQeWQCkzfVgz65RTlrm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVf3JCjV; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6095fc6bc40so942193a12.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Jul 2025 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752766134; x=1753370934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cthjB1lBYL4eZHBHey5xzm0tQ6bcoKzfDDKS2kEQSBw=;
        b=IVf3JCjVqMF9ojp8nfRsgSRnz4M67R5tdzbqcpt+DiKsKgU0t7AzvBkXOYCpBzk70E
         /aHe8VVl2IgwZd3WZ+bB9qyR4pv7H0QPO5TgHc2f83EpmmCaqmSwwAyxf/FiR0/hccRc
         QqhvRqHe7SMybx08Bl231ObAzCfZaESjJfnGan3GSGfoCbkVDTd0vPDWwkPBKH3i4IO+
         Tm2201YuQJeQQ/ByqcTP9P18YGewTgv8BfpqKyx1ZYAcAoNWhn2z+ah9HOTvOYC/gV6i
         LPPzWZYtF7278xFla67vHRJV8xzJTPz17IgTl7PHAv7rUTFKugTyVMcHS5cx5wr+d1vt
         xLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766134; x=1753370934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cthjB1lBYL4eZHBHey5xzm0tQ6bcoKzfDDKS2kEQSBw=;
        b=rXUBTweWg/YaFMR03U/RsDTD/s+cRAmYvjzaxDpTMn7iNmffk16idreoAR8/emUgtr
         4D+kAzeHYPoRKGny50srkQMO3FxFfbGCioXQo4Qzia+gqTGqhQAzzq1BiWgWUXdFpNLL
         Cd4HVRqQMiWpbL34OGSxixSt84T+WO0Gf8YcqAW2eQv0PqUgMD2piSGcqmTeWDjNe2Y4
         S+a1NOJzsS1/YenSOyxzYT5XcOfYlpFg0hVvuw0/+VgXKkjaYkh2M+cbyTeD3fRTgAa+
         rIr39ns5LkS2jUj2y5lTNUR2CIkZRESP59mkmMtKuwmq8OfCQnOY22PMoasaO0GUluE/
         4PxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh43NSR+cdkfehNv1yKbFiLFB4HTnULhKRstmQFlDgmkXJdWDVZ/jPs+bIs3JyPUyu2NPcxYip8ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3U2snoHec6HaJXhB6TZRAhab+Gei7lACSEORONGNIFFVLMAQT
	EjFp5vfqFNqUTpn4rmqzHC2puKWIgwNvvCrDFXXLURsGpabd0lIbPKeXd2k9uVGtzkNABFiaVIx
	Ucz0E6zRJNg==
X-Google-Smtp-Source: AGHT+IHcKFjMlNrrNgjCyppcSr//KTBbsIGPrwjAmE7PGmpW5re2EjYf1MQOj1siVvkpiPv/SNTkfwglWCmV
X-Received: from edqj23.prod.google.com ([2002:aa7:c417:0:b0:612:92c2:b49d])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3548:b0:607:206f:a25
 with SMTP id 4fb4d7f45d1cf-612859304ddmr5716235a12.9.1752766134233; Thu, 17
 Jul 2025 08:28:54 -0700 (PDT)
Date: Thu, 17 Jul 2025 15:28:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717152851.3709744-1-czapiga@google.com>
Subject: [PATCH v2] spi: intel: Allow writeable MTD partition with module param
From: Jakub Czapiga <czapiga@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Konrad Adamczyk <konrada@google.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Czapiga <czapiga@google.com>
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
v1 -> v2:
- Fix typo in the macro name.

 drivers/spi/spi-intel.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 5d5a546c62ea..6428e7de1aec 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -189,6 +189,11 @@ struct intel_spi_mem_op {
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+static bool ignore_protection_status;
+module_param(ignore_protection_status, bool, 0);
+MODULE_PRAM_DESC(
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


