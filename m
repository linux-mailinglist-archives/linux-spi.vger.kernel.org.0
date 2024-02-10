Return-Path: <linux-spi+bounces-1259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216C850554
	for <lists+linux-spi@lfdr.de>; Sat, 10 Feb 2024 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E081F25567
	for <lists+linux-spi@lfdr.de>; Sat, 10 Feb 2024 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5315C5E2;
	Sat, 10 Feb 2024 16:40:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B405C5E8
	for <linux-spi@vger.kernel.org>; Sat, 10 Feb 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583249; cv=none; b=oJgpL5vGYFnnbaU1thROnrObF/PoEdfxZ3GVq5jeWKFsOmH+JHu2W3FWrYWNU8dX0hbRo08rJ6Xmb0v/RWSmsS23xgNQa+Xz3URsbG6tX1u4wsYPPB2mjPzdRy3t9zd3VBqR4QcZieZJpmXzEG57ix2uAaPPkF8+gn9IFCdBvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583249; c=relaxed/simple;
	bh=zxnkSjU8zgg5ZUmhJtmpcwisYsjJs7ecC4KVxXBlVv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOaQXlQoTLZ1XuNRTVaGOEOnZEV1FPTskTxlQegQBYuxvTL4Et3pY9pRuCONrehjVUMF6yX3+d26dyvrNSb5OpNJhqzPVcBh6Ax2Kk5hzQW49k9VuoPE5Yfwp2XdgLBASadexFIY9FQZ13iRc/h4eb5UcoUhr89O01UtxRxRGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOs-0001I9-Pk; Sat, 10 Feb 2024 17:40:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-005i47-L7; Sat, 10 Feb 2024 17:40:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rYqOq-002ER7-1p;
	Sat, 10 Feb 2024 17:40:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: ppc4xx: Fix fallout from include cleanup
Date: Sat, 10 Feb 2024 17:40:06 +0100
Message-ID: <20240210164006.208149-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zxnkSjU8zgg5ZUmhJtmpcwisYsjJs7ecC4KVxXBlVv0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlx6bne49I0C7mT2sVPnGiyLzjcN+/ccr00u0TY K8GCKbq1XKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcem5wAKCRCPgPtYfRL+ TrdaB/4rSPzpBWOEz6E+zsmujs4yigrklb06Mhmpmd2UGYGCicl0nJvdDPvmqm/zCC0offJN/Qo zWR7v9EmBqoLM5e/nmWWGOwl01qVp75ZMJ7ialpK6QwuPUMjyeqk2ep3CJLHosr5DwNQ1H8gaDU DQqCZmnW7/CBSwIeX0aFNj8BSPYJInkqOSJSMqW1jbAmd1oeqPYWhRCGTJ0GauFaKu1j/tN9XND f17x7EXQuI7/b4tk/uz+ZKykixoJXG7vLkGCS0NQX5b4rNzvk73sm3iXIgI4s4yNjMC/3zCpiOU d5UjhhA+V5LPHjD71G/eDAzi6zIBVz5XK5tQPt+7aQXdV7Wm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The driver uses several symbols declared in <linux/platform_device.h>,
e.g module_platform_driver(). Include this header explicitly now that
<linux/of_platform.h> doesn't include <linux/platform_device.h> any
more.

Fixes: ef175b29a242 ("of: Stop circularly including of_device.h and of_platform.h")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-ppc4xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 412d6e678224..2290b40459ef 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -31,6 +31,7 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-- 
2.43.0


