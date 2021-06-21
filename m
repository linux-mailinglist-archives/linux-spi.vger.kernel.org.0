Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8943AE78A
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUKuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:50:23 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:55118 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUKuX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 06:50:23 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C0A92AD5FD;
        Mon, 21 Jun 2021 18:48:05 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24132T140365807994624S1624272484357256_;
        Mon, 21 Jun 2021 18:48:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <10292b0ec8847d933dbe4f72212f2387>
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
Subject: [PATCH v10 0/6] Support ROCKCHIP SPI new feature
Date:   Mon, 21 Jun 2021 18:47:54 +0800
Message-Id: <20210621104800.19088-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Changes in v10:
- The internal CS inactive function is only supported after VER 0x00110002

Changes in v9:
- Conver to use CS GPIO description

Changes in v8:
- There is a problem with the version 7 mail format. resend it

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
 drivers/spi/spi-rockchip.c                    | 55 ++++++++++++++-----
 2 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.17.1



