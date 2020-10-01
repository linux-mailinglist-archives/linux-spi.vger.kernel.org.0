Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4028029A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgJAPXJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:23:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40864 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgJAPWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152249euoutp0126ddb18754f2a6801b100d04a333f592~555TsxaEB2706927069euoutp01e
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152249euoutp0126ddb18754f2a6801b100d04a333f592~555TsxaEB2706927069euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565769;
        bh=AZIlVNZBDC5UKC2U+MQYh+ihNhSv5nvwrR6mp6tepnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKBban36JBWJcH5pF1v0tjw6go1/YjgrXvkuMCoyCM6YMxe2W76DvJ6gJgDD2Av9A
         Q9CgsgC26i6xTtJ9eXvY1spnv8phW2hkcw4vkdGCCPtTEWxs9CJB96+fO8Gkq9lNIU
         UhwC3QQep9H1UTntDTFBiIUvfuDFWISmgmwVQ25Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eucas1p2213b2031a69ccb396971b66f93e6c2d3~555TT_Y_F0232902329eucas1p23;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.2F.06456.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152248eucas1p12f71c21a5873b6360e4b38efebb50271~555S6nGU51512815128eucas1p12;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eusmtrp166a327d93742a07c0d33a3026ff47b89~555S5_yF72671526715eusmtrp1m;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-48-5f75f4484103
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.D5.06017.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152248eusmtip1429f6811b3c967fc29871e4ec193a309~555Sv20TE2448824488eusmtip1b;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 6/9] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Date:   Thu,  1 Oct 2020 17:21:45 +0200
Message-Id: <20201001152148.29747-7-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt7vdezedXaflhz3EYUFCmiRxQw2NiP1RYCBIounKi0qbyuas
        FehUSJ3TpSK+0XygDdNc5vJBwhI1JB8ZPiqFUBFnkboJak+3a+R/5zvnfOc7P/iRmMjE8yST
        ktMYRbJUJsYF3O6hnbGzEpsq9px2LZBu3F7h0J0VHTy67MsSTusX1zB6fPw5Qc+ZWxFtXJzm
        0VO9NThdMf6aQ2dtzBH0s8F5gjb0/kShzpKZpk1M0lM1T0iMhnxc8qIpU1LUZUASq/FkOB4l
        CI5nZEnpjML/UpwgcWS5gJe65HT/h43SID1fi/gkUIHwRP+BY8ciqhXBskWqRYI9bEOwU1CJ
        s4MVwdyiltAi0rHxafI0y7cgKNetYuywgmB3S+OIwqkw0DeP8OyCO2XiQLF1nGsXMEoFuh4z
        bsduFAODRbPInsqlTkH5vMJOC6kgaO8rRGw9L8htMTnsfCoYxorf4KzHFd5WLjkiD1O+0JY9
        sx/vBTkvqx2FgFogoKf5K4dtfQWMOw/ZTDewDHcRLD4Oo6U6LmvJhNKSC+yqDkF3zTaX9QTB
        57Fd3O7BqDPQ0evP0mGQU52NsasuMPvNlW3gAiXd5fu0EPIeiVi3D7Tr+/cDPaHQ0ooeI3HV
        gbdUHehf9f9WPcIMyINRKeUJjDIgmbnnp5TKlarkBL87KXIj2vtOo7+HN1+hrfe3zYgikdhZ
        mGhWxYp40nSlWm5GQGJid+Hld6O3RMJ4qfoBo0iJVahkjNKMjpFcsYfwfMNqjIhKkKYxdxkm
        lVH8Uzkk31ODQgaShiIzyi72rx+KXBhNiCGDV32utgomatf7NE5Hr+XFhao7Y6dTGsLrbH9C
        22p1N7M6Jw0RJl5n/kap5braWxgc0bh6YjZvKmN+LEtGRLXX5DJHOio5TxvrBqwNZSb1WnnB
        r92YoBW0PMFEW3aJLZ/v1o/e68g5JLpeM3NDzFUmSgN8MYVS+heWnK4DSgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7oeX0rjDf6+lLRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOPG0m7XgCXfF7y8CDYz9nF2MHBwSAiYS
        ty+qdTFycQgJLGWU2HTwOyNEXEpi5dz0LkZOIFNY4s+1LjaImqeMEmc62plAEmwCjhL9S0+w
        giREBPYzSVy6cJ8FJMEsUC5xadZzdhBbWCBZ4vGOH0wgQ1kEVCWm3y0CCfMKWEus293LCLFA
        XqJ9+XY2EJtTwEbi3MTDYLaQQK7E7t1H2SDqBSVOznzCAjKGWUBdYv08IZAwv4CWxJqm61Bb
        5SWat85mnsAoNAtJxyyEjllIqhYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMZtx35u
        2cHY9S74EKMAB6MSD6/AgdJ4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9i
        NAX6ciKzlGhyPjBR5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRq
        YAzwmctlp7b04gRL9zeLU1PktxldWly97N/5N//Mr1mG3vQ6Ur/Sfp38fJa+ppOO+TNbth18
        WPLbZNOElWw9/LvOb31RfzNg84Mv95S+i3+/0xqqzPA7eGtWt60nI3MRW5Axi6jJERXWAwy1
        KaeuCuqdZNx++PqaDLfg53M1/gbJObIeNmNeH67EUpyRaKjFXFScCAATG8dW3AIAAA==
X-CMS-MailID: 20201001152248eucas1p12f71c21a5873b6360e4b38efebb50271
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152248eucas1p12f71c21a5873b6360e4b38efebb50271
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152248eucas1p12f71c21a5873b6360e4b38efebb50271
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152248eucas1p12f71c21a5873b6360e4b38efebb50271@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove descriptions for non-existent fields and fix indentation.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index adc5593ca2ca..02de734b8ab1 100644
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

