Return-Path: <linux-spi+bounces-12443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A0D311F7
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 13:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F62B3009542
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC5288AD;
	Fri, 16 Jan 2026 12:32:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A179CD
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566759; cv=none; b=g2aCFo0e2y44lzn5HsUe84bdidDbnzB8cOtLDQ58qAMNWnBQKqo6lb7zcNQVmX82FPuRxgd4z4DRTbBpY+NmWMWfCemKEc6gvzEcy0k1tFoFz3BuFGtHOIEk2pFm5em6ps749exFhYhEKagM+heLxJqnuikXWvR3eul51JD4mDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566759; c=relaxed/simple;
	bh=qD3t8KkmryE8Q3sEWp1im89nOG2BoAsAGxlKbLR7bNI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZzzxOkJqgeaHas+aHW2uCaQM+fCHVmXvb4M/PtbgJ/XvKVRxZczugeAzvM0dLZyankzeMuX1IlS3xlobSmclkl3JTNB0sTA+q/xGwtuK2H2+D0aw0lebQthyoJ+hqLrgCxm5cIaTVoQcQhLkAFTvqFKy0+msQhoEquZvctPE0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1331619a12.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 04:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768566757; x=1769171557;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVLV19TawD5XZpUdbFIZpsowqiEtwSZoUGvKEVNvWDE=;
        b=rFJTyezi/TJDOzZJ0XPJxAcDHlvSMFVGCkEJX0s2mUG774ldR9V8iwlOydRfJATbIN
         q4Sh9eQW9PFx60sAoDqBosgvhJ14E1QLZ9F6tnpoBHWV50ZEfmht6VAppPPHekzAj6I+
         cRW39jik0YFcXryq/+a4Y5SkoqGUoC/EywoQEkldpSJfa+soOIyT6p4OM+5/NKtcESNl
         EYlgU4OtLv3T6eXxZx6HYmvusbKg7Iuj3883VYycosyLxuz/2bdiyCKukAQjIkRthMAa
         NIPrrb8f33XRenIIF2zXOEe9jJwBDwph1UuVdORG2S7Tfv5hWOM2Gpc/V9yIPczi9P2y
         EQXA==
X-Forwarded-Encrypted: i=1; AJvYcCVDi5FmQ08KjOaNfYHUxBI3/bq3L0s1TZKmmwWNKFZTAb1cBXs7NoZg6L7pTvjXnAcKnl3OlW1gPOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/32K4UQ7KVBYYEiRihoJ8ArMJ+snK5dkF9il6gsGYsifekIe6
	Ps9zPxKlOSqGaKFgh9NcyQ+yS0Fx9gsdYWxMyJpBbVOvFTQHCdPvY2IrkIsWzw==
X-Gm-Gg: AY/fxX4pIiRadkmC/iSGuZOfjbq/AYzBe81MTaUGX2tNKONiUslGshjMw6MrcRl+jvh
	GZeIPPDYj4Pf/0rhZn4jJQzdpZzL8NQcjFsw2nFW5CJX0TnPNtCP0gQIUu/xG09tAdgCTVdFzjC
	SqHdGBtPhmPpR6Fw9xR86Drak1/reoCcCy8enr0c34VhriYHhU601erA0RqPRRmwDULCmTVtuV0
	bA9gGV+UcCZ0CxeBL1aqLMKcYDApYz0BDFB+bLaeZ7SbyR7f0l6YgLoNqtBB3LuIWHttS8WGTRU
	A4hsSRGbx3n+fdvGMrI4kWi7EtsieI5atiaenhUfBHs4Yg0vkNgzbD2uD9Sd5owAk3IVMv5DAd7
	a2M4/J0t26JFUXsQZgIkzzfDh0aDCmSPsDdUt8WiLFeN+FiatfKRB+G+l5BYfMUpttDtN/NJpwl
	60Ow==
X-Received: by 2002:a05:6830:81f8:b0:7cf:da7d:5040 with SMTP id 46e09a7af769-7cfded6f064mr1774625a34.14.1768560115730;
        Fri, 16 Jan 2026 02:41:55 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a5f02sm1468465a34.25.2026.01.16.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:41:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Date: Fri, 16 Jan 2026 02:41:40 -0800
Message-Id: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUVamkC/yXMQQqDMBAF0KsMf20gSSFCrlKKxHSi40LLRIsg3
 r1Yl2/zDlRW4YpIB5S/UmWZEck1hDymeWAjb0SCtz5Y57xZedDU7YXVhJT7h02h9bagIXyUi+z
 /7Pm6Xbd+4rxeA87zBwuXlJBuAAAA
