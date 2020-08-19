Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA8249DE1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHSMcg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:32:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60072 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgHSMc2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123226euoutp01ae3b6e1bf37020dc979c366a399a9049~sq1Ra8lhN2728227282euoutp01Y
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200819123226euoutp01ae3b6e1bf37020dc979c366a399a9049~sq1Ra8lhN2728227282euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840346;
        bh=6iF6p6XqPkllMGpxkrEM8eY/z3vvuUimrFcDnD695pY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X4L07LFuJvCU67iRwlDSwHQUUVII9ddEDazjKN2v2Sml1gSPAk9n9c/isFddr25E7
         6uz4rqpK2b5iphdNbJExS+dfxtRoBMTM07iG2s7DucGgOvbpgSsYiDRP04EOMGBqkQ
         YbmAQlrgbh/U/zgRLJwMEnOoyYSvdLYxd4aKkuNM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123226eucas1p225f2e679b6b81efb4f1d299d588b8158~sq1RDKXaN3023830238eucas1p2-;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.C3.06318.ADB1D3F5; Wed, 19
        Aug 2020 13:32:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6~sq1Qys_qY3168631686eucas1p2F;
        Wed, 19 Aug 2020 12:32:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819123225eusmtrp2c4226000143c53b3ebabfc97199df742~sq1QsF7K02883128831eusmtrp2h;
        Wed, 19 Aug 2020 12:32:25 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-c2-5f3d1bda7159
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.CF.06314.9DB1D3F5; Wed, 19
        Aug 2020 13:32:25 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123225eusmtip1f2e39b9a504db7f46c61a97a5dfab7ad~sq1QhmKTv2653226532eusmtip1j;
        Wed, 19 Aug 2020 12:32:25 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 0/8] Some fixes for spi-s3c64xx
Date:   Wed, 19 Aug 2020 14:32:00 +0200
Message-Id: <20200819123208.12337-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87q3pG3jDT4c57JY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+PCidWsBZs4Ks5Ouc3ewPiN
        rYuRk0NCwETibtNc9i5GLg4hgRWMEld+NTJDOF8YJd51XYbKfGaUmHHpJVzL53+9rBCJ5YwS
        1y7fY4RwnjNKXL56jB2kik3AUaJ/6QmwKhGBCUwSD8+9AWtnFiiV6Nl5CMwWFtCXmNfQAGaz
        CKhKPHtxEqyZV8BaYufi9ywQ6+Ql2pdvZ4OIC0qcnPkELM4voCWxpuk6C8RMeYnmrbOZIeq3
        sUsc6lKCsF0kJvZ8hzpbWOLV8S3sELaMxP+d85m6GDmA7HqJyZPMQO6UEOhhlNg25wfUXmuJ
        O+d+sYHUMAtoSqzfpQ8RdpR4cvIVI0Qrn8SNt4IQF/BJTNo2nRkizCvR0SYEUa0isa5/D9RA
        KYneVysYIWwPic8rehgnMCrOQvLXLCS/zELYu4CReRWjeGppcW56arFxXmq5XnFibnFpXrpe
        cn7uJkZgQjr97/jXHYz7/iQdYhTgYFTi4a04Zx0vxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYF14L1Lt4+0Jfl5eH
        QMu6uNDdSpbykuL/XXnL12QzeE/7sqKdQ2YxH4enuNSZlgrB+Ag+ZblDEe/m1tpO/jxZa5Fc
        wqw1fGf/rZtakXhftuLZvfb/SuoaBV41c3iVbOpk9PVlLrJkvAs31J14+OREl0f5QZqHDh4s
        ffJQwHnZ/5If2zOZxJmUWIozEg21mIuKEwGVf/M8RAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7o3pW3jDa590bdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PCidWsBZs4Ks5Ouc3ewPiNrYuRk0NCwETi879e1i5GLg4h
        gaWMEgs/L2XpYuQASkhJrJybDlEjLPHnWhcbRM1TRom7F3awgCTYBBwl+peeAGsWEZjBJPHk
        xmRWkASzQLnEpVnP2UFsYQF9iXkNDWDbWARUJZ69OAkW5xWwlti5+D0LxAZ5ifbl29kg4oIS
        J2c+ATuCWUBdYv08IZAwv4CWxJqm6ywQ4+UlmrfOZp7AKDALSccshI5ZSKoWMDKvYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECIynbcd+bt7BeGlj8CFGAQ5GJR7einPW8UKsiWXFlbmHGCU4
        mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9M5EZinR5HxgrOeVxBuaGppbWBqaG5sbm1ko
        ifN2CByMERJITyxJzU5NLUgtgulj4uCUamCcpMcY/7d5R8/Xrzv3ee9OUnomYlD8lHPxt+1S
        natl93UmuEfnLxFyvcqyuGudseGko0s3ld9uYHhpmjKt/WNBeW02b9iXfww+19dec1p4QFT2
        WUX6Qof1329/OMi6li+TPSqQ+/y3zz2HhS8U2j4R1zDXk43M+scRasVzfueeTscOtanbGVYr
        sRRnJBpqMRcVJwIAtG2XJ70CAAA=
X-CMS-MailID: 20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6
References: <CGME20200819123225eucas1p28be1b1920ade0ba8997bc17da97599b6@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a series of fixes created during porting a device driver (these
patches will be released soon too) for an SPI device to the current kernel.

The two most important are 

  spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
  spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250

Without them DMA transfers larger than 512 bytes from the SPI controller
would fail.

Łukasz Stelmach (8):
  spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
    s3c64xx_enable_datapath()
  spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
  spi: spi-s3c64xx: Report more information when errors occur
  spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
  spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
  spi: spi-s3c64xx: Check return values
  spi: spi-s3c64xx: Increase tranfer timeout
  spi: spi-s3c64xx: Turn on interrupts upon resume

 drivers/spi/spi-s3c64xx.c | 81 +++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 25 deletions(-)

-- 
2.26.2

