Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08A6D107A
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjC3VEH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjC3VEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 17:04:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C4E1BD
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 14:04:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQw-00028m-Oi; Thu, 30 Mar 2023 23:03:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQu-007qTP-Ny; Thu, 30 Mar 2023 23:03:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQt-009Hr6-DP; Thu, 30 Mar 2023 23:03:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/2] spi: qup: Convert to platform remove callback returning void
Date:   Thu, 30 Mar 2023 23:03:39 +0200
Message-Id: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=532; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9zfLMYlWQxEw1cqggl3wyAkDczsHo73o5BKfzj9wRDo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkJfko7IX+rXRzuLJK9EVaXaTFJiP63fl+8etGl dGIxdzf10CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCX5KAAKCRCPgPtYfRL+ TtlSCAC1LRfdhvag450TbLskpQmJQx6z1Kw4qdTu2LBMbm0+gQ9smWxi+tYncGMiaMVPKJbLIWX frZyP7QG240eC+O0ZKs+kI55rihJYCWgU3BQq+oQQ4xolBQP8WhF02lTxQFdYV1U67CW/RbS7qd IBkcdzREsy7SwtFEY/ZddSkxjs80tM1WkjRAWse8dN1QxRvw+4xMy4HujpwNACP4mbxze1cm3M+ l360ej0p9zoX8QUyxJvHCoBW9NetASbPc4549AHYcYL+lQXqTpk1MY46wKS3sikOZmj/NqicALq PTDoWkVICbER6shnmqSXhMZVQ23HD653XmddIdSjEFyVYX4d
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

after fixing the error handling in the .remove() callback of the qup
driver, convert it to .remove_new() preparing to make platform driver's
remove functions return void.

Best regards
Uwe

Uwe Kleine-König (2):
  spi: qup: Don't skip cleanup in remove's error path
  spi: qup: Convert to platform remove callback returning void

 drivers/spi/spi-qup.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

