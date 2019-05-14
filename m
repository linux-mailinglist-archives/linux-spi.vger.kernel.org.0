Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30B1C1A1
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 07:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfENFEA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 01:04:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9786 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfENFEA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 01:04:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda4c3b0000>; Mon, 13 May 2019 22:03:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 22:03:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 22:03:59 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:03:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 05:03:58 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 May 2019 05:03:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.159]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cda4c3d0001>; Mon, 13 May 2019 22:03:58 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 0/4] additional features to Tegra SPI
Date:   Mon, 13 May 2019 22:03:51 -0700
Message-ID: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557810235; bh=Is7PPSPkZU2e4SEbeo7WhEdzzJcwmz429GSJWJitgnE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Gvm9jPXq/kUoUrrLAFDe/7PmPtAr6F9tzBRoB1P6qV1bkp2UyKmh90WHQ29EEf3WL
         yKnzpxHgeqr6tUszvEBhrUuMgEFAJeSa2/En6bbni2qsJazJpk3gKzA6fzfWNfpMfJ
         KfiivWlMi3PoPzdGkV7WVntqpoRPvzUaCIDh4VvYNpaeOZoKsGdVTlZJaLfVBsN5wo
         jgHWkmXwgQb8tN96xd2K7ijD6CQIUnOMKx5T642EB90UufUbxBaZvmDZwX10hGBCFy
         Adu5WsZJLdUEji8TCEcOJwLxEPu8AQcNAy0sPUl2pZFuvV7t8aJNn6XadypAYDOxtN
         kW1+HHIs/mEmg==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[V5] : This patch series version includes
	- Updated GPIO based chip select control using GPIO descriptor.
	- HW based chip select implementation is same as V3 but V5
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V3 but V5
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V3
	  but V5 has this patch updated to be on top of above changes
	  and updated commit description.

[V4] : This version went out accidentally. Please discard.

[V3] : This patch series version includes
	- only patches that are not applied from V2.
	- splitted expanding mode and adding LSByte First support
	  in separate patches and removed DT property for selecting
	  LSByte First.
	- Updated GPIO based chip select control to use spi_set_cs
	  from SPI core.
	- HW based chip select implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V2
	  but V3 has this patch updated to be on top of above changes
	  and updated commit description.

[V2] : This patch series version includes
	- only patches that are not applied from V1.
	- changed order of patches to include all fixes prior to new features
	  support.
	- Removed HW CS timing from DT properties and created set_cs_timing
	  SPI master optional method for SPI controllers to implement and
	  created API spi_cs_timing for SPI client drivers to request CS
	  setup, hold and inactive delay timing configuration.
	- Fixed HW based CS decision to be based on single transfer and
	  cs_change. Remove selection of HW based CS through DT.


Sowjanya Komatineni (4):
  spi: tegra114: add support for gpio based CS
  spi: tegra114: add support for hw based cs
  spi: tegra114: add support for HW CS timing
  spi: tegra114: add support for TX and RX trimmers

 drivers/spi/spi-tegra114.c | 167 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 16 deletions(-)

-- 
2.7.4

