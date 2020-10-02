Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01A28125E
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJBMXS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54178 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgJBMXB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:23:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122256euoutp02144c5bfb05ddaab0c7b9d61a6823a939~6LFiu-lTz2196421964euoutp02N
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002122256euoutp02144c5bfb05ddaab0c7b9d61a6823a939~6LFiu-lTz2196421964euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641376;
        bh=f/KuQfJ1RwS6nqmPWEc337gr7kbEjJQjnrujYNmhICE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOEBdClYP4EjGghx1LWWF+Cy44x8vKEwvhOQypAODifhUZKjEQk2Gl0fvaqpH+TBy
         WBfLXfmbUVslK9O9DKH1FjrwEoiHPua8Z1ia16Uzmo+fPpHbEMMjA/AUwFxAhdh9fM
         vsWYsTklM6K84wWJ9Pl9XHUKE6fyGIVA5gT9dcWY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122256eucas1p2298f0dce69266f0ef85a610aedb7199b~6LFiRm4B-1010210102eucas1p2K;
        Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.42.06456.0AB177F5; Fri,  2
        Oct 2020 13:22:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002122256eucas1p10093b3619fbe5f96ae351920329d1626~6LFh7A0NO0998409984eucas1p1D;
        Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002122256eusmtrp1825b3cb0ad387e0924d5cb6303447670~6LFh6VMjH1376413764eusmtrp1O;
        Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-9f-5f771ba0f4f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.CD.06314.F9B177F5; Fri,  2
        Oct 2020 13:22:55 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122255eusmtip27ea039f48d8ac51da319a2d6cd605682~6LFhvw5MM1355513555eusmtip2Y;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Bart=C5=82omiej=20=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 9/9] spi: spi-s3c64xx: Turn on interrupts upon resume
Date:   Fri,  2 Oct 2020 14:22:43 +0200
Message-Id: <20201002122243.26849-10-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7oLpMvjDRbtF7RY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKuLF0PVPB
        K7aKzkurWBsYn7N2MXJySAiYSDw7+pm5i5GLQ0hgBaPEvX2voZwvjBIn77axQDifGSV2nZjH
        BNMy7fYHqKrljBIndu9jg3CeM0rsX/OJGaSKTcBRon/pCVaQhIjAdiaJiZ/Pg81iFjjKKLH5
        wVUWkCphAQ+J3qYPYHNZBFQlWhdMAuvmFbCROPpnFtQ+eYn25dvZQGxOoPjJRdvYIGoEJU7O
        fAI2h19AS2JN03UwmxmovnnrbLD7JATusUs82PKIGWKQi0T/121QQ4UlXh3fwg5hy0icntwD
        1MwBZNdLTJ5kBtHbwyixbc4PFogaa4k7536xgdQwC2hKrN+lDxF2lOhYMI0RopVP4sZbQYgT
        +CQmbZvODBHmlehoE4KoVpFY178HaqCURO+rFYwTGJVmIXlmFpIHZiHsWsDIvIpRPLW0ODc9
        tdgwL7Vcrzgxt7g0L10vOT93EyMwUZ3+d/zTDsavl5IOMQpwMCrx8GYcKo0XYk0sK67MPcQo
        wcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTByc
        Ug2M+p1zO7Y4CTWbsJ+L/iH26aff7AXMzVkhe7OYsg0mW2Uff3lGSZuliHO6wfXF+7Se3e/w
        7r86RXCLmlhA3OKlm/VvR97avGj6m0fVP4zD0tNvpX2rL379midTv+7AjNID8+Nl757XaOm4
        t+NmnvH0gFsvW16zdh4tVlvaafCse9uRWN2++dGvlFiKMxINtZiLihMBKnO7blADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rzpcvjDS5PsLJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuLF0PVPBK7aKzkurWBsYn7N2MXJySAiY
        SEy7/YG5i5GLQ0hgKaPEjmuzmLoYOYASUhIr56ZD1AhL/LnWxQZiCwk8ZZRYNpkZxGYTcJTo
        X3qCFaRXRGA/k8SlC/dZQBxmgcOMEpfXrWMCqRIW8JDobfoAZrMIqEq0LpgE1s0rYCNx9M8s
        JogN8hLty7eDbeAEip9ctA1qm7VE68e5rBD1ghInZz5hATmOWUBdYv08IZAwv4CWxJqm6ywg
        NjPQmOats5knMArNQtIxC6FjFpKqBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjctux
        n5t3MF7aGHyIUYCDUYmHV+BAabwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KL
        DzGaAr05kVlKNDkfmC7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFw
        SjUwLrz79yR/3dvKd895BL736XXwR52+zRMonuhet+/owhOn2EQNXVXbvzCsnPi0rE5/+rmo
        ecr/NsleanwWqxjFEKm0xnaBsFdSVf6KLUky5+wNuk2KvSI5qll/ZGhFP9wXrCPWpB5T/rw9
        QoiDx7nlS0NHbOAuSUvz69vnX0zJKdT7sb/xY6cSS3FGoqEWc1FxIgBUrg4f3wIAAA==
X-CMS-MailID: 20201002122256eucas1p10093b3619fbe5f96ae351920329d1626
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122256eucas1p10093b3619fbe5f96ae351920329d1626
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122256eucas1p10093b3619fbe5f96ae351920329d1626
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122256eucas1p10093b3619fbe5f96ae351920329d1626@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

s3c64xx_spi_hwinit() disables interrupts. In s3c64xx_spi_probe() after
calling s3c64xx_spi_hwinit() they are enabled with the following call.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9f728a7c59a1..dfa7c91e13aa 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1378,6 +1378,10 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 
 	s3c64xx_spi_hwinit(sdd);
 
+	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
+	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
+	       sdd->regs + S3C64XX_SPI_INT_EN);
+
 	return 0;
 
 err_disable_src_clk:
-- 
2.26.2

