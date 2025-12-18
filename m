Return-Path: <linux-spi+bounces-12025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDFCCDB47
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40493023E99
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FC2F3622;
	Thu, 18 Dec 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwzfUog8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCE258EC2;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093708; cv=none; b=BJf9nlp5Qr1I9uE+nA02PEJTC3/c+uKaRgm3dYmLQirgacBmJfnU6Nq8bySrgD3kd1I1HveVJDDSVZl0/6Bxy4OijfPIFdlPuO0A2ONJUhzttTEvRK4lEWsvFRAoeLIcWAllccEQ7FGreAh2Zw+7ud04LgmkggG9VWCtPH8iHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093708; c=relaxed/simple;
	bh=CaTsMkKJSLp90vMn5/MV0Z5pzDnd9h/1Sh1EfZProTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RlGmNbGI8Gc9bUmKaDUthzgzO6Ycdoeaxj2bL2UCFaLUQ/UwV9zUEbGp/TvFN39uW/zmp+iYsd09yeGr/K2b6nfTya0Sh3/6FgqK4Z/Rf+rP20GAWKwDI0a8jN2rHrc0s0+qnr/vDXRhLFXI9W/uIUSMb95bX/pe65RcCp00Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwzfUog8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70344C4CEFB;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766093708;
	bh=CaTsMkKJSLp90vMn5/MV0Z5pzDnd9h/1Sh1EfZProTA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rwzfUog89eFHQS/LqHxJu+V8rVSKvQPQMqVHT7SpN/ltQecrdkM0dx1wU04MkQsD9
	 OZwGSo8CUrJij8loyZL2qxB+1GmFqXyhuTcFhqMWQ2RWSKQQThnm8g4vC0vy6rR9oh
	 9AHCX59Xw/lNODFFdyUz8JGVNmR+fgOGIEP1I75lV0zndFXc+dZgV5EC6UQzCTNW4j
	 xZAkF1Xm8e5Fe4ui6zqVkcC9kFh24bQy06RxEPyW8wbk6HW8my20ma++M+pRyHf6aj
	 XAh+kzss0+Z7oMMLjN18ypNlMK0c/FZShgplVIWMsIKC2kiPCCuXSGQMJjD/TK+ib6
	 RkHcy76nOizjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B2D6E2B7;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
From: Mateusz Litwin via B4 Relay <devnull+mateusz.litwin.nokia.com@kernel.org>
Subject: [PATCH v2 0/2] spi: cadence-quadspi: Prevent indirect read
 timeouts
Date: Thu, 18 Dec 2025 22:33:03 +0100
Message-Id: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABBzRGkC/33NQQrCMBCF4auUrI0kEdvqyntIKXEytYM0iZMSl
 NK7GwtuXf5v8b1FJGTCJM7VIhgzJQq+hNlVAkbr7yjJlRZGmaM2upHwTJF68o4YYe4Zretpihw
 yyvZklXF6OIABUYTIONBr069d6ZHSHPi9nWX9XX9u+9fNWiqpAG66gdoMdXPx4UF2D2ES3bquH
 y1iqp/GAAAA
X-Change-ID: 20251217-cqspi_indirect_read_improve-89a02d1f3c2c
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Litwin <mateusz.litwin@nokia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766093707; l=4079;
 i=mateusz.litwin@nokia.com; s=20251217; h=from:subject:message-id;
 bh=CaTsMkKJSLp90vMn5/MV0Z5pzDnd9h/1Sh1EfZProTA=;
 b=4gOiQ6sTA5Z0Y52V7Dh370eZc0dLGPtTFoZoWleFNuEK9vv24KVq+y7qNQ59+Ouz0g42Xuv9a
 tNmZ6PYH901B0IgtMhri9+FgMNvVFtB5NqqPxPlGc46U90l/rA9q0kv
X-Developer-Key: i=mateusz.litwin@nokia.com; a=ed25519;
 pk=9NV76cwWrtwYUektOrK/ht9GTzmhtkqSvghr3Td4hM4=
X-Endpoint-Received: by B4 Relay for mateusz.litwin@nokia.com/20251217 with
 auth_id=579
