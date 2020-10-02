Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B68281251
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBMXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55012 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122256euoutp013c6bdf0f9393a5e55e5162b4c6bae653~6LFiaLndT0520905209euoutp018
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002122256euoutp013c6bdf0f9393a5e55e5162b4c6bae653~6LFiaLndT0520905209euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641376;
        bh=7LtCdh3X+5TnFv/x7HOdoPIHebaOi5pA9zfppmeDtdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qz+vef36m73sPBaSm5dUcO/aI655hvK7kedOYruQZGXSs36zJBVkEHQT7EWszIFGA
         gxAYAS8MEjTDtRLey5btgpyENxkwrIcg5GBArsyGdBgkbjainsICXHW8RDtO/jXgC9
         MjmfbNIbXRpbmDgDcDlN9nk3Zp+Ea2NodQXUXVZM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201002122256eucas1p12e5bf98482976c654647738ab239202b~6LFiD4kQb3160631606eucas1p15;
        Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D9.8F.06318.F9B177F5; Fri,  2
        Oct 2020 13:22:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201002122255eucas1p2cec6d9cdac111d6f2dc628c7865f7bd5~6LFhoMk3s1906319063eucas1p2f;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122255eusmtrp2f67b56444dfc2817397a3c9c19eaa9f0~6LFhninyB0251002510eusmtrp2V;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-f3-5f771b9f9d33
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.C0.06017.F9B177F5; Fri,  2
        Oct 2020 13:22:55 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122255eusmtip124cc2afa490630643fd094aded4aca84~6LFhbCGOi0741307413eusmtip1A;
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
Subject: [PATCH v3 8/9] spi: spi-s3c64xx: Increase transfer timeout
Date:   Fri,  2 Oct 2020 14:22:42 +0200
Message-Id: <20201002122243.26849-9-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7oLpMvjDSY1slks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlfDh4lqng
        M0fF/v1PGRsYZ7J3MXJySAiYSKxb+Iipi5GLQ0hgBaPEzkWXoJwvjBKvbyxlh3A+M0p8fPua
        Caal8ew3VojEckaJqzsaoKqeM0r09l9nBqliE3CU6F96AqxKRGA7k8TEz+dZQBxmgaOMEpsf
        XAVyODiEBZwlFj4qAGlgEVCV2PFwFyuIzStgLTH1/D5GiHXyEu3Lt7OB2JwCNhInF21jg6gR
        lDg58wkLiM0voCWxpuk6mM0MVN+8dTYzyC4JgXvsEucnzGeGGOQicbF9AdRQYYlXx7dAg0BG
        4v/O+Uwg90gI1EtMnmQG0dvDKLFtzg8WiBpriTvnfrGB1DALaEqs36UPEXaUuHGwjRWilU/i
        xltBiBP4JCZtm84MEeaV6GgTgqhWkVjXvwdqoJRE76sVjBMYlWYheWYWkgdmIexawMi8ilE8
        tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzBNnf53/OsOxn1/kg4xCnAwKvHwZhwqjRdiTSwr
        rsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KL
        YLJMHJxSDYxpZz0yd0S0du4MK6o/+SO0ZMPduRXG/Q5bDh/+t2mG16LEDc6B366JW0j+Xxo6
        c2lv5Sb77wFbDqZXT37FcGJtXEeP+wEOXtaUrrf7j4qaz/Zva5V/Uf2bR4HvzZ90Az/Pp2uv
        azy15uB7ujI6vTEyN+mgpvx6gbKiyzVe6//3KhrHrPkb+UuJpTgj0VCLuag4EQBSuxjqTwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rzpcvjDc5/ULFY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+HDwLFPBZ46K/fufMjYwzmTvYuTkkBAw
        kWg8+421i5GLQ0hgKaPEhh27WLoYOYASUhIr56ZD1AhL/LnWxQZR85RR4s/U02DNbAKOEv1L
        T4A1iwjsZ5K4dOE+C4jDLHCYUeLyunVMIJOEBZwlFj4qAGlgEVCV2PFwFyuIzStgLTH1/D5G
        iA3yEu3Lt7OB2JwCNhInF20Ds4WAalo/zoWqF5Q4OfMJ2HHMAuoS6+cJgYT5BbQk1jRdZwGx
        mYHGNG+dzTyBUWgWko5ZCB2zkFQtYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiT2479
        3LKDsetd8CFGAQ5GJR5egQOl8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+
        xGgK9OZEZinR5HxgusgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp
        1cDYaFtzduvJZSvLf1X9qvrEy/nYx8DTJUn2jEGld8nGudOSD+79+2GRpP8t555zFS6Hlp1Q
        mB5R/UDxeGiK9KEjF+6JXZdqrMx6N4fzDDfHNq/jzo8aVjBqdu/9r7jV07eDO2Xe2il5mpZy
        rb3f7ASEmrz0ZX30bkw/ILp0zp7NF//uPbnY5Q+vEktxRqKhFnNRcSIAtLk2Jd8CAAA=
X-CMS-MailID: 20201002122255eucas1p2cec6d9cdac111d6f2dc628c7865f7bd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122255eucas1p2cec6d9cdac111d6f2dc628c7865f7bd5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122255eucas1p2cec6d9cdac111d6f2dc628c7865f7bd5
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122255eucas1p2cec6d9cdac111d6f2dc628c7865f7bd5@eucas1p2.samsung.com>
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
index 0bd3e230350c..9f728a7c59a1 100644
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

