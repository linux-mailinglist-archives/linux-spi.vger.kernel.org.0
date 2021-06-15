Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37CB3A7510
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFOD2j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 23:28:39 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:38138 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhFOD2f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Jun 2021 23:28:35 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 26F02F4C8D;
        Tue, 15 Jun 2021 11:26:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16485T139919122814720S1623727582436580_;
        Tue, 15 Jun 2021 11:26:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2ae7b3ac56f8947e7a80825c06dfa1fa>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 0/6] Support ROCKCHIP SPI new feature
Date:   Tue, 15 Jun 2021 11:26:14 +0800
Message-Id: <20210615032620.24769-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607111837.31074-1-jon.lin@rock-chips.com>
References: <20210607111837.31074-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Changes in v7:
- Fall back "rockchip,rv1126-spi" to "rockchip,rk3066-spi"

Changes in v6:
- Consider to compatibility, the "rockchip,rk3568-spi" is removed in
  Series-changes v5, so the commit massage should also remove the
  corresponding information

Changes in v5:
- Change to leave one compatible id rv1126, and rk3568 is compatible
  with rv1126

Changes in v4:
- Adjust the order patches
- Simply commit massage like redundancy "application" content

Changes in v3:
- Fix compile error which is find by Sascha in [v2,2/8]

Jon Lin (6):
  dt-bindings: spi: spi-rockchip: add description for rv1126
  spi: rockchip: add compatible string for rv1126
  spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
  spi: rockchip: Wait for STB status in slave mode tx_xfer
  spi: rockchip: Support cs-gpio
  spi: rockchip: Support SPI_CS_HIGH

 .../devicetree/bindings/spi/spi-rockchip.yaml |  1 +
 drivers/spi/spi-rockchip.c                    | 95 +++++++++++++++----
 2 files changed, 80 insertions(+), 16 deletions(-)

-- 
2.17.1



