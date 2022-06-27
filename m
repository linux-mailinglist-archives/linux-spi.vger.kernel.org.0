Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE955B502
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jun 2022 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiF0Bk6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jun 2022 21:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiF0Bk5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jun 2022 21:40:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE621E59
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 18:40:55 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220627014052epoutp01c044bf078f936ca15c6f7dffbe133305~8Vqo30jBj1671916719epoutp01S
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 01:40:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220627014052epoutp01c044bf078f936ca15c6f7dffbe133305~8Vqo30jBj1671916719epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656294052;
        bh=FTgIlwdCexk43RcygmqXEfu9bpUi2ih8ml1Z2LIlrv4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qZN4C5ywSOAQh6EPTqqlLD6d3DBehK0e5kEU4TgHkAPffoiyT0xDTyfjjPNdUSZnb
         Bvzx3QlnBdYZgnFxqjEIIqH8KMcFMUTL1w7y9ChOvKkzMiFyLFrppikO+x/R9nEOfF
         wrwvuOu8UCRi+/oap7S5BeTbx5YTuvLwUPUemr24=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220627014050epcas2p3219e77e193e8f1c752cf76535dcfe2f7~8Vqnxp5SK3172231722epcas2p3N;
        Mon, 27 Jun 2022 01:40:50 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LWVmf2P10z4x9Q9; Mon, 27 Jun
        2022 01:40:50 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.B3.09650.2AA09B26; Mon, 27 Jun 2022 10:40:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220627014049epcas2p1fd6b4dddf5b40cd334708043a08ac2f9~8Vqm8Bemy0829608296epcas2p1a;
        Mon, 27 Jun 2022 01:40:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627014049epsmtrp145f972a96a2db021f40c5d8034b9570e~8Vqm6-5Rd0204502045epsmtrp13;
        Mon, 27 Jun 2022 01:40:49 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-3a-62b90aa28752
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.A3.08802.1AA09B26; Mon, 27 Jun 2022 10:40:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220627014049epsmtip194ad9f2c15cda06b6eb7bcd7cca62d2c~8VqmxC3_22834328343epsmtip1h;
        Mon, 27 Jun 2022 01:40:49 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Adithya K V <adithya.kv@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] spi: s3c64xx: move dma_release_channel to unprepare
