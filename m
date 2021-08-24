Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349883F5A4C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhHXJAv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:00:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:21969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234237AbhHXJAu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="197517184"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="197517184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 02:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="597515537"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2021 01:59:58 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v2 0/2] Add support for Intel Thunder Bay SPI
Date:   Tue, 24 Aug 2021 16:58:54 +0800
Message-Id: <20210824085856.12714-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Hi,

This patch set enables support for Designware SPI on the Intel Thunder Bay SoC.

Patch 1: SPI DT bindings for Intel Thunder Bay SoC.
Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC.

The driver is tested on Keem Bay and Thunder Bay evaluation board

Changes from v1:
1) Designware CR0 specific macros are named in a generic way.
2) SPI CAP macros are named in generic way rather than naming project specific.
3) SPI KEEM BAY specific macros are replaced by generic macros.
4) Resued the existing SPI deassert API instead of adding another reset

Thanks & Regards,
Nandhini

Nandhini Srikandan (2):
  dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
  spi: dw: Add support for Intel Thunder Bay SPI

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
 drivers/spi/spi-dw-core.c                     |  7 +++++--
 drivers/spi/spi-dw-mmio.c                     | 20 ++++++++++++++++++-
 drivers/spi/spi-dw.h                          | 12 ++++++++---
 4 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.17.1

