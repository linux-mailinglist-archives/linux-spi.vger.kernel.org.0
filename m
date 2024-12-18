Return-Path: <linux-spi+bounces-6108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F89F6BAA
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D51679AF
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49DC1F2396;
	Wed, 18 Dec 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UlhkcmTJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6314884C;
	Wed, 18 Dec 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541143; cv=none; b=b3LGOVodxphc/yT4BCfeb2kTJuE1qm05bssA0NJ732c21iiZCBt7ZO9sudN3SYINSPYkSDIpJIlpTDO+r+ju3DXSsGR0zXYR3S8/iHp5mluMc3PvaEBro314VmGe61AIW0xdADxraH6KwwnWMtMZdJkOvWch4WVnOzVP/G6YF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541143; c=relaxed/simple;
	bh=gw35d6BOb663sZO/I4/7Q/oV0JYSymNLLbDnvedOwAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GN3qaon3tjpt7ejVqUJR132UYYVg9VznCO1RxnVYfM0a16Cgan5URgmz0y8qWk9N7jZMHZRp5G8vWKcAHei91SnHbp+1n7CV6FyuJjAHqoYdDmfs6EFZXpHojXl+XbBAuEjDXYl6WOrNLDvLv6oKLxwM0wul6nBMaiFLnscJJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UlhkcmTJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5EA95A0523;
	Wed, 18 Dec 2024 17:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Zl8RAR4+VoktxwACTb78JwmocySVvgcud/1ayJe16tU=; b=
	UlhkcmTJ9T0bsRVvaSdvfunxQBc24iaK4u6HoRCep/wajfPYXSKEB6DuxO04ut/t
	QUUZDdPXiDuv6dheswnpqDJWd03TiiEOzl64hkfIcTXsrodQ/ZkEBa9+F07jtAop
	zVx+Xh8CK4XUgv0fhOuTiVeFDvllcH/lin6TWNMJyG3qcRDSWC8akhqyNnPmVxAd
	Gmt1F+Iin0kHr/50SRjhollSdNWJSCEUThF9wBiAqG99FD05t3upnzjSNBIcmjIF
	7H7mwpoQkkgXfsSR/qV9+GDxlOSGi3+fRTXSNzLpuftoNZqrYbdtOjUKxt2uoOIY
	0wMzga1s6lWxd6nqDG1ErHBlND6q2/b/I1GfY7GNVCcYdtcSL5bn9s9ujSkyuVjz
	Cz9XyS9jnRrNXgvvrGWvgm2u1bz+5BNQ8DK4xr7lCaSzP35TxoZzDh3JxFFHSDja
	U6rtP4HvvrmcW6BhzNR8vCtVVo8SLh50tM1rlm1jsr1kPx5V5J7dpi5QRp65xKm3
	DOgrOVmj4NFo5pLGiJc4Z3OaCivDaMbSmfri13fz/6xV2gf24JB9qhvjIz9ggego
	9re/W8tiFVuFDBybv997aRoplG9NS2hRPMRdXqIVbYyo63HmIO75tLsvbFxK5msy
	75nXQNGecyOkD+sePNXlhYyZGbFpoEKjZGRRLiSyQRY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Mark Brown <broonie@kernel.org>, Piotr Bugalski
	<bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	<Hari.PrasathGE@microchip.com>, <Mahesh.Abotula@microchip.com>,
	<Marco.Cardellini@microchip.com>, <stable@vger.kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] spi: atmel-qspi: Memory barriers after memory-mapped I/O
Date: Wed, 18 Dec 2024 17:58:49 +0100
Message-ID: <20241218165850.378909-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734541135;VERSION=7982;MC=1721398368;ID=88099;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D7063

The QSPI peripheral control and status registers are
accessible via the SoC's APB bus, whereas MMIO transactions'
data travels on the AHB bus.

Microchip documentation and even sample code from Atmel
emphasises the need for a memory barrier before the first
MMIO transaction to the AHB-connected QSPI, and before the
last write to its registers via APB. This is achieved by
the following lines in `atmel_qspi_transfer()`:

	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
	(void)atmel_qspi_read(aq, QSPI_IFR);

However, the current documentation makes no mention to
synchronization requirements in the other direction, i.e.
after the last data written via AHB, and before the first
register access on APB.

---

In our case, we were facing an issue where the QSPI peripheral
would cease to send any new CSR (nCS Rise) interrupts,
leading to a timeout in `atmel_qspi_wait_for_completion()`
and ultimately this panic in higher levels:

	ubi0 error: ubi_io_write: error -110 while writing 63108 bytes to PEB 491:128, written 63104 bytes

After months of extensive research of the codebase, fiddling
around the debugger with kgdb, and back-and-forth with
Microchip, we came to the conclusion that the issue is
probably that the peripheral is still busy receiving on AHB
when the LASTXFER bit is written to its Control Register
on APB, therefore this write gets lost, and the peripheral
still thinks there is more data to come in the MMIO transfer.
This was first formulated when we noticed that doubling the
write() of QSPI_CR_LASTXFER seemed to solve the problem.

Ultimately, the solution is to introduce memory barriers
after the AHB-mapped MMIO transfers, to ensure ordering.

Fixes: d5433def3153 ("mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi")
Cc: Hari.PrasathGE@microchip.com
Cc: Mahesh.Abotula@microchip.com
Cc: Marco.Cardellini@microchip.com
Cc: <stable@vger.kernel.org> # c0a0203cf579: ("spi: atmel-quadspi: Create `atmel_qspi_ops`"...)
Cc: <stable@vger.kernel.org> # 6.x.y
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 73cf0c3f1477..96fc1c56a221 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -625,13 +625,20 @@ static int atmel_qspi_transfer(struct spi_mem *mem,
 	(void)atmel_qspi_read(aq, QSPI_IFR);
 
 	/* Send/Receive data */
-	if (op->data.dir == SPI_MEM_DATA_IN)
+	if (op->data.dir == SPI_MEM_DATA_IN) {
 		memcpy_fromio(op->data.buf.in, aq->mem + offset,
 			      op->data.nbytes);
-	else
+
+		/* Synchronize AHB and APB accesses again */
+		rmb();
+	} else {
 		memcpy_toio(aq->mem + offset, op->data.buf.out,
 			    op->data.nbytes);
 
+		/* Synchronize AHB and APB accesses again */
+		wmb();
+	}
+
 	/* Release the chip-select */
 	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 
-- 
2.34.1