X-Original-From: Mateusz Litwin <mateusz.litwin@nokia.com>
Reply-To: mateusz.litwin@nokia.com

Hello,

On the Stratix10 platform, indirect reads can become very slow due to lost
interrupts and/or missed `complete()` calls, causing
`wait_for_completion_timeout()` to expire.

Three issues were identified:
1) A race condition exists between the read loop and IRQ `complete()`
   call:
   An IRQ can call `complete()` after the inner loop ends, but before
   `reinit_completion()`, losing the completion event and leading to
   `wait_for_completion_timeout()` expire. This function will not return
   an error because `bytes_to_read` > 0 (indicating data is already in the
   FIFO) and the final `ret` value is overwritten by
   `cqspi_wait_for_bit()` return value (indicating request completion),
   masking the timeout.

   For test purpose, logging was added to print the count of timeouts and
   the outer loop count.
   $ dd if=/dev/mtd0 of=/dev/null bs=64M count=1
   [ 2232.925219] cadence-qspi ff8d2000.spi: Indirect read error timeout
    (1) loop (12472)
   [ 2236.200391] cadence-qspi ff8d2000.spi: Indirect read error timeout
    (1) loop (12460)
   [ 2239.482836] cadence-qspi ff8d2000.spi: Indirect read error timeout
    (5) loop (12450)
   This indicates that such an event is rare, but possible.
   Tested on the Stratix10 platform.

2) The quirk assumes the indirect read path never leaves the inner loop on
   SoCFPGA. This assumption is incorrect when using slow flash. Disabling
   IRQs in the inner loop can cause lost interrupts.

3) The `CQSPI_SLOW_SRAM` quirk disables `CQSPI_REG_IRQ_IND_COMP` (indirect
   completion) interrupt, relying solely on the `CQSPI_REG_IRQ_WATERMARK`
   (FIFO watermark) interrupt. For small transfers sizes, the final data
   read might not fill the FIFO sufficiently to trigger the watermark,
   preventing completion and leading to wait_for_completion_timeout()
   expiration.

Two patches have been prepared to resolve these issues.
-  [1/2] spi: cadence-quadspi: Prevent lost complete() call during
   indirect read
   Moving `reinit_completion()` before the inner loop prevents a race
   condition. This might cause a premature IRQ complete() call to occur;
   however, in the worst case, this will result in a spurious wakeup and
   another wait cycle, which is preferable to waiting for a timeout.

-  [2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is
   slow
   Re-enabling `CQSPI_REG_IRQ_IND_COMP` interrupt resolves the problem for
   small reads and removes the disabling of interrupts, addressing the
   issue with lost interrupts. This marginally increases the IRQ count.

   Test:
   $ dd if=/dev/mtd0 of=/dev/null bs=1M count=64
   Results from the Stratix10 platform with mt25qu02g flash.
   FIFO size in all tests: 128

   Serviced interrupt call counts:
   Without `CQSPI_SLOW_SRAM` quirk: 16 668 850
   With `CQSPI_SLOW_SRAM` quirk: 204 176
   With `CQSPI_SLOW_SRAM` and this patch: 224 528

Patch 2/2: Delivers a substantial read‑performance improvement for the
Cadence QSPI controller on the Stratix10 platform. Patch 1/2: Applies to
all platforms and should yield a modest performance gain, most noticeable
with large `CQSPI_READ_TIMEOUT_MS` values and workloads dominated by many
small reads.

---
Changes in v2:
- Correct the IRQ mask corresponding to the SLOW_SRAM quirk.
  This was prepared and tested on Linux kernel version 6.6, but
  wrongly applied to version 6.20.
- I apologize for this oversight.
- Link to v1: https://lore.kernel.org/r/20251218-cqspi_indirect_read_improve-v1-0-0ccb17c62f67@nokia.com

---
Mateusz Litwin (2):
      spi: cadence-quadspi: Prevent lost complete() call during indirect read
      spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is slow

 drivers/spi/spi-cadence-quadspi.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)
---
base-commit: f4acea9eef704607d1a950909ce3a52a770d6be2
change-id: 20251217-cqspi_indirect_read_improve-89a02d1f3c2c

Best regards,
-- 
Mateusz Litwin <mateusz.litwin@nokia.com>



