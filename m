Return-Path: <linux-spi+bounces-9890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6AB43D42
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 15:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745477BCA0C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833C302CC3;
	Thu,  4 Sep 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U6U6mrE4"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC38301469;
	Thu,  4 Sep 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992740; cv=none; b=grRdOFdVemkt4iYqY+WvsUQhK8yJe1u5snbLk9No8Na1DXttg0L5K4U28bzWKscTjI18Dodiw46Mrbgs+J7OA3H6sJW/f3bK3VuMXfuOMfyGsd7Y2LWWkIvywCHb8XWg77mcF8abErhR5Y8EbSDhdLZi+oN+p3mFBmLfmHdx9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992740; c=relaxed/simple;
	bh=0/u5ukoiGKUX2afNu20CcAZHH8Ybvgx6mbCb5EevV7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvP/lQLlJ3fmxVIQpHfuydMjHfZ/wMAJEFTPosNqPaYelAuImrpB9hpBBCvyTgANgNqDa1tK/2hirutt7JomJKbN5cTvySi8GqJt1fCRTAMnKOfhFcGSe6HZXZo95FdRQ8wRKs26I7mXOMZNEBI7mPYmqv6+J3EmThMMgfzujpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U6U6mrE4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DW6943477181;
	Thu, 4 Sep 2025 08:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756992726;
	bh=iMdr06tS1Iy1xhwRtBagSpdrqF8nd4Cv0cXJoPOolmU=;
	h=From:To:CC:Subject:Date;
	b=U6U6mrE4ghm/WRullpPJYosbN6TMWJKQlKJsXgXpL5Vc4dnWO5wZSaVC7oaSel3ty
	 VX4ZvWf7Tt2UCmAb4i98JVHz+N47La1anc83dRJLcZOsWewkcQHwWEDc3D3k8uVRg5
	 eBM1IwCxeV/5iXHyMum1JKj7HrbuI2z9PIgosxqE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DW5XV149765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:32:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:32:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:32:05 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DW0DM3325799;
	Thu, 4 Sep 2025 08:32:01 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>, <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <s-k6@ti.com>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH 0/4] Miscellaneous fixes and clean-ups
Date: Thu, 4 Sep 2025 19:01:26 +0530
Message-ID: <20250904133130.3105736-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series introduces some small but important fixes and cleanups in
the Cadence QSPI Controller.

Tested on TI's AM62A SK and AM62P SK:
Logs: https://gist.github.com/santhosh21/0d25767b58d9a1d9624f2c502dd8f36b

Signed-off-by: Santhosh Kumar K s-k6@ti.com

Pratyush Yadav (2):
  spi: cadence-quadspi: Flush posted register writes before INDAC access
  spi: cadence-quadspi: Flush posted register writes before DAC access

Santhosh Kumar K (1):
  spi: cadence-quadspi: Fix cqspi_setup_flash()

Vignesh Raghavendra (1):
  spi: cadence-quadspi: Use BIT() macros where possible

 drivers/spi/spi-cadence-quadspi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.34.1


