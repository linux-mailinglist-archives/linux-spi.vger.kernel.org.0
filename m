Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6D6E434F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Apr 2023 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDQJKr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Apr 2023 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjDQJKq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 05:10:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD010D1
        for <linux-spi@vger.kernel.org>; Mon, 17 Apr 2023 02:10:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33H9Ab2N045408;
        Mon, 17 Apr 2023 04:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681722637;
        bh=HvfshV2DaF4y/7Pn92rbhH1Jy3vWXTr4qUArdBBWy9g=;
        h=From:To:CC:Subject:Date;
        b=t/CcLTpshcqNO2tgWFexz72wpDMvDF6O9wTaIMcLRSoYiuSLS3gR45LyxIXvGC5gU
         T/dT/nchp+caJiWagLqvoGDUgzY5rfRgTEeRfiyvOnS65tesXcPxLwk2lq29Nxxphm
         289zRg05JLuXR75c6zTSNrR7nxNs8EhNYTxasdCw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33H9Aaq3014555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 04:10:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 04:10:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 04:10:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33H9AZWG027016;
        Mon, 17 Apr 2023 04:10:36 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 0/2] Fix PM Hooks in the Cadence Quad SPI Driver
Date:   Mon, 17 Apr 2023 14:40:25 +0530
Message-ID: <20230417091027.966146-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds fixes to the Suspend and Resume Hooks of the CQSPI Driver.
Earlier, the ltp-ddt test "OSPI_S_FUNC_DD_RW_ERASESIZE_UBIFS" failed
post system suspend resume. It is now passing as shown in [0].

Tested on top of linux-next (next-20230414) on an AM625-SK-EVM. For logs,
please refer [0].

[0] https://gist.github.com/DhruvaG2000/29b15f9c8a1e632c6819a986e5f28ab2

Dhruva Gole (2):
  spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
  spi: cadence-quadspi: fix suspend-resume implementations

 drivers/spi/spi-cadence-quadspi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.25.1

