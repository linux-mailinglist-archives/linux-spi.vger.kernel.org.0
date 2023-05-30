Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE0715824
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjE3IQ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjE3IQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 04:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279A9D
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 01:16:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXF-0008ME-5u; Tue, 30 May 2023 10:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXE-003pUq-2R; Tue, 30 May 2023 10:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXD-009PLk-Co; Tue, 30 May 2023 10:16:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/3] spi: mt65xx: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 10:16:45 +0200
Message-Id: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=644; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kg97sQv5DoA+oGSXg9CVV4WclrrXCk1z5GaXBZO/fbc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdbDlBF4ptq5kTtvb1PybOQI2bkX0sNVhLzsX0 0bcQuOe4KKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWw5QAKCRCPgPtYfRL+ TqcOB/9AhWVxKFwFfosZ0BVoPkuGDn+m8RcHe+SrXp9tSPo/AswsaqyMbbopNoTc6xeLcbmz2jk x6L8WmZUOcfBe66hhMdGPk1sTWG0kG38+vWFf5fw+DVsg5MnINClgaMOlcxjfxONgso+ze72ZVp 4M4h7JUFh7A77UPSp14wJ2m5ndFeJXnA41s+9vllPrsy6H1llO+soWemMkshaWhZxNo4Ci3FslU GwP01MBWMW6XshoWZ9/Mtvrgz8gzxnwbVoy2C+6xIbF5H1nhkaLYKWBu/bza9vP0+woAsG0RYP+ cflbLdReu80iikieQ/LFBowo6rBWJ/odoDzzPg2RI1s2sOAP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

compared to (implicit) v1 sent in March with Message-Id:
<20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>, I reworked
patch 1 on feedback by AngeloGioacchino Del Regno. Patches 2 and 3 got
his Reviewed-by.

Best regards
Uwe

Uwe Kleine-König (3):
  spi: mt65xx: Properly handle failures in .remove()
  spi: mt65xx: Convert to platform remove callback returning void
  spi: mt65xx: Don't disguise a "return 0" as "return ret"

 drivers/spi/spi-mt65xx.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

