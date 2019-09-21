Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2031B9DD1
	for <lists+linux-spi@lfdr.de>; Sat, 21 Sep 2019 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437869AbfIUMYZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 21 Sep 2019 08:24:25 -0400
Received: from mout.web.de ([212.227.17.12]:56103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437867AbfIUMYY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 21 Sep 2019 08:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569068659;
        bh=+zSC1wMM+rSyr33ylEkXpwyC1pR57yGZDDXbuIvTSBo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ojvGTqdFsTrqpoNA9uwU98N8p6T2r/4oz51LXh9GMdKHbQsprKeVIPWZBt08jabjX
         nhlrXuTPnVnxFNwIdNyBgVXxYYfxOnDoZ5nqD/SZKfmtj0B80auTd88CUi8100F0xW
         XTaGKrqx6t/hcG81GmMgVC9JboqSJ11gVcci8qY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1iXydf3zhB-00MMs0; Sat, 21
 Sep 2019 14:24:19 +0200
To:     linux-spi@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: lantiq-ssc: Use devm_platform_ioremap_resource() in
 lantiq_ssc_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <230495a7-b754-bc6a-05e0-059a6b6c643d@web.de>
Date:   Sat, 21 Sep 2019 14:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ytj4SpcnxbW+WSbZ7z+12cwwGMDKrkFldtNhtI/KOwfwh+ZFViz
 adIIHQM5eS9eFfM4hX9YDeDEnBLXGFdKmEmAWsjmuJJrCmCltxGNyEoxmblnibuqyAdnR0j
 h++hyOAV+Q6NRybyhKpHO+xaat7YnhtycgtaUKkM8cyNE2St1ELdoxO6JqFXouoDMd3zvXE
 nV1HSNhwyVTbMMyTS9AIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9nCNjGV6FUU=:KMnczZEYmIDJHPZ43aKguE
 vhkLOCKd3D6XWuiJaCYOQnjQ/EHb4Z/rFBu6j2DlTvwE+BAENjQxwYIHhG+SIXJzTOPigoYG9
 Et4lB8yHx0MbdQ9RJQKKlDa3qSnLD4bl2PC9DetwTE3gKnCReqvgIGLecZMJoOwhztc4+e0M7
 UihcvV7ZlcHR+BgMnCA0hFVU0mDk3RShYrRU7wJ+koT7bcSY1BqewFI8EBjY7A3EPdygSrldo
 bYeEAcJ+4Ae4rjGYxnIegp38ZY6MKcHBQ+AYuEk2ly86Wajwuz5uodvH8VmPFvzUKAIUhCw8i
 5Vj4f9YcWzFXc0FXzJ+RC88gKIlsqErh3/42+a34QD5dClqQahic2bLsc6QWPlSd/uYlKg2xs
 VH0OY8daCjPLbPyh6w79S96KDCwSKO5p+Z6fclX8kzlclM2XRNoUX7qaQneGgoR1b0bxbYIZq
 g+d9XIhVBSkLc6AGAOvO8X4mROMYki2niTZWk3t3u+k+6x0m6QHgj/+Sp1gDvsYtMZUMGUaaO
 EMSy3CAfCme3QI0S6sBcO0DpN9M29aPqgqp+PbTvdotgr3VC6LGqrv+FZ0mbaWZ/pv+n4S5oe
 RvD4OZt9LvQHoQLMdUq+25C/QXpjH+WSVOlxQ8z7+qLZAIRFa1z1e6DjvP+LMorSt1+zJuZZC
 Gse7CVozuGP6uSX1ZyxbMrC0AOnUIM9AmCTv5MPWgl672U1xzSh1SevmAwJ7j5NkcUQ2m5JTk
 4BuQo1I5Hw1ZofBDu8Sir/JA0D61MAeGQ7bA77Sk37fK5lUKgrWcGcCw5clR2i/iJ8Qmuq0ch
 vMfCO/XRm4hXst4bUfnHY/SOA/dObY81KuzB90RpNAbnGOnBZeHmDMQE3cTW09aNVMXhp8UHW
 APUhW66Ji3oUCkFOOuyza+XpiWbG4CB/iu2DPuGEIh1Xjh4rJE7I8lp7LMUyyG+RNx5pDKArP
 Mzj5hXoNRsp3aQh/qZO5y8W5XiKe/KnebgiIFXXPPoxBulzk48jKzEE7NV+2tXp15SfszOoK1
 01Vto97hDJ5U66XzCEcM2SDoDklyVG4tt1znGPJ/lH3j19E4IKkctPftq4hcBSPRiA1BZf/Ow
 KIqNoBqRTH9Io0esz61GOZ3mMXC1kZOWm5qrQs+exfsW12f+q3rImfOyVtm0wkzzJO0YHYkt7
 Wu6O73cF0QMqqH49PJEvmy7yo5Yf1pTQbwQ7yTKtarX0YLUSMzVa/42zNuai01Grd0zmmbkmK
 rLlcBjmbp5XksNBPPktJ7o4ocgDDWpBBQqgqm44vWxvZnOhwX2XhqyRb9qW0=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 14:16:49 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-lantiq-ssc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 9dfe8b04e688..1fd7ee53d451 100644
=2D-- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -797,7 +797,6 @@ static int lantiq_ssc_probe(struct platform_device *pd=
ev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct spi_master *master;
-	struct resource *res;
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
 	const struct of_device_id *match;
@@ -812,12 +811,6 @@ static int lantiq_ssc_probe(struct platform_device *p=
dev)
 	}
 	hwcfg =3D match->data;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get resources\n");
-		return -ENXIO;
-	}
-
 	rx_irq =3D platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
 	if (rx_irq < 0)
 		return -ENXIO;
@@ -839,8 +832,7 @@ static int lantiq_ssc_probe(struct platform_device *pd=
ev)
 	spi->dev =3D dev;
 	spi->hwcfg =3D hwcfg;
 	platform_set_drvdata(pdev, spi);
-
-	spi->regbase =3D devm_ioremap_resource(dev, res);
+	spi->regbase =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi->regbase)) {
 		err =3D PTR_ERR(spi->regbase);
 		goto err_master_put;
=2D-
2.23.0

