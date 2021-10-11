Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F5428DCB
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhJKNaI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhJKNaI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:30:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F7C06161C
        for <linux-spi@vger.kernel.org>; Mon, 11 Oct 2021 06:28:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLZ-0006fj-Rm; Mon, 11 Oct 2021 15:28:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLV-0003ng-C7; Mon, 11 Oct 2021 15:28:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZvLV-0000SC-BC; Mon, 11 Oct 2021 15:28:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/13] drm/panel: s6e63m0: Make s6e63m0_remove() return void
Date:   Mon, 11 Oct 2021 15:27:42 +0200
Message-Id: <20211011132754.2479853-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=s7lxpA3SlxdAgalZdfZtQ9BEymVUSL76ohaDIVT+Hbk=; m=QwS8VQ147nh5eUkRo9mxGTfBcUgnx3Jl4gdGJ73rKHM=; p=gB1Eh6qhdZKXG7+Sv2MnM6FjygYEx1l/LzdGrasJ/Qc=; g=4d3b9377dd7211c6773f6965376e81757de8d724
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFkO2AACgkQwfwUeK3K7Ame9Qf/eAD tFQYqwS+uD6PKIsI4sLe39e5/3VEZ6+nKm9vaW16R3ClIdLI5TNn+Ve60BlNob14yiCgANJyrHf0A 6uTH+vpvp8Ydmhg8R+4p7bDJZL6VLlcDSdbgp9z82EKnRDEJa3yHA+9bQaI5YE3rMsUlJRllChWlc gl5/UIK336D1rG6NgLfb8XPCtpO+hNdUE30JRpyPPx6ZI/MQ0XAgjgsLnoDT6keRzAN/cF02MSo0/ MMOPHHZmstFum/q4oxqUIWkLt9ZWvv6e7TS4dr11GZ/hESKI9qZ8ArXXOmcDgyxWcC5BXWqKTvLLV 5GqAwDrkucRj8rSvRG7B4n2uVA3LviA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now s6e63m0_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c | 3 ++-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c | 3 ++-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c     | 4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
index e0b1a7e354f3..e0f773678168 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
@@ -116,7 +116,8 @@ static int s6e63m0_dsi_probe(struct mipi_dsi_device *dsi)
 static int s6e63m0_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	mipi_dsi_detach(dsi);
-	return s6e63m0_remove(&dsi->dev);
+	s6e63m0_remove(&dsi->dev);
+	return 0;
 }
 
 static const struct of_device_id s6e63m0_dsi_of_match[] = {
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
index 3669cc3719ce..c178d962b0d5 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
@@ -64,7 +64,8 @@ static int s6e63m0_spi_probe(struct spi_device *spi)
 
 static int s6e63m0_spi_remove(struct spi_device *spi)
 {
-	return s6e63m0_remove(&spi->dev);
+	s6e63m0_remove(&spi->dev);
+	return 0;
 }
 
 static const struct of_device_id s6e63m0_spi_of_match[] = {
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index 35d72ac663d6..b34fa4d5de07 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -749,13 +749,11 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 }
 EXPORT_SYMBOL_GPL(s6e63m0_probe);
 
-int s6e63m0_remove(struct device *dev)
+void s6e63m0_remove(struct device *dev)
 {
 	struct s6e63m0 *ctx = dev_get_drvdata(dev);
 
 	drm_panel_remove(&ctx->panel);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(s6e63m0_remove);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
index 306605ed1117..c926eca1c817 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
@@ -35,6 +35,6 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 				   const u8 *data,
 				   size_t len),
 		  bool dsi_mode);
-int s6e63m0_remove(struct device *dev);
+void s6e63m0_remove(struct device *dev);
 
 #endif /* _PANEL_SAMSUNG_S6E63M0_H */
-- 
2.30.2

