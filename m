Return-Path: <linux-spi+bounces-10744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7FBF31A1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237D94EE273
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6B242D6A;
	Mon, 20 Oct 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o93jfIBQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4912C11C5
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987029; cv=none; b=UVh96IwxMiozCHh85gR2M9/Vy7GVdSqEDeChdszypwWHVNUAg97lDpgEzF5ky5RvLrA3kFvhUX+BMC8xW0CbGcF71EdF2hkF/kGLhmsGu9qRGK0qGiViLxIzfNfz2Ivt/B3m1TSqizHWivgG9kS48W0EVXVJjPhVenBojj7ryzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987029; c=relaxed/simple;
	bh=2YHlLqlIQo6H07nRr4MOTQ1A60hBj9sEsAx1iVykJwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pGYVrUiNF/ImaKuS3+h/R9Nr2F1PHBtCtYAvzRut3Ab0l6nGPXGIikWnarb3/pjNwninIOw0vRUVfgxaaSsUiYrDiuQtdl6bv2mgc91Ie2Q84Dw5dY7tEh3Qiyp3dqxLGlnefftZWQaOooMGvDisQ7i2lW6Fa+DcHgrCIipufxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o93jfIBQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760987024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iB/wSIt/Z4ZqrIHWJ1sCSLBfcHZ6VeoqL5ySojaKqBM=;
	b=o93jfIBQazIrmQHeahKrkS6fVow0FVDnl9PavYFxsPP+pkNBiG9jkUaixTXduRN9sZlnkn
	1kMEAnwN0QCsP6uFShDH3hcwxStlAhyKQIAYHqoGDzIx4Tjm7/wYSnOkP6QxlXbz4G+wkW
	s+bcV2Ko/OtfW3OL9loh+N5sDZz1bcI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
Cc: linux-kernel@vger.kernel.org (open list),
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] spi: spi-mem: Trace exec_op
Date: Mon, 20 Oct 2025 15:03:33 -0400
Message-Id: <20251020190333.1431664-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The spi subsystem has tracing, which is very convenient when debugging
problems. Add tracing for spi-mem too so that accesses that skip the spi
subsystem can still be seen.

The format is roughly based on the existing spi tracing. We don't bother
tracing the op's address because the tracing happens while the memory is
locked, so there can be no confusion about the matching of start and
stop. The conversion of cmd/addr/dummy to an array is directly analogous
to the conversion in the latter half of spi_mem_exec_op.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 MAINTAINERS                    |   1 +
 drivers/spi/spi-mem.c          |   5 ++
 include/trace/events/spi-mem.h | 106 +++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 include/trace/events/spi-mem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b45db73e55df..a6c4e0f65818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24204,6 +24204,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 F:	Documentation/devicetree/bindings/spi/
 F:	Documentation/spi/
 F:	drivers/spi/
+F:	include/trace/events/spi*
 F:	include/linux/spi/
 F:	include/uapi/linux/spi/
 F:	tools/spi/
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 064b99204d9a..c8b2add2640e 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,6 +12,9 @@
 #include <linux/spi/spi-mem.h>
 #include <linux/sched/task_stack.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/spi-mem.h>
+
 #include "internals.h"
 
 #define SPI_MEM_MAX_BUSWIDTH		8
@@ -403,7 +406,9 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		if (ret)
 			return ret;
 
+		trace_spi_mem_start_op(mem, op);
 		ret = ctlr->mem_ops->exec_op(mem, op);
+		trace_spi_mem_stop_op(mem, op);
 
 		spi_mem_access_end(mem);
 
