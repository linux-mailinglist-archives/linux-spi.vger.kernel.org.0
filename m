Return-Path: <linux-spi+bounces-7824-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A7AA6E8E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6729467403
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AE23184A;
	Fri,  2 May 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wUIuHIPm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u8BJ4QAW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB011C5F35
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179795; cv=none; b=dIngt7sCgFKPn/DXt4cVgf5x//1a5a0qAR9FLIGiBRyjcUasXsKBAWknD/XBVHUx9mtMfg3N+Qx9yI4Dniqz2AuSBjVQJkpai971RQhNho/ZUgilEy9eLF3SIcZ5HnjFjd80H+YLf7NZYfWoBCj/Fk3BZfzhiZVb5crXhhZM6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179795; c=relaxed/simple;
	bh=WjO6AEqa0Ouz5EJQDzlASn3VVIVtDm8ZTswc2iGPnaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiF3gbAWuSo/59ihg6p87Ed3CnHDn+5jYtnWWkb5YWnIZ6S53KZLDmR8JFYHI2bLYW0t02rgTUIecc5o7lKgbXO6DC3JlKszfI2QLkRI+Mrwf6TTkbwRqpbAhT8CK/P6wIcRJ8YcaItNvYxC0yADASuhigoog/XtZTn8uy5jxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wUIuHIPm; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u8BJ4QAW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZpmXS3J33z9srw;
	Fri,  2 May 2025 11:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1746179784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2vepB/jIPEQ40g8BwgCTBXA96g1diL6qKR/zGjCPoIw=;
	b=wUIuHIPmER+Q6gjs7PrATL/IgCqKJml8B7+HLDKhegjvc+REJ8UW80uWGMdifKrWdw4gPq
	qU1pySt9dg59eWz7g9ZfIupTJ3AK9VA010DbVQWKU4PG7Lp9/Q/giMVAEqy2rZ3iA7qTHa
	cy6FD7RtPZbgBuxLJZreaBOT8iCoyhKb0a+7FWmvnEEFK18X5ZWBLWDrxhctajJDR0QE0S
	6H/6FOCOIboeVaCXhgkVxEGtNLFhsQueXayxzHSwbphBUR3yBV0d5jMQ36fN57nXOhKjPw
	6F3huQLvD4FK+GxV3ZA9IfXWpV8fCC8vWR7Id76Kd0PutE0S9S3teSAgpE4ciQ==
From: Alessandro Grassi <alessandro.grassi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1746179782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2vepB/jIPEQ40g8BwgCTBXA96g1diL6qKR/zGjCPoIw=;
	b=u8BJ4QAW8eluiP9U35uZ5nyQc4cuuIO/SlKwUSFER7hc8GXXs9D6NDpHbczmvZ5IwsHnlE
	7sSK0G5G2c4AhvYCzlqVUeQaDR6Axa42IDm2jZa3Kp84N6qvU4iwlfNsJfgEjbZXvi+oJw
	dFqLihJcTTSsJHuZwn9UgkB+sejHIorFPKj+Wgt9Os3up70iaWgQ73UnY5xrsy9AYX/JCx
	qErFGgq3bY3j5Kji+g6KaogI6y5lm3SVtIltTR0vdx4SpHMZUWHjXAs+rjtCtlI3mmHDcl
	h7cilRrPhbZ5y0duy54uoIaaOXtxWUNvKbXweODIYXi+wQyiD63dfKpiwttg1w==
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	Alessandro Grassi <alessandro.grassi@mailbox.org>
Subject: [PATCH] spi: spi-sun4i: fix early activation
Date: Fri,  2 May 2025 11:55:20 +0200
Message-ID: <20250502095520.13825-1-alessandro.grassi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f43294ea0a781a1fb67
X-MBO-RS-META: ayooh4b75ws1eydhkaph4xzspb41cmx7

The SPI interface is activated before the CPOL setting is applied. In
that moment, the clock idles high and CS goes low. After a short delay,
CPOL and other settings are applied, which may cause the clock to change
state and idle low. This transition is not part of a clock cycle, and it
can confuse the receiving device.

To prevent this unexpected transition, activate the interface while CPOL
and the other settings are being applied.

Signed-off-by: Alessandro Grassi <alessandro.grassi@mailbox.org>
---
 drivers/spi/spi-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f89826d7dc49..aa92fd5a35a9 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -264,6 +264,9 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -404,7 +407,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
-- 
2.47.2


