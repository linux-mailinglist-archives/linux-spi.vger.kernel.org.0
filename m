Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9372802A3
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbgJAPWs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:22:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41144 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbgJAPWs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152247euoutp022aa8eda83bab64a4d85292649d7c6f59~555RoNlsP2406624066euoutp02I
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201001152247euoutp022aa8eda83bab64a4d85292649d7c6f59~555RoNlsP2406624066euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565767;
        bh=8qQ7XhRDqloXq5mu4QmtOTIxJXHGJmKRl076KUjAT0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnSQWVU2eeRYBmiMcvKzdOX+wezxM69cjEPv9cImEzyoM3EHcqzAZTpm6nks/HNOo
         O1derfolfsVNjX7GACgIzz22cV63KWBz6eBPyEdCLpjoZmH9xlXgyM7omfBjbwocRM
         m2bA9sF2AKHG6+zfY70pDdLsXJnHT2CacvyhAU0k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201001152246eucas1p1d68cac3762c9b82972341f23db5117ae~555RKz0wb0403504035eucas1p1T;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.EC.06318.644F57F5; Thu,  1
        Oct 2020 16:22:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152246eucas1p1ee289b8a85b707f7496355c081623796~555Q3DMdC2388923889eucas1p1Q;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152246eusmtrp1ca03cbe7bad9fa24f8758cf0177b66a1~555Q2U_6k2671626716eusmtrp1c;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-98-5f75f4463591
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.95.06314.644F57F5; Thu,  1
        Oct 2020 16:22:46 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152246eusmtip19e697be5899cbd56265e489ac7762964~555QtlwHZ2653026530eusmtip1Z;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
Date:   Thu,  1 Oct 2020 17:21:39 +0200
Message-Id: <20201001152148.29747-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXZ3X7acXafgYUbCSEIpX9DimlIZFetbEPVBS5t6UXG+sOtM
        K9OMrMS0tBebw8z3xJdaNp2I1RKnrlxpZWqKMss0/GAaqYjVvEp++5/n/M7//A88FCY14jIq
        LjGFVScqVXJCLDR0LVl3H13QRPi+6JEzFYtTAuZpcRPO3J2YJJgC2w+MsVqfkMyQqRYxetsn
        nBlo0xFMsbVDwFyeGyKZhs5RkqlrW0EHHRSDlT8xhVE7Sir0dTcIxbPKTEV+cx1SzOu3HydC
        xcHRrCoulVX77D8rjm1YNuDJH7ek/Xk8SGahXlEuElFAB8DIRCuWi8SUlK5F0L1aTvLFAoKi
        HJuQL+YRzLaXCTZGdDlzON+oQdBvM61TUwhK9A3IThF0CBRUda9RLnSLAG7PW4X2BkZrIM9o
        InIRRTnTgdD3yt8uhbQHDL25ZCckdBA0P+pE/DJ3uFbTQti1iA4Gc382zjNO0PNgcs1xK+0F
        9dmD6+7ucOV5ydo9QA+TUN24jPNGh0FX37aunWHG3EzyehtYivKE9gxAZ0JR4V5+Ng+BQbco
        5Jkg+NK3vBYZoz2hqc2Hx0PgveUALx3h86wTn8ARCg33Mf5ZAtdzpLzHDmgsaF/3k8HNmVp0
        C8m1m27Rbsqv/b+qDGF1yJXVcAkxLOefyJ7z5pQJnCYxxjsqKUGP/n0oy6r5VyvqWIk0IZpC
        cgdJrEkTIcWVqVx6ggkBhcldJIfeWsKlkmhl+nlWnRSh1qhYzoTcKKHcVeJfPn1GSscoU9h4
        lk1m1RtdASWSZSHtna8n8D1j90JtvoEBpb7Skt7oiXFjalaYkUw3PMytHtAt5ode/RBJnI6a
        WTFwoTB54WJYoNVv34pK7+FZVakLf9d+0nEp3jKL2XZWjM//LiWKHcwZfTMEIYt7HRPGTfdk
        jXzLGH7ZmqbsnxAfUY2PiXa5Mae6jk1p47/LzHIhF6v088LUnPIvj6uqn0wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7puX0rjDZ4d4rNY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPtrG2vBVe6K/yuvszcwnuLsYuTkkBAw
        kZjT9pG1i5GLQ0hgKaPEov/tQA4HUEJKYuXcdIgaYYk/17rYIGqeMkpsmvecESTBJuAo0b/0
        BFiziMB+JolLF+6zgCSYBcolLs16zg4ySFjAUuLcQWMQk0VAVeLmmTqQCl4Ba4ktC48wQsyX
        l2hfvp0NxOYUsJE4fqmJFcQWAqrZtvgyC0S9oMTJmU9YQMYwC6hLrJ8nBBLmF9CSWNN0HWqp
        vETz1tnMExiFZiHpmIXQMQtJ1QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiB8bjt2M/N
        OxgvbQw+xCjAwajEwytwoDReiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcY
        TYG+nMgsJZqcD0wVeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUa
        GCe9FVv0Xqpiy9Uabh/FO3zltYzz7PbFK5zzZzZvCT/Vk8L+1UTwylKpx2KN+RMmWPE97qpI
        a14VxDVJXF/KO0Ch1+Br4V75x9/dU3W2rVL8/i/f9fTP61dmObwre9iSujBQ6/FPSa64pxJV
        OVsSrt9XdgjKeq4wR+jlm7a5N+1fC09+78HVoMRSnJFoqMVcVJwIAJmqjkHdAgAA
X-CMS-MailID: 20201001152246eucas1p1ee289b8a85b707f7496355c081623796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152246eucas1p1ee289b8a85b707f7496355c081623796
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152246eucas1p1ee289b8a85b707f7496355c081623796
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20201001152246eucas1p1ee289b8a85b707f7496355c081623796@eucas1p1.samsung.com>
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

Łukasz Stelmach (9):
  spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
    s3c64xx_enable_datapath()
  spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
  spi: spi-s3c64xx: Check return values
  spi: spi-s3c64xx: Report more information when errors occur
  spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
  spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
  spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  spi: spi-s3c64xx: Increase transfer timeout
  spi: spi-s3c64xx: Turn on interrupts upon resume

 drivers/spi/spi-s3c64xx.c | 111 +++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 32 deletions(-)

Changes in v2:
  - added missing commit descriptions
  - added spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  - implemented error propagation in
      spi: spi-s3c64xx: Check return values
  - rebased onto v5.9-rc1 which contains
      spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
-- 
2.26.2
