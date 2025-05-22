Return-Path: <linux-spi+bounces-8237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0575AC0A2F
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04B63B9B51
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCB1A3A94;
	Thu, 22 May 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aE28sjqJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42D20328;
	Thu, 22 May 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911559; cv=none; b=ld/SifVBaNl8rJBAfVpWllCaimJBXffwu5RDZWrMwZGVtACmIUt7TdFO8g2Wnly3Ho9ce6nT+EsEg5GODDN701uhx6gTmYsWf46W4sEG6kiGv/5pJttGMmLVW8bb07KktlCPlTUPzcXb02spVQrRgyOLz+YBykwCLlN6AgEN7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911559; c=relaxed/simple;
	bh=oVc2l+nSbm/Diti1r9QlUqGa3gFNeKqKd996ksGyD4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXJ1V1GJVmlh3lTChxtcNe1NTzVDHAxM+fP1Jff4Bqm/cyAniiQ/BTr5ehgJvAddZxPhBoUzEF9vWiows1GL5kmlA7SiSNm8MgzHAcUHcDWxXJMsRJ3r75Nztcv7JpqtebPnN5AbhP4no5PwPNNSYQL4APs/nKJGaVE8S/mdM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aE28sjqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB38C4CEE4;
	Thu, 22 May 2025 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747911558;
	bh=oVc2l+nSbm/Diti1r9QlUqGa3gFNeKqKd996ksGyD4c=;
	h=From:To:Cc:Subject:Date:From;
	b=aE28sjqJbT/l4wWTE8q9ORL6EuebjQko550XWqC0X2u5io8K/AqeastFG6fhwkBea
	 x/K5wldzBLsQE8ZPpCnXUMZDAmpM6i3JjeFvQiAfUU9x6qR6FhTz+yG7yyfxPnjDZT
	 jTnEnllCAepjFOd77j2oFXZgQ6BphvqLLqtbRWNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: loopback-test: fix up const pointer issue in rx_ranges_cmp()
Date: Thu, 22 May 2025 12:59:14 +0200
Message-ID: <2025052213-semifinal-sublevel-d631@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 28
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=oVc2l+nSbm/Diti1r9QlUqGa3gFNeKqKd996ksGyD4c=; b=owGbwMvMwCRo6H6F97bub03G02pJDBn6zI0/p0jZlZ6qWHBuwuMw+8bkggl5J1d4qRxY0ndHn fXJDzbpjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIlh8MCxZFSWldV3i5frrq zKZ/9itP+2a1PmVY0BXwQvfoIrHV+5wdV7Ucd1Z9sXTqNAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When a list head is a const pointer, the list entry for that head also
must remain a const pointer, otherwise we are just "throwing it away"
for no good reason.  Fix this up by properly marking these structures as
const.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 31a878d9458d..0389fce5b1f2 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -494,8 +494,8 @@ struct rx_ranges {
 static int rx_ranges_cmp(void *priv, const struct list_head *a,
 			 const struct list_head *b)
 {
-	struct rx_ranges *rx_a = list_entry(a, struct rx_ranges, list);
-	struct rx_ranges *rx_b = list_entry(b, struct rx_ranges, list);
+	const struct rx_ranges *rx_a = list_entry(a, struct rx_ranges, list);
+	const struct rx_ranges *rx_b = list_entry(b, struct rx_ranges, list);
 
 	if (rx_a->start > rx_b->start)
 		return 1;
-- 
2.49.0


