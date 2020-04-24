Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91A1B723D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDXKnc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 06:43:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:19868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgDXKna (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 06:43:30 -0400
IronPort-SDR: s52HwrkmSI1KLZ16YhJ2SN9O+Wac5B6tUiuRwghQ6SET2XrddwJ35h9sSW42nTKgd/vH9O9pr8
 uF8TjHKsl+xQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 03:43:29 -0700
IronPort-SDR: 4GGBQkILTwyxoN4He2wwk9AW2tUn3/h+fdKGh4mVGO7TaPbz5LwgYA68GAOJ2biJrSj7g108HH
 zvHDKocdapoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="366307433"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2020 03:43:25 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 0/4] spi: lantiq: Synchronize interrupts, transfers and add new features
Date:   Fri, 24 Apr 2020 18:42:29 +0800
Message-Id: <cover.1587702428.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series add changes to synchronize the SPI interrupt handlers
and transfer operations. Intorduces the configurations to support
SPI controller on multiple SoCs.
Adds support to Lightning Mountain SoC.

Dilip Kota (4):
  spi: lantiq: Synchronize interrupt handlers and transfers
  spi: lantiq: Dynamic configuration of interrupts and FIFO size
  dt-bindings: spi: Add support to Lightning Mountain SoC
  spi: lantiq: Add support to Lightning Mountain SoC

 .../devicetree/bindings/spi/spi-lantiq-ssc.txt     |  21 ++-
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-lantiq-ssc.c                       | 194 ++++++++++++---------
 3 files changed, 137 insertions(+), 82 deletions(-)

-- 
2.11.0

