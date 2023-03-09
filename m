Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610BA6B208B
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCIJsD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 04:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCIJro (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 04:47:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C87C85A6
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 01:47:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrc-0007fw-K6; Thu, 09 Mar 2023 10:47:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrb-002uv7-34; Thu, 09 Mar 2023 10:47:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCra-003VnE-5J; Thu, 09 Mar 2023 10:47:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] spi: mt65xx: Convert to platform remove callback returning void
Date:   Thu,  9 Mar 2023 10:47:01 +0100
Message-Id: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GAA9NNA1eTFeCZToI//iP4zdyMxlzjlonJ6Yd3JZGzQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCasJ9by57QrgVJwLr1WcRX1JKly2s5tmgWY3O DIuR5ioHueJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAmrCQAKCRDB/BR4rcrs CaBiB/0fKV7QCeyHztzEj87HC/VU6N9POqBn12jkY8NtAyfwaoqSDxR5EdEbMZIOdPlYwvGCeQF jeiU8B1nPmmxhZ2fCdiu4zPayo1sS1vYgzeY26wnoujisQw/C2/0J0lrSES7Bld7jscEjYWyasa WXDAbnb5dIM040gTbEJ5ZArw+45HVfYprK+uXWjSGbpDLF+P5+56/tePMp20q/e6367mlKxBcFc /7AnS2O9SNKtDraviCwv31VUIbMZ01jHxxq/oS45cFn9b/h2EaSAm3Dlmm0jOk68YL69u/zowKk AOB9vY4u38uXGFhfM039u3en76/Kk+0oAf/4SUl+6dTos/Ep
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

this series converts the spi-mt65xx driver to .remove_new(). While the
preparing patch that gets rid of an early error return is in many cases
a bug fix, it's not tragic here, as the early return only skips steps
that are not necessary after resume failed. Still rework the code flow
to prepare for conversion to .remove_new(). The 2nd patch actually
converts the driver. The third is a small nitpick cleanup the I noticed
while working on the driver.

Best regards
Uwe

Uwe Kleine-König (3):
  spi: mt65xx: Properly handle failures in .remove()
  spi: mt65xx: Convert to platform remove callback returning void
  spi: mt65xx: Don't disguise a "return 0" as "return ret"

 drivers/spi/spi-mt65xx.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

