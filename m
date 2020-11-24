Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685712C26F6
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 14:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbgKXNPu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 08:15:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47902 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgKXNPu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 08:15:50 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201124131538euoutp0262020ebcaa81c1a31d8d15c28eda8ecd~Kc-rt9lLe0375803758euoutp02z
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2020 13:15:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201124131538euoutp0262020ebcaa81c1a31d8d15c28eda8ecd~Kc-rt9lLe0375803758euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606223738;
        bh=VMIE5grJi+EGHjoSejoXX7yX4OEbolDjXuEvDM6rKGc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OcOiESpgCrygJ43lXwjTd3wiLRKZJUJBJklZxar05CWmg6hjs4vR9n7OWjhJj4Usv
         kGpEodTouU9qiRzFvADOHJfJbiqMBgXfTUvkeCVq/qJ6j58QkR+82SRygUAVhtQm2b
         cOz+HD2meDlcPBteh32fN5PsTuqH4eEAoJs9dNgw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201124131533eucas1p270324139dfa5f41b960cfeb9d4ed0104~Kc-mpCAVX0811808118eucas1p2b;
        Tue, 24 Nov 2020 13:15:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 42.2F.44805.5770DBF5; Tue, 24
        Nov 2020 13:15:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201124131532eucas1p22f02c41a48e9768738b4529771ed7820~Kc-mL6iY00914609146eucas1p2T;
        Tue, 24 Nov 2020 13:15:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201124131532eusmtrp1d48af34344ab3485e6c66e463df95850~Kc-mLMjFm2366323663eusmtrp11;
        Tue, 24 Nov 2020 13:15:32 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-31-5fbd07752b63
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.D7.16282.4770DBF5; Tue, 24
        Nov 2020 13:15:32 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201124131532eusmtip209b157e09e83caa73c00236fff181a41~Kc-lx8Ufq0274902749eusmtip2s;
        Tue, 24 Nov 2020 13:15:32 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] spi: Fix potential NULL pointer dereference in
 spi_shutdown()
