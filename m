Return-Path: <linux-spi+bounces-10938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67020C2658A
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 18:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5353BF7ED
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8E313E00;
	Fri, 31 Oct 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vvI4HU/g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18711309EF4;
	Fri, 31 Oct 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931696; cv=none; b=kjPQGUN9MxA7e/SsRQW4pvMxEPMC6U60y+k+mhWhDEnD2AxtTuCKy0c4tUcqevUozdkQLoC5ZgOPsnIpxFLrgqOn5u5LSpCSMTUD+61aYMYEozvdrg6ECfPVDQDEPWZsnM1vDUqTgYVg8r7WkYQXqL60pqi2b+rUo15SexZqXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931696; c=relaxed/simple;
	bh=Ll99UYQGGbu1eTDA6A1FqaugkPOuyw0NjihqNfzOht4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/W44wpc9Rq09xVo3QT7OwKtf/0ooBimGuzR1Lm1IPQaZLabhHz1+EQ+a0IYNTrQxCEeJ33Q1bmVyBT8NkStYT/QIZ6hx71SitJASbUmE96mvQyn7nCRMvqsOzQY2PL7F9IKyOo2sfuCFSu7ACXk7WfkLRiMDts7lUVsL3W6Wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vvI4HU/g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B6C64C0E95A;
	Fri, 31 Oct 2025 17:27:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 477B860704;
	Fri, 31 Oct 2025 17:28:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AD781181800B;
	Fri, 31 Oct 2025 18:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MQ2OSbA2wX7GpEne4dN3xY/3vjobyU3TcL9SV/CMJH8=;
	b=vvI4HU/grcaLTF2EgrEQqMZN9bpaAXWY9kU/ltufl/+RXDyc8UiYJSFIMOx971wR5+m+mr
	/QABjhbFEv4ePBgoNHVR2N6ddUH9WnFa5VkJJC9BJHzFGQU37w2MpQE8nPQXuSYqKVJxy2
	/rJvT+fSBGXmFItqrda9qTNeJApBDcI5QZTN8G7TiTJ1D0+BpfSKYZACjPU3R4kDJG3DTA
	21jLXXDmkN/Az90EQnn13I75WOxgp+gSlF7wrIQUAP0/vtsSZIt+qQPe5bJxz/VLZtu8yA
	D8erudFjW/vAZudPrgCii7M+0HwZXQyns2C3vYuwNhvQKW0ERiV9I44Z6wRMTg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:46 +0100
Subject: [PATCH 02/28] spi: spi-mem: Create a repeated address operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

In octal DTR mode, while the command opcode is *always* repeated,
addresses may either be long enough to cover at least two bytes (in
which case the existing macro works), or otherwise for single byte
addresses, the byte must also be duplicated and sent twice: on each
front of the clock. Create a macro for this common case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 81c9c7e793b6ab894675e0198d412d84b8525c2e..e4db0924898ce5b17d2b6d4269495bb968db2871 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -43,6 +43,14 @@
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
+	{							\
+		.nbytes = 2,					\
+		.val = __val | __val << 8,			\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\

-- 
2.51.0


