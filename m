Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6B13CA4F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgAORHM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 12:07:12 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38822 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgAORHM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 12:07:12 -0500
X-Greylist: delayed 2606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 12:07:11 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 00FGN3te021572;
        Wed, 15 Jan 2020 18:23:03 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id DB60D60328; Wed, 15 Jan 2020 18:23:02 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/4] spi: npcm-pspi: improve preformance modify reset and fix issue
Date:   Wed, 15 Jan 2020 18:22:57 +0200
Message-Id: <20200115162301.235926-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch set modify Perphiral SPI NPCM driver as follow:
	
	- Improve transfer performance.
	- Fix 16 bit send and receive support.
	- Modify dt-binding documentation to support reset controller driver.
	- Modify reset support to use reset controller driver
	  NPCM reset driver: https://lkml.org/lkml/2019/11/7/429.

Tomer Maimon (4):
  spi: npcm-pspi: fix 16 bit send and receive support
  spi: npcm-pspi: improve spi transfer performance
  dt-binding: spi: add NPCM PSPI reset binding
  spi: npcm-pspi: modify reset support

 .../bindings/spi/nuvoton,npcm-pspi.txt        | 12 +---
 drivers/spi/spi-npcm-pspi.c                   | 57 +++++++++----------
 2 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.22.0

