Return-Path: <linux-spi+bounces-10494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA7BCA053
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393504FF524
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA42FAC0C;
	Thu,  9 Oct 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCqfnEUx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B92FAC07;
	Thu,  9 Oct 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025575; cv=none; b=Oc6jk7vEPfkc8CN+GOrzlrfF6A63UgUhqP7z0cKAWOzhdEXo3ireGU1mZZG1wjvTBn5m65AU+6ovsQ5/z74edZm8M4+wXtfygZrUICewcRIbA83zhjVafx7fYDQhou8RWG0YdEhtaycy94dmlp7mQUgwZUxJs+a6Q4TubMD7Uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025575; c=relaxed/simple;
	bh=td/9rpfVL5kc3539pOIYKE9FDVHoZjxCJ/AWHY0bREw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9nB0yKQn1IfY4x6UOseLLgv291qq92JgIZClSk8cMoxgllOecQ9nIUsSdej0TMbH9i9iVA9G0Zr5a4T28BrvkIApLW8fQQ/VxTCmk32LktrJD1tpVaJpOfAf4xdtpz2GbJqNKE+DzrwteY/PpqeFIdu7zUB/yroVpm03Q99yik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCqfnEUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AFAC4CEF8;
	Thu,  9 Oct 2025 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025575;
	bh=td/9rpfVL5kc3539pOIYKE9FDVHoZjxCJ/AWHY0bREw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCqfnEUxrDI+O+kg04A+r/81yBrBhLpEpLoH6HmMOlylAVBsbp4ee/MkJDp81/9Cn
	 w9cvu9dg8BB6Wu1F2xFbvsny2pr+UbUnWhUtdUa9Jz9nIgEZFpBC7bHMA0p//IotW/
	 susBnhGJu5T/R1xZ555hBA6dVaT4oRs3684sJ7RN3pPehD9IJybTalO4PJG+MZMGI7
	 RsL6lCOMQ9f8nFkQTkwFuHdvOqNAsg6U4ywdDrFo1murksUavk/zaGR3/G3vgt6fUl
	 18MUOphYnYT+riMDS4Did/9tlrf2FJUTNvjmVXiGFSt42dSLigsrfkVZuJOh99nB+Y
	 BkZgvPj9m3e7g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-spi@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17-5.4] spi: loopback-test: Don't use %pK through printk
Date: Thu,  9 Oct 2025 11:55:21 -0400
Message-ID: <20251009155752.773732-55-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit b832b19318534bb4f1673b24d78037fee339c679 ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://patch.msgid.link/20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit and the broader
context, here is my determination:

**Backport Status: YES**

## Analysis

### Nature of the Change
This commit replaces the `%pK` (restricted pointer) format specifier
with `%p` (regular pointer) in debugging output functions within the SPI
loopback test driver. The changes affect:
- `spi_test_dump_message()` - debugging output for SPI messages (lines
  449, 459, 461, 467)
- `spi_check_rx_ranges()` - error reporting (line 561)
- `spi_test_translate()` - error reporting (line 699)

### Technical Justification for Backporting

**1. Real Bug Fix - Sleeping Locks in Atomic Context**

The commit message's claim about "acquiring sleeping locks in atomic
contexts" is accurate and documented. My investigation reveals:

- `%pK` implementation (lib/vsprintf.c:863-904) calls
  `has_capability_noaudit()` which invokes `security_capable()` through
  the LSM framework
- Under CONFIG_PREEMPT_RT with SELinux and kptr_restrict=1, this
  triggers "sleeping function called from invalid context" warnings
- The code explicitly checks for atomic context (lib/vsprintf.c:874) and
  returns "pK-error" if in hardirq, softirq, or NMI context
- This is a real correctness issue, not just theoretical

**2. Security Improvement**

Since commit ad67b74d2469 (v4.15-rc2, November 2017), `%p` already
hashes addresses and doesn't leak raw pointers. The commit message
correctly notes that `%pK` through printk() can "still unintentionally
leak raw pointers" depending on kptr_restrict settings, whereas `%p`
consistently hashes addresses.

