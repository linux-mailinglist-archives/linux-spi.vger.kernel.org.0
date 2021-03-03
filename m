Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F027632C6F2
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451158AbhCDAac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:10465 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245431AbhCCPbF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:05 -0500
IronPort-SDR: Hnt48Xt5k0qx5gdYrADxQTmtGlWdv/lKjf5Hg/Fs4ie6GASCg2/JuyKNMYwfl6d+tAr/irCbxA
 OGan6dfgSRZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166470324"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166470324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:28:16 -0800
IronPort-SDR: GetpgO7Ijf5LWFXEtgi3vgxEaRRpEkySJdohll2UD+5gB0SXUNnSbNDRlyBbTGo3C6nOeNem+x
 Jl2fhiCCru4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506827344"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 07:28:15 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] spi: Adding support for software nodes
Date:   Wed,  3 Mar 2021 18:28:10 +0300
Message-Id: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

The older API used to supply additional device properties for the
devices - so mainly the function device_add_properties() - is going to
be removed. The reason why the API will be removed is because it gives
false impression that the properties are assigned directly to the
devices, which has actually never been the case - the properties have
always been assigned to a software fwnode which was then just directly
linked with the device when the old API was used. By only accepting
device properties instead of complete software nodes, the subsystems
remove any change of taking advantage of the other features the
software nodes have.

The change that is required from the spi subsystem and the drivers is
trivial. Basically only the "properties" member in struct
spi_board_info, which was a pointer to struct property_entry, is
replaced with a pointer to a complete software node.

thanks,

Heikki Krogerus (4):
  spi: Add support for software nodes
  ARM: pxa: icontrol: Constify the software node
  ARM: pxa: zeus: Constify the software node
  spi: Remove support for dangling device properties

 arch/arm/mach-pxa/icontrol.c | 12 ++++++++----
 arch/arm/mach-pxa/zeus.c     |  6 +++++-
 drivers/spi/spi.c            | 21 ++++++---------------
 include/linux/spi/spi.h      |  7 +++----
 4 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.30.1

