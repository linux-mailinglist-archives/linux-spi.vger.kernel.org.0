Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB455D01
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 02:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFZAl5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jun 2019 20:41:57 -0400
Received: from mx.socionext.com ([202.248.49.38]:7012 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFZAl5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Jun 2019 20:41:57 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Jun 2019 09:41:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8B1AF1800A0;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 26 Jun 2019 09:41:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 493F21A14E3;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1DA80120138;
        Wed, 26 Jun 2019 09:41:55 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 0/2] spi: fix spi driver for UniPhier SoC
Date:   Wed, 26 Jun 2019 09:41:46 +0900
Message-Id: <1561509708-4175-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series fixes timeout problem and modifies timeout handling.
The zero-length transfer results in two second timeout
and the transfer speed becomes slow.

Keiji Hayashibara (2):
  spi: uniphier: fix timeout error
  spi: uniphier: fix zero-length transfer

 drivers/spi/spi-uniphier.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.7.4

