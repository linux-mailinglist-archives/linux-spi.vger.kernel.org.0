Return-Path: <linux-spi+bounces-6637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7FA2A326
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C0A168789
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F722541F;
	Thu,  6 Feb 2025 08:27:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96652248B2;
	Thu,  6 Feb 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830443; cv=none; b=Q7e3v6dpt5Vlfq1EGDbGS+Xlz1Z/BmyvLMqToucumZ8T771/4CvsHuZjfATCZ3vFfR+mF5n50AB3tqbj9oJFMk5HcPo9DQ6mwOm/H0SQq0qMWvy5T2/8df9D/BDci5LN6aKmC+do+HkzPWeG3RVCL7PinwNLB6UGMksESgw0Rbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830443; c=relaxed/simple;
	bh=7ivFfgGgW83t8fwX7YiW4UBAiVDI2L3NrV1JPEDSr3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGWy4y6bceErbXFqrXZMU7SKaTMXl22AeVVFk9A0hZpX4JwnpuwSyCbULNP0yzKg5ewNb6C5Y/tJas0AtXoFYpeR2WslE91qujGrbGOBSI4rfPkHAeEvEb+O7Ar83Wzm1Wi2Bwl+bVLpsRWd1mr7kqPpIh53Y8/B2Mvhc39liEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Feb 2025 17:27:19 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id B98D92006FDF;
	Thu,  6 Feb 2025 17:27:19 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 6 Feb 2025 17:27:19 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 39613AB187;
	Thu,  6 Feb 2025 17:27:19 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] spi: sn-f-ospi: Fix division by zero
Date: Thu,  6 Feb 2025 17:27:17 +0900
Message-Id: <20250206082717.3833004-1-hayashi.kunihiko@socionext.com>
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


