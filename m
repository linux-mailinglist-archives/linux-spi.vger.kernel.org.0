Return-Path: <linux-spi+bounces-11243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA5C6168E
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57061356F3A
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346992D8771;
	Sun, 16 Nov 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T69VnyMk"
X-Original-To: linux-spi@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1C2DA76F;
	Sun, 16 Nov 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763302179; cv=none; b=IrWigWXyRn+KKr/NIADwi6FeRWeTOWuA8cBWy8hwxRPlm9k9k72gv3BezPM8kK2udKAxhMLaI1kQJkv3o6CM1hxqZefuYmgxC94D3oeKy8o+juBSh0fpgAoVVoCmARTXncxv3NSgEEJRqDwug/7pfRfmZ/WabNamY9F3Gztx0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763302179; c=relaxed/simple;
	bh=I+Bxk7A8fqD+rv7hvNkN880Oq/v85iX0DbhXg1k8ah0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Imy9G7KIgtjld9D9F1fI+IIw+Rx4qjosSazfG2PpfpYIYO/E8P8WMB6d+ro6VDTJFtb3Ne1JmEC26mG2efJfoCAH+bIuzsWbWQ1d8Hg4WixGMs7nLzHeeprOAHSl4I4tltzvKofBQFCzbLC2UUF1peS9lDXqxyyid/vyc/32WCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T69VnyMk; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763302166; bh=w+iJzRMc1+StF6vqJUaTFxjEQFg52jIjs9DmyPRzwXo=;
	h=From:To:Cc:Subject:Date;
	b=T69VnyMkX8D2fpJe/o8nPLio+7x8ueija4+0H4gzFFEASd9fuzQrmXDdFs3rtHLQ0
	 /GKDAEcK9IWgFBsvXMJQ+GFh2mc7cJ2aLa323jj0NJavNEKYiz2jJuvhC57/eS7XW9
	 FNqkr17mg9bryY6+8wu7jRrKFRWWFHLttie9VXrU=
Received: from localhost.localdomain ([2401:d002:1207:ce00:5cbb:f6ff:fe9e:eefa])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 2349EA5B; Sun, 16 Nov 2025 22:08:52 +0800
X-QQ-mid: xmsmtpt1763302132tgjyj4bsv
Message-ID: <tencent_7AC88FCB3076489A4A7E6C2163DF1ACF8D06@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfwY+MHmMvOJmcqvKURzqXzvms/4OC4vnFlTPUIvSqc+onw7f6UX
	 ARuDnzbYeaU8JsmIyOJBqOPKEiKUSYy5sRqgtRP6xqBFKFD7mz+Bd6O24fSoKnpmXAClpkEerGSp
	 GQUH6/n9ARlhsLf350DNhI6dVhNJtbBMt64Iqvuak2BBsrdy/8wRkSHgb9w+ZckJk3B8Z5mjUoEL
	 U05Xev8y5M4yK06CQ25sxK+05mJzlX2jv5CzdReIi6BzxN0+XBu/iJ8UC84KjluXhMKRYMOs16hS
	 x+O54OZtBeswlhfAdOzp84AdwaXfyIUrzUhc7s8v5Hd1VKNWo6KZT8mztwx2ZBcEhSrmr0eF7+zV
	 dj9eDd5269CZYExOlN551mIMvSu3xQx/mvTHBfxErymg/idipeX0loirORaKqOICXDgHaU4/2zZv
	 sfAqxkp4DMxLFrDhC2NdVg3y2nrn0YwAnBumG/ME/3A30QxHJCKI4D2NjM5YpLnfeBgvKIWwvOXE
	 I6M5VMblzeVZS5XFsahJT3RiGWVGjinFUU9EDVcgvCB2WDlgovq9Jtd7kRhmUu3PigBGAOKitMFa
	 DIFwraOKs2FEXq1RO3hZSkIB7a4KNEqs4XeBUIfK0CdPQWWFxcdOmwpU4g68mgDe7t1pHUreseCF
	 YCZy0nL/sAGSh7dGPfMOoN/Pk77d4DuGfweBiEAeRw8EQE8jC6D5cUyx4qFElMt9/VfumO62C48n
	 LG+Hp9YDEFcbZcqqcj48YxQjZyW7cbsftYhKgWhxzoXq7y6Df5N1/m7tiMxiWQl+Kbue1FA51Q5M
	 7mwUdpAwkyazeJG/YfsQfitIIo+KYCw0cCXnJbGQn40OWp6de8T6ZMPx+544x8ZrDP+S0/WVg21h
	 kFJbXJQ1aWL3d9MNDKGeM8LWEBpGMsdHSImx2osc4inJc1B9lV7xO32Yvwi46F47XAaxFomW3czA
	 Px9rNzjsZUpFxmcfLWK6ORsuCwbBAN3Asj2/wKjXraN7JZRG3dcJj1Ukpv6tl9JbU8eiHc56//JY
	 fzUJFVcinh0TL+EZsEjBZih8UAtzGaZZrQHzWRti/IMvEAnStZ4W53pByOqWo=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Hang Zhou <929513338@qq.com>
To: broonie@kernel.org
Cc: jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hang Zhou <929513338@qq.com>
Subject: [PATCH v2] spi: bcm63xx: fix premature CS deassertion on RX-only transactions
Date: Mon, 17 Nov 2025 01:08:35 +1100
X-OQ-MSGID: <20251116140835.205005-1-929513338@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On BCM6358 (and also observed on BCM6368) the controller appears to
only generate as many SPI clocks as bytes that have been written into
the TX FIFO. For RX-only transfers the driver programs the transfer
length in SPI_MSG_CTL but does not write anything into the FIFO, so
chip select is deasserted early and the RX transfer segment is never
fully clocked in.

A concrete failing case is a three-transfer MAC address read from
SPI-NOR:
  - TX 0x03 (read command)
  - TX 3-byte address
  - RX 6 bytes (MAC)

In contrast, a two-transfer JEDEC-ID read (0x9f + 6-byte RX) works
because the driver uses prepend_len and writes dummy bytes into the
TX FIFO for the RX part.

Fix this by writing 0xff dummy bytes into the TX FIFO for RX-only
segments so that the number of bytes written to the FIFO matches the
total message length seen by the controller.

Fixes: b17de076062a ("spi/bcm63xx: work around inability to keep CS up")

Signed-off-by: Hang Zhou <929513338@qq.com>
---
 drivers/spi/spi-bcm63xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 8510400e7867..76ccd0f62c2e 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -154,6 +154,20 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 
 		if (t->rx_buf) {
 			do_rx = true;
+
+			/*
+			 * In certain hardware implementations, there appears to be a
+			 * hidden accumulator that tracks the number of bytes written into
+			 * the hardware FIFO, and this accumulator overrides the length in
+			 * the SPI_MSG_CTL register.
+			 *
+			 * Therefore, for read-only transfers, we need to write some dummy
+			 * value into the FIFO to keep the accumulator tracking the correct
+			 * length.
+			 */
+			if (!t->tx_buf)
+				memset_io(bs->tx_io + len, 0xFF, t->len);
+
 			/* prepend is half-duplex write only */
 			if (t == first)
 				prepend_len = 0;
-- 
2.34.1


