Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF72E6E4E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 06:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgL2FdA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 00:33:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:18331 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgL2FdA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 00:33:00 -0500
IronPort-SDR: IFSDHHKH4D47i/s64fh9tv3Zh11KTUGQSYwyjdCJWBgKaIAPbwYFoM9GyE7kHkMiZSYeAgO3jy
 t0OmJV2qszlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="164170711"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="164170711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:32:19 -0800
IronPort-SDR: lacNd/9BuLT+r2v1mYTx6wdTVw3BvetJabXAOqHGiOBZGerSEbQsUMDhc+/jmfYp5V8Yw/I0g8
 GpNrNsylZTGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="395307680"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2020 21:32:16 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix the issue when xfer by spi-altera
Date:   Tue, 29 Dec 2020 13:27:40 +0800
Message-Id: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When doing spi xfer by spi-altera, divide by 0 exception happens in
spi_transfer_wait(), This is because the xfer->speed_hz is always
clamped to 0 by spi->controller->max_speed_hz, the feature is
introduced in:

commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")

The spi-altera doesn't have hardware indication for controller's
max_speed_hz, so its value is uninitialized as 0.

Patch #1 fixes the issue of spi_altera driver. When doing polling
mode xfer, its transfer_one() callback should return 1, to indicate
the xfer is finished. It should return 0 for irq mode xfer. With
this patch the polling mode xfer is OK as it needs no
spi_transfer_wait() anymore.

But the irq mode xfer is still broken. So Patch #2 assumes 1khz xfer
speed if the xfer->speed_hz is not assigned. I try to avoid the
divide by 0 issue and ensures a reasonable tolerant waiting time in
a generic way.

Xu Yilun (2):
  spi: altera: fix return value for altera_spi_txrx()
  spi: fix the divide by 0 error when calculating xfer waiting time

 drivers/spi/spi-altera.c | 26 ++++++++++++++------------
 drivers/spi/spi.c        |  4 +++-
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.7.4

