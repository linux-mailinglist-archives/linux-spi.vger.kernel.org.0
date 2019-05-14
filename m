Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3D21C170
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENEgO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 00:36:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16002 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEgN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 00:36:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda45950001>; Mon, 13 May 2019 21:35:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 21:36:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 21:36:12 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 04:36:12 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 04:36:12 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 May 2019 04:36:12 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.159]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cda45bb0000>; Mon, 13 May 2019 21:36:12 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 0/4] additional features to Tegra SPI
Date:   Mon, 13 May 2019 21:36:09 -0700
Message-ID: <1557808569-3747-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557808533; bh=VR62qDH2MvqUtpta3YvaIijfP/dfEHfDtu5yJHO5+MA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=cEeOLELfbPlwg1QiHM2ZNC+Tn7eDq/EQ50Otz099xu0jqnBDPuzmbCNsjnQiLr6iC
         GsfWhTzvjLsaUUI/HXxyKEoP4I1Podz1KB9XP4+Xb4vW547Q7Dtsqyz2RBQrBE/XsD
         t620M1kzEiOpERIZnE0uYYWN5TREBPlPxbSPKRhqrzLiQeTjYeQuvguNKh2YP1RVYZ
         5U15754n/x/iC7ma2fss+ZytGoGUF7nFpANATmQ4G8Fdv9dm4OWiAgRXLoVqWj7zVv
         SF/tNnxF8xTWy2yPmzn1lkg0pcfjRWHSb2AGoBqTycOhn/47c91DgN/aZWTuQ/g/99
         +W7iDfeR1kv6w==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[V4] : This patch series version includes
	- Updated GPIO based chip select control using GPIO descriptor.
	- HW based chip select implementation is same as V3 but V4
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V3 but V4
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V3
	  but V4 has this patch updated to be on top of above changes
	  and updated commit description.

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

 drivers/spi/spi-tegra114.c | 169 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 153 insertions(+), 16 deletions(-)

-- 
2.7.4

