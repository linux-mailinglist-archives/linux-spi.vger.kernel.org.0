Return-Path: <linux-spi+bounces-7073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4CA55E47
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 04:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96198175E17
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105418DB1F;
	Fri,  7 Mar 2025 03:25:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642529408;
	Fri,  7 Mar 2025 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317951; cv=none; b=WcBrsvieWwBKP3mNIW5Bo526wmOvAHftD36JTUbV2232Bn0D1Twzll1p5oESglgBnEqAEvMku3cDtnOpsbSCR/tBH1iUMGlZyS6QHWKoVcDpyzaC918q/JfCpSgvRmkHJqeNU1RTShbJ0KeCIP440ndHnrJ9m2XrAjLBUTrEAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317951; c=relaxed/simple;
	bh=AeizJya3IEeXZE/xwtzLxLFEXt9d6U6q8b3BRF4dsEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uIFNe0Val8kLOKvTqMQbDqWPkjcShblEIJjllH/rBij8YoHvZewEUJ8RspAODPdggjn981iDKIioht55qou11C2BRXy4takuJ/dQg3OfIiwfk/bpLRMVksYK5p5JuJ4tk/8IqjIth2oJi1TIpfTRly846K/hCFmJzqGzqr3NEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503071125354834;
        Fri, 07 Mar 2025 11:25:35 +0800
Received: from locahost.localdomain (10.94.18.185) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 7 Mar 2025 11:25:34 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <broonie@kernel.org>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <patrice.chotard@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] spi: stm32: Fix a NULL vs IS_ERR() bug
Date: Fri, 7 Mar 2025 11:25:28 +0800
Message-ID: <20250307032530.116837-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025307112535a815d6c3a2c39f102f9dbacaeff8520a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The devm_ioremap() function doesn't return error pointers, it may
returns NULL.  Update the error checking to match.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 8eadcb64f34a..a544d7897edf 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -835,10 +835,10 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	if (rmem) {
 		ospi->mm_size = rmem->size;
 		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
-		if (IS_ERR(ospi->mm_base)) {
+		if (!ospi->mm_base) {
 			dev_err(dev, "unable to map memory region: %pa+%pa\n",
 				&rmem->base, &rmem->size);
-			ret = PTR_ERR(ospi->mm_base);
+			ret = -ENOMEM;
 			goto err_dma;
 		}
 
-- 
2.43.0


