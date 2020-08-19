Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F32249DEC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHSMdS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:33:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60786 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgHSMct (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123229euoutp020a24ac14ae624aa1d94d274be75f9682~sq1Ty6TmS1343913439euoutp02j
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819123229euoutp020a24ac14ae624aa1d94d274be75f9682~sq1Ty6TmS1343913439euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840349;
        bh=sHz9XIY28jBa5tlEBali0qZr+Ofu2cstTm1SGZTXsMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxCTm3k0T82k+fCObXI9KlJxngC08Oa9L8Cq62528ObjBGd6EqnF2Qir8I0WV0o9n
         DFVca07XDsAVYbl3/sZu1lRHl/kF2hekmO+7xKI0cXMP83NPk6IG/ZaFm0QSxW8Qmg
         PJ3iH95vQeMEqKGvUS5ZVHiiAe6PQw5/VLH92Csg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123228eucas1p263fd2b27c771539cf3fd84fe09db450e~sq1TaENCJ1280312803eucas1p2Q;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.D3.06318.CDB1D3F5; Wed, 19
        Aug 2020 13:32:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace~sq1THztZr1042010420eucas1p1_;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819123228eusmtrp20cd5e853d123e833030f5e74dfc6259a~sq1THNPmW2933429334eusmtrp2T;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-c8-5f3d1bdcadd6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.DF.06314.CDB1D3F5; Wed, 19
        Aug 2020 13:32:28 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123228eusmtip20ea267b41195af5a976803de1184e354~sq1S1gVLk0167401674eusmtip2X;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 7/8] spi: spi-s3c64xx: Increase transfer timeout
Date:   Wed, 19 Aug 2020 14:32:07 +0200
Message-Id: <20200819123208.12337-8-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7p3pG3jDb63a1ss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlfHkywu2gka2it+fbrI0MH5h
        6WLk5JAQMJF4/3AyUxcjF4eQwApGiZ3rHzBCOF8YJf4sPsoG4XxmlFj88SM7TMu/cxvZQGwh
        geWMEi/nS0MUPWeUuPduHSNIgk3AUaJ/6QlWkISIwAQmiYfn3oB1MAuUSvTsPARmCws4SGy/
        2A7WwCKgKtF9aC0TiM0rYC2xv28KK8Q2eYn25dvB6jkFbCQe/prCBlEjKHFy5hOwJ/gFtCTW
        NF1ngZgvL9G8dTYzyGIJgXPsErce3WWDGOQisfb5LyYIW1ji1fEtUO/ISPzfOR8ozgFk10tM
        nmQG0dvDKLFtzg9oKFlL3Dn3iw2khllAU2L9Ln2IsKPE6uNt7BCtfBI33gpCnMAnMWnbdGaI
        MK9ER5sQRLWKxLr+PVADpSR6X61gnMCoNAvJM7OQPDALYdcCRuZVjOKppcW56anFxnmp5XrF
        ibnFpXnpesn5uZsYgQnp9L/jX3cw7vuTdIhRgINRiYe34px1vBBrYllxZe4hRgkOZiURXqez
        p+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi4JRqYDSuY/74
        MsK50XHj4/rEiScPTTz1hUnt1Ip13ttexj9793x5iNPpuKuPxI/8Sbl05OwJP49Tb//UdFRM
        Wdi7S4N/WbXYMakU42n5JZvUZ9x/p8C9siegKybJc8auVWaZDG6MMhMT2VSTWFlKuCMuqW9Z
        c+Tftr+MX9hS15xsunm9tONiiMs+9T4lluKMREMt5qLiRADLkjr6RAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7p3pG3jDbpvC1ks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl/Hkywu2gka2it+fbrI0MH5h6WLk5JAQMJH4d24jWxcjF4eQ
        wFJGiQc/pgA5HEAJKYmVc9MhaoQl/lzrgqp5yijxetlpsGY2AUeJ/qUnWEESIgIzmCSe3JjM
        CpJgFiiXuDTrOTuILSzgILH9YjsjiM0ioCrRfWgtE4jNK2Atsb9vCivEBnmJ9uXb2UBsTgEb
        iYe/poDZQkA1XYsXQtULSpyc+YQF5DhmAXWJ9fOEQML8AloSa5qus0CslZdo3jqbeQKj0Cwk
        HbMQOmYhqVrAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMP62Hfu5eQfjpY3BhxgFOBiV
        eHgrzlnHC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQmxOZpUST84Gp
        Ia8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6Pgjlt3nF1qr/Gc
        XuL9ZpFSgvoy38Lmxxb/tywv3tFoqHs10aJy1ePnfos9VgivfmYbte3CuqU5tdJSXAxfuGaF
        Vjx1fZZzMPabpbJYq9qKrk1xV5PLdXW9t/M++5i+6eb67Tt1ZYN/lvJq/5tnwOZh/m1ey53l
        XhLibzYvaPQ/+f38Yvs5UaZKLMUZiYZazEXFiQBW0daz1QIAAA==
X-CMS-MailID: 20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123228eucas1p19ac7fc04dec52c733ab9c770e91f6ace@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 27d77600a820..27db1e0f6f32 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -464,7 +464,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
-	ms += 10; /* some tolerance */
+	ms = (ms * 10) + 30;    /* some tolerance */
+	ms = max(ms, 100);      /* minimum timeout */
 
 	val = msecs_to_jiffies(ms) + 10;
 	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
-- 
2.26.2

