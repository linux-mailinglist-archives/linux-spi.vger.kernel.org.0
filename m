Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4024DE61
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgHUR3i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:29:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38848 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgHUQOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161409euoutp02efc949316e925a0d9ae987211259e007~tVJbCZjPW0371003710euoutp02k
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161409euoutp02efc949316e925a0d9ae987211259e007~tVJbCZjPW0371003710euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026449;
        bh=Dxb1SZqMxibqUhl7VyWNPNEmP5zeKa3acFNVfEqRw/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfdfivzeID+QoggnK8XOEVNIPQgAVgy9s/4/dsDxCMcelyYsqZ55fFVQAzWqAo9p1
         LVDhQCO5AzEl4hiPYlEALMMCb3+8TEgq8qqFTFUEZtghWqtPG/6ypFp2gHHbMVzqaz
         29WbXxGh/96oueBnmCJ50Xq98W9pV40VLuVbgGSI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161408eucas1p2cafb7eeed6d5b4efac5898f5a39f8204~tVJaHwHFv1578115781eucas1p2l;
        Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.B2.06318.0D2FF3F5; Fri, 21
        Aug 2020 17:14:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821161407eucas1p23a283ac117d4381e087e9bacec537665~tVJZrBcp81823418234eucas1p2m;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eusmtrp10acbb38b7aa0954ac61f8e63a2c5ccda~tVJZqYXBt1179011790eusmtrp19;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-d5-5f3ff2d0fc0e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.B9.06017.FC2FF3F5; Fri, 21
        Aug 2020 17:14:07 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161407eusmtip2fe0ec413613697189cd2361948227403~tVJZdOHJ_2051720517eusmtip2n;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 8/9] spi: spi-s3c64xx: Increase transfer timeout
Date:   Fri, 21 Aug 2020 18:14:00 +0200
Message-Id: <20200821161401.11307-9-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7oXPtnHG/zv5LNY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK2P19tfsBbs4KjoWTmZtYHzG
        1sXIySEhYCJx7/hupi5GLg4hgRWMEicutjNDOF8YJX5NWsMEUiUk8JlR4sjmAJiO/b0HWSGK
        ljNKnN40hx3Cec4osa9pEStIFZuAo0T/0hNgVSICE5gkHp57A7aQWaBUomfnITBbWMBZ4sm9
        /WA2i4CqxOsFe8FsXgFriZMr10IdKC/Rvnw7mM0pYCNx/FITK0SNoMTJmU9YQGx+AS2JNU3X
        WSDmy0s0b50N9oOEwCl2iUkNm6AGuUj8OL2LBcIWlnh1fAs7hC0jcXpyD1CcA8iul5g8yQyi
        t4dRYtucH1D11hJ3zv1iA6lhFtCUWL9LHyLsKDGleTczRCufxI23ghAn8ElM2jYdKswr0dEm
        BFGtIrGufw/UQCmJ3lcrGCcwKs1C8swsJA/MQti1gJF5FaN4amlxbnpqsXFearlecWJucWle
        ul5yfu4mRmBCOv3v+NcdjPv+JB1iFOBgVOLh/XHIPl6INbGsuDL3EKMEB7OSCK/T2dNxQrwp
        iZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTCevhMv8jHGVGdt
        ltSDdwfNdky64K45b3Js68rnHas+fdPlc4ljPCQ5JXbzvrQ4kdMXwjlPiK/dprROcPMvTWPr
        vF+Gjk0Lryd3LbcNDs38scrzv9bM63WbTr88PX2njuJcz75nBqWx1mI73v50eibgXXRuT/jZ
        RIctnS9+t5XlbYzcYzl3Zd0DJZbijERDLeai4kQAK4uuS0QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7rnP9nHG9zZrGWx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsbq7a/ZC3ZxVHQsnMzawPiMrYuRk0NCwERif+9B1i5GLg4h
        gaWMEvvbdrB0MXIAJaQkVs5Nh6gRlvhzrQusXkjgKaPE5ZY8EJtNwFGif+kJsF4RgRlMEk9u
        TGYFSTALlEtcmvWcHcQWFnCWeHJvP1gzi4CqxOsFe8FsXgFriZMr10IdIS/Rvnw7mM0pYCNx
        /FITK8Qya4ltiy+zQNQLSpyc+QTsNmYBdYn184RAwvwCWhJrmq6zQKyVl2jeOpt5AqPQLCQd
        sxA6ZiGpWsDIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw+rYd+7llB2PXu+BDjAIcjEo8
        vD8O2ccLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdCbE5mlRJPzgYkh
        ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo7xZd5Szt3//6eNX
        MxcLvvwbPD2Rp6T13+Lrisa/2VTmu7Iu1WK1bRFaUB3QssG843jhL2/x/ZPK4+efnxn81lcs
        O+9rh4/r/F5N8ZrerM0qU67fNJigMb3OrDDksETE6kc3BWUrXn9aYp0TarCM+R13vv3uKYp7
        nj5ZohCxdXLSpYgrhgGPlFiKMxINtZiLihMBWyc9dNQCAAA=
X-CMS-MailID: 20200821161407eucas1p23a283ac117d4381e087e9bacec537665
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161407eucas1p23a283ac117d4381e087e9bacec537665
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161407eucas1p23a283ac117d4381e087e9bacec537665
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161407eucas1p23a283ac117d4381e087e9bacec537665@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Increase timeout by 30 ms for some wiggle and set the minimum value to
100 ms. This ensures a non-zero value for short transfers which
may take less than 1 ms. The timeout value does not affect
performance because it is used with a completion.

Similar formula is used in other drivers e.g. sun4i, sun6i.

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