X-Change-ID: 20260112-tegra_xfer-6acb30a6720f
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, puranjay@kernel.org, 
 usamaarif642@gmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5022; i=leitao@debian.org;
 h=from:subject:message-id; bh=qD3t8KkmryE8Q3sEWp1im89nOG2BoAsAGxlKbLR7bNI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpahXx6Jy9ntHF0BqQauX2V9RiyvTKge/74KgBS
 9hKsnE//E+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWoV8QAKCRA1o5Of/Hh3
 bdGiD/9tEhwi2Msnv0oFN38RVhGI9fUUeGG8kb+u9ma/CiLgvhTYO/2ykMjAnOYghhAl/Usp4Rj
 +tVUH4oB8zE5RPu6bljQJlN2LODGTqc4qV8HOKzJ+App6qgsRsnI6ItXIPKY+BYg9/88E+nDIXX
 KNfqzbG4theM91N4XH79le6J7M5pnbndlEWwAHu1WBAEHEqFJDY81sitcxmGVmKEH/rPk1jolne
 N5Hggmd6s35LV8NQv/KN4x0Bgeas/s5NJm0iqQ/3d/DT3F9Tel32jpwiQgzsLkjPgdf+HN40afD
 A3xYVeEMtwX/YywdhETVB/YFFOtYXRXUYMy0d+xGYdoirk22b1izfng4ujEdshEl1diLS56pcDq
 QwpvuIsc2Z4xP/G+2fLsiKyYAnrgSGiVrmOmc9wHLiekye9dVa8XzHOMprm80fj/lclcmG+GoG2
 WADwv162XPhob9sAqj6qDpB07LguqLF0FBGPBU03DLaxbU0l8Sa6/0zQ4wqFTzJfNNZYcbuuXpm
 /SqV01zOg0wutKUoY5gT+IfUEvD4xfUQcrii8UNtBXqNCWO0w3jDTcStG84xiPWOHLD6bKm5GJW
 lkeGhTpk3q1MI9ZRx18e0/h8hVLditde5xT8c2nhz9dQLkvC7OBkR28X4h6+zRsxrfA0ji6GZe+
 LQW32I42FtbKG9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The tegra-quad-spi driver is crashing on some hosts. Analysis revealed
the following failure sequence:

1) After running for a while, the interrupt gets marked as spurious:

    irq 63: nobody cared (try booting with the "irqpoll" option)
    Disabling IRQ #63

2) The IRQ handler (tegra_qspi_isr_thread->handle_cpu_based_xfer) is
   responsible for signaling xfer_completion.
   Once the interrupt is disabled, xfer_completion is never completed, causing
   transfers to hit the timeout:

    WARNING: CPU: 64 PID: 844224 at drivers/spi/spi-tegra210-quad.c:1222 tegra_qspi_transfer_one_message+0x7a0/0x9b0

3) The timeout handler completes the transfer:

    tegra-qspi NVDA1513:00: QSPI interrupt timeout, but transfer complete

4) Later, the ISR thread finally runs and crashes trying to dereference
   curr_xfer which the timeout handler already set to NULL:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
    pc : handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad]
    lr : tegra_qspi_handle_timeout+0xb4/0xf0 [spi_tegra210_quad]
    Call trace:
      handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad] (P)

Root cause analysis identified three issues:

1) Race condition on tqspi->curr_xfer

   The curr_xfer pointer can change during ISR execution without proper
   synchronization. The timeout path clears curr_xfer while the ISR
   thread may still be accessing it.

   This is trivially reproducible by decreasing QSPI_DMA_TIMEOUT and
   adding instrumentation to tegra_qspi_isr_thread() to check curr_xfer
   at entry and exit - the value changes mid-execution. I've used the
   following test to reproduce this issue:

   https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh

   The existing comment in the ISR acknowledges this race but the
   protection is insufficient:

       /*
        * Occasionally the IRQ thread takes a long time to wake up (usually
        * when the CPU that it's running on is excessively busy) and we have
        * already reached the timeout before and cleaned up the timed out
        * transfer. Avoid any processing in that case and bail out early.
        */

   This is bad because tqspi->curr_xfer can just get NULLed

2) Incorrect IRQ_NONE return causing spurious IRQ detection

   When the timeout handler processes a transfer before the ISR thread
   runs, tegra_qspi_isr_thread() returns IRQ_NONE.

   After enough IRQ_NONE returns, the kernel marks the interrupt as spurious
   and disables it - but these were legitimate interrupts that happened to be
   processed by the timeout path first.

   Interrupt handlers shouldn't return IRQ_NONE, if the driver somehow handled
   the interrupt (!?)

3) Complex locking makes full protection difficult

   Ideally the entire tqspi structure would be protected by tqspi->lock,
   but handle_dma_based_xfer() calls wait_for_completion_interruptible_timeout()
   which can sleep, preventing the lock from being held across the entire
   ISR execution.

   Usama Arif has some ideas here, and he can share more.

This patchset addresses these issues:

Return IRQ_HANDLED instead of IRQ_NONE when the timeout path has
already processed the transfer. Use the QSPI_RDY bit in
QSPI_TRANS_STATUS (same approach as tegra_qspi_handle_timeout()) to
distinguish real interrupts from truly spurious ones.

Protect curr_xfer access with spinlock everywhere in the code, given
Interrupt handling can run in parallel with timeout and transfer.
This prevents the NULL pointer dereference by ensuring curr_xfer cannot
be cleared while being checked.

While this may not provide complete protection for all tqspi fields
(which might be necessary?!), it fixes the observed crashes and prevents
the spurious IRQ detection that was disabling the interrupt entirely.

This was tested with a simple TPM application, where the TPM lives
behind the tegra qspi driver:

https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh

A special thanks for Usama Arif for his help investigating the problem
and helping with the fixes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (6):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler

 drivers/spi/spi-tegra210-quad.c | 54 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)
---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260112-tegra_xfer-6acb30a6720f

Best regards,
--  
Breno Leitao <leitao@debian.org>