diff --git a/include/trace/events/spi-mem.h b/include/trace/events/spi-mem.h
new file mode 100644
index 000000000000..e97c2c417233
--- /dev/null
+++ b/include/trace/events/spi-mem.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi-mem
+
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR spi_mem
+
+#if !defined(_TRACE_SPI_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SPI_MEM_H
+
+#include <linux/tracepoint.h>
+#include <linux/spi/spi-mem.h>
+
+#define decode_dtr(dtr) \
+	__print_symbolic(dtr, \
+		{ 0, "S" }, \
+		{ 1, "D" })
+
+TRACE_EVENT(spi_mem_start_op,
+	TP_PROTO(struct spi_mem *mem, const struct spi_mem_op *op),
+	TP_ARGS(mem, op),
+
+	TP_STRUCT__entry(
+		__string(name, mem->name)
+		__dynamic_array(u8, op, 1 + op->addr.nbytes + op->dummy.nbytes)
+		__dynamic_array(u8, data, op->data.dir == SPI_MEM_DATA_OUT ?
+					  min(op->data.nbytes, 64) : 0)
+		__field(u32, data_len)
+		__field(u32, max_freq)
+		__field(u8, cmd_buswidth)
+		__field(bool, cmd_dtr)
+		__field(u8, addr_buswidth)
+		__field(bool, addr_dtr)
+		__field(u8, dummy_nbytes)
+		__field(u8, data_buswidth)
+		__field(bool, data_dtr)
+	),
+
+	TP_fast_assign(
+		int i;
+
+		__assign_str(name, mem->name);
+		__entry->max_freq = op->max_freq ?: mem->spi->max_speed_hz;
+
+		__entry->cmd_buswidth = op->cmd.buswidth;
+		__entry->cmd_dtr = op->cmd.dtr;
+		*((u8 *)__get_dynamic_array(op)) = op->cmd.opcode;
+
+		__entry->addr_buswidth = op->addr.buswidth;
+		__entry->addr_dtr = op->addr.dtr;
+		for (i = 0; i < op->addr.nbytes; i++)
+			((u8 *)__get_dynamic_array(op))[i + 1] =
+				op->addr.val >> (8 * (op->addr.nbytes - i - 1));
+
+		memset(((u8 *)__get_dynamic_array(op)) + op->addr.nbytes + 1,
+		       0xff, op->dummy.nbytes);
+
+		__entry->data_len = op->data.nbytes;
+		__entry->data_buswidth = op->data.buswidth;
+		__entry->data_dtr = op->data.dtr;
+		if (op->data.dir == SPI_MEM_DATA_OUT)
+			memcpy(__get_dynamic_array(data), op->data.buf.out,
+			       __get_dynamic_array_len(data));
+	),
+
+	TP_printk("%s %u%s-%u%s-%u%s @%u Hz op=[%*phD] len=%u tx=[%*phD]",
+		__get_str(name),
+		__entry->cmd_buswidth, decode_dtr(__entry->cmd_dtr),
+		__entry->addr_buswidth, decode_dtr(__entry->addr_dtr),
+		__entry->data_buswidth, decode_dtr(__entry->data_dtr),
+		__entry->max_freq,
+		__get_dynamic_array_len(op), __get_dynamic_array(op),
+		__entry->data_len,
+		__get_dynamic_array_len(data), __get_dynamic_array(data))
+);
+
+TRACE_EVENT(spi_mem_stop_op,
+	TP_PROTO(struct spi_mem *mem, const struct spi_mem_op *op),
+	TP_ARGS(mem, op),
+
+	TP_STRUCT__entry(
+		__string(name, mem->name)
+		__dynamic_array(u8, data, op->data.dir == SPI_MEM_DATA_IN ?
+					  min(op->data.nbytes, 64) : 0)
+		__field(u32, data_len)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, mem->name);
+		__entry->data_len = op->data.nbytes;
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			memcpy(__get_dynamic_array(data), op->data.buf.in,
+			       __get_dynamic_array_len(data));
+	),
+
+	TP_printk("%s len=%u rx=[%*phD]",
+		__get_str(name),
+		__entry->data_len,
+		__get_dynamic_array_len(data), __get_dynamic_array(data))
+);
+
+
+#endif /* _TRACE_SPI_MEM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.35.1.1320.gc452695387.dirty


