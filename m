Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5421598C
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgGFOet (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgGFOet (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C22C061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:49 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCj-0005DP-Rn; Mon, 06 Jul 2020 16:34:45 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH v2 00/10] spi: spi-sun6i: One fix and some improvements
Date:   Mon,  6 Jul 2020 16:34:33 +0200
Message-Id: <20200706143443.9855-1-mkl@pengutronix.de>
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

changes since v1:
- added Maxime Ripard's to the existing patches
- 06/10: (was 05/10 in v1)
  "spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it"
  use FIELD_GET instead of open coding it
  (tnx: Maxime Ripard)
- 05/10: "spi: spi-sun6i: sun6i_spi_get_tx_fifo_count: Convert manual shift+mask to FIELD_GET()"
  new patch



