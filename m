Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8187E13EE
	for <lists+linux-spi@lfdr.de>; Sun,  5 Nov 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKEOjo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Nov 2023 09:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjKEOjo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Nov 2023 09:39:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A644C6
        for <linux-spi@vger.kernel.org>; Sun,  5 Nov 2023 06:39:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeHs-0000CS-3x; Sun, 05 Nov 2023 15:39:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeHr-006oRT-Ln; Sun, 05 Nov 2023 15:39:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzeHr-00DBo0-Ca; Sun, 05 Nov 2023 15:39:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: cadence-xspi: Drop useless assignment to NULL
Date:   Sun,  5 Nov 2023 15:39:33 +0100
Message-ID: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ztrTOf1PUpIRrUplBdnHfkQo1H6Zr5pWLOrZw/TdZqY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR6kkzaFCmX1pp8XsNE5ub7q+nZYaNb83wE7zE 9Z9ciwspY2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUepJAAKCRCPgPtYfRL+ Tna2B/9zwapQz6QHmuhMWmD2/3OjTT+YIWbbzwdOF9CL0B3oWoZQthN8qLHMjXfSipKakfUtMgb 3nWGtu3YfchS2eCMsngx+MJX5eI0yKZQbgbLzoLHZ4FkfMxYQvVsZx6TmJ+W07WBTMymjY4TH0n XLO67pL/YQ26A2vhMn6FSB2BLqVXSPM1DZxgojdtbNfDOJwXu2/IvgzuO65LiaID93fI4rhhaXd BegFoOB/Qte62AyxL9ngs6uPOor0j6eHZ5OlM0H48ZYGL5cfG7lWxI5GSOkKy+T7VTu4LwfU9oS 8B+NyCGJjBFgj02KW0ivXBHQKca32JN5L6qiLPP6VzvTWbdw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Static structs are initialized with zeros for unspecified fields. So
there is no advantage to explicitly initialize .remove with NULL and the
assignment can be dropped without side effects.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cadence-xspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index b7e04b03be58..8648b8eb080d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -619,7 +619,6 @@ MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
 
 static struct platform_driver cdns_xspi_platform_driver = {
 	.probe          = cdns_xspi_probe,
-	.remove         = NULL,
 	.driver = {
 		.name = CDNS_XSPI_NAME,
 		.of_match_table = cdns_xspi_of_match,

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.42.0

