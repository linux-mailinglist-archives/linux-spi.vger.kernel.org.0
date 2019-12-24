Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B97129C23
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLXA6q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 19:58:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:23630 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfLXA6q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 19:58:46 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 24 Dec 2019 09:58:45 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2FEE1603AB;
        Tue, 24 Dec 2019 09:58:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 24 Dec 2019 09:59:24 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B36781A01CF;
        Tue, 24 Dec 2019 09:58:44 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/5] spi: uniphier: Introduce DMA transfer mode
Date:   Tue, 24 Dec 2019 09:58:22 +0900
Message-Id: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series introduces DMA transfer mode into UniPhier SPI driver.
This only supports UniPhier XDMAC implemented in the SoC.

The DMA transfer mode uses FIFO threshold as a trigger to start DMA transfer,
however, the FIFO is limited to one word width due to alignment restiction
of the DMA controller.

Kunihiko Hayashi (5):
  spi: uniphier: Fix FIFO threshold
  spi: uniphier: Change argument of irq functions to private structure
  spi: uniphier: Add handle_err callback function
  spi: uniphier: Add SPI_LOOP to the capabilities
  spi: uniphier: Add DMA transfer mode support

 drivers/spi/spi-uniphier.c | 261 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 241 insertions(+), 20 deletions(-)

-- 
2.7.4

