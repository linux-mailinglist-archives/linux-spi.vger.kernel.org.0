Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18842A887
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhJLPmM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbhJLPmI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5BC061767
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsj-0000I1-Qq; Tue, 12 Oct 2021 17:39:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsj-0004kB-9q; Tue, 12 Oct 2021 17:39:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsc-0004YH-6D; Tue, 12 Oct 2021 17:39:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 07/20] media: cxd2880: Eliminate dead code
Date:   Tue, 12 Oct 2021 17:39:32 +0200
Message-Id: <20211012153945.2651412-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=i/V0IwiXrJHb2puTsy4r3UAQrVBpJK4uRHfeGK5dIi4=; m=6Brp6ipiIrN4N0gba2jlJ7ZY/JS2k/XshUNdN7/roa8=; p=8ZiFid/gojahfXRtSIUMwOZadkeWb7YdowfHaijfOII=; g=d6494736086a7092e3c965bf6057c1246baeecdc
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrA0ACgkQwfwUeK3K7AmsNgf7BfZ I7zwHdHpHgVO+f3PbnRyDrjG6tyn0xgkcl2ZNNWmkO0e3wtFAGep6OmlaRjEFEb7uz6XTIDdQZds0 K2cFwH5xSVJF+C9Y95vGqz7sr81H0imQJ908h3lpoqVZzdzNaxm2jFV/CTUZB/h/rE1e/ymSnFY6M 7KSC2dCwKbohf/IWACgBCc4BTxjQqcJA/YpTYzqoFJVANDpLF/fA3N3pihjeXB1aBaDu8tfPp4Fhz tTIUTOiFAQ60Oh3ihxCRB7IpjD68df45f3+J1qfuWhZBoN0S4bl0sA+fZWx5B7zAP343Cij38bDH6 jy3bUzJWLhv1g4KA2UzL1A4oSoxmfEA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

An spi remove callback is never called with an spi_device pointer that
is NULL. Also it is only called for devices that probed successfully. As
cxd2880_spi_probe() always sets driver data, spi_get_drvdata() cannot be
NULL.

Also the return value of spi remove callbacks is ignored anyway and not
freeing resources in .remove() is a bad idea.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/media/spi/cxd2880-spi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index b91a1e845b97..67cacf29a61e 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -628,19 +628,8 @@ cxd2880_spi_probe(struct spi_device *spi)
 static int
 cxd2880_spi_remove(struct spi_device *spi)
 {
-	struct cxd2880_dvb_spi *dvb_spi;
+	struct cxd2880_dvb_spi *dvb_spi = spi_get_drvdata(spi);
 
-	if (!spi) {
-		pr_err("invalid arg\n");
-		return -EINVAL;
-	}
-
-	dvb_spi = spi_get_drvdata(spi);
-
-	if (!dvb_spi) {
-		pr_err("failed\n");
-		return -EINVAL;
-	}
 	dvb_spi->demux.dmx.remove_frontend(&dvb_spi->demux.dmx,
 					   &dvb_spi->dmx_fe);
 	dvb_dmxdev_release(&dvb_spi->dmxdev);
-- 
2.30.2