Date:   Mon, 27 Jun 2022 10:38:45 +0900
Message-Id: <20220627013845.138350-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTTHcR184kgxUTBC0OTHjFavFg3jY2
        i8U/njNZTH34hM3i8n5ti72vt7JbbHp8jdVixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjP2tz9mL5goWjH5yULmBsbngl2MnBwSAiYSO49uZOxi5OIQEtjB
        KPFj729mCOcTo8SvD/tYIJzPjBJ372xlhml5OK+HHSKxi1HizKtXbBDOR0aJ96dWsYBUsQno
        Smx5/ooRxBYRqJKY+fwN2FxmgUeMEtdWnGACSQgLuEj8XdDODmKzCKhK3Px8AczmFbCXeL+9
        jwlinbzEhvm9zBBxQYmTM5+ALWAGijdvnQ02VELgEbvE1d+T2SEaXCR2fvwGZQtLvDq+BcqW
        knjZ3wZlF0ssnfWJCaK5gVHi8rZfbBAJY4lZz9qBzuYA2qApsX6XPogpIaAsceQW1F4+iY7D
        f9khwrwSHW1CEI3qEge2T2eBsGUluud8ZoWwPSTu/b0LFhcSiJVY/3kj8wRG+VlIvpmF5JtZ
        CHsXMDKvYhRLLSjOTU8tNiowgkdrcn7uJkZwwtRy28E45e0HvUOMTByMhxglOJiVRHhfX9+a
        JMSbklhZlVqUH19UmpNafIjRFBi+E5mlRJPzgSk7ryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQ
        QHpiSWp2ampBahFMHxMHp1QD00HZRRf0+H7Hi021tQ4Kfjd5ol7UvaC72qlfbqsLiG5RX+DK
        zet6tfnR0ex6f5dZak9d1F+eNbt9cOaEz++XeN4piJqpfVy/1+IFw+GnBoIV5Uv+57orbus/
        KZCR8uZP7OYTjZ3nVZSXX73k/f/6HrsjvzY+DhR4O/+hq8rEdj3hzLcXmdYbVdgfndgju/xt
        z8/IdsfjZnqqDxmV7R8Fdd/+PMP3p5q0b98O86JAbr1Ah68Hcrfv0wx48DSm5W/kzcV8Uk4X
        rcxNIzo+MHKq14ZWTLzyQK10kbL9TwXnJ1fTDDxnsvP0M/M/NHs9vcP/c8LyY04Nlgf73961
        /x3Z/+3GFrYA8cvMOTppsn6LlViKMxINtZiLihMB3AHoyiEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO5Crp1JBjtPm1scmPCK1eLBvG1s
        Fot/PGeymPrwCZvF5f3aFntfb2W32PT4GqvFjPP7mCwaP95kd+D0uL7kE7PHplWdbB53ru1h
        89i8pN6jb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4Mva3P2YvmChaMfnJQuYGxueCXYycHBIC
        JhIP5/WwdzFycQgJ7GCUONn8kAUiISvx7N0OdghbWOJ+yxFWEFtI4D2jxOdudxCbTUBXYsvz
        V4wgtohAjcSZC1cZQQYxCzxjlFh1eRFYg7CAi8TfBe1gg1gEVCVufr4AZvMK2Eu8397HBLFA
        XmLD/F5miLigxMmZT8COYAaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoT
        c4tL89L1kvNzNzGCA1hLawfjnlUf9A4xMnEwHmKU4GBWEuF9fX1rkhBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MhZJ813a8nHryKDefhs+zh39znsdH
        Re0IEZecPPf6hYeHBAx9lTIVVzd8DzVND+uZ7PUuI2X7cStnkeUfJrw6dEbELur5UTeDqufB
        9RM1fxZz1DoUbjvF+C3Hd69r889v8qrmpRKVFlMb3v8Odr/ZzLGtgddOdYH4+YezFFZF8RVP
        VlBX2nbkoKzITOUZ0iYfT03pEn1x93rD92n3hEoPX1rHxVG/nnWBir9Os9GB7sW9n781uqn0
        1RRON/y2Mjn76MQHXZOuHp+6XTfOl+Pr1TMOwSvjQz772Vl9lvzv6uo9YfPeu1UROxrbmbos
        350I//nB/k3HvSMeRu8fFOZ2L7vCajX5YXx/iU/y3cpvSizFGYmGWsxFxYkAbWfwo88CAAA=
X-CMS-MailID: 20220627014049epcas2p1fd6b4dddf5b40cd334708043a08ac2f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627014049epcas2p1fd6b4dddf5b40cd334708043a08ac2f9
References: <CGME20220627014049epcas2p1fd6b4dddf5b40cd334708043a08ac2f9@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This fixes the sequence of dma_release_channel.
Since commit f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only
during data transfer"),
dma_release_channel has been located in the s3c64xx_spi_transfer_one
but this makes invalid return of can_dma callback.
__spi_unmap_msg will check whether the request is requested by dma or
not via can_dma callback. When it is calling to check it, the channels
will be already released at the end of s3c64xx_spi_transfer_one so the
callback function will return always "false". So, they can't be unmapped
from __spi_unmap_msg call. To fix this, we need to add
unprepare_transfer_hardware callback and move the dma_release_channel
from s3c64xx_spi_transfer_one to there.

Fixes: f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only during data transfer")
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 819b660dae82..7f0faf0d75d9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -373,6 +373,24 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	return 0;
 }
 
+static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
+{
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
+
+	if (is_polling(sdd))
+		return 0;
+
+	/* Releases DMA channels if they are allocated */
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+		dma_release_channel(sdd->rx_dma.ch);
+		dma_release_channel(sdd->tx_dma.ch);
+		sdd->rx_dma.ch = 0;
+		sdd->tx_dma.ch = 0;
+	}
+
+	return 0;
+}
+
 static bool s3c64xx_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
@@ -804,14 +822,6 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		xfer->len = origin_len;
 	}
 
-	/* Releases DMA channels after data transfer is completed */
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
-		dma_release_channel(sdd->rx_dma.ch);
-		dma_release_channel(sdd->tx_dma.ch);
-		sdd->rx_dma.ch = NULL;
-		sdd->tx_dma.ch = NULL;
-	}
-
 	return status;
 }
 
@@ -1128,6 +1138,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->setup = s3c64xx_spi_setup;
 	master->cleanup = s3c64xx_spi_cleanup;
 	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
+	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
 	master->num_chipselect = sci->num_cs;
-- 
2.36.1

