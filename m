Return-Path: <linux-spi+bounces-6639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710FA2A3B3
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 09:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3909C188203E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAB225798;
	Thu,  6 Feb 2025 08:58:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598822578A;
	Thu,  6 Feb 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832291; cv=none; b=uoY1JY/qMnC54vu1s84A0q7j7lApTS9FGOoLkwmk2647EKIXsB1gbcTzKcWZ19NBjjJYTmPLOtIR2T02737utcILNJjoxYiZzXq+REyTsgivWyGWk4CwEO3cnWRMH+e0DyzZCsxg+1jaDNHOg0+Nx1/HPHNwynJMc4rrT2wnCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832291; c=relaxed/simple;
	bh=snZetSh+O+16zu7OB+zRKFnyhedhxJaN1GrQR/Z19oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ApluwlwkSFqHw7g16h2jn6Js9H5uHHdTCwbVvZw75+OMD2Fm17PthmXAdKpW2Eh2c9UYo1wDYOvc1Y8tcQvLQpDWHLQGZNQt3UosuzL1RpQ0G+fl7n2B/54pjJ8LBGZMLwQLTAGKed5Sse9ooifFOVGeWwB/HrP2aydjGx63NiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Feb 2025 17:58:08 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 2FF02200F133;
	Thu,  6 Feb 2025 17:58:08 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 6 Feb 2025 17:58:08 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id E43ACAB187;
	Thu,  6 Feb 2025 17:58:07 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Kohei Ito <ito.kohei@socionext.com>
Subject: [RESEND PATCH v1] spi: sn-f-ospi: Fix division by zero
Date: Thu,  6 Feb 2025 17:57:47 +0900
Message-Id: <20250206085747.3834148-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no dummy cycle in the spi-nor commands, both dummy bus cycle
bytes and width are zero. Because of the cpu's warning when divided by
zero, the warning should be avoided. Return just zero to avoid such
calculations.

Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")
Co-developed-by: Kohei Ito <ito.kohei@socionext.com>
Signed-off-by: Kohei Ito <ito.kohei@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-sn-f-ospi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index adac645732fe..56ef114effc9 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -116,6 +116,9 @@ struct f_ospi {
 
 static u32 f_ospi_get_dummy_cycle(const struct spi_mem_op *op)
 {
+	if (!op->dummy.nbytes)
+		return 0;
+
 	return (op->dummy.nbytes * 8) / op->dummy.buswidth;
 }
 
-- 
2.25.1


