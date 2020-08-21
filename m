Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DBC24D97F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 18:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHUQOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 12:14:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37192 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHUQOI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161407euoutp013fcccffa38fc0697da1eaf1387720693~tVJZRNxMH2473324733euoutp01B
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200821161407euoutp013fcccffa38fc0697da1eaf1387720693~tVJZRNxMH2473324733euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026447;
        bh=rhBsub9wjuMeOLZuAmFwGL8Y5MlYJoQUBEjSxehD7oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEik/R6fdob4nD8Z2XZtWmhG4YEMcJLvDZNTliTxwtZoRPP775mUMmebTqk+Xfuxb
         PfTpWjXfoOhtHWb/SfpP0sUYS7CjFluQFo3uOid7fHJUwqegrg8orJoaFP6v0Ao171
         WGnrXIlVc8HurlVdA5E9nbm6hw3oyl6b7YOA0H9M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eucas1p2be320a91a60463a5166e0c03cbb661b0~tVJY8N0I21844518445eucas1p2e;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 36.D9.06456.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c~tVJYpdGJT0803808038eucas1p1U;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821161406eusmtrp10efe21b7cf620757b68ea4503b40a27d~tVJYox_3g1179011790eusmtrp17;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-d5-5f3ff2ce6145
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.B9.06017.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161406eusmtip1d752dc1e58f598870119d8412c7be1b8~tVJYeDRr91141711417eusmtip1B;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 5/9] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Date:   Fri, 21 Aug 2020 18:13:57 +0200
Message-Id: <20200821161401.11307-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7rnPtnHGzQdtrJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+PN2YPMBRu4Kz7+f8bawPiA
        o4uRk0NCwESi4e5E9i5GLg4hgRWMEv17+lkgnC+MEvPfXWKFcD4zSvxb/ZYFpuVP2z6oluWM
        EmcnvmeEcJ4zSjyeMIkJpIpNwFGif+kJsHYRgQlMEg/PvWEDSTALlEr07DwEZHNwCAvESaxp
        VwAJswioSrxafosFJMwrYC3xb6INxDJ5ifbl28E6OQVsJI5famIFsXkFBCVOznwCdhC/gJbE
        mqbrLBDT5SWat85mBlkrIXCJXeJQzzomiEEuEmte3mKEsIUlXh3fwg5hy0icntwDtldCoF5i
        8iQziN4eRoltc35AfWwtcefcL7CTmQU0Jdbv0ocIO0o8O7sIqpVP4sZbQYgT+CQmbZvODBHm
        lehoE4KoVpFY178HaqCURO+rFYwTGJVmIXlmFpIHZiHsWsDIvIpRPLW0ODc9tdgwL7Vcrzgx
        t7g0L10vOT93EyMwHZ3+d/zTDsavl5IOMQpwMCrx8P44ZB8vxJpYVlyZe4hRgoNZSYTX6ezp
        OCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYF1y5t3n+
        5aoY26m8d7M3x3udZte2emrx71WmcH67bMXVqxPteHP73tl6RPg0HGVocKzxcmQUSrtvIWdo
        rrYrbEvg4TNfXOXaAy7+f7sr19yjaovEcs+u5uw2zwQF9wTlvY5n9Op43Lm/1FiknDwTUNv/
        QZV10522Hd6LjPYYGK88f6P0WL4SS3FGoqEWc1FxIgAFQHgYQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7rnPtnHG2x9qGax+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsabsweZCzZwV3z8/4y1gfEBRxcjJ4eEgInEn7Z97F2MXBxC
        AksZJVZcbGDrYuQASkhJrJybDlEjLPHnWhcbRM1TRokpG2axgCTYBBwl+peeYAVJiAjMYJJ4
        cmMyK0iCWaBc4tKs5+wgtrBAjMTbA+fYQGwWAVWJV8tvsYAs4BWwlvg30QZigbxE+/LtYCWc
        AjYSxy81gY0RAirZtvgy2C5eAUGJkzOfgLUyC6hLrJ8nBBLmF9CSWNN0nQViq7xE89bZzBMY
        hWYh6ZiF0DELSdUCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgdG37djPLTsYu94FH2IU
        4GBU4uH9ccg+Xog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BvpzILCWa
        nA9MDHkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhg5L+dX39xi
        u1Tv9t6IDb5HF/eUGWQZLdzusXe+XMkhk4V5TYt+b4g7yrsnrnLGxjesGx9/4xUPDjSMWDlf
        UGxXQPr8B09XKPsumVLjL6q/RI/5ku7rENYpOu7GJ4tfREQFCrI/uJLcfebJm7MBF7kTdnZG
        9DJOzBLxzQs6pGNfyWJ8bM2nFTeVWIozEg21mIuKEwHRzKAK1AIAAA==
X-CMS-MailID: 20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161406eucas1p121553719d4e9cc020d2c557a69000f0c@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove descriptions for non-existent fields and fix indentation.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 433b9d77b914..6381a7557def 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -162,11 +162,8 @@ struct s3c64xx_spi_port_config {
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
- * @rx_dmach: Controller's DMA channel for Rx.
- * @tx_dmach: Controller's DMA channel for Tx.
  * @sfr_start: BUS address of SPI controller regs.
  * @regs: Pointer to ioremap'ed controller registers.
- * @irq: interrupt
  * @xfer_completion: To indicate completion of xfer task.
  * @cur_mode: Stores the active configuration of the controller.
  * @cur_bpw: Stores the active bits per word settings.
@@ -183,7 +180,7 @@ struct s3c64xx_spi_driver_data {
 	struct clk                      *ioclk;
 	struct platform_device          *pdev;
 	struct spi_master               *master;
-	struct s3c64xx_spi_info  *cntrlr_info;
+	struct s3c64xx_spi_info         *cntrlr_info;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
-- 
2.26.2