Date:   Tue, 24 Nov 2020 14:15:23 +0100
Message-Id: <20201124131523.32287-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7djP87ql7HvjDa6s5rTYOGM9q8XUh0/Y
        LJoXr2ezuLxrDptF48eb7BZrj9xlt7g9cTKjA7vHplWdbB77565h9+j/a+DRt2UVo8fnTXIB
        rFFcNimpOZllqUX6dglcGU8bNzEVPOauODZvLnMD41fOLkZODgkBE4nW/0fYuxi5OIQEVjBK
        nHjXwwrhfGGUWLhuGhuE85lRouPQCTaYlhdrNjBDJJYzSsxsn8oM13Ju4SlGkCo2AUOJrrdd
        YB0iAtYS32ZMAytiFmhlkrg3HaSdk0NYIEBiy6EHQNs5OFgEVCVabhaDhHkFbCX+Nx6F2iYv
        sXrDAbBeCYFGDokTDb+hEi4SE2fOZ4KwhSVeHd/CDmHLSJye3MMC0dDMKPHw3Fp2CKeHUeJy
        0wxGiCpriTvnfrGBbGYW0JRYv0sfIuwoceXFOVaQsIQAn8SNt4IgYWYgc9K26cwQYV6JjjYh
        iGo1iVnH18GtPXjhElSJh8TVc8IgYSGBWIn9f66zT2CUm4WwagEj4ypG8dTS4tz01GKjvNRy
        veLE3OLSvHS95PzcTYzAVHD63/EvOxiXv/qod4iRiYPxEKMEB7OSCG+r3M54Id6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rxJW9bECwmkJ5akZqemFqQWwWSZODilGpjq3n91fBkwy8Qm6seXk1d3
        L5h/9s88hZsRR+/sbYs84bw99/rUSY9OXJ/87lndBsWMQ28O5U3Zc4BDYdqzs74Nq0NMlD5k
        REgkKf4+0TvlzHoJ9UpF6V9s7RzisktneL2PnJ6Vfflag8GB2dv9dyz8mLJ/RbDRR6XII04S
        bTGZBUusuLNmOx7d38YvVPaI02L//M3s70+x5S2TqzL/emfaLQOeafEqG5UnqRbJTxWMiigS
        XNG6YZbCqyYZzyi3wEch6R+iZ9XejxaZOXX/9MvO+qIl533cRM5ttWzbnvQ+akt6482jIhF8
        LZolF/x9r/QwXbOdqnzmntGDm7P+Obi35UWyGQUmP9w9VX76y5RuJZbijERDLeai4kQAVDvC
        xnQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t/xe7ol7HvjDY491bDYOGM9q8XUh0/Y
        LJoXr2ezuLxrDptF48eb7BZrj9xlt7g9cTKjA7vHplWdbB77565h9+j/a+DRt2UVo8fnTXIB
        rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GU8b
        NzEVPOauODZvLnMD41fOLkZODgkBE4kXazYwdzFycQgJLGWUuHR/IRNEQkbi5LQGVghbWOLP
        tS42iKJPjBL7t59kBEmwCRhKdL0FSXByiAjYSsx//4IVpIhZoJVJYsO0UywgCWEBP4nn0/qB
        bA4OFgFViZabxSBhXqD6/41H2SAWyEus3nCAeQIjzwJGhlWMIqmlxbnpucVGesWJucWleel6
        yfm5mxiBIbjt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG+r3M54Id6UxMqq1KL8+KLSnNTiQ4ym
        QOsmMkuJJucDoyCvJN7QzMDU0MTM0sDU0sxYSZzX5MiaeCGB9MSS1OzU1ILUIpg+Jg5OqQYm
        l56unx86uWRSuUtlY0TeVPxk7mUR4Oq29jQ/LhD4xOGDuCOfH/80TkbHBatF5EwCRHaK9Pvu
        rPscNzHif+cviaWlBzRnsvGdr3j3YbqboeBJNjPzYpNZ72Tt856e/n10m7OL6l2/ZW8FkqbN
        2iC4mH+z+rwbF29dW7xNqO/JQ6GpS7x8ToUfiXF4JLfD0CP76aRr6zoWOiUv2nK3Oqao6pDB
        HdbGRKGNncsZ/VX7Np1uejtfvO/zovcX7knVnPL6YbBSOTDsZtEz9UliVXW2qncCHvIsYdDh
        ZZ943NpcS83Z9fuu64rJ23Yu08lZJxO5odSSdXvjEXuNHy3H9y42TH93Tj5rd0chs/xut29K
        LMUZiYZazEXFiQCf6Cx2ygIAAA==
X-CMS-MailID: 20201124131532eucas1p22f02c41a48e9768738b4529771ed7820
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201124131532eucas1p22f02c41a48e9768738b4529771ed7820
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201124131532eucas1p22f02c41a48e9768738b4529771ed7820
References: <CGME20201124131532eucas1p22f02c41a48e9768738b4529771ed7820@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Shutdown bus function might be called on the unbound device, so add a
check if there is a driver before calling its shutdown function.

This fixes following kernel panic obserbed during system reboot:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
...
Call trace:
 spi_shutdown+0x10/0x38
 kernel_restart_prepare+0x34/0x40
 kernel_restart+0x14/0x88
 __do_sys_reboot+0x148/0x248
 __arm64_sys_reboot+0x1c/0x28
 el0_svc_common.constprop.3+0x74/0x198
 do_el0_svc+0x20/0x98
 el0_sync_handler+0x140/0x1a8
 el0_sync+0x140/0x180
Code: f9403402 d1008041 f100005f 9a9f1021 (f9400c21)
---[ end trace 266c07205a2d632e ]---

Fixes: 9db34ee64ce4 ("spi: Use bus_type functions for probe, remove and shutdown)"
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0c3f3a962448..cd3c395b4e90 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -426,10 +426,12 @@ static int spi_remove(struct device *dev)
 
 static void spi_shutdown(struct device *dev)
 {
-	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	if (dev->driver) {
+		const struct spi_driver	*sdrv = to_spi_driver(dev->driver);
 
-	if (sdrv->shutdown)
-		sdrv->shutdown(to_spi_device(dev));
+		if (sdrv->shutdown)
+			sdrv->shutdown(to_spi_device(dev));
+	}
 }
 
 struct bus_type spi_bus_type = {
-- 
2.17.1

