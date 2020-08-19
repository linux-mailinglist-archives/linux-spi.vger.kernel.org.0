Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514B6249E1E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHSMfZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:35:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60175 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgHSMch (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123228euoutp0146131a817d174dae483ac36dc0d18feb~sq1TAUTjj3048130481euoutp01B
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200819123228euoutp0146131a817d174dae483ac36dc0d18feb~sq1TAUTjj3048130481euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840348;
        bh=7f24GrlrSzExvPyMurYvvze594Jf+4wWKfmrwTyxWYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSzObZ8L4aHjXo/f7rTxFSKR5Dvm0qj+GTvVvsEJAYqzuZS1IJZXaav8s+Ui3Ivb4
         tR5GtchwzWQicP+KReGPMAXmKk4Rk4xlSE6Qg85BLvbr9m3+tNaoyNyl1/UWnr1dSW
         NdApU8tf6UVrJHDa93Oeu6xl4H0lYT7x8XEVd7BE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eucas1p18a64212bb70ae93ac9e0220fc4d5f25a~sq1SrrbAV1965719657eucas1p1K;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 41.D3.06318.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1~sq1SWKfpC1036210362eucas1p1M;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eusmtrp1a27f49844b5cc129534e002312efb284~sq1SVgkYq1680116801eusmtrp1_;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-c5-5f3d1bdb2bcb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.63.06017.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123227eusmtip1ad276b04c9d5ed6d54e90aa7f9368fc6~sq1SKbBed3074630746eusmtip1j;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 5/8] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Date:   Wed, 19 Aug 2020 14:32:05 +0200
Message-Id: <20200819123208.12337-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7q3pW3jDV41WVgs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlfHkhXzBUf6Kmc+XsjYwfubu
        YuTkkBAwkZj25TNLFyMXh5DACkaJ+4db2CCcL4wSM2dcYIJwPjNKnHrwhh2m5d7XXkYQW0hg
        OaPE4n9CEEXPGSVWPXrPCpJgE3CU6F96ghUkISIwgUni4bk3bCAJZoFSiZ6dh8BsYYFoicbv
        05i7GDk4WARUJbYdMQQJ8wpYSzzdvpQZYpm8RPvy7WDlnAI2Eg9/TWGDqBGUODnzCQuIzS+g
        JbGm6ToLxHh5ieats5lB9koInGOXuNPzjxFikIvEy9UHWCFsYYlXx7dAfSMjcXpyDwvIDRIC
        9RKTJ5lB9PYwSmyb84MFosZa4s65X2wgNcwCmhLrd+lDhB0lfq5/xQrRyidx460gxAl8EpO2
        TWeGCPNKdLQJQVSrSKzr3wM1UEqi99UKxgmMSrOQPDMLyQOzEHYtYGRexSieWlqcm55abJyX
        Wq5XnJhbXJqXrpecn7uJEZiMTv87/nUH474/SYcYBTgYlXh4K85ZxwuxJpYVV+YeYpTgYFYS
        4XU6ezpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkZZ
        6VlZraseik3aGvDDUUjmdO3DYxM+ed54nODdwufcGHjuif1lyXoHDtNNh6Jy/jy9/f9ec8XW
        oz0SASu+MHWbHU2OvNxVziOjfOhOmVM5n25BFdf1y9IrzcsYvZIK5PzvaCfqGM00mnNEMlYr
        d7HPQVvjiOnZVQpZXImFjRsPMm569qFgshJLcUaioRZzUXEiANuM9MZCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7q3pW3jDZ49kLdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PJC/mCo/wVM58vZW1g/MzdxcjJISFgInHvay9jFyMXh5DA
        UkaJG6ufsnYxcgAlpCRWzk2HqBGW+HOtiw2i5imjRPvLnewgCTYBR4n+pSdYQRIiAjOYJJ7c
        mMwKkmAWKJe4NOs5WJGwQKRE5/RtjCBDWQRUJbYdMQQJ8wpYSzzdvpQZYoG8RPvy7WwgNqeA
        jcTDX1PAbCGgmq7FC5kg6gUlTs58wgIyhllAXWL9PCGQML+AlsSapussEFvlJZq3zmaewCg0
        C0nHLISOWUiqFjAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMvW3Hfm7Zwdj1LvgQowAH
        oxIPb8U563gh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+
        MC3klcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgrLwQH7+/b/nM
        hGz3Yzs0hf4lOxy+E35VW4X37A/FyXXMbjM2WSZd95R+aFDauZPZ/7mn4/ML6SLPMx0nBDw6
        brRWJ+7+ORO1L1kfSqu6Ui3vtrN3XW0WEDvpF6QZ6Xl4//s7a/bnqvc5BOjL16+a+76dq2te
        ZuqV4495/xqct6vhUEjouPVJiaU4I9FQi7moOBEAmqSkEdMCAAA=
X-CMS-MailID: 20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123227eucas1p11cd47cf281a035ed02d5fc819a0370c1@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6fe896f2be18..505789f91fdf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -155,19 +155,21 @@ struct s3c64xx_spi_port_config {
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
  * @ioclk: Pointer to the i/o clock between master and slave
+ * @pdev: Pointer to the SPI controller platform device
  * @master: Pointer to the SPI Protocol master.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
- * @rx_dmach: Controller's DMA channel for Rx.
- * @tx_dmach: Controller's DMA channel for Tx.
+ * @rx_dma: Controller's DMA channel for Rx.
+ * @tx_dma: Controller's DMA channel for Tx.
  * @sfr_start: BUS address of SPI controller regs.
  * @regs: Pointer to ioremap'ed controller registers.
- * @irq: interrupt
  * @xfer_completion: To indicate completion of xfer task.
  * @cur_mode: Stores the active configuration of the controller.
  * @cur_bpw: Stores the active bits per word settings.
  * @cur_speed: Stores the active xfer clock speed.
+ * @port_conf: Pointer to the SPI port configuration
+ * @port_id: SPI port ID number
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
@@ -176,7 +178,7 @@ struct s3c64xx_spi_driver_data {
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

