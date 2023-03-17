Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D328E6BE41A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCQIoS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjCQIn6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 04:43:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB09748C
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 01:42:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fc-0004tK-Oc; Fri, 17 Mar 2023 09:42:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-004jZR-PA; Fri, 17 Mar 2023 09:42:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-005ZuF-0z; Fri, 17 Mar 2023 09:42:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 0/3] spi: atmel-quadspi: Convert to platform remove callback returning void
Date:   Fri, 17 Mar 2023 09:42:29 +0100
Message-Id: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YAFz1YTnuThYDtNAEGpCUm2bF1gQGO712oyG7d1fBas=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkFCfmCsrEOkqElR7kJ9OSWkLwy5ojHbI5ybVwa FEGg6jvbkWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBQn5gAKCRDB/BR4rcrs CfKLB/9J78qp1+tWVUvWypWDvOa4T8wJMVEdW7Z/5R9Xz/eefcbdeJlxi10M8TTJ3kwUYJXZOWs 3GDTAl1Pzd1IDfYeZQsusMdhzfZjAYVCdWCm28uMmqABjPPraN5xnrPjREtmon78pDp5uOE4Q7e Zn2I9TjcZqgBUhR73ZmyhF7b1327SgU90GzelHZUR++ouUGEVZrXfqXEz6EEmgwt7y6mCUvpRP1 1AMb8A9NVs9Z3TU+9dqG3WMghK+uV7my57XbPjxoOfUeuKJIRGBhB+zHsM2jEFHTXrg9mJZMN5p a5VfDb5K2FvSUwE3AMZYlMv344Ss7x4SY/rDCjt0KcxraBH9
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

this series converts the atmel-quadspi driver to use the .remove_new()
callback that doesn't return an int but void. The motivation is to not
give driver authors a reason to (wrongly) believe that returning an
error code was sensible error handling. In fact the spi core only emits
a warning message in this case and otherwise continues as if the return
value was zero. This usually yields resource leaks that sometimes can
lead to exceptions later on.

The atmel-quadspi driver is one of these drivers that got error handling
wrong, this is fixed here and in the last patch the driver is converted
to .remove_new() with the eventual goal to change .remove() to return
void once all drivers are converted this way.

Best regards
Uwe

Uwe Kleine-König (3):
  spi: atmel-quadspi: Don't leak clk enable count in pm resume
  spi: atmel-quadspi: Free resources even if runtime resume failed in
    .remove()
  spi: atmel-quadspi: Convert to platform remove callback returning void

 drivers/spi/atmel-quadspi.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

