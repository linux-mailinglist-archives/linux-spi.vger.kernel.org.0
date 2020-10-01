Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121A280287
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbgJAPWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:22:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40875 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgJAPWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152249euoutp01349f407c4b9f0cc0c2d8378b6cf1414b~555UMUAWe2712227122euoutp01Z
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152249euoutp01349f407c4b9f0cc0c2d8378b6cf1414b~555UMUAWe2712227122euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565769;
        bh=GJq8Rrl/NqY+M8Jy9Il23NXnXWGEb+l5rpI2RMGL5uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdutv5RUGBIMkf0u7JITUZ0D1+mh+Z9YHnhULtczKivt+/zomYJtAy2kJBy7LU8ek
         MTq2CfzjmaBX9qMigVoRDChl+1sSlhmnK1bg4B5OGX+olYL3peHcmsYbIIScrWHm/P
         c4b/c0ZP7elDz/dEeR8zJr/1iLhcngBVazXbUxqE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152249eucas1p2b495c0905e73ec5122f74683f74f1acf~555T3vaaj1941819418eucas1p2F;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.EC.06318.944F57F5; Thu,  1
        Oct 2020 16:22:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152249eucas1p1c3bbe7b2a677affe4e1a1e4d469f94c8~555TjTztC1646216462eucas1p1O;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152249eusmtrp16ccaa3ffc2978b39f9c17abb2b48db92~555TipH3K2671626716eusmtrp1k;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-a2-5f75f4492abb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.A5.06314.944F57F5; Thu,  1
        Oct 2020 16:22:49 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152248eusmtip24cdda12d8517106e67e5454a644fa5c5~555TZRzJ_0513205132eusmtip2V;
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
Subject: [PATCH v2 RESEND 8/9] spi: spi-s3c64xx: Increase transfer timeout
Date:   Thu,  1 Oct 2020 17:21:47 +0200
Message-Id: <20201001152148.29747-9-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87qeX0rjDZ73S1os/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlLGtvYCz4
        zFFx5cxMtgbGmexdjJwcEgImEs0dJ5i6GLk4hARWMEqsPbEGyvnCKPH1azMzhPOZUWLVq0Nw
        Lf9vtkMlljNKzD21khEkISTwnFFi+moeEJtNwFGif+kJVpAiEYHtTBITP59nAUkwC5RK9Ow8
        xAZiCwt4SXyefB6smUVAVeLD4sVMIDavgLXExfvvmSG2yUu0L98OVs8pYCNxbuJhNogaQYmT
        M5+AzeQX0JJY03Qdar68RPPW2VC9j9glXs1ggrBdJA739LJA2MISr45vgfpGRuL05B6gOAeQ
        XS8xeZIZyM0SAj2MEtvm/ICqt5a4c+4XG0gNs4CmxPpd+hBhR4mrN18wQbTySdx4KwhxAZ/E
        pG3TmSHCvBIdbUIQ1SoS6/r3QA2Ukuh9tYJxAqPSLCS/zEJy/yyEXQsYmVcxiqeWFuempxYb
        56WW6xUn5haX5qXrJefnbmIEpqjT/45/3cG470/SIUYBDkYlHt6MQ6XxQqyJZcWVuYcYJTiY
        lUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB
        cY3uukVb++dVSISmO7x1rZo989jWP5PveHQwB31pbu1f8PJ6dqnlyt0vOyb7P7sWdfs7pzB/
        1Qylmp5taptblbffZb3zjSuneoMPXxVLY/Aduwf7LVl8eq5HfuU4UKb4Lyn7rAdv3ea3u948
        t+nO9WO4Ljvl7fzi0oQsDyb7aemFQZvi3+6bpMRSnJFoqMVcVJwIAPV5V8ZNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qeX0rjDVqms1ss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLGtvYCz4zFFx5cxMtgbGmexdjJwcEgIm
        Ev9vtjN3MXJxCAksZZRY+eUwaxcjB1BCSmLl3HSIGmGJP9e62CBqnjJKTFywGqyZTcBRon/p
        CVaQhIjAfiaJSxfus4AkmAXKJS7Neg5WJCzgJfF58nlGEJtFQFXiw+LFTCA2r4C1xMX775kh
        NshLtC/fzgZicwrYSJybeBjMFhLIldi9+ygbRL2gxMmZT1hAjmMWUJdYP08IJMwvoCWxpuk6
        1Fp5ieats5knMArNQtIxC6FjFpKqBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjctux
        n5t3MF7aGHyIUYCDUYmHV+BAabwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KL
        DzGaAr05kVlKNDkfmC7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFw
        SjUwVt7ecPTlJ0mJ0hwPz5R19x43n12+7YTIf8mWE2pP/zcpxF/56LH0ibxxx+xLctL7T+/Q
        NDz/LG197PpZnq7m270cC5u2CUWFm7imtjnffrHo49KJtqeFuredF3oX/LI96JuM8IV9+bue
        hn1rM6ndOeVeuQXTrOSpLz49SZsxV2/hkoZnUdw7JymxFGckGmoxFxUnAgAd7q793wIAAA==
X-CMS-MailID: 20201001152249eucas1p1c3bbe7b2a677affe4e1a1e4d469f94c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152249eucas1p1c3bbe7b2a677affe4e1a1e4d469f94c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152249eucas1p1c3bbe7b2a677affe4e1a1e4d469f94c8
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152249eucas1p1c3bbe7b2a677affe4e1a1e4d469f94c8@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Increase timeout by 30 ms for some wiggle room and set the minimum value
to 100 ms. This ensures a non-zero value for short transfers which
may take less than 1 ms. The timeout value does not affect
performance because it is used with a completion.

Similar formula is used in other drivers e.g. sun4i, sun6i.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 89c162efe355..ea5a22dec53d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -473,7 +473,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
-	ms += 10; /* some tolerance */
+	ms += 30;               /* some tolerance */
+	ms = max(ms, 100);      /* minimum timeout */
 
 	val = msecs_to_jiffies(ms) + 10;
 	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
-- 
2.26.2