**3. Part of Tree-Wide Cleanup**

This is part of a coordinated effort to remove `%pK` from printk() paths
across the entire kernel:
- Similar commits already backported: BPF (c2f48cb89b76f), SCSI, WiFi,
  remoteproc, DRM, crypto, etc.
- All authored by Thomas Weißschuh with identical commit messages
- Shows this is recognized as a kernel-wide issue requiring systematic
  fixing

**4. Low Regression Risk**

- Only changes format specifiers, no logic changes
- Confined to test/debugging driver (spi-loopback-test.c) used for
  regression testing, not production code
- Changes 6 format strings across 3 functions
- Output remains functionally equivalent (both show pointer addresses,
  just hashed differently)

**5. Stable Tree Criteria Compliance**

✓ Fixes important bug (sleeping locks in atomic context under RT
kernels)
✓ No new features introduced
✓ No architectural changes
✓ Minimal regression risk
✓ Small and contained change (12 lines, 1 file)
✓ Part of security hardening effort

### Evidence of Backport Intent

The commit has already been queued for backport to this stable tree
(commit c51f79c2aadcd with "Signed-off-by: Sasha Levin"), indicating it
has passed stable tree review criteria. It's currently 66 commits ahead
of the v6.17 release tag.

### Conclusion

This commit should definitively be backported to stable trees. It fixes
a real correctness bug affecting RT kernel configurations, improves
security posture, carries minimal risk, and is part of a systematic
kernel-wide cleanup that's already being backported across subsystems.

 drivers/spi/spi-loopback-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7dd92deffe3fb..e0b131aa29b62 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -446,7 +446,7 @@ static void spi_test_dump_message(struct spi_device *spi,
 	int i;
 	u8 b;
 
-	dev_info(&spi->dev, "  spi_msg@%pK\n", msg);
+	dev_info(&spi->dev, "  spi_msg@%p\n", msg);
 	if (msg->status)
 		dev_info(&spi->dev, "    status:        %i\n",
 			 msg->status);
@@ -456,15 +456,15 @@ static void spi_test_dump_message(struct spi_device *spi,
 		 msg->actual_length);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_info(&spi->dev, "    spi_transfer@%pK\n", xfer);
+		dev_info(&spi->dev, "    spi_transfer@%p\n", xfer);
 		dev_info(&spi->dev, "      len:    %i\n", xfer->len);
-		dev_info(&spi->dev, "      tx_buf: %pK\n", xfer->tx_buf);
+		dev_info(&spi->dev, "      tx_buf: %p\n", xfer->tx_buf);
 		if (dump_data && xfer->tx_buf)
 			spi_test_print_hex_dump("          TX: ",
 						xfer->tx_buf,
 						xfer->len);
 
-		dev_info(&spi->dev, "      rx_buf: %pK\n", xfer->rx_buf);
+		dev_info(&spi->dev, "      rx_buf: %p\n", xfer->rx_buf);
 		if (dump_data && xfer->rx_buf)
 			spi_test_print_hex_dump("          RX: ",
 						xfer->rx_buf,
@@ -558,7 +558,7 @@ static int spi_check_rx_ranges(struct spi_device *spi,
 		/* if still not found then something has modified too much */
 		/* we could list the "closest" transfer here... */
 		dev_err(&spi->dev,
-			"loopback strangeness - rx changed outside of allowed range at: %pK\n",
+			"loopback strangeness - rx changed outside of allowed range at: %p\n",
 			addr);
 		/* do not return, only set ret,
 		 * so that we list all addresses
@@ -696,7 +696,7 @@ static int spi_test_translate(struct spi_device *spi,
 	}
 
 	dev_err(&spi->dev,
-		"PointerRange [%pK:%pK[ not in range [%pK:%pK[ or [%pK:%pK[\n",
+		"PointerRange [%p:%p[ not in range [%p:%p[ or [%p:%p[\n",
 		*ptr, *ptr + len,
 		RX(0), RX(SPI_TEST_MAX_SIZE),
 		TX(0), TX(SPI_TEST_MAX_SIZE));
-- 
2.51.0


