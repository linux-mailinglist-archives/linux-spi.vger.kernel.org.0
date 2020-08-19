Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F56249DE9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHSMdN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:33:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60788 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgHSMct (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123229euoutp02076a0f122b7041f6981d2f90ddae7f99~sq1UEgRrv1342313423euoutp02l
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819123229euoutp02076a0f122b7041f6981d2f90ddae7f99~sq1UEgRrv1342313423euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840349;
        bh=+cQ0qkFcczMMqrtKf3ORB2nrtOVHuhDIpsXvvZWWCto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRtZ4GXNPeziK7GJoeLjO53EvkRyT+Yfnf1rbQ4LeWPV7SI0O2r5P0kfpRnHMu4dW
         j1ez54S7ecIlt7Cil96L/1Wram2maHFIy54gSlwP8bwLgaAhW6XDop1VL4AIj9PRZW
         gWzX0kIrvGZFsXRzNcidsOBGI2UqOQr/7oJsYE6A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123229eucas1p2080888519e789dd3d209ed718b0cccdc~sq1TtBOXi2958529585eucas1p2W;
        Wed, 19 Aug 2020 12:32:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.FC.05997.CDB1D3F5; Wed, 19
        Aug 2020 13:32:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123228eucas1p132d530d17256f887d93ed7792f5b9587~sq1TVEUJn1043110431eucas1p1_;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819123228eusmtrp177eef954eecb0661659abe8ea61d335e~sq1TUV2341680116801eusmtrp1A;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-41-5f3d1bdc3a76
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.73.06017.CDB1D3F5; Wed, 19
        Aug 2020 13:32:28 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123228eusmtip129998803c8db9600657644651c4f8d31~sq1TLIxaS3061630616eusmtip1j;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 8/8] spi: spi-s3c64xx: Turn on interrupts upon resume
Date:   Wed, 19 Aug 2020 14:32:08 +0200
Message-Id: <20200819123208.12337-9-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7p3pG3jDX60W1ks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbH75j32giWsFZe7+tkbGHey
        dDFyckgImEhsO7SSsYuRi0NIYAWjxOlFZ5khnC+MEnuWfmOHcD4zSuz8do8VpuXv32esEInl
        jBK3936Fcp4zSsy8uRJsMJuAo0T/0hNgCRGBCUwSD8+9YQNJMAuUSvTsPARmCwu4SmxYcw3M
        ZhFQlfi9q40RxOYVsJa4dvsPO8Q6eYn25dvBajgFbCQe/prCBlEjKHFy5hOwZfwCWhJrmq6z
        QMyXl2jeOhvsCQmBc+wS++bPZYQY5CJx4OVhqKHCEq+Ob4GyZSROT+4BauYAsuslJk8yg+jt
        YZTYNucHNJisJe6c+8UGUsMsoCmxfpc+RNhR4mFPMztEK5/EjbeCECfwSUzaNp0ZIswr0dEm
        BFGtIrGufw/UQCmJ3lcrGCcwKs1C8swsJA/MQti1gJF5FaN4amlxbnpqsVFearlecWJucWle
        ul5yfu4mRmBKOv3v+JcdjLv+JB1iFOBgVOLhrThnHS/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhiF/8kXnLrdmTvN
        Xvj09ZRnq/1DyuuUFUqS4lbes+15u3Nt6Bkt7WTXm82rxI3DDqrs/uZSrPzp7gY+NrU3tiwv
        Q98cnCAUs+LwzNfSKuGqhjN+7zE+HlXc92S/3RSf2svmZaZW3C6JU92i5aXtzIPCDKaqXX0+
        P7jv8r+Xy5l9rL3E5hrqMiixFGckGmoxFxUnAgAGB/RVRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7p3pG3jDaY1qlos/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7H75j32giWsFZe7+tkbGHeydDFyckgImEj8/fuMtYuRi0NI
        YCmjxJ1NH9i7GDmAElISK+emQ9QIS/y51sUGUfOUUeLBrc1MIAk2AUeJ/qUnwJpFBGYwSTy5
        MZkVJMEsUC5xadZzdhBbWMBVYsOaa2wgNouAqsTvXW2MIDavgLXEtdt/2CE2yEu0L98OVsMp
        YCPx8NcUMFsIqKZr8UImiHpBiZMzn7CAHMcsoC6xfp4QSJhfQEtiTdN1Foi18hLNW2czT2AU
        moWkYxZCxywkVQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExt+2Yz+37GDsehd8iFGA
        g1GJh7finHW8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgK9OZFZSjQ5
        H5ga8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MOqduqely2O6
        9SPfhVuPFmcaLpnPx7r1UieX4odFk7M3n9cXFtzhln/Wsa87WqHkrs/RcBdxdXbWQEX9fh5O
        50Mcl0/ZctsZZ/Dsy9sikyw6hz+qzH6O+prY/ycq1r3abrx8ifzpv9F7U7QzZ3cdMrh/rPy5
        /rSXshfkw8U/Hjuz2uH/LO37ZkosxRmJhlrMRcWJAL3wrWDVAgAA
X-CMS-MailID: 20200819123228eucas1p132d530d17256f887d93ed7792f5b9587
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123228eucas1p132d530d17256f887d93ed7792f5b9587
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123228eucas1p132d530d17256f887d93ed7792f5b9587
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123228eucas1p132d530d17256f887d93ed7792f5b9587@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 27db1e0f6f32..5dcad43fb847 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1356,6 +1356,10 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 
 	s3c64xx_spi_hwinit(sdd);
 
+	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
+	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
+	       sdd->regs + S3C64XX_SPI_INT_EN);
+
 	return 0;
 
 err_disable_src_clk:
-- 
2.26.2

