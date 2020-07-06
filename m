Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABE2152F5
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGFHSI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgGFHSI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EDAC061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:07 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLO6-0004BC-SJ; Mon, 06 Jul 2020 09:18:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 0/9] spi: spi-sun6i: One fix and some improvements
Date:   Mon,  6 Jul 2020 09:17:52 +0200
Message-Id: <20200706071801.558394-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

this series first fixes the calculation of the clock rate. The driver will
round up to the nearest clock rate instead of rounding down. Resulting in SPI
devices accessed with a too high SPI clock.

The remaining patches improve the performance of the driver. The changes range
from micro-optimizations like reducing MMIO writes to the controller to
reducing the number of needed interrupts in some use cases.

regards,
Marc



