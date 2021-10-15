Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E129042E975
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhJOG6s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhJOG6s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Oct 2021 02:58:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE9C061570
        for <linux-spi@vger.kernel.org>; Thu, 14 Oct 2021 23:56:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mbH8g-0004qv-LK; Fri, 15 Oct 2021 08:56:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mbH8c-0000DL-1m; Fri, 15 Oct 2021 08:56:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mbH8c-0006t3-0I; Fri, 15 Oct 2021 08:56:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 0/2 net-next] Let spi drivers return 0 in .remove()
Date:   Fri, 15 Oct 2021 08:56:13 +0200
Message-Id: <20211015065615.2795190-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

this series is part of my quest to change the return type of the spi
driver .remove() callback to void. In this first stage I fix all drivers
to return 0 to be able to mechanically change all drivers in the final
step. Here the two spi drivers in net are fixed to obviously return 0.

Returning an error code (which actually very few drivers do) doesn't
make much sense, because the only effect is that the spi core emits an
error message.

The same holds try for platform drivers, one of them is fixed en passant.

There is no need to coordinate application of this series. There is
still much to do until struct spi_driver can be changed.

Changes since v1:

 - Fix a compile error found by the kernel test robot, thanks!

Best regards
Uwe

Uwe Kleine-König (2):
  net: ks8851: Make ks8851_remove_common() return void
  net: w5100: Make w5100_remove() return void

 drivers/net/ethernet/micrel/ks8851.h        | 2 +-
 drivers/net/ethernet/micrel/ks8851_common.c | 4 +---
 drivers/net/ethernet/micrel/ks8851_par.c    | 4 +++-
 drivers/net/ethernet/micrel/ks8851_spi.c    | 4 +++-
 drivers/net/ethernet/wiznet/w5100-spi.c     | 4 +++-
 drivers/net/ethernet/wiznet/w5100.c         | 7 ++++---
 drivers/net/ethernet/wiznet/w5100.h         | 2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)


base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.30.2

