Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3819C0B3
	for <lists+linux-spi@lfdr.de>; Thu,  2 Apr 2020 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgDBMKi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Apr 2020 08:10:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14408 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgDBMKf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Apr 2020 08:10:35 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200402121032epoutp03e59d128d4f2f61c6cdd37ba804984d40~B-3eXCa2c1804518045epoutp03w
        for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2020 12:10:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200402121032epoutp03e59d128d4f2f61c6cdd37ba804984d40~B-3eXCa2c1804518045epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585829432;
        bh=W1uGLnSfO0xhdPy733z8ZFnqmNvQ5mZd5PW1888pFIQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=B8VYQz834wH1Qxg41E08Pw6zfgTbf2bFmZaT0diIwXQt5/EdFK77qlVg9aVCNxA7N
         uiGkrkxU4wjTGcZK92cy18ROF91RX+59oSijWk2BbBZdZppZ31DFgBcqWihgNM5IuL
         HGcrMNdgrl2OgaGnIUD5Ouczs7cL0jf+movJ4yBE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200402121032epcas1p2956ea13226d3883536e916f5a972ed4e~B-3eEhxi63107131071epcas1p2G;
        Thu,  2 Apr 2020 12:10:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48tMMq3wbnzMqYkY; Thu,  2 Apr
        2020 12:10:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.8F.04402.736D58E5; Thu,  2 Apr 2020 21:10:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200402121030epcas1p443ac0b9ee2bbdc2afe8790bad9ab436b~B-3cjHdDB0745707457epcas1p4h;
        Thu,  2 Apr 2020 12:10:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200402121030epsmtrp2679b1b0437107037b1a58c9c99139350~B-3ciewha0196701967epsmtrp2L;
        Thu,  2 Apr 2020 12:10:30 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-d5-5e85d6379325
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.9A.04158.636D58E5; Thu,  2 Apr 2020 21:10:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.100.192]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200402121030epsmtip2d9ec8e4c7a3e1dacafdabfefd2273d94~B-3cZhTr-3176931769epsmtip2W;
        Thu,  2 Apr 2020 12:10:30 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] spi: spi-ep93xx: fix wrong SPI mode selection
Date:   Thu,  2 Apr 2020 21:10:22 +0900
Message-Id: <20200402121022.9976-1-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7bCmnq75tdY4g9eN0hZTHz5hs3h08zer
        xeVdc9gsGj/eZHdg8di0qpPNo2/LKkaPz5vkApijcmwyUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMl49vcxe0MNZcfjlRuYGxk3sXYycHBIC
        JhKzLr0Fs4UEdjBKrFyp2sXIBWR/YpT4/ngqM4TzjVHi+oRJjF2MHGAdF65AFe1llGiafoYF
        wvnMKNE3vQlsFJuAlsSN35tYQWwRgTiJE8vmgtnMAhoSvw/cZAGxhQXsJC7duswCMpRFQFWi
        90YdSJhXwELi9IYtjBDXyUus3nAA7AgJgYesEh+3LGCGSLhIbLx6jA3CFpZ4dXwL1DtSEp/f
        7YWKF0vsXDmRHaK5hVHi0fIlUEXGEu/ermUGWcwsoCmxfpc+RFhRYufvuYwQd/JJvPvawwrx
        MK9ER5sQRImSxJsHLSwQtoTEhce9UCUeEqtfxkICMVZiwZLdTBMYZWchzF/AyLiKUSy1oDg3
        PbXYsMAQOYo2MYLTj5bpDsYp53wOMQpwMCrx8DIcbI0TYk0sK67MPcQowcGsJMLrOAMoxJuS
        WFmVWpQfX1Sak1p8iNEUGHYTmaVEk/OBqTGvJN7Q1MjY2NjCxMzczNRYSZx36vWcOCGB9MSS
        1OzU1ILUIpg+Jg5OqQZGuxah3Veygvc/Tnt6RmdlNk/CHI4ag59bhT8rbE9j7hX+07yk6lhz
        t7160ete5rkXptjLnvgRf3+V3d87j2K7hBOPbM5W9iv6s4x1o1A/L5eRbXfJD7Nyw8N9s19x
        sh3me3iN/5IXT5jibjVTBd18a/tZOasqtfmPGt9Ico+Xv/j48bcFD6crsRRnJBpqMRcVJwIA
        MTDHy1UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSvK7ZtdY4g1sPTS2mPnzCZvHo5m9W
        i8u75rBZNH68ye7A4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGW8enqZvaCHs+Lw
        y43MDYyb2LsYOTgkBEwkLlxR7WLk4hAS2M0o8ez6SaYuRk6guITEo51fWCBqhCUOHy6GqPnI
        KLH5xGxWkBo2AS2JG783gdkiAgkS//4sYgexmQU0JH4fuMkCYgsL2ElcunUZbA6LgKpE7406
        kDCvgIXE6Q1bGCFWyUus3nCAeQIjzwJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMHhoKW1g/HEifhDjAIcjEo8vAwHW+OEWBPLiitzDzFKcDArifA6zgAK8aYkVlalFuXHF5Xm
        pBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNT3XV72YubG0qUOnm+/FIVc5bBf
        7ZV4ZzI/66dz3V07mjli/X/yH38YkvTuILfWFMvua2KCe84cPT9n292myZH2HltXSwVKXV9u
        MSf0lW/Cpj6NGUV353SqREUXTDn4/HjeqV2C30VyT/g8ebnjkG21Zrup3p2LZ36dTpdJnPO7
        9sHikMCKhYFKLMUZiYZazEXFiQDEpwoWAwIAAA==
X-CMS-MailID: 20200402121030epcas1p443ac0b9ee2bbdc2afe8790bad9ab436b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402121030epcas1p443ac0b9ee2bbdc2afe8790bad9ab436b
References: <CGME20200402121030epcas1p443ac0b9ee2bbdc2afe8790bad9ab436b@epcas1p4.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The mode bits on control register 0 are in a different order compared
to the spi mode define values. Thus, in the current code, it fails to
set the correct SPI mode selection. Fix it.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/spi/spi-ep93xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4e1ccd4e52b6..8c854b187b1d 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -31,7 +31,8 @@
 #include <linux/platform_data/spi-ep93xx.h>
 
 #define SSPCR0			0x0000
-#define SSPCR0_MODE_SHIFT	6
+#define SSPCR0_SPO		BIT(6)
+#define SSPCR0_SPH		BIT(7)
 #define SSPCR0_SCR_SHIFT	8
 
 #define SSPCR1			0x0004
@@ -159,7 +160,10 @@ static int ep93xx_spi_chip_setup(struct spi_master *master,
 		return err;
 
 	cr0 = div_scr << SSPCR0_SCR_SHIFT;
-	cr0 |= (spi->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_MODE_SHIFT;
+	if (spi->mode & SPI_CPOL)
+		cr0 |= SSPCR0_SPO;
+	if (spi->mode & SPI_CPHA)
+		cr0 |= SSPCR0_SPH;
 	cr0 |= dss;
 
 	dev_dbg(&master->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-- 
2.17.1

