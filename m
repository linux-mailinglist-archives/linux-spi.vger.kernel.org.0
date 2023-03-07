Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A26AF751
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 22:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCGVOr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCGVOn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 16:14:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D297FD8
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 13:14:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedk-0002H2-LT; Tue, 07 Mar 2023 22:14:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedj-002ZBe-Jg; Tue, 07 Mar 2023 22:14:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedi-0037BZ-JO; Tue, 07 Mar 2023 22:14:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/2] spi: sprd: Convert to platform remove callback returning void
Date:   Tue,  7 Mar 2023 22:14:24 +0100
Message-Id: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=20uOaUxM/0tfQrqOVznZg/A7D+RGNsgmvlaSGH0PAoI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkB6kmawKClBubr3G51sW9zDxSruseVLoRwty6W +Tl1hsqw0uJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAepJgAKCRDB/BR4rcrs Cc7OB/9fv30xQSbfJyALZSo9w7ShqDEqb5D5G7AJPRtoqsBC9rvHrtOxeVBKP3uyak9gUlPtT21 CyS2mwq003SEQjoPOgZpA3N9+a0HrU++iCP0PxYiHeqO4sIsFy0jMqu4bgZ87WjKF1tQiRH6Gsc m0L+Z34VIE5GPm6l4xATbNgMEWLDDaHQ+j2fqwQOunTTnekC+5XurQD5Hd2WLhRCNj7982E8n9e YJwn4o/AmfY4MZq76FZQT1J9+SIepi8sOkVRRqLaWHGL0ykq+nW2K5MYRGhKpXOCVow4KQ1UAh5 0GMcYbwxMugwswlqzrFR+osk0l4rqG7s81gYtuuE0vcNkHBK
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

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Hello,

An early error return from a remove callback is usally wrong. In the
case of the spi-sprd driver it's not that critical because the skipped
steps are mainly undoing the things that a successful runtime-resume
would have done.

Still it's cleaner to not exit early and not return an (mostly ignored)
error value. The second patch converts to .remove_new (which is the
motivation for this series).

Best regards
Uwe

Uwe Kleine-König (2):
  spi: sprd: Don't skip cleanup in remove's error path
  spi: sprd: Convert to platform remove callback returning void

 drivers/spi/spi-sprd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

