Return-Path: <linux-spi+bounces-1407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1178582D3
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7783D1F2354B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD812FF94;
	Fri, 16 Feb 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPeK1K/d"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323E12FB31;
	Fri, 16 Feb 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101757; cv=none; b=AO0VtOtjriaEJg7dJadIeiRL/0nRSSvNjfYUX1sykJdZoCuIxb+6qgE+seEBnZKhlYHfvZeLMR4a1ymEAnTIWCKLzTR7Jowyk3pkeM5OCGPPZ3WZwBU4Z0LxHbMpaQSuJUcCMgx0pwDkpUiET5FdaxJ18yGgK8JAySZI6OLTuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101757; c=relaxed/simple;
	bh=7KK5pW5Pi1LYzR+fqNDdK36NWqcgwEsjoRxchyrLz1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tUI5MZ+IMH1TZh9E/+aVMqVDapDLI3fMinE6pNJ2to/rDT36W3ba5EfWZSD67nn8O1IyY1pEZZUQKTGKsjHrmSXOph1on+jI3L2Cd5uzvR/w6o2HmKtPM0y0L+S93PNNnlpN5fmk4Wu/Kr/Iv9wBnSJ5bSuulgxQGCEUv+dl7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPeK1K/d; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 501321C0002;
	Fri, 16 Feb 2024 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708101746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3AlMyECXi93Leg6H8I5ViKVxyWQVWpHjcVcmxJw5o8=;
	b=jPeK1K/d/w0ODWTupcEMh2QD8c/TyhBJP2v4NJD1qvd1+ycA8IyOpSIFvZPjHXwrDyj9yY
	MAYBjljx0K2uQMKIOkI4rkS0lu4BoMYK5AD8v7VUp71b2evT2z3xU58SgHb/AVUND62YO2
	5wGNhNN0eTMtkaLs9K7cEh0AIUg1PWXqFcyjWVtlCAv6joswLFXLva0AOy6U+JFG1KJ+cw
	gaTP1HJOd+BMkU6tQanGHFps+ZLxkxALIBn7vt+bafkO0BFAUSt2bqI2nIi5om/L0huVZQ
	4nlPZVbzIN3idYDbL5t6qXew6Il/ennN2hUW35SuajiuSiZDpaEMLUY1mkn14w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 16 Feb 2024 17:42:19 +0100
Subject: [PATCH v2] spi: spi-mem: add statistics support to ->exec_op()
 calls
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGqQz2UC/3XMQQrCMBCF4auUWTuSCRWpK+8hXaTpxA7YpmRCU
 Urubuze5f/gfTsoJ2GFW7ND4k1U4lLDnhrwk1uejDLWBmtsa6zpUFfBmWfU7LJiCN0QOvImXBn
 qZ00c5H14j772JJpj+hz8Rr/1n7QREo4judba4A1d7kOM+SXL2ccZ+lLKF/uw4tasAAAA
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Current behavior is that spi-mem operations do not increment statistics,
neither per-controller nor per-device, if ->exec_op() is used. For
operations that do NOT use ->exec_op(), stats are increased as the
usual spi_sync() is called.

The newly implemented spi_mem_add_op_stats() function is strongly
inspired by spi_statistics_add_transfer_stats(); locking logic and
l2len computation comes from there.

Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
errors, timedout, transfer_bytes_histo_*.

Note about messages & transfers counters: in the fallback to spi_sync()
case, there are from 1 to 4 transfers per message. We only register one
big transfer in the ->exec_op() case as that is closer to reality.

This patch is NOT touching:
 - spi_async, spi_sync, spi_sync_immediate: those counters describe
   precise function calls, incrementing them would be lying. I believe
   comparing the messages counter to spi_async+spi_sync is a good way
   to detect ->exec_op() calls, but I might be missing edge cases
   knowledge.
 - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
   provided.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Turn len and l2len into u64. Remove casts on all 4 nbytes fields.
  Remove clamp of l2len to be positive.
- Replace "xferred" in comment by "transferred".
- Remove sysfs demo from commit message. Moved to below the tear line.
- Take Reviewed-by Dhruva Gole.
- Link to v1: https://lore.kernel.org/r/20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com
---

Testing this patch:

   $ cd /sys/devices/platform/soc
   $ find . -type d -path "*spi*" -name statistics
   ./2100000.spi/spi_master/spi0/statistics
   ./2100000.spi/spi_master/spi0/spi0.0/statistics
   $ cd ./2100000.spi/spi_master/spi0/statistics

   $ for f in *; do printf "%s\t" $f; cat $f; done | \
         grep -v transfer_bytes_histo | column -t
   bytes                    240745444
   bytes_rx                 240170907
   bytes_tx                 126320
   errors                   0
   messages                 97354
   spi_async                0
   spi_sync                 0
   spi_sync_immediate       0
   timedout                 0
   transfers                97354
   transfers_split_maxsize  0
---
 drivers/spi/spi-mem.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2dc8ceb85374..c9d6d42a88f5 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -297,6 +297,49 @@ static void spi_mem_access_end(struct spi_mem *mem)
 		pm_runtime_put(ctlr->dev.parent);
 }
 
+static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
+				 const struct spi_mem_op *op, int exec_op_ret)
+{
+	struct spi_statistics *stats;
+	u64 len, l2len;
+
+	get_cpu();
+	stats = this_cpu_ptr(pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+
+	/*
+	 * We do not have the concept of messages or transfers. Let's consider
+	 * that one operation is equivalent to one message and one transfer.
+	 */
+	u64_stats_inc(&stats->messages);
+	u64_stats_inc(&stats->transfers);
+
+	/* Use the sum of all lengths as bytes count and histogram value. */
+	len = op->cmd.nbytes + op->addr.nbytes;
+	len += op->dummy.nbytes + op->data.nbytes;
+	u64_stats_add(&stats->bytes, len);
+	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
+	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
+
+	/* Only account for data bytes as transferred bytes. */
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+		u64_stats_add(&stats->bytes_tx, op->data.nbytes);
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		u64_stats_add(&stats->bytes_rx, op->data.nbytes);
+
+	/*
+	 * A timeout is not an error, following the same behavior as
+	 * spi_transfer_one_message().
+	 */
+	if (exec_op_ret == -ETIMEDOUT)
+		u64_stats_inc(&stats->timedout);
+	else if (exec_op_ret)
+		u64_stats_inc(&stats->errors);
+
+	u64_stats_update_end(&stats->syncp);
+	put_cpu();
+}
+
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
@@ -339,8 +382,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
+		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
+			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
+			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
+
 			return ret;
+		}
 	}
 
 	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;

---
base-commit: 19b50f80b3a4865bd477aa5c026dd234d39a50d2
change-id: 20240209-spi-mem-stats-ff9bf91c0f7e

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


