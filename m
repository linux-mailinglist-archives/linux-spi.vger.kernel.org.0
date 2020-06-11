Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0156D1F606F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKD2u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:28:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgFKD2u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:28:50 -0400
IronPort-SDR: yUiP/E+kCWGaPqHB8vxDgdGF8JXwjmTuTwSpLFnPcR0F8HrcY/eVdpPH4NRWqPzpN+OX4CHl7J
 P3QKIjqnSE4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:28:49 -0700
IronPort-SDR: LalyfZGMnEkL6uRGWaE29LKoLCyRxmdx6MmY4lyUAxdKxrOhYGrv49NWuo5DTUQflDPIHtUcBl
 w3s7aA5vVCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587328"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:28:47 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 0/6] Add more configuration and regmap support for spi-altera
Date:   Thu, 11 Jun 2020 11:25:05 +0800
Message-Id: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset adds platform_data for spi-altera, to enable more IP
configurations, and creating specific spi client devices. It also adds
regmap support, to enable the indirect access to this IP.

We have a PCIE based FPGA platform which integrates this IP to communicate
with a BMC chip (Intel MAX10) over SPI. The IP is configured as 32bit data
width. There is also an indirect access interface in FPGA for host to
access the registers of this IP. This patchset enables this use case.

Matthew Gerlach (1):
  spi: altera: fix size mismatch on 64 bit processors

Xu Yilun (5):
  spi: altera: add 32bit data width transfer support.
  spi: altera: add SPI core parameters support via platform data.
  spi: altera: add platform data for slave information.
  spi: altera: use regmap instead of direct mmio register access
  spi: altera: move driver name string to header file

 drivers/spi/Kconfig        |   1 +
 drivers/spi/spi-altera.c   | 161 +++++++++++++++++++++++++++++++++++++--------
 include/linux/spi/altera.h |  37 +++++++++++
 3 files changed, 171 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/spi/altera.h

-- 
2.7.4

