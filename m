Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311DBB9E04
	for <lists+linux-spi@lfdr.de>; Sat, 21 Sep 2019 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394150AbfIUNTw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 21 Sep 2019 09:19:52 -0400
Received: from mout.web.de ([212.227.17.12]:37869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388184AbfIUNTw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 21 Sep 2019 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569071969;
        bh=9+xypCKN1krYc4zKOAM4qOYGemsp2J5T/csTgm4F+nU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=M/l0d6XNFA2n1ffP/eTG/nEFMak1qvkmHaL6HvfTr0xqg3xk8iJgiBD4CJrPl0p/u
         Bue1T+qo6Q5oj2G3F2pTc4rzNsOwrJM0G/f/5laAzoBziwr69yVPulQUAKTLwoluPQ
         I9UH20vaW82uazoNc25R1sbwIqXnCgDk/m4vXHg0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.64.44]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK1s1-1iAqLk2YAX-001V9W; Sat, 21
 Sep 2019 15:19:29 +0200
To:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_slave_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <225b76ca-a367-4bef-d8ce-42c7af9242a5@web.de>
Date:   Sat, 21 Sep 2019 15:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xO8Z1pvpI8iq6eY4ur2wGPtzGdYEW++YUJqtJjR+6Kw0WD8rx0O
 pWBRCZFfeyG5rlD7dWW4cy2qv3Kewcv/OYeKzPI9IHrLYNuM6MRqb00V80W0LIm5LXjZ/Vu
 zTnB8DGGA0n58FxVPBZQPlbKhLWm96My7g76aWvPqnoWaUF7FZKsl3V4Guz/JnKcSH45vFu
 dBKMRsXwkUPeR4ZjZHHMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LxqNktLQJF8=:oZDmTDmllwpA/Y/Crx0yds
 ZYddq+LrxZzlUls5ftPyKA5Vg9nUXHS2wphRXeRDhQp/9qRisUNcGeROlHMMgRMOq5D6x8v4y
 uxiXjdEPKoDV+CWIW7VgiEfU+coXSMk2C59PcQ44gpbuiNXLooAt8usgtPbRCUG2zSzOkb9tO
 m3i1BszfxXPkKL3W82NEdIyZUKHy2isX3dV/UUqxjkXK7uE9jwqVGyqbeRZaDZW7s/7LmY9mR
 ub+TL7xcMzXRcOYfvALLai4nObRdkqbUPNLBtiNuEqRox0MqGgYDal7sRmFbhAiVfKKLgKD4m
 n155qUIW8On8xH7ZD6U0IMa/oGkJFPgc1DzFJq7jYLXOw8I62QwQsJ6NqsXB6If9dPUQ6fwUv
 /ITcvCIrmt+CxQ4uExb6a2PPjqPHtd81+oiMSztHgQDxm3RTyMVgBiPmc9Gal+3//wP1MEBRj
 h8lxd39ezu2Kz9s/d2UTLsP9PpYcdhjFEDNKPN9U32oP+JeqVmdZX58F6d5btUGycEnJiJKET
 pCCYMG+NcVv5UxIlUHMXth5VmlOUtzvggGK8wr8UqXcBLyOGB13tUqK1b3u3DQrnsw92X/cZ7
 4UeaQRHD9tCEkIzBSh/mAtZifzqcs7rYcl+BfYvwFcG5Fwnn0zSYCT0wNKV8pngStzC73mEGg
 y5Vi6kSo+dyOz623uOqep2hD/JMGr/M/RJTb/AzNyDGQtS/DmFQfcKyjLteJd6HD8jrRsy900
 I4dWF0+wLSqT1uUccAJ9H6CG7XemrrMjs1iZ3YXE+wgypFg2pQXlxmpOyFRs61vU0JGHxt9qx
 Zh++6bTTXYjLulxIh7O5blr/CZqwpo0rjJAvUg+jTVpSAbWTQHuZa7n4TyGE+6DMXiaZMig88
 TAXDw9MxqmOLgAvPSA8piM7HroHmnGkrbIP7ce9IBRm7njR9CwgI3J831rf0YPWAu3Br+20jx
 la2UN8eCmhZrakRr/+8Y3ZIVqbF6Zx5BNgeUws3T/TmRfzUd3DPeYRfYvRvfDYKxHwtkPWj7O
 0MLC07o09LSOwq5EJKs5JOrNDPXLP8HA7sALIXy53NAWCCi5+cmOS3gYVBLvQLdZbF9txroao
 NwYLnb7tBe+d7nWYCQrlT4J/yyrzoQU6VIYBwFF9nX3am+PtfAr/J+wBYqzRo9y5FPW6K+0tX
 JxFM8IGXTMR17LbiOcVsnw528kmS0myrZ5Pus/8zS27ikyPGVkMVGOIKK9igSyXmHbQykn1VY
 vO5rBcglVrVm7Wy/8rtPTu9LR9Krldu0unXInGwxb4sS9e/Sv0LljQsVfBp4=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 15:12:33 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-slave-mt27xx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx=
.c
index 61bc43b0fe57..44edaa360405 100644
=2D-- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -368,7 +368,6 @@ static int mtk_spi_slave_probe(struct platform_device =
*pdev)
 {
 	struct spi_controller *ctlr;
 	struct mtk_spi_slave *mdata;
-	struct resource *res;
 	int irq, ret;

 	ctlr =3D spi_alloc_slave(&pdev->dev, sizeof(*mdata));
@@ -392,17 +391,8 @@ static int mtk_spi_slave_probe(struct platform_device=
 *pdev)
 	platform_set_drvdata(pdev, ctlr);

 	init_completion(&mdata->xfer_done);
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret =3D -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_ctlr;
-	}
-
 	mdata->dev =3D &pdev->dev;
-
-	mdata->base =3D devm_ioremap_resource(&pdev->dev, res);
+	mdata->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret =3D PTR_ERR(mdata->base);
 		goto err_put_ctlr;
=2D-
2.23.0

