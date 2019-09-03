Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC571A608F
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 07:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfICFbG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:49352 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfICFbG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:06 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Sep 2019 14:31:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id DA5F918028D;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 3 Sep 2019 14:31:04 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B002D1A0E9F;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 860471204B3;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 0/3] spi: uniphier: introduce polling mode and fix bug
Date:   Tue,  3 Sep 2019 14:30:58 +0900
Message-Id: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series introduces new polling mode and fixes bug.

- Introduce new polling mode for short size transfer. Either the estimated
  transfer time is estimated to exceed 200us, or polling loop actually exceeds
  200us, it switches to irq mode.
- Fix a bug of register overwrite.
- Minor corrections.

Keiji Hayashibara (3):
  spi: uniphier: fix wrong register overwrite
  spi: uniphier: remove unnecessary code
  spi: uniphier: introduce polling mode

 drivers/spi/spi-uniphier.c | 85 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 17 deletions(-)

-- 
2.7.4

