Return-Path: <linux-spi+bounces-6233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09292A02C73
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792251887992
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCA13C3D6;
	Mon,  6 Jan 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="IkK8LumY"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C9155352;
	Mon,  6 Jan 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178850; cv=none; b=V39+ZF7mDppm86WtYAlD1DWlWpkCaOW3kM9hblenPrent5ryOtm+e6Zkk3WedFYSB2qL4v/cOjl9Z0jgF7VCebGW6lpyJz68emS887yvl5dLGGPAgf00pTEebWvcUfgWMWVS21syP+MnlqDOdghyPg6YTPv2CquGFC+kRwb61HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178850; c=relaxed/simple;
	bh=6WaJWwIcdDpS4dogVu9o1AB9CekvLCEUlOnOFjlyCFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Alavsk1d54kMgNn9jYVrIuAEZ2T4c3Njm33DhzAZDVItP/QR8SSTBC0UeauNbF/qq92xnWyKUisfsJnnn/EMaBng7IC19WuM6En+EsRf+0pAdSpq2ofMgnywjaSTVLOd1gx0FcahXVGVStCCxqWHrW+WiBgLZxvMg1zih1XPVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=IkK8LumY; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D8CB8A087A;
	Mon,  6 Jan 2025 16:48:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=U3rxMNi65rLW9FILTb0vIx/aX0FXP8OpMsz35GckwCU=; b=
	IkK8LumYhpB3qM2PAqqurobgZE9TK1/wZXygRhNDUE0OJNhqHHLZlsZzoAQtG2Rp
	19OiMwCHpIOQBMXGJtnyKLkBYT2IkFOMFlDm6kMKBx4Zpz3lr9j/mxryPT6ieuwE
	zVJG6K9l426O/3E/2J2bEEgltorz88LA0QHuzq+x0wjXV9yjyq42E01Lg7CDQfxk
	h7mP3ZhFfA+fnGYVnWp0XqZCyw1+EPTD2ySwgleoJlxRjRYe2yWswfwUZ9dMtzHz
	gkD4lhqrHWRh+hyPjin4tBlk4dOUwzk5zicjfBrmfLuKweVOr+ZC1T/Kt02YQD3q
	hpjmPqlSk8yvRVTZI4O4JLW3fqXf2WdK3amce3mP/haObNctpK1WdABhpvbImqLh
	Vf2qR7V9i/2ZDHQfKRvZnihbTwFXuae+6QukR9WGkMdQLuysYJKtoypzWzNLwueA
	jgzfvTAI8GsUC3OFPF9DmgIDRkWTnslMU7FmMN6oykDPMSepDPTjuLvGhScAZmjp
	CcAODVbLmun3a8pEXaUg0lxn6bGntTFRS0flJSt6J9cXEWNUPXdUypmb8pRgt5eU
	ECMzpfaVNHmieXMdryZfL5oMscEa5dO43R7B+47Apq956ZApjBsFe1WamPRgt5Lh
	b8s9XGIFTf9b+o2lH3fnjU0LBp0d9vtTHXS+B/A2mp4=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Mark Brown <broonie@kernel.org>, Piotr Bugalski
	<bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	<Hari.PrasathGE@microchip.com>, <Mahesh.Abotula@microchip.com>,
	<Marco.Cardellini@microchip.com>, <stable@vger.kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH resubmit v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O
Date: Mon, 6 Jan 2025 16:48:06 +0100
Message-ID: <20250106154806.1959266-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736178500;VERSION=7982;MC=3895028276;ID=224790;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852657067

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

In our case, we were facing an issue where the QSPI peripheral
would cease to send any new CSR (nCS Rise) interrupts,
leading to a timeout in `atmel_qspi_wait_for_completion()`
and ultimately this panic in higher levels:

	ubi0 error: ubi_io_write: error -110 while writing 63108 bytes
 to PEB 491:128, written 63104 bytes

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

Notes:
    Changes in v2:
    * dropping --- from commit msg
    
    Resubmit: rebased on current spi-next

 drivers/spi/atmel-quadspi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f46da363574f..8fdc9d27a95e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -661,13 +661,20 @@ static int atmel_qspi_transfer(struct spi_mem *mem,
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



