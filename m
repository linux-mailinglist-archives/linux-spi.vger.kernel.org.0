Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0166F2A67C8
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgKDPfi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgKDPfh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Nov 2020 10:35:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E5C0401C1
        for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2020 07:35:37 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kaKos-0004O2-77; Wed, 04 Nov 2020 16:35:30 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kaKor-0006cD-H9; Wed, 04 Nov 2020 16:35:29 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v1 0/2] Input: ads7846: reduce SPI related CPU load 
Date:   Wed,  4 Nov 2020 16:35:26 +0100
Message-Id: <20201104153528.25362-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series is optimizing SPI transfer related CPU load.

Oleksij Rempel (2):
  Input: ads7846: convert to full duplex
  Input: ads7846: convert to one message

 drivers/input/touchscreen/ads7846.c | 395 +++++++++++-----------------
 1 file changed, 151 insertions(+), 244 deletions(-)

-- 
2.28.0

